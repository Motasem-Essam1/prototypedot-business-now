<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterRequest;
use App\Http\Resources\UserResource;
use App\Models\City;
use App\Models\Governorate;
use App\Models\User;
use App\Models\Ad;
use App\Models\Client;
use App\Models\Company;
use App\Models\Category;
use App\Services\UserService;
use App\Traits\ApiResponses;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

use Illuminate\Support\Facades\Hash;
use App\Exports\UsersExport; 
use Maatwebsite\Excel\Facades\Excel;

class UserController extends Controller
{
    use ApiResponses;

    public function __construct(private readonly UserService $user_service)
    {

    }


    /**
     * All users
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $users = UserResource::collection(User::all());
        return $this->success($users, 'Done', Response::HTTP_OK);
    }

    /**
     * Show specific user
     *
     * @param User $user
     * @return JsonResponse
     */
    public function show(): JsonResponse
    {
        $user = User::findOrFail(request('id'));
        return $this->success(new UserResource($user), 'Done', Response::HTTP_OK);
    }

    /**
     * Update specific user
     *
     * @param Request $request
     * @param User $user
     * @return JsonResponse
     */
    public function update(Request $request): JsonResponse
    {
        $user = User::findOrFail(request('id'));
        if ($user->id !== Auth::user()->id) {
            return $this->failed('Not authorized to change this user data', 401);
        }

        $user->update($request->all());
        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }

    /**
     * Update specific user
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function updateProfile(Request $request): JsonResponse
    {

        $user = $this->user_service->getUserType();

        // Validate the phone number
        $validator = Validator::make($request->all(), [
            'email' => 'nullable|string|email|max:255|unique:users,email,' . $user['id'],
            'phone' => [
                'nullable',
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                function ($attribute, $value, $fail) use ($user)  {
                    
                    // Normalize the phone number by removing all spaces
                    $normalizedPhone = preg_replace('/\s+/', '', $value);
                    
                    if ($user['type'] == 'client') {
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->where('id', '!=', $user['client']['id'])->exists();
                    }
                    else if ($user['type'] == 'company') {
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->where('id', '!=', $user['company']['id'])->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->exists();
                    }
                    if ($companyExists || $clientExists) {
                        $fail('The phone number has already been taken.');
                    }
                },
            ],
            'password' => 'string|min:8',
            'old_password' => 'required_with:password|string|min:8', // New field for old password
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Check if the old password matches if a new password is provided
        if ($request->filled('password') && !Hash::check($request->input('old_password'), $user['password'])) {
            return response()->json(['errors' => 'Old password does not match'], 422);
        }
        
        $user_data = [
            'display_name' => $request['display_name'],
            'phone'        => $request['phone'],
            'address'      => $request['address'],
            'profile'      => $request['profile'],
            'email'      => $request['email'],
        ];

        $user = $this->user_service->updateUser($user_data);

        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }

    public function updateProfileImage(Request $request): JsonResponse
    {

        $user = $this->user_service->updateUserImage($request);

        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }



    /**
     * Update specific user
     *
     * @return JsonResponse
     */
    public function userProfile(): JsonResponse
    {
        $user = $this->user_service->getUserType();
        $user['token'] = request()->bearerToken();        
        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }

    public function userByToken(): JsonResponse
    {
        $user = Auth::user();
        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }


    /**
     * Update specific user
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function updatePassword(Request $request): JsonResponse
    {
        $user = $this->user_service->getUserType();

         // Validate the phone number
         $validator = Validator::make($request->all(), [
            // 'old_password' => 'required|string',
            'password' => 'string|min:8|confirmed',
            'old_password' => 'required_with:password|string|min:8', // New field for old password
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        
        // Check if the old password matches if a new password is provided
        if ($request->filled('password') && !Hash::check($request->input('old_password'), $user['password'])) {
            return response()->json(['errors' => 'Old password does not match'], 422);
        }
       

        $user_data = [
            'password' => $request['password'],
        ];
        
        $user = $this->user_service->updateUser($user_data);
        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }


    /**
     * Destroy specific user.
     *
     * @param User $user
     * @return JsonResponse|bool
     */
    public function destroy(): JsonResponse|bool
    {
        $user = User::findOrFail(request('id'));
        $user->delete();
        return $this->success(null, 'Deleted', Response::HTTP_NO_CONTENT);
    }


