<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\FilterRequest;
use App\Http\Resources\FilterResource;
use App\Services\FilterService;
use Illuminate\Http\Request;

class FilterController extends BaseController
{
    private readonly FilterService $filter_service;

    public function __construct(FilterService $filter_service)
    {
        $this->filter_service = $filter_service;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if(!empty($request['category_id']))
        {
            $filters = $this->filter_service->byCategory($request['category_id'])->load('values');
            return $this->sendResponse(FilterResource::collection($filters), "success");
        }
        else{
            $filters = $this->filter_service->index()->load('values');
            return $this->sendResponse(FilterResource::collection($filters), "success");
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(FilterRequest $request)
    {
        $data = $request->only('name', 'category_id');
        $response = $this->filter_service->addFilter($data);
        return $this->sendResponse($response, "Filter created successfully");
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $filter = $this->filter_service->show($id)->load('values');

        if (!empty($filter)) {
            return $this->sendResponse(FilterResource::make($filter), "success");
        } else {
            return $this->sendError('failed', ['Filter element does not exist to show']);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(FilterRequest $request, int $id)
    {
        $filter = $this->filter_service->show($id);

        if (!empty($filter)) {
            $data = $request->only('name', 'category_id');
            $response = $this->filter_service->update($data, $id);
            return $this->sendResponse($response, 'Filter updated successfully');
        } else {
            return $this->sendError('failed', ['Filter element does not exist to update']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id)
    {
        $filter = $this->filter_service->show($id);

        if (!empty($filter)) {
            $this->filter_service->destroy($id);
            return $this->sendResponse([], "Filter deleted successfully");
        } else {
            return $this->sendError('failed', ['Filter element does not exist to delete']);
        }
    }
}
