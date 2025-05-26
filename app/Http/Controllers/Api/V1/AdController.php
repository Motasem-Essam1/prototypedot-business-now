<?php
namespace App\Http\Controllers\Api\V1;
use App\Http\Resources\AdSResourceCollection;
use App\Http\Resources\UserResource;
use App\Models\Ad;
use App\Models\User;

use App\Models\AdImage;
use App\Models\Like;
use App\Models\Favourite;
use App\Models\Value;
use App\Models\ValueAd;

use App\Services\CategoryService;
use App\Services\CityService;
use App\Services\CommentService;
use App\Services\FavouriteService;
use App\Services\SubcategoryService;
use App\Traits\ImageTrait;
use App\Models\Transaction;

use App\Traits\ApiResponses;
use Exception;
use Illuminate\Http\Request;
use App\Models\PromotionPlan;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;

class AdController extends Controller
{
    use ImageTrait;
    use ApiResponses;

    public function __construct(private readonly SubcategoryService $sub_category_service,
                                private readonly CategoryService $category_service,
                                private readonly CityService $city_Service,
                                private readonly CommentService $comment_service,
                                private readonly FavouriteService $Favourite_service)
    {
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $region = request('region');
        $ads = Ad::where('region', $region)->where('approved',1)
        ->orderBy('created_at', 'desc')
        //->where('status',1)->sortedAds()->paginate(30);
        ->sortedAds()->paginate(30);

        //add favourite
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token);
        
