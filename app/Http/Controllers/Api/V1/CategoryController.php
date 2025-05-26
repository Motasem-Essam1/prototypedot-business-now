<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\CategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Attribute;
use App\Services\CategoryService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;


class CategoryController extends BaseController
{
    public function __construct(private readonly CategoryService $category_service)
    {
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories = $this->category_service->index();
        return $this->sendResponse(CategoryResource::collection($categories), "success");
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CategoryRequest $request)
    {
            $data = $request->only('name_en','name_ar', 'name_fr', 'image_app', 'image_web');
            $response = $this->category_service->addCategory($data);
            return $this->sendResponse($response, "Category created successfully");

    }
    
    /**
    * Display the specified resource.
    */
    public function show(string $id)
    {

        $category = $this->category_service->show($id);

        if(!empty($category))
        {
            return $this->sendResponse(CategoryResource::make($category), "success");
        }
        else{
            return $this->sendError('failed',['Category element does not exist to show']);
        }
    }

    
    public function attribute(): JsonResponse
    {
        $category = Attribute::where('category_id', request('category_id'))->get();
        return response()->json(['data' => $category]);
    }

    /**
    * Update the specified resource in storage.
    */
    public function update(CategoryRequest $request, string $id)
    {
        $category = $this->category_service->show($id);

        if(!empty($category))
        {
            $data = $request->only('name_en','name_ar', 'name_fr', 'image_app', 'image_web');
            $response = $this->category_service->update($data, $id);
            return $this->sendResponse(CategoryResource::make($response), "category updated successfully");

        }
        else{
            return $this->sendError('failed',['Category element does not exist to update']);
        }
    }

    /**
    * Remove the specified resource from storage.
    */
    public function destroy(string $id)
    {
        $category = $this->category_service->show($id);

        if(!empty($category))
        {
            $this->category_service->destroy($id);
            return response()->json(['data'=> [], 'message' => "category deleted successfully"]);
        }
        else{
            return $this->sendError('failed',['category element does not exist to delete']);
        }
    }

    public function uploadImages(Request $request, string $id)
    {
        $category = $this->category_service->show($id);

        if(!empty($category))
        {
            $data = $request->only('image_app', 'image_web');
            $response = $this->category_service->uploadImages($data, $id);
            return $this->sendResponse(CategoryResource::make($response), "category updated images successfully");

        }
        else{
            return $this->sendError('failed',['Category element does not exist to upload Images']);
        }
    }
    
}
