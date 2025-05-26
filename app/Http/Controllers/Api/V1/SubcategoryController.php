<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\SubcategoryRequest;
use App\Http\Resources\SubcategoryResource;
use App\Services\CategoryService;
use App\Services\SubcategoryService;
use Illuminate\Http\Request;
use App\Traits\ImageTrait;

class SubcategoryController extends BaseController
{
    
    use ImageTrait;

    public function __construct(private readonly SubcategoryService $sub_category_service,
                                private readonly CategoryService $category_service)
    {
    }

    /**
     * Display a listing of the resource.
    */
    /**
     * Display a listing of the resource.
     */
/**
 * Display a listing of the resource.
 */
public function index(Request $request)
{
    if(!empty($request['category_id']))
    {
        $category = $this->category_service->show($request['category_id']);
        
        if(!empty($category))
        {
            $sub_categories = $this->sub_category_service->showByCategories($request['category_id']);
            $sub_categories = SubcategoryResource::collection($sub_categories);

            // Convert the resource collection to an array
            $sub_categories = $sub_categories->toArray($request);

            // Define your priority names
            $priorityNames = [
                'Bmw', 'Mercedes Benz', 'Ford', 'Mitsubishi', 'Chevrolet',
                'Jeep', 'Honda', 'Volkswagen', 'Porsche', 'Hyundai', 'Dodge', 'Kia', 
                'Audi', 'Mazda', 'Mini', 'Peugeot', 'Bentley', 'Jaguar', 'Maserati', 
                'Citroen', 'Ferrari', 'Lamborghini', 'Opel', 'Bugatti', 'Aston martin'
            ];

            // Apply sorting based on parent_id and priority names
            $sub_categories = collect($sub_categories)->sortBy(function ($subcategory) use ($priorityNames) {
                if ($subcategory['parent_id'] == 4) {
                    $priorityIndex = array_search($subcategory['name_en'], $priorityNames);
                    return $priorityIndex === false ? PHP_INT_MAX : $priorityIndex;
                }
                return PHP_INT_MAX;
            })->values()->all();

            return $this->sendResponse($sub_categories, "success");
        }
        else
        {
            return $this->sendError('failed',['category element does not exist to show']);
        }
    }
    else
    {
        $categories = $this->sub_category_service->index();
        $sub_categories = SubcategoryResource::collection($categories);

        // Convert the resource collection to an array
        $sub_categories = $sub_categories->toArray($request);

        // Define your priority names
        $priorityNames = [
            'Bmw', 'Mercedes Benz', 'Ford', 'Mitsubishi', 'Chevrolet',
            'Jeep', 'Honda', 'Volkswagen', 'Porsche', 'Hyundai', 'Dodge', 'Kia', 
            'Audi', 'Mazda', 'Mini', 'Peugeot', 'Bentley', 'Jaguar', 'Maserati', 
            'Citroen', 'Ferrari', 'Lamborghini', 'Opel', 'Bugatti', 'Aston martin'
        ];

        // Apply sorting based on parent_id and priority names
        $sub_categories = collect($sub_categories)->sortBy(function ($subcategory) use ($priorityNames) {
            if ($subcategory['parent_id'] == 4) {
                $priorityIndex = array_search($subcategory['name_en'], $priorityNames);
                return $priorityIndex === false ? PHP_INT_MAX : $priorityIndex;
            }
            return PHP_INT_MAX;
        })->values()->all();

        return $this->sendResponse($sub_categories, "success");
    }
}



    /**
     * Store a newly created resource in storage.
     */
    public function store(SubcategoryRequest $request)
    {

            $data = $request->only('name_en','name_ar', 'name_fr', 'image_app', 'image_web', 'parent_id');
            $category = $this->category_service->show($data['parent_id']);

            if(!empty($category))
            {
                $response = $this->sub_category_service->addSubCategory($data);
                return $this->sendResponse($response, "Subcategory created successfully");
            }
            else{
                return $this->sendError('failed',['parent_id is invalid, parent_id is subcategory']);

            }

    }
    

    /**
     * Display a listing of the resource by categories
    */
    public function show(string $id)
    {
        $category = $this->sub_category_service->show($id);

        if(!empty($category))
        {
            return $this->sendResponse(SubcategoryResource::make($category), "success");
        }
        else{
            return $this->sendError('failed',['Subcategory element does not exist to show']);
        }
    }
    
        /**
    * Update the specified resource in storage.
    */
    public function update(SubcategoryRequest $request, string $id)
    {
        $data = $request->only('name_en','name_ar', 'name_fr', 'image_app', 'image_web', 'parent_id');
        $category = $this->category_service->show($data['parent_id']);

        if(!empty($category))
        {
            $sub_category = $this->sub_category_service->show($id);

            if(!empty($sub_category))
            {
                $response = $this->sub_category_service->update($data, $id);
                return $this->sendResponse(SubcategoryResource::make($response), "Subcategory updated successfully");
    
            }
            else{
                return $this->sendError('failed',['Subcategory element does not exist to update']);
            }
        }
        else{
            return $this->sendError('failed',['parent_id is invalid, parent_id is subcategory']);

        }

        //////////////////
        
    }
    
    
    /**
    * Remove the specified resource from storage.
    */
    public function destroy(string $id)
    {
        $category = $this->sub_category_service->show($id);

        if(!empty($category))
        {
            $this->sub_category_service->destroy($id);
            return response()->json(['data'=> [], 'message' => "Subcategory deleted successfully"]);
        }
        else{
            return $this->sendError('failed',['Subcategory element does not exist to delete']);
        }
    }

        /**
    * Remove the specified resource from storage.
    */
    public function destroyWithAds(string $id)
    {
        $category = $this->sub_category_service->show($id);

        if(!empty($category))
        {
            $this->sub_category_service->destroyWithAds($id);
            return response()->json(['data'=> [], 'message' => "Subcategory deleted successfully"]);
        }
        else{
            return $this->sendError('failed',['Subcategory element does not exist to delete']);
        }
    }


    public function uploadImages(Request $request, string $id)
    {
        $category = $this->sub_category_service->show($id);

        if(!empty($category))
        {
            $data = $request->only('image_app', 'image_web');
            $response = $this->sub_category_service->uploadImages($data, $id);
            return $this->sendResponse(SubcategoryResource::make($response), "Subcategory updated images successfully");

        }
        else{
            return $this->sendError('failed',['Subcategory element does not exist to upload Images']);
        }
    }
}
