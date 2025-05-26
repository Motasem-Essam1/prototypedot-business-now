<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\Packages\AddPackageRequest;
use App\Http\Requests\Packages\UpdatePackageRequest;
use App\Http\Requests\Packages\UploadImage;
use App\Http\Resources\PackageResource;
use App\Services\PackageService;
use App\Models\Package;
use Illuminate\Http\Request;

class PackageController extends BaseController
{

    public function __construct(private readonly PackageService $package_service,

    )
    {

    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $packages = $this->package_service->index();
        return $this->sendResponse(PackageResource::collection($packages), "success");
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(AddPackageRequest $request)
    {
        $data = $request->only('title','description' ,'price', 'slug', 'image', 'color', 'status');
        $package = $this->package_service->addPackage($data);

        if($package){
            $package = PackageResource::make($package);
            return $this->sendResponse($package, 'success');
        }else{
            return $this->sendError('something went wrong', []);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $package = $this->package_service->show($id);

        // if(empty($package['image']))
        // {
        //     Package::where('id', $id)->update(array('image' => 'assets/img/subscriptions/ninja.svg'));
        // }

        if(!empty($package))
        {
            return $this->sendResponse(PackageResource::make($package), "success");
        }
        else{
            return $this->sendError('failed',['Package element does not exist to show']);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePackageRequest $request, $id)
    {

        $package = $this->package_service->show($id);

        if(!empty($package))
        {
            $data = $request->only('title','description' ,'price', 'slug', 'color', 'status');
            $response = $this->package_service->update($data, $id);
            return $this->sendResponse($response,'package updated successfully');
 
        }
        else{
            return $this->sendError('failed',['package element does not exist to updated']);
        }
    }

    public function isPublic(Request $request){
        $request->validate([
            'id' => 'required|exists:packages,id',
        ]);
        $data = $request->only('id');
        $package = Package::find($request->id);
        if($package->status == 1){
            $data['status'] = 0;
        }else{
            $data['status'] = 1;
        }
        $package->update($data);
        $user = PackageResource::make($package);
        return $this->sendResponse( $user, $package->is_public == 1 ? 'Success change package status to [ON]' : 'Success change package status to [OFF]');
    }

    // public function assignPackageToUser(Request $request){
    //     $validator = Validator::make($request->all(), [
    //         'user_id' => 'required|exists:users,id',
    //         'package_id' => 'required|exists:packages,id',
    //     ]);

    //     if ($validator->fails()) {
    //         return $this->sendError($validator->messages(), 'something went wrong');
    //     }

    //     $data = $request->only('user_id', 'package_id');
    //     $userData = UserData::where('user_id', $data['user_id'])->first();
    //     $userData->package_id = $data['package_id'];
    //     $userData->user_type = "Service Provider";
    //     if($userData->save()){
    //         $user = UserResource::make(User::with('user_data')->first());
    //         $this->packageDurationService->upgradePackageDuration($data['user_id'], $data['package_id'], $this->packageDurationService->package_months);
    //         return $this->sendResponse( $userData, 'package update success');
    //     }else{
    //         return $this->sendError('something went wrong', []);
    //     }
    // }

    /**
     * Remove the specified resource from storage.
     */
   public function destroy($id)
   {
        $package = $this->package_service->show($id);

        if(!empty($package))
        {
            $this->package_service->destroy($id);

            return $this->sendResponse([], "package deleted successfully");
        }
        else{
            return $this->sendError('failed',['package element does not exist to delete']);
        }
   }

    public function uploadImage(UploadImage $request)
    {
        $package = $this->package_service->show($request['id']);

        if(!empty($package))
        {
            $data = $request->only('id', 'image');
            $response = $this->package_service->uploadImage($data);
            return $this->sendResponse($response,'package updated successfully');
 
        }
        else{
            return $this->sendError('failed',['package element does not exist to updated']);
        }

    }
}