        // Transform the collection and test something for each ad 
        $ads->getCollection()->transform(function ($ad)use ($user_id) { 
            if($user_id == 0)
            {
                $ad->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;
            }

            $favourities_count   = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;
            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);

            return $ad;
        });  
            
        return $this->success($ads, 'Done');
    }

    
    //get ads for Dashboard
    public function index2(Request $request)
    {
        // Extract the search and approved filters from the request
        $filters = $request->only(['search', 'approved']);
        $per_page = $request->get('per_page', 30); // Get 'per_page' parameter or default to 30

        // Apply the filters using the Ad model's scope
        $ads = Ad::filterBySearchAndApproved($filters)->orderBy('created_at', 'desc')->paginate($per_page);

        // Add favourite  
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token);

        // Transform the collection and test something for each ad 
        $ads->getCollection()->transform(function ($ad) use ($user_id) {
            if ($user_id == 0) {
                $ad->is_current_user_favourite = false;
            } else {
                $favourite = Favourite::where('user_id', $user_id)
                    ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;
            }

            $favourities_count = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;
            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);
            return $ad;
        });

        return response()->json([
            'data' => $ads,
            'links' => [
                'first' => $ads->url(1),
                'last' => $ads->url($ads->lastPage()),
                'prev' => $ads->previousPageUrl(),
                'next' => $ads->nextPageUrl(),
            ],
            'meta' => [
                'current_page' => $ads->currentPage(),
                'from' => $ads->firstItem(),
                'last_page' => $ads->lastPage(),
                'path' => $ads->path(),
                'per_page' => $ads->perPage(),
                'to' => $ads->lastItem(),
                'total' => $ads->total(),
            ],
        ]);
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
            // تعيين user_id من المستخدم المصادق عليه
            $request['user_id'] = auth()->user()->id;
            $request['slug'] = Str::slug($request->slug);

            // تحقق من صحة البيانات المدخلة
            $validatedData = Validator::make($request->all(), [
                'type' => 'required|in:product,service,required_service',
                'title' => 'required|string',
                'description' => 'required|string',
                'price' => 'required|numeric',
                'region' => 'required|in:egypt,morocco',
                'category_id' => 'required|integer|exists:categories,id',
                'sub_category_id' => 'required|integer|exists:categories,id',
                'governorate_id' => 'required|exists:governorate,id',
                'city_id' => 'required|exists:cities,id',
                'images' => 'required|array|min:1|max:12', // Require the images array with at least one file
                // 'images.*' => 'image|mimes:jpeg,png,jpg|max:2048',
                'value_id' => 'array',
                'value_id.*' => 'required|int',
                // 'slug' => 'required|string|unique:ads,slug',
            ]);


            if ($validatedData->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validatedData->errors()
                ], 422);
            }


            $user = User::find($request['user_id']);



            if ($user->type === 'client') {
                $user['user_info'] = $user->client;
            } elseif ($user->type === 'company') {
                $user['user_info'] = $user->company;
            }
    
            if(empty($user['user_info']['phone']))
            {
                return response()->json([
                    'message' => 'phone required',
                    'errors' => $validatedData->errors()
                ], 422);  
            }



            $category = $this->category_service->show($request['category_id']);
            if(empty($category))
            {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => 'category_id is invalid, category_id is subcategory id'
                ], 422);
            }

            
            $sub_category = $this->sub_category_service->show($request['sub_category_id']);
            if(empty($sub_category))
            {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => 'sub_category_id is invalid, category_id is category id'
                ], 422);
            }
            
            // إنشاء إعلان جديد
            $ad = Ad::create([
                'type' => $request->type,
                'user_type' => 1,
                'title' => $request->title,
                'description' => $request->description,
                'price' => $request->price,
                'region' => $request->region,
                'category_id' => $request->category_id,
                'user_id' => $request->user_id,
                'sub_category_id' => $request->sub_category_id,
                'governorate_id' => $request->governorate_id,
                'city_id' => $request->city_id,
                // 'slug' => Str::slug($request->title),
                //'slug' => $request->slug,
            ]);
            

            // إدخال الخصائص الإضافية إذا كانت موجودة
            // if ($request->has('attributes')) {
            //     $attributes = $request->input('attributes');

            //     foreach ($attributes as $attribute) {
            //         DB::table('ad_attribute')->insert([
            //             'ad_id' => $ad->id,
            //             'attribute_id' => $attribute['attribute_id'],
            //             'attribute_option_id' => $attribute['attribute_option_id']
            //         ]);
            //     }
            // }

                //add image
            // التحقق من وجود الصور ورفعها
            if ($request->hasFile('images')) {
                $images = $request->file('images');
                // التأكد من أن $images هو مصفوفة
                if (!is_array($images)) {
                    $images = [$images];
                }
                $paths = $this->uploadMultiFiles($images, "Ad_num_" . strtotime(now()), "AdsImages");
                foreach ($paths as $path) {
                    $AdImage = new AdImage();
                    $AdImage['ad_id'] = $ad->id;
                    $AdImage['image'] = $path;
                    $AdImage->save();
                }
            }

            if ($request->has('value_id') && is_array($request->input('value_id'))) {
                // Get the 'value_id' array from the request
                $valueIds = $request->input('value_id');
        
                // Iterate over each value in the array
                foreach ($valueIds as $valueId) {
                    if(value::where('id', $valueId)->exists()) {
                        $ValueAd = new ValueAd();
                        $ValueAd['ad_id'] = $ad->id;
                        $ValueAd['value_id'] = $valueId;
                        $ValueAd->save();
                    }
                }
            }
                        
            return $this->success($ad, 'Added Successfully.');

    }

    /**
     * Store a newly created resource in storage.
     */
    public function dashboardStore(Request $request)
    {
            // تعيين user_id من المستخدم المصادق عليه
            $request['slug'] = Str::slug($request->slug);

            // تحقق من صحة البيانات المدخلة
            $validatedData = Validator::make($request->all(), [
                'user_id' => 'required|integer|exists:users,id', // Add validation for user_id
                'type' => 'required|in:product,service,required_service',
                'title' => 'required|string',
                'description' => 'required|string',
                'price' => 'required|numeric',
                'region' => 'required|in:egypt,morocco',
                'category_id' => 'required|integer|exists:categories,id',
                'sub_category_id' => 'required|integer|exists:categories,id',
                'governorate_id' => 'required|exists:governorate,id',
                'city_id' => 'required|exists:cities,id',
                'images' => 'required|array|min:1|max:12', // Require the images array with at least one file
                // 'images.*' => 'image|mimes:jpeg,png,jpg|max:2048',
                'value_id' => 'array',
                'value_id.*' => 'required|int',
                // 'slug' => 'required|string|unique:ads,slug',
            ]);


            if ($validatedData->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validatedData->errors()
                ], 422);
            }


            $user = User::find($request['user_id']);

            if ($user->type === 'client') {
                $user['user_info'] = $user->client;
            } elseif ($user->type === 'company') {
                $user['user_info'] = $user->company;
            }
    
            if(empty($user['user_info']['phone']))
            {
                return response()->json([
                    'message' => 'phone required',
                    'errors' => $validatedData->errors()
                ], 422);  
            }

            $category = $this->category_service->show($request['category_id']);
            if(empty($category))
            {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => 'category_id is invalid, category_id is subcategory id'
                ], 422);
            }

            
            $sub_category = $this->sub_category_service->show($request['sub_category_id']);
            if(empty($sub_category))
            {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => 'sub_category_id is invalid, category_id is category id'
                ], 422);
            }
            
            // إنشاء إعلان جديد
            $ad = Ad::create([
                'type' => $request->type,
                'user_type' => 1,
                'title' => $request->title,
                'description' => $request->description,
                'price' => $request->price,
                'region' => $request->region,
                'category_id' => $request->category_id,
                'user_id' => $request->user_id,
                'sub_category_id' => $request->sub_category_id,
                'governorate_id' => $request->governorate_id,
                'city_id' => $request->city_id,
                // 'slug' => Str::slug($request->title),
                //'slug' => $request->slug,
            ]);
            

            // إدخال الخصائص الإضافية إذا كانت موجودة
            // if ($request->has('attributes')) {
            //     $attributes = $request->input('attributes');

            //     foreach ($attributes as $attribute) {
            //         DB::table('ad_attribute')->insert([
            //             'ad_id' => $ad->id,
            //             'attribute_id' => $attribute['attribute_id'],
            //             'attribute_option_id' => $attribute['attribute_option_id']
            //         ]);
            //     }
            // }

                //add image
            // التحقق من وجود الصور ورفعها
            if ($request->hasFile('images')) {
                $images = $request->file('images');
                // التأكد من أن $images هو مصفوفة
                if (!is_array($images)) {
                    $images = [$images];
                }
                $paths = $this->uploadMultiFiles($images, "Ad_num_" . strtotime(now()), "AdsImages");
                foreach ($paths as $path) {
                    $AdImage = new AdImage();
                    $AdImage['ad_id'] = $ad->id;
                    $AdImage['image'] = $path;
                    $AdImage->save();
                }
            }

            if ($request->has('value_id') && is_array($request->input('value_id'))) {
                // Get the 'value_id' array from the request
                $valueIds = $request->input('value_id');
        
                // Iterate over each value in the array
                foreach ($valueIds as $valueId) {
                    if(value::where('id', $valueId)->exists()) {
                        $ValueAd = new ValueAd();
                        $ValueAd['ad_id'] = $ad->id;
                        $ValueAd['value_id'] = $valueId;
                        $ValueAd->save();
                    }
                }
            }
                        
            return $this->success($ad, 'Added Successfully.');

    }

    public function show(): JsonResponse
    {
        //userid for liked and favorited
        $userId = request('user_id');
        $adId = request('id');
        
        // Retrieve the ad without filtering by approved
        $ads = Ad::with('comments')->find($adId);

        if (!$ads) {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }

        // Get the authenticated user
        $token = request()->bearerToken();
        $user = $this->getUserByToken($token);
        $authUserId = $user?->id; // Use optional chaining to avoid errors

        // If the ad is approved, allow access for everyone
        if ($ads->approved == 1) {
            // Proceed without restrictions
        }
        // If the ad is NOT approved, only allow access to the ad owner
        elseif (!$user || $ads->user_id !== $authUserId) {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }

        // Check if the user has liked or favorited the ad
        $likeExists = Like::where('user_id', $userId)
        ->where('ad_id', $adId)
        ->exists();

        $favExists = Favourite::where('user_id', $userId)
                ->where('ad_id', $adId)
                ->exists();


    
        if ($ads) {

            // Increment views only for non-admin users and if they haven’t viewed it before
            if ($user && $user->type !== 'admin' && !$user->viewedAds->contains($ads->id)) {
                $ads->increment('views');
                $user->viewedAds()->attach($ads->id);
            }
            
            // $images = ImageResource::collection($ad['images']);
            // تحويل النموذج إلى مصفوفة وإزالة الخصائص غير المرغوب فيها
            // $adArray = $ad->toArray();
            // unset($adArray['updated_at'], $adArray['attributes']);


            // $adArray['images'] = $images;
            // // إزالة الخصائص غير المرغوب فيها من التعليقات
            // foreach ($adArray['comments'] as &$comment) {
            //     unset( $comment['updated_at'], $adArray['attributes']);
            // }
            
            // if (isset($adArray['category'])) {
            //     unset($adArray['category']['created_at'], $adArray['category']['attributes'],$adArray['category']['updated_at']);
            // }

            //add favourite
            $user_id = $this->getIdByToken($token); 

            if($user_id == 0)
            {
                $ads->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ads->id)->exists();
                $ads->is_current_user_favourite = $favourite;
             }

             $favourities_count = Favourite::where('ad_id', $ads->id)->count();
             $ads->favourities_count = $favourities_count;
             $user = User::find($ads->user_id);
             $ads->user = new UserResource($user);


             //get additional ads             
             $additional_ads = Ad::query()
             ->where('id', '!=', $adId)
             ->where('approved',1)
             ->where('status', 1)
             ->where(function ($query) use ($ads) {
                 $query->where('city_id', $ads->city_id)
                       ->orWhere('title', $ads->title)
                       ->orWhere('governorate_id', $ads->governorate_id);
             })
             ->orderByRaw("CASE 
                             WHEN city_id = ? THEN 1 
                             WHEN title = ? THEN 2 
                             WHEN governorate_id = ? THEN 3 
                           END", [$ads->city_id, $ads->title, $ads->governorate_id])
             ->get();
            
             return response()->json([
                'status' => 'success',
                'data' => $ads,
                'like' => $likeExists,
                'fav' => $favExists,
                'additional_ads' => $additional_ads,
                // 'user' => $user_ad,
                'message' => 'Done'
            ]);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }
    }

    //get ad for Dashboard
    public function show2(): JsonResponse
    {
        $userId = request('user_id');
        $adId = request('id');
    
        $ads = Ad::with('comments')->find($adId);
    
        $likeExists = Like::where('user_id', $userId)
                          ->where('ad_id', $adId)
                          ->exists();
    
        $favExists = Favourite::where('user_id', $userId)
                              ->where('ad_id', $adId)
                              ->exists();
    
        if ($ads) {
            // $ads->increment('views');
            
            // $images = ImageResource::collection($ad['images']);
            // تحويل النموذج إلى مصفوفة وإزالة الخصائص غير المرغوب فيها
            // $adArray = $ad->toArray();
            // unset($adArray['updated_at'], $adArray['attributes']);


            // $adArray['images'] = $images;
            // // إزالة الخصائص غير المرغوب فيها من التعليقات
            // foreach ($adArray['comments'] as &$comment) {
            //     unset( $comment['updated_at'], $adArray['attributes']);
            // }
            
            // if (isset($adArray['category'])) {
            //     unset($adArray['category']['created_at'], $adArray['category']['attributes'],$adArray['category']['updated_at']);
            // }

            //add favourite
            $token = request()->bearerToken();
            $user_id = $this->getIdByToken($token); 

            if($user_id == 0)
            {
                $ads->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ads->id)->exists();
                $ads->is_current_user_favourite = $favourite;
             }

             $favourities_count = Favourite::where('ad_id', $ads->id)->count();
             $ads->favourities_count = $favourities_count;
             $user = User::find($ads->user_id);
             $ads->user = new UserResource($user);

            return response()->json([
                'status' => 'success',
                'data' => $ads,
                'like' => $likeExists,
                'fav' => $favExists,
                // 'user' => $user_ad,
                'message' => 'Done'
            ]);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }
    }

    public function showAdUser(): JsonResponse
    {
        $userId = auth()->user()->id;
        $adId = request('id');
    
        $ads = Ad::with('comments')->find($adId);
    
        $likeExists = Like::where('user_id', $userId)
                          ->where('ad_id', $adId)
                          ->exists();
    
        $favExists = Favourite::where('user_id', $userId)
                              ->where('ad_id', $adId)
                              ->exists();
    
        // Ensure the Ad belongs to the authenticated user
        if ($ads->user_id !== $userId) {
            return response()->json([
                'status' => 'failed',
                'message' => 'You are not authorized to show this Ad',
            ], 403);
        }

        if ($ads) {
            // $ads->increment('views');
            
            // $images = ImageResource::collection($ad['images']);
            // تحويل النموذج إلى مصفوفة وإزالة الخصائص غير المرغوب فيها
            // $adArray = $ad->toArray();
            // unset($adArray['updated_at'], $adArray['attributes']);


            // $adArray['images'] = $images;
            // // إزالة الخصائص غير المرغوب فيها من التعليقات
            // foreach ($adArray['comments'] as &$comment) {
            //     unset( $comment['updated_at'], $adArray['attributes']);
            // }
            
            // if (isset($adArray['category'])) {
            //     unset($adArray['category']['created_at'], $adArray['category']['attributes'],$adArray['category']['updated_at']);
            // }

            //add favourite
            $token = request()->bearerToken();
            $user_id = $this->getIdByToken($token); 

            if($user_id == 0)
            {
                $ads->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ads->id)->exists();
                $ads->is_current_user_favourite = $favourite;
             }

             $favourities_count = Favourite::where('ad_id', $ads->id)->count();
             $ads->favourities_count = $favourities_count;
             $user = User::find($ads->user_id);
             $ads->user = new UserResource($user);

            return response()->json([
                'status' => 'success',
                'data' => $ads,
                'like' => $likeExists,
                'fav' => $favExists,
                // 'user' => $user_ad,
                'message' => 'Done'
            ]);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {

        $request['slug'] = Str::slug($request->slug);

        $validatedData = Validator::make($request->all(), [
            'id' => 'required|integer|exists:ads,id',
            'type' => 'required|in:product,service,required_service',
            'title' => 'required|string',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'region' => 'required|in:egypt,morocco',
            'category_id' => [
                'required',
                'integer',
                'exists:categories,id',
                function ($attribute, $value, $fail) {
                    $category = $this->category_service->show($value);
                    if(empty($category)) {
                        $fail('The selected category is invalid. It must be a main category.');
                    }
                },
            ],
            'sub_category_id' => [
                'required',
                'integer',
                'exists:categories,id',
                function ($attribute, $value, $fail) {
                    $sub_category = $this->sub_category_service->show($value);
                    if(empty($sub_category)) {
                        $fail('The selected subcategory is invalid. It must be a subcategory of a main category.');
                    }
                },
            ],
            'company_id' => 'nullable|numeric|exists:companies,id',
            'attributes' => 'nullable|array',
            'attributes.*.attribute_id' => 'nullable',
            'attributes.*.attribute_option_id' =>'nullable',
            'governorate_id' => 'required|exists:governorate,id',
            'city_id' => 'required|exists:cities,id',
            'images.*' => 'image|mimes:jpeg,png,jpg|max:2048',
            'value_id' => 'array',
            'value_id.*' => 'required|int',
            // 'slug' => [
            //     'required',
            //     'string',
            //     Rule::unique('ads', 'slug')->ignore($request->id),
            // ],
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $request['user_id'] = auth()->user()->id;
        $request['id'] = request('id');
        $files = [];
        $ad = Ad::find($request['id']);

        // Check if Ad exists
        if (!$ad) {
            return response()->json([
                'status' => 'failed',
                'message' => 'This Ad Not Found',
            ], 400);
        }

        // Ensure the Ad belongs to the authenticated user
        if ($ad->user_id !== $request['user_id']) {
            return response()->json([
                'status' => 'failed',
                'message' => 'You are not authorized to update this Ad',
            ], 403);
        }

        if ($request->hasFile('images')) {
            //check images limit
            $current_images_num = AdImage::query()->where('ad_id', $request['id'])->count();


            if($current_images_num <= 12)
            {
                $images = $request->file('images');
                $images_num = 12 - $current_images_num;
                $images = array_slice($images, 0, $images_num);
    
                $paths = $this->uploadMultiFiles($images, "Ad_num_" . strtotime(now()), "AdsImages");
                foreach ($paths as $path) {
                    $AdImage = new AdImage;
                    $AdImage['ad_id'] = $request['id'];
                    $AdImage['image'] = $path;
                    $AdImage->save();
                    $files[] = $path;
                }    
            }
        }

        $request['links'] = $files;
        $ad= Ad::whereId($request['id'])->update([
            'type' => $request->type,
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
            'region' => $request->region,
            'category_id' => $request->category_id,
            'user_id' => $request->user_id,
            'company_id' => $request->company_id ?? null,
            'governorate_id' => $request->governorate_id ?? 0,
            'city_id' => $request->city_id ?? 0,
            'sub_category_id' =>$request->sub_category_id?? 0,
            //    'slug' => $request->slug,
        ]);


       //update values of ad
       if ($request->has('value_id') && is_array($request->input('value_id'))) {
        
        ValueAd::where('ad_id', $request['id'])->delete();
        
        // Get the 'value_id' array from the request
        $valueIds = $request->input('value_id');

        // Iterate over each value in the array
        foreach ($valueIds as $valueId) {
            if(value::where('id', $valueId)->exists()) {
                $ValueAd = new ValueAd();
                $ValueAd['ad_id'] = $request['id'];
                $ValueAd['value_id'] = $valueId;
                $ValueAd->save();
            }
        }
    }

       return $this->success('done', 'Updated Successfully . . .');
    }

    /**
     * Update the specified resource in storage.
     */
    public function dashboardUpdate(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'id' => 'required|integer|exists:ads,id',
            'type' => 'required|in:product,service,required_service',
            'title' => 'required|string',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'region' => 'required|in:egypt,morocco',
            'category_id' => 'required|integer|exists:categories,id',
            'sub_category_id' => 'required|integer|exists:categories,id',
            'company_id' => 'nullable|numeric|exists:companies,id',
            'attributes' => 'nullable|array',
            'attributes.*.attribute_id' => 'nullable',
            'attributes.*.attribute_option_id' =>'nullable',
            'governorate_id' => 'required|exists:governorate,id',
            'city_id' => 'required|exists:cities,id',
            'images.*' => 'image|mimes:jpeg,png,jpg|max:2048',
            'value_id' => 'array',
            'value_id.*' => 'required|int',
            'user_id' => 'required|integer|exists:users,id', // Add validation for user_id
            // 'slug' => [
            //     'required',
            //     'string',
            //     Rule::unique('ads', 'slug')->ignore($request->id),
            // ],
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $category = $this->category_service->show($request['category_id']);
        if(empty($category))
        {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => 'category id is invalid, category_id is subcategory id'
            ], 422);
        }

        
        $sub_category = $this->sub_category_service->show($request['sub_category_id']);
        if(empty($sub_category))
        {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => 'subcategory id is invalid, subcategory id is category id'
            ], 422);
        }

        $files = [];

        if ($request->hasFile('images')) {
            //check images limit
            $current_images_num = AdImage::query()->where('ad_id', $request['id'])->count();


            if($current_images_num <= 12)
            {
                $images = $request->file('images');
                $images_num = 12 - $current_images_num;
                $images = array_slice($images, 0, $images_num);
    
                $paths = $this->uploadMultiFiles($images, "Ad_num_" . strtotime(now()), "AdsImages");
                foreach ($paths as $path) {
                    $AdImage = new AdImage;
                    $AdImage['ad_id'] = $request['id'];
                    $AdImage['image'] = $path;
                    $AdImage->save();
                    $files[] = $path;
                }    
            }
        }
        
          $request['links'] = $files;
          $ad= Ad::whereId($request['id'])->update([
           'type' => $request->type,
           'title' => $request->title,
           'description' => $request->description,
           'price' => $request->price,
           'region' => $request->region,
           'category_id' => $request->category_id,
           'user_id' => $request->user_id,
           'company_id' => $request->company_id ?? null,
           'governorate_id' => $request->governorate_id ?? 0,
           'city_id' => $request->city_id ?? 0,
           'sub_category_id' =>$request->sub_category_id?? 0,
        //    'slug' => $request->slug,
       ]);


       if ($request->has('value_id') && is_array($request->input('value_id'))) {
        
        ValueAd::where('ad_id', $request['id'])->delete();
        
        // Get the 'value_id' array from the request
        $valueIds = $request->input('value_id');

        // Iterate over each value in the array
        foreach ($valueIds as $valueId) {
            if(value::where('id', $valueId)->exists()) {
                $ValueAd = new ValueAd();
                $ValueAd['ad_id'] = $request['id'];
                $ValueAd['value_id'] = $valueId;
                $ValueAd->save();
            }
        }
    }

       return $this->success('done', 'Updated Successfully . . .');
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy()
    {
        $validatedData = Validator::make(request()->all(), [
            'id' => 'required|integer|exists:ads,id',
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }


        $data = [
            'user_id' => auth()->user()->id,
            'id' => request('id')
        ];

        $ad= Ad::findOrFail($data['id']);

        $images = $ad->images()->get();
        foreach($images as $image)
        {
            $image = $image->getRelativeImagePathAttribute();
            $this->deleteFileByPath($image);
        }


        $ad->images()->delete();
        $this->comment_service->deleteAdComments(request('id'));
        $this->Favourite_service->deleteAdfavorties(request('id'));
        ValueAd::where('ad_id', $data['id'])->delete();


        $ad->delete();
        return $this->success('done', 'deleted Successfully . . .');
    }


        /**
     * Remove the specified resource from storage.
     */
    public function dashboardDestroy()
    {
        $validatedData = Validator::make(request()->all(), [
            'id' => 'required|integer|exists:ads,id',
            // 'user_id' => 'required|integer|exists:users,id', // Add validation for user_id
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }


        $data = [
            // 'user_id' => request('user_id'),
            'id' => request('id')
        ];

        $ad= Ad::findOrFail($data['id']);

        $images = $ad->images()->get();
        foreach($images as $image)
        {
            $image = $image->getRelativeImagePathAttribute();
            $this->deleteFileByPath($image);
        }


        $ad->images()->delete();
        $this->comment_service->deleteAdComments(request('id'));
        $this->Favourite_service->deleteAdfavorties(request('id'));
        ValueAd::where('ad_id', $data['id'])->delete();


        $ad->delete();
        return $this->success('done', 'deleted Successfully . . .');
    }


    public function dashboardUpdateStatus()
    {
        $validatedData = Validator::make(request()->all(), [
            'id' => 'required|integer|exists:ads,id',
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $data = [
            'id' => request('id')
        ];

        $ad= Ad::findOrFail($data['id']);
        $newStatus = $ad['status'] === 0 ? 1 : 0;
        $ad['status'] = $newStatus;
        $ad->save();

        return $this->success($ad, 'deleted Successfully . . .');
    }

    public function dashboardStatus()
    {
        $validatedData = Validator::make(request()->all(), [
            'status' => 'required|in:0,1',
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $ads= Ad::where('status', request('status'))->get();
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token); 
        $adsCollection = new AdSResourceCollection($ads, $user_id);
        return $this->success($adsCollection, 'Done');
    }


    
     public function promote(Request $request)
    {
        try {
            DB::beginTransaction();
            $user=User::whereId(auth()->user()->id)->first();

            $adId=request('adId');
            $ad = Ad::findOrFail($adId);
            if ($ad->promotion_expiry >= now()) {
                echo 'Ad Already Promoted' . PHP_EOL;
                return;
            }
            $promotionPlan = PromotionPlan::findOrFail($request->promotion_plan_id);
            $duration = $request->duration;

            $promotionPrice = $promotionPlan->getPromotionPrice($duration);

            $ad->promote($promotionPlan, $duration);
            $ad->save();

            // Create a new transaction record
            $transaction = new Transaction();
            $transaction->type = 'ad_promotion';
            $transaction->ad_id = $ad->id;
            $transaction->amount = $promotionPrice;
            $transaction->save();

            if ($user->wallet = 0 || $user->wallet<$transaction->amount) {
                return response()->json(['message' => 'Wallet is Empty']);

            } else {
               $user->wallet -= $transaction->amount;
            }

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            echo $e->getMessage();
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Ad Promoted Successfully . . .',
        ], 200);
    }
  public function endPromotion()
    {
        $adId=request('adId');
        $data['id'] = $adId;
        try {
            $ad = Ad::findOrFail($adId);

            $ad->endPromotion();
        } catch (\Exception $e) {
            echo $e->getMessage() . PHP_EOL;
        }
        return response()->json([
            'status' => 'success',
            'message' => 'Ad Promotion Ended Succsessfully . . .',
        ], 200);
    }

    public function getProducts(): JsonResponse
    {
        $region = request('region');
        $category_id = request('category_id');
        $ads = Ad::where('type', 'product')
            ->where('region', $region)
            ->where(function ($query) use ($category_id) {
                $query->where('category_id', $category_id)
                    ->orWherehas('category', function ($query) use ($category_id) {
                        $query->whereNotNull('parent_id')
                            ->where('parent_id', $category_id);
                    });
            })->sortedAds()->paginate(30);

        //add favourite
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token);
        
        // Transform the collection and test something for each ad 
        $ads->getCollection()->transform(function ($ad)use ($user_id) { 
            if($user_id == 0)
            {
                $ad->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;
                }

            $favourities_count = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;
            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);
            
            return $ad;
        });  
            
        return $this->success($ads, 'Done');
    }

    public function getTypes(): JsonResponse
    {
        $region = request('region');
        $category_id = request('category_id');
        $type=request('type');
        $ads = Ad::where('type', $type)
            ->where('approved', 1)
            // ->where('status',1)
            ->where('region', $region)
            ->where(function ($query) use ($category_id) {
                $query->where('category_id', $category_id)
                    ->orWherehas('category', function ($query) use ($category_id) {
                        $query->whereNotNull('parent_id')
                            ->where('parent_id', $category_id);
                    });
            })
            ->sortedAds()->paginate(30);

                //add favourite
                $token = request()->bearerToken();
                $user_id = $this->getIdByToken($token);
                
                // Transform the collection and test something for each ad 
                $ads->getCollection()->transform(function ($ad)use ($user_id) { 
                    if($user_id == 0)
                    {
                        $ad->is_current_user_favourite = false;
                    }
                    else{
                        $favourite = Favourite::where('user_id', $user_id)
                        ->where('ad_id', $ad->id)->exists();
                        $ad->is_current_user_favourite = $favourite;
                        }

                    $favourities_count = Favourite::where('ad_id', $ad->id)->count();
                    $ad->favourities_count = $favourities_count;
                    $user = User::find($ad->user_id);
                    $ad->user = new UserResource($user);
                    
                    return $ad;
                });  


        return $this->success($ads, 'Done');

    }


    public function byCategory(Request $request): JsonResponse
    {

        $validatedData = Validator::make($request->all(), [
            'region' => 'in:egypt,morocco',
            'category_id' => 'required|integer|exists:categories,id',
        ]);


        if ($validatedData->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validatedData->errors()
            ], 422);
        }


            $region = $request['region'];
            $categoryId = $request['category_id'];

            
            $validatedData = Validator::make($request->all(), [
                'category_id' => 'required|integer|exists:categories,id',
            ]);

            if ($validatedData->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validatedData->errors()
                ], 422);
            }

            // Get the category and its child categories
            // $category = Category::with('children')->findOrFail($categoryId);
            // $categoryIds = $category->children->pluck('id')->push($categoryId);
            // return $this->success($categoryIds, 'Done');   

            // $ads = Ad::where('approved',  true)
            //     ->where('category_id', $categoryId)
            //     ->where('region', $region)
            //     ->sortedAds()->paginate(30);

           $minValue = $request['min_value'];
           $maxValue = $request['max_value'];

            $ads = Ad::where('approved', true)
                ->where('category_id', $categoryId)
                ->where('region', $region)
                // ->where('status',1)
                ->when(isset($request['min_value']) && isset($request['max_value']), function ($query) use ($minValue, $maxValue) {
                    return $query->whereBetween('price', [$minValue, $maxValue]);
                })
                ->when(isset($request['min_value']) && !isset($request['max_value']), function ($query) use ($minValue) {
                    return $query->where('price', '>=', $minValue);
                })
                ->when(!isset($request['min_value']) && isset($request['max_value']), function ($query) use ($maxValue) {
                    return $query->where('price', '<=', $maxValue);
                })
                ->when(isset($request['value_id']), function ($query) use ($request) {
                    $valueIds = $request->input('value_id');
                    return $query->whereIn('id', function($subquery) use ($valueIds) {
                        $subquery->select('ad_id')
                            ->from('value_ads')
                            ->whereIn('value_id', $valueIds);
                    });
                })
                ->sortedAds()
                ->paginate(30);


                

                //add favourite
                $token = $request->bearerToken();
                $user_id = $this->getIdByToken($token);

                // Transform the collection and test something for each ad 
                $ads->getCollection()->transform(function ($ad)use ($user_id) { 
                    if($user_id == 0)
                    {
                        $ad->is_current_user_favourite = false;
                    }
                    else{
                        $favourite = Favourite::where('user_id', $user_id)
                        ->where('ad_id', $ad->id)->exists();
                        $ad->is_current_user_favourite = $favourite;
                    }

                    $favourities_count = Favourite::where('ad_id', $ad->id)->count();
                    $ad->favourities_count = $favourities_count;
                    $user = User::find($ad->user_id);
                    $ad->user = new UserResource($user);

                    return $ad;
                });   

 


            return $this->success($ads, 'Done');   
    }

