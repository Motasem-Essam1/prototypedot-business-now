<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\GovernorateRequest;
use App\Http\Resources\GovernorateResource;
use App\Services\CityService;
use App\Services\GovernorateService;

class GovernorateController extends BaseController
{

    public function __construct(
        private readonly GovernorateService $governorate_service,
        private readonly CityService $city_service
    )
    {
    }
 
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
       $governorate = $this->governorate_service->index();
       return $this->sendResponse(GovernorateResource::collection($governorate), "success");

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(GovernorateRequest $request)
    {
       $data = $request->only('name_en','name_ar', 'name_fr', 'lang', 'lat');
       $response = $this->governorate_service->addGovernorate($data);
       return $this->sendResponse($response, "Governorate created successfully");

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $governorate = $this->governorate_service->show($id);

        if(!empty($governorate))
        {
            return $this->sendResponse(GovernorateResource::make($governorate), "success");
        }
        else{
            return $this->sendError('failed',['Governorate element does not exist to show']);
        }
 
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(GovernorateRequest $request, string $id)
    {
        $governorate = $this->governorate_service->show($id);

        if(!empty($governorate))
        {
            $data = $request->only('name_en','name_ar', 'name_fr', 'lang', 'lat');
            $response = $this->governorate_service->update($data, $id);
            return $this->sendResponse($response,'Governorate updated successfully');
 
        }
        else{
            return $this->sendError('failed',['Governorate element does not exist to updated']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $governorate = $this->governorate_service->show($id);

        if(!empty($governorate))
        {
            $this->governorate_service->destroy($id);
 
            return $this->sendResponse([], "Governorate deleted successfully");
        }
        else{
            return $this->sendError('failed',['Governorate element does not exist to delete']);
        }
    }
}
