<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Resources\BannerResource;
use App\Services\BannerService;
use Carbon\Carbon;
use App\Models\Banner;
use App\Jobs\AddBanner;
use App\Jobs\DeleteBanner;
use App\Jobs\UpdateBanner;
use App\Traits\ApiResponses;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class BannerController extends Controller
{
    use ApiResponses;


    public function __construct(private readonly BannerService $banner_service)
    {
    }
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {      
        $data = $request->only('category_id');
        $banners= $this->banner_service->index($data);
        return response()->json(['data' =>BannerResource::collection($banners)]);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'image' => 'required|array',
            'image.*' => 'required|string',
            'category_id' => 'required|array',
            'category_id.*' => 'required|int',
            'action_type' => 'required|in:url,product,profile,whatsapp',
            'action' => 'required|string',
            'duration' => 'required|integer',
        ]);

        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }
        
        $data = $request->only('image','action_type', 'action', 'duration', 'category_id');
        $response = $this->banner_service->addBanner($request);
        // $response['image'] = $response['image'] ? (string) asset($response['image']) : "";
        return $this->success($response, 'added Successfully . . .');
    }

    /**
     * Display the specified resource.
     */
    public function show()
    {
        $banner = $this->banner_service->show(request('id'));

        if(!empty($banner))
        {
            return response()->json([
                'data' => BannerResource::make($banner)
            ]);
        }
        else{
            return $this->failed(message: "failed Banner element does not exist to show");
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {

        $validatedData = Validator::make($request->all(), [
            'id' => 'required|integer|exists:banners,id',
            'action_type' => 'required|in:url,product,profile,whatsapp',
            'action' => 'required|string',
            'duration' => 'required|in:1,3,7',
            'category_id' => 'array',
            'category_id.*' => 'int',
        ]);

        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $data = $request->only('action_type','action', 'duration', 'category_id');
        $response = $this->banner_service->update($data, $request['id']);
        return $this->success(BannerResource::make($response), 'updated Successfully . . .');

    }

    /**
     * Remove the specified resource from storage.
     */

    public function destroy()
    {
        $category = $this->banner_service->show(request('id'));

        if(!empty($category))
        {
            $this->banner_service->destroy(request('id'));
            return response()->json(['data'=> [], 'message' => "Banner deleted successfully"]);
        }
        else{
            return $this->failed(message: "failed Banner element does not exist to show");
        }
    }

    public function uploadImages(Request $request, string $id)
    {
        $banner = $this->banner_service->show($id);

        if(!empty($banner))
        {
            $data = $request->only('image');
            $response = $this->banner_service->uploadImages($data, $id);
            return response()->json([
                'data' => BannerResource::make($response)
            ]);
        }
        else{
            return $this->failed(message: "failed Banner element does not exist to upload Images");
        }
    }


}