public function bySubCategory(Request $request): JsonResponse
{

    $validatedData = Validator::make(request()->all(), [
        'region' => 'required|in:egypt,morocco',
        'sub_category_id' => 'required|integer|exists:categories,id',
    ]);


    if ($validatedData->fails()) {
        return response()->json([
            'message' => 'Validation failed',
            'errors' => $validatedData->errors()
        ], 422);
    }

    $region = request('region');
    $sub_category_id = request('sub_category_id');
    $minValue = request('min_value');
    $maxValue = request('max_value');

     $ads = Ad::where('approved', true)
         ->where('sub_category_id', $sub_category_id)
         ->where('region', $region)
        //  ->where('status',1)

         ->when(isset($request['min_value']) && isset($request['max_value']), function ($query) use ($minValue, $maxValue) {
             return $query->whereBetween('price', [$minValue, $maxValue]);
         })
         ->when(isset($request['min_value']) && !isset($request['max_value']), function ($query) use ($minValue) {
             return $query->where('price', '>=', $minValue);
         })
         ->when(!isset($request['min_value']) && isset($request['max_value']), function ($query) use ($maxValue) {
             return $query->where('price', '<=', $maxValue);
         })
         ->when(isset($request['value_id']), function ($query) use ($request) {
            $valueIds = $request->input('value_id');
            return $query->whereIn('id', function($subquery) use ($valueIds) {
                $subquery->select('ad_id')
                    ->from('value_ads')
                    ->whereIn('value_id', $valueIds);
            });
        })
         ->sortedAds()
         ->paginate(30);

    
    // $adsQuery = Ad::where('approved', true)
    //               ->where('sub_category_id', $sub_category_id)
    //               ->where('status',1)
    //               ->where('region', $region);
    // $ads = $adsQuery->sortedAds()->paginate(30);

    //add favourite
    $token = request()->bearerToken();
    $user_id = $this->getIdByToken($token);
    
    // Transform the collection and test something for each ad 
    $ads->getCollection()->transform(function ($ad)use ($user_id) { 
        if($user_id == 0)
        {
            $ad->is_current_user_favourite = false;
        }
        else{
            $favourite = Favourite::where('user_id', $user_id)
            ->where('ad_id', $ad->id)->exists();
            $ad->is_current_user_favourite = $favourite;
            }

        $favourities_count = Favourite::where('ad_id', $ad->id)->count();
        $ad->favourities_count = $favourities_count;

        $user = User::find($ad->user_id);
        $ad->user = new UserResource($user);
        
        return $ad;
     });  

    
    return $this->success($ads, 'Done');
}


    public function byCompany(): JsonResponse
    {
        $region = request('region');
        $companyId = request('company_id');
        $ads = Ad::where('approved', true)
            ->where('company_id', $companyId)
            // ->where('status',1)
            ->where('region', $region)
            ->sortedAds()->paginate(30);

        //add favourite
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token);
        
        // Transform the collection and test something for each ad 
        $ads->getCollection()->transform(function ($ad)use ($user_id) { 
            if($user_id == 0)
            {
                $ad->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;
                }

            $favourities_count = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;

            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);

            return $ad;
        });  

        return $this->success($ads, 'Done');
    }

    public function getPending(): JsonResponse
    {
        $ads = Ad::where('approved', false)
            ->where('region', request('region'))
            // ->where('status',1)
            ->sortedAds()->paginate(30);

        //add favourite
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token);
        
        // Transform the collection and test something for each ad 
        $ads->getCollection()->transform(function ($ad)use ($user_id) { 
            if($user_id == 0)
            {
                $ad->is_current_user_favourite = false;
            }
            else{
                $favourite = Favourite::where('user_id', $user_id)
                ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;
                }

            $favourities_count = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;

            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);
                
            return $ad;
        });  
        
        return $this->success($ads, 'Done');
    }

    public function searchAd(Request $request): JsonResponse
    {
        $search = $request['search'];

        //$region = request('region');

        if(isset($search))
        {
            // $ads->where('region', $region);
            $ads = Ad::where('approved', 'like', "1")
            ->where('title', 'like', "%$search%")
            ->orWhere('description', 'like', "%$search%")
            ->where('approved', 'like', "1")
            // ->where('status',1)
            ->sortedAds()->paginate(30);

            //add favourite
            $token = request()->bearerToken();
            $user_id = $this->getIdByToken($token);

            // Transform the collection and test something for each ad 
            $ads->getCollection()->transform(function ($ad)use ($user_id) { 
                if($user_id == 0)
                {
                    $ad->is_current_user_favourite = false;
                }
                else{
                    $favourite = Favourite::where('user_id', $user_id)
                    ->where('ad_id', $ad->id)->exists();
                    $ad->is_current_user_favourite = $favourite;
                    }

                $favourities_count = Favourite::where('ad_id', $ad->id)->count();
                $ad->favourities_count = $favourities_count;

                $user = User::find($ad->user_id);
                $ad->user = new UserResource($user);

                return $ad;
            });  

            return $this->success( $ads, 'Done');
        }
        else{
            $ads = Ad::where('approved', 'like', "1")
            // ->where('status',1)
            ->where('title', 'like', "$search")->sortedAds()->paginate(30);

            //add favourite
            $token = request()->bearerToken();
            $user_id = $this->getIdByToken($token);

            // Transform the collection and test something for each ad 
            $ads->getCollection()->transform(function ($ad)use ($user_id) { 
                if($user_id == 0)
                {
                    $ad->is_current_user_favourite = false;
                }
                else{
                    $favourite = Favourite::where('user_id', $user_id)
                    ->where('ad_id', $ad->id)->exists();
                    $ad->is_current_user_favourite = $favourite;
                    }

                $favourities_count = Favourite::where('ad_id', $ad->id)->count();
                $ad->favourities_count = $favourities_count;

                $user = User::find($ad->user_id);
                $ad->user = new UserResource($user);

                return $ad;
            });  

            return $this->success( $ads, 'Done');

        }

    }


    // public function filterByAttributes(Request $request): JsonResponse
    // {
    //     $region = request('region');
    //     $validator = Validator::make($request->all(), [
    //         'category_id' => 'required|exists:categories,id',
    //         'attributes' => 'array',
    //         'attributes.*' => 'exists:attribute_options,id',
    //         'city' => 'nullable|string',
    //         'subCategory' => 'nullable|exists:categories,id',
    //         'price_from' => 'nullable|numeric',
    //         'price_to' => 'nullable|numeric',
    //     ]);

    //     if ($validator->fails()) {
    //         return response()->json([
    //             'error' => $validator->errors(),
    //         ], 400);
    //     }

    //     $categoryID = $request->input('category_id');
    //     $attributeOptions = $request->input('attributes');
    //     $city = $request->input('city');
    //     $subCategoryID = $request->input('subCategory');
    //     $priceFrom = $request->input('price_from');
    //     $priceTo = $request->input('price_to');

    //     $ads = Ad::where('approved', true)
    //         ->where('category_id', $categoryID)
    //         ->where('region', $region);

    //     if ($city) {
    //         $ads->where('city', $city);
    //     }

    //     if ($subCategoryID) {
    //         $ads->whereHas('category', function ($query) use ($subCategoryID) {
    //             $query->where('parent_id', $subCategoryID);
    //         });
    //     }

    //     if (!empty($attributeOptions)) {
    //         foreach ($attributeOptions as $attributeId => $optionId) {
    //             $ads->whereHas('attributes', function ($query) use ($attributeId, $optionId) {
    //                 $query->where('attribute_id', $attributeId)
    //                     ->where('attribute_option_id', $optionId);
    //             });
    //         }
    //     }

    //     if ($priceFrom && $priceTo) {
    //         $ads->whereBetween('price', [$priceFrom, $priceTo]);
    //     } elseif ($priceFrom) {
    //         $ads->where('price', '>=', $priceFrom);
    //     } elseif ($priceTo) {
    //         $ads->where('price', '<=', $priceTo);
    //     }

    //     $filteredAds = $ads->distinct()->sortedAds()->paginate(30);

    //     return response()->json([
    //         'data' => $filteredAds
    //     ]);
    // }

    public function userAds() {
        
        $ads = Ad::where('user_id', Auth::id())
        // ->where('status',1)
        ->with(['comments', 'category'])->paginate(30);
        // $adsArray = $ads->toArray();
    
        // // إزالة الخصائص غير المرغوب فيها من الإعلانات
        // foreach ($adsArray['data'] as &$ad) {
        //     unset($ad['updated_at'], $ad['attributes']);
    
        //     // إزالة الخصائص غير المرغوب فيها من التعليقات
        //     foreach ($ad['comments'] as &$comment) {
        //         unset($comment['updated_at']);
        //     }
    
        //     // إزالة الخصائص غير المرغوب فيها من الفئة
        //     if (isset($ad['category'])) {
        //         unset($ad['category']['created_at'], $ad['category']['attributes'], $ad['category']['updated_at']);
        //     }
        // }

        //add favourite
            // Transform the collection and test something for each ad 
            $ads->getCollection()->transform(function ($ad) { 
                $favourite = Favourite::where('user_id', Auth::id())
                ->where('ad_id', $ad->id)->exists();
                $ad->is_current_user_favourite = $favourite;

            $favourities_count = Favourite::where('ad_id', $ad->id)->count();
            $ad->favourities_count = $favourities_count;
            
            $user = User::find($ad->user_id);
            $ad->user = new UserResource($user);

            return $ad;
            });  
    
        return $this->success($ads, 'Done');
    }


    public function prometedUserAds(){
        $ads=Ad::where('user_id',request('id'))
        // ->where('status',1)
        ->where('promotion_plan_id' ,'!=',null)->paginate(30);

        //add favourite
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token); 
        $adsCollection = new AdSResourceCollection($ads, $user_id);
        
        return $this->success($adsCollection, 'Done');
    }

    
    public function getApprovedAds(Request $request){

        // $per_page = $request->get('per_page', 30); // Get 'per_page' parameter or default to 30

        $ads = Ad::where('approved', 1)
		->where('status',1)
        ->when(request('category_id'), function ($query) {
            return $query->where('category_id', request('category_id'));
        })
        ->when(request('sub_category_id'), function ($query) {
            return $query->where('sub_category_id', request('sub_category_id'));
        })
        ->when(request('min_value'), function ($query) {
            return $query->where('price', '>=', request('min_value'));
        })
        ->when(request('max_value'), function ($query) {
            return $query->where('price', '<=', request('max_value'));
        })
        ->when($request->governorate_id, function ($query, $governorate_id) {
            return $query->where('governorate_id', $governorate_id);
        })
        ->when($request->city_id, function ($query, $city_id) {
            return $query->where('city_id', $city_id);
        })
        ->orderBy('created_at', 'desc')
        ->get();
        //->paginate($per_page);
         // Add pagination    

        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token); 

        
        // return response()->json([
        //     'data' => new AdSResourceCollection($ads, $user_id),
        //     'links' => [
        //         'first' => $ads->url(1),
        //         'last' => $ads->url($ads->lastPage()),
        //         'prev' => $ads->previousPageUrl(),
        //         'next' => $ads->nextPageUrl(),
        //     ],
        //     'meta' => [
        //         'current_page' => $ads->currentPage(),
        //         'from' => $ads->firstItem(),
        //         'last_page' => $ads->lastPage(),
        //         'path' => $ads->path(),
        //         'per_page' => $ads->perPage(),
        //         'to' => $ads->lastItem(),
        //         'total' => $ads->total(),
        //     ],
        // ]);
        $adsCollection = new AdSResourceCollection($ads, $user_id);
        return $this->success($adsCollection, 'Done');
    }


    public function UpdateApprovedAd(Request $request): JsonResponse{
        $validator = Validator::make($request->all(), [
            'ad_id' => 'required|exists:ads,id',
            'approved' => 'required|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors(),
            ], 400);
        }

        $ad =Ad::where('id',$request['ad_id'])->first();
        $ad['approved'] = $request['approved'];
        $ad->save();

        return $this->success($ad, 'Done');
    }


    public function getIdByToken($token)
{
    if ($token) {
        // Find the token in the database
        $personalAccessToken = PersonalAccessToken::findToken($token);

        if ($personalAccessToken) {
            // Token is valid, authenticate the user
            $user = $personalAccessToken->tokenable;
            return $user->id;
        }
        else{
            return 0;   
        }
    }
    else{
        return 0;
    }
    }

    public function getUserByToken($token)
    {
        if ($token) {
            // Find the token in the database
            $personalAccessToken = PersonalAccessToken::findToken($token);
    
            if ($personalAccessToken) {
                // Token is valid, authenticate the user
                $user = $personalAccessToken->tokenable;
                return $user;
            }
            else{
                return null;   
            }
        }
        else{
            return null;
        }
        }

    public function uploadImages(Request $request){
        $validatedData = Validator::make($request->all(), [
            'id' => 'required|integer|exists:ads,id',
            'images.*' => 'image|mimes:jpeg,png,jpg|max:2048',
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        //check user token
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token); 
        $ad = Ad::where('id',$request->id)->where('user_id', $user_id);


        if(!empty($ad))
        {

            $current_images_num = AdImage::query()->where('ad_id', $request['id'])->count();
            
            if($current_images_num <= 12)
            {
                $images = $request->file('images');
                $images_num = 12 - $current_images_num;
                $images = array_slice($images, 0, $images_num);
    
    
                if ($request->hasFile('images')) {
                    $images = $request->file('images');
                    $paths = $this->uploadMultiFiles($images, "Ad_num_" . strtotime(now()), "AdsImages");
                    foreach ($paths as $path) {
                        $AdImage = new AdImage();
                        $AdImage['ad_id'] = $request['id'];
                        $AdImage['image'] = $path;
                        $AdImage->save();
                        $files[] = $path;
        
                    }
                }
            }
            
            return $this->success('done', 'Updated Images Successfully . . .');
        }
        else{
            return $this->failed('wrong authorization', 'Updated Images failed . . .');

        }
    }

    public function deleteImages(Request $request){
        $validatedData = Validator::make($request->all(), [
            'ad_images_id' => 'required|integer|exists:ad_images,id',
        ]);
        
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }



       $ad_image = AdImage::where('id', $request->ad_images_id)->first();


        //check user token
        $token = request()->bearerToken();
        $user_id = $this->getIdByToken($token); 
        $ad = Ad::where('id',$ad_image->ad_id)->where('user_id', $user_id);

        if(!empty($ad))
        {
            $image = $ad_image->getRelativeImagePathAttribute();
            $this->deleteFileByPath($image);
            $ad_image->delete();
     
            return $this->success('done', 'Delete Images Successfully . . .');
        }
        else{
            return $this->failed('wrong authorization', 'Delete Images failed . . .');

        }
    }
    
    public function filter(Request $request)
    {
        // Extract filters from the request
        $filters = $request->only([
            'name', 
            'email', 
            'type', 
            'display_name', 
            'phone', 
            'address',
            'title', 
            'description', 
            'price', 
            'region', 
            'category_id', 
            'sub_category_id', 
            'governorate_id', 
            'city_id'
        ]);
                
        // Apply the filters using the Ad model's scope
        $ads = Ad::filterAds($filters)->get();

        // Return the filtered results as JSON
        return response()->json($ads);
    }

}
