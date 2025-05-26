<?php

// app/Http/Controllers/Api/V1/ValueController.php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\ValueRequest;
use App\Http\Resources\ValueResource;
use App\Services\ValueService;
use Illuminate\Http\Request;

class ValueController extends BaseController
{
    public function __construct(
        private readonly ValueService $value_service
    )
    {
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if(!empty($request['filter_id']))
        {
            $values = $this->value_service->byFilter($request['filter_id']);
            return $this->sendResponse(ValueResource::collection($values), "success");
        }
        else{
            $values = $this->value_service->index();
            return $this->sendResponse(ValueResource::collection($values), "success");
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ValueRequest $request)
    {
        $data = $request->only('filter_id', 'name');
        $response = $this->value_service->addValue($data);
        return $this->sendResponse($response, "Value created successfully");
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $value = $this->value_service->show($id);

        if (!empty($value)) {
            return $this->sendResponse(ValueResource::make($value), "success");
        } else {
            return $this->sendError('failed', ['Value element does not exist to show']);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ValueRequest $request, string $id)
    {
        $value = $this->value_service->show($id);

        if (!empty($value)) {
            $data = $request->only('filter_id', 'name');
            $response = $this->value_service->update($data, $id);
            return $this->sendResponse($response, 'Value updated successfully');
        } else {
            return $this->sendError('failed', ['Value element does not exist to update']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $value = $this->value_service->show($id);

        if (!empty($value)) {
            $this->value_service->destroy($id);
            return $this->sendResponse([], "Value deleted successfully");
        } else {
            return $this->sendError('failed', ['Value element does not exist to delete']);
        }
    }
}
