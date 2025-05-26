<?php

namespace App\Services;

use App\Models\Category;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use App\Traits\ImageTrait;


/**
 * Class CategoryService.
 */
class CategoryService
{
    use ImageTrait;

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Category::query()->whereNull('parent_id')->orderBy('name_en', 'asc')->get();
    }
 
 
    /**
     * add New Category
     *
     * @param array $data
     * @return array
     */
    public function addCategory(array $data): array
    {
        $category = new Category;
        $category['name_en'] = $data['name_en'];
        $category['name_ar'] = $data['name_ar'];
        $category['name_fr'] = $data['name_fr'];

        if (!empty($data['image_app'])) {
            $data['image_app'] = str_replace('data:image/png;base64,', '', $data['image_app']);
            $imagename = $this->uploadFileBase64($data['image_app'], "CategoryApp" . strtotime(now()), 'Category/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($data['image_web'])) {
            $data['image_web'] = str_replace('data:image/png;base64,', '', $data['image_web']);
            $imagename = $this->uploadFileBase64($data['image_web'], "CategoryWeb" . strtotime(now()), 'Category/image_web');
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
        return Category::query()->whereNull('parent_id')->find($id);
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

        if (!empty($request['image_app'])) {
            $this->deleteFileByPath($category['image_app']);
            $request['image_app'] = str_replace('data:image/png;base64,', '', $request['image_app']);
            $imagename = $this->uploadFileBase64($request['image_app'], "CategoryApp" . strtotime(now()), 'Category/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($request['image_web'])) {
            $this->deleteFileByPath($category['image_web']);
            $request['image_web'] = str_replace('data:image/png;base64,', '', $request['image_web']);
            $imagename = $this->uploadFileBase64($request['image_web'], "CategoryWeb" . strtotime(now()), 'Category/image_web');
            $category['image_web'] = $imagename;
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
        Category::query()->where('parent_id', $category['id'])->delete();
        $category->delete();
    }


    public function uploadImages(Array $request, int $id)
    {

        $category = Category::query()->find($id);

        if (!empty($request['image_app'])) {
            $this->deleteFileByPath($category['image_app']);
            $request['image_app'] = str_replace('data:image/png;base64,', '', $request['image_app']);
            $imagename = $this->uploadFileBase64($request['image_app'], "CategoryApp" . strtotime(now()), 'Category/image_app');
            $category['image_app'] = $imagename;
        }

        if (!empty($request['image_web'])) {
            $this->deleteFileByPath($category['image_web']);
            $request['image_web'] = str_replace('data:image/png;base64,', '', $request['image_web']);
            $imagename = $this->uploadFileBase64($request['image_web'], "CategoryWeb" . strtotime(now()), 'Category/image_web');
            $category['image_web'] = $imagename;
        }
        
        $category->save();
        return $category;
    }
}

