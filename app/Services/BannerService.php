<?php

namespace App\Services;

use App\Models\Banner;
use App\Models\Bannercategory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use App\Traits\ImageTrait;

/**
 * Class CityService.
 */
class BannerService
{
    use ImageTrait;

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index(array $data)
    {

        if (isset($data['category_id'])) {
            // Get banner IDs from the Bannercategory table
            $bannercategories = Bannercategory::where('category_id', $data['category_id'])->get();

            // Extract banner IDs
            $bannerIds = $bannercategories->pluck('banner_id');

            return  Banner::whereIn('id', $bannerIds)->get();
        }
        else{
            return Banner::get();

        }
    }
 
 
    /**
     * add New Banner
     *
     * @return array
     */
    public function addBanner($data): array
    {
            // Save Banner Images
            foreach ($data['image'] as $index => $image) {

                
                $image_text = str_replace('data:image/png;base64,', '', $image);
                $image_link = $this->uploadFileBase64($image_text, "banner" . strtotime(now()) . "_{$index}", 'banner');


                $banner = new Banner;
                $banner['image'] = $image_link;
                $banner['action_type'] = $data['action_type'];
                $banner['action'] = $data['action'];
                $banner['expiry_date'] = now()->addDays($data['duration']);
                $banner['category_id'] = $data['category_id'][0];
                $banner->save();

                $banner['image'] = $banner['image'] ? (string) asset($banner['image']) : "";
                $banners[] = $banner;
                
                // Save banner Categories
                foreach ($data['category_id'] as $category) {
                    $banner_category = new Bannercategory;
                    $banner_category['banner_id'] = $banner['id'];
                    $banner_category['category_id'] = $category;
                    $banner_category->save();
                }

            }

            


        return $banners;
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Banner::query()->find($id);
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
        $expiryDate = now()->addDays($request['duration']);
        $banner = Banner::query()->find($id);
        $banner['action_type'] = $request['action_type'];
        $banner['action'] = $request['action'];
        $banner['expiry_date'] = $expiryDate;

        if (isset($request['category_id'])) {
            Bannercategory::query()->where('banner_id',$id)->delete();
            $banner['category_id'] = $request['category_id'][0];

            foreach ($request['category_id'] as $category) {
                $banner_category = new Bannercategory;
                $banner_category['banner_id'] = $banner['id'];
                $banner_category['category_id'] = $category;
                $banner_category->save();
            }
        }
        else{
            $banner['category_id'] = 300;

        }

        
        $banner->save();
        return $banner;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $banner = Banner::query()->find($id);
        $this->deleteFileByPath($banner['image']);
        Bannercategory::where('banner_id', $id)->delete();
        $banner->delete();
    }

    public function uploadImages(Array $request, int $id)
    {
        $banner = Banner::query()->find($id);

        if (!empty($request['image'])) {
            $this->deleteFileByPath($banner['image']);
            $request['image'] = str_replace('data:image/png;base64,', '', $request['image']);
            $imagename = $this->uploadFileBase64($request['image'], "banner" . strtotime(now()), 'banner');
            $banner['image'] = $imagename;
        }   

        $banner->save();
        return $banner;
    }
}