    //for Dashbaord
    public function createUser(RegisterRequest $request): JsonResponse|bool
    {
        if($request['user_type'] == 'user')
        {
            $request['user_type'] = 'client';
        }

        $user = User::create([
            'name' => $request->input('name'),
            'email' => $request->input('email') ?? null,
            'password' => Hash::make($request->input('password')),
            'type' => $request->input('user_type'),
            'wallet' =>0
        ]);

        if (isset($request['is_mobile'])) {
            $user['is_mobile'] = (Boolean) $request['is_mobile'];
        } else {
            $user['is_mobile'] = false;
        }

        
        $user->save();


        if($request['user_type'] == 'client')
        {
            Client::create([
                'display_name' => $request->input('name'),
                'phone' => $request->input('phone') ?? null,
                'user_id' => $user->id
            ]);
        }
        
        else if($request['user_type'] == 'company')
        {
            Company::create([
                'display_name' => $request->input('name'),
                'phone' => $request->input('phone') ?? null,
                'description' => "",
                'user_id' => $user->id
            ]);
        }

        return $this->success(new UserResource($user), 'Done', Response::HTTP_CREATED);
    }


    public function userUpdate(Request $request): JsonResponse|bool
    {
        if($request['id'])
        {
            $user = $this->user_service->getUserbyId($request['id']);

            if (!$user)
            {
                return response()->json(['errors' => 'User does not exist'], 422);
            }
        }
        else{
            return response()->json(['errors' => 'user id is required'], 422);

        }

       

        // Validate the phone number
        $validator = Validator::make($request->all(), [
            'email' => 'nullable|string|email|max:255|unique:users,email,' . $user['id'],
            'phone' => [
                'nullable',
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                function ($attribute, $value, $fail) use ($user)  {
                    
                    // Normalize the phone number by removing all spaces
                    $normalizedPhone = preg_replace('/\s+/', '', $value);
                    
                    if ($user['type'] == 'client') {
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->where('id', '!=', $user['client']['id'])->exists();
                    }
                    else if ($user['type'] == 'company') {
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->where('id', '!=', $user['company']['id'])->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->exists();
                    }
                    if ($companyExists || $clientExists) {
                        $fail('The phone number has already been taken.');
                    }
                },
            ],
            'password' => 'string|min:8',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        
        $user_data = [
            'id' => $request['id'],
            'display_name' => $request['display_name'],
            'phone'        => $request['phone'],
            'address'      => $request['address'],
            'profile'      => $request['profile'],
            'email'      => $request['email'],
        ];

        $user = $this->user_service->updateUserByDashboard($user_data);

        return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }

    public function userPassword(Request $request): JsonResponse|bool
    {
        if($request['id'])
        {
            $user = $this->user_service->getUserbyId($request['id']);

            if (!$user)
            {
                return response()->json(['errors' => 'User does not exist'], 422);
            }
        }
        else{
            return response()->json(['errors' => 'user id is required'], 422);

        }

        // Validate the phone number
        $validator = Validator::make($request->all(), [
           'password' => 'string|min:8|confirmed',

       ]);

       // Check if validation fails
       if ($validator->fails()) {
           return response()->json(['errors' => $validator->errors()], 422);
       }
      

       $user_data = [
            'id' => $request['id'],
           'password'      => $request['password'],
       ];
       $user = $this->user_service->updateUserByDashboard($user_data);
       return $this->success(new UserResource($user), "Done", Response::HTTP_ACCEPTED);
    }
    public function getPlatformCount(Request $request)
    {
        $ads_filters = $request->only(['ads-search', 'approved']);
        $category_filters = $request->only(['category-id']);

        $ads_filters['search'] = $ads_filters['ads-search'];
        $androidCount = User::where('platform', 'Android')->count();
        $iosCount = User::where('platform', 'iOS')->count();
        $ads = Ad::filterBySearchAndApproved($ads_filters)->orderBy('created_at', 'desc')->count();
        $category = Category::query()->whereNull('parent_id')->count();

        if ($request->has('category-id')){
            $subcategory = Category::query()->where('parent_id', $request['category-id'])->count();
        }
        else{
            $subcategory = Category::query()->whereNotNull('parent_id')->count();
        }  
        $users = User::count();
        $companies = Company::count();
        $clients = Client::count();
        $governorates = Governorate::count();
        $cities = City::count();

        $platformData = [
            'Android' => $androidCount,
            'iOS' => $iosCount,
            'ads' => $ads,
            'categories' => $category,
            'subcategories' => $subcategory,
            'users' => $users,
            'companies' => $companies,
            'clients' => $clients,
            'governorates' => $governorates,
            'cities' => $cities,
        ];

        return $this->success($platformData, 'Done', Response::HTTP_CREATED);

    }

    public function exportUsers()
    {
        $users = User::all();

        return Excel::download(new UsersExport($users), 'users.xlsx');
    }
}
