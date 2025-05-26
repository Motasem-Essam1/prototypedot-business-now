<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Controllers\Controller;
use App\Http\Requests\CityRequest;
use App\Http\Resources\CityResource;
use App\Services\CityService;
use Illuminate\Http\Request;

class CityController extends BaseController
{
    
    public function __construct(private readonly CityService $city_service)
    {
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
       $city = $this->city_service->index();
       return $this->sendResponse(CityResource::collection($city), "success");

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CityRequest $request)
    {
        $data = $request->only('name_en','name_ar', 'name_fr', 'lang', 'lat', 'governorate_id');
        $response = $this->city_service->addCity($data);
        return $this->sendResponse($response, "City created successfully");
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $city = $this->city_service->show($id);

        if(!empty($city))
        {
            return $this->sendResponse(CityResource::make($city), "success");
        }
        else{
            return $this->sendError('failed',['City element does not exist to show']);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CityRequest $request, string $id)
    {
        $city = $this->city_service->show($id);

        if(!empty($city))
        {
            $data = $request->only('name_en','name_ar', 'name_fr', 'lang', 'lat', 'governorate_id');
            $response = $this->city_service->update($data, $id);
            return $this->sendResponse($response,'City updated successfully');
 
        }
        else{
            return $this->sendError('failed',['City element does not exist to updated']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $city = $this->city_service->show($id);

        if(!empty($city))
        {
            $this->city_service->destroy($id);
 
            return $this->sendResponse([], "City deleted successfully");
        }
        else{
            return $this->sendError('failed',['City element does not exist to delete']);
        }
    }
}
