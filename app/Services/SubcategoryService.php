<?php

namespace App\Services;

use App\Models\Category;
use App\Models\Ad;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use App\Traits\ImageTrait;

/**
 * Class SubcategoryService.
 */
class SubcategoryService
{
    use ImageTrait;

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Category::query()->whereNotNull('parent_id')->get();
    }
 
     /**
     * Display a listing of the resource by categories
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function showByCategories(int $id)
    {
        return Category::query()->where('parent_id', $id)->get();
    }

    /**
     * add New Category
     *
     * @param array $data
     * @return array
     */
    public function addSubCategory(array $data): array
    {
        $category = new Category;
        $category['name_en'] = $data['name_en'];
        $category['name_ar'] = $data['name_ar'];
        $category['name_fr'] = $data['name_fr'];
        $category['parent_id'] = $data['parent_id'];

        if (!empty($data['image_app'])) {
            $data['image_app'] = str_replace('data:image/png;base64,', '', $data['image_app']);
            $imagename = $this->uploadFileBase64($data['image_app'], "SubCategoryApp" . strtotime(now()), 'SubCategory/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($data['image_web'])) {
            $data['image_web'] = str_replace('data:image/png;base64,', '', $data['image_web']);
            $imagename = $this->uploadFileBase64($data['image_web'], "SubCategoryWeb" . strtotime(now()), 'SubCategory/image_web');
            $category['image_web'] = $imagename;
        }

        $category->save();
 
        return $category->toArray();
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Category::query()->whereNotNull('parent_id')->find($id);
    }
 
     /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function CheckIsSubCategory(int $id)
    {
        return Category::query()->whereNotNull('parent_id')->find($id);
    }
 

    
    

    /**
     * update the specified resource
     *
     * @param array $request
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function update(Array $request, int $id)
    {
        $category = Category::query()->find($id);
        $category['name_en'] = $request['name_en'];
        $category['name_ar'] = $request['name_ar'];
        $category['name_fr'] = $request['name_fr'];
        $category['parent_id'] = $request['parent_id'];

        if (!empty($request['image_app'])) {
            $this->deleteFileByPath($category['image_app']);
            $request['image_app'] = str_replace('data:image/png;base64,', '', $request['image_app']);
            $imagename = $this->uploadFileBase64($request['image_app'], "SubCategoryApp" . strtotime(now()), 'SubCategory/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($request['image_web'])) {
            $this->deleteFileByPath($category['image_web']);
            $request['image_web'] = str_replace('data:image/png;base64,', '', $request['image_web']);
            $imagename = $this->uploadFileBase64($request['image_web'], "SubCategoryWeb" . strtotime(now()), 'SubCategory/image_web');
            $category['image_web'] = $imagename;
        }

        // Update all ads with the old category ID to the new category ID
        $ads = Ad::query()->where('sub_category_id', $id)->get();
        foreach ($ads as $ad) {
            $ad->category_id = $request['parent_id'];
            $ad->save();
        }

        $category->save();
        return $category;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $category = Category::query()->find($id);
        $this->deleteFileByPath($category['image_app']);
        $this->deleteFileByPath($category['image_web']);
        $category->delete();
    }

        /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroyWithAds(int $id): void
    {
        $category = Category::query()->find($id);
        $this->deleteFileByPath($category['image_app']);
        $this->deleteFileByPath($category['image_web']);
        Ad::query()->where('sub_category_id', $id)->delete();
        $category->delete();
    }


    public function uploadImages(Array $request, int $id)
    {

        $category = Category::query()->find($id);

        if (!empty($request['image_app'])) {
            $this->deleteFileByPath($category['image_app']);
            $request['image_app'] = str_replace('data:image/png;base64,', '', $request['image_app']);
            $imagename = $this->uploadFileBase64($request['image_app'], "SubCategoryApp" . strtotime(now()), 'SubCategory/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($request['image_web'])) {
            $this->deleteFileByPath($category['image_web']);
            $request['image_web'] = str_replace('data:image/png;base64,', '', $request['image_web']);
            $imagename = $this->uploadFileBase64($request['image_web'], "SubCategoryWeb" . strtotime(now()), 'SubCategory/image_web');
            $category['image_web'] = $imagename;
        }

        $category->save();
        return $category;
    }
}
