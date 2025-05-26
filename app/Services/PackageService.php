<?php

namespace App\Services;

use App\Models\Package;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use App\Traits\ImageTrait;

/**
 * Class PackageService.
 */
class PackageService
{

    use ImageTrait;

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Package::query()->get();
    }
 
 
    /**
     * add New Package
     *
     * @param array $data
     * @return Builder|Builder[]|Collection|Model
     */
    public function addPackage(array $data)
    {
        $package = new Package;
        $package['title'] = $data['title'];
        $package['description'] = $data['description'];
        $package['price'] = $data['price'];
        $package['slug'] = $data['slug'];
        $package['color'] = $data['color'];
        $package['status'] = $data['status'];

        if ($data['status']) {
            $package['status'] = $data['status'];
        }
        else{
            $package['status'] = 0;
        }


        if ($data['image']) {
            $imagename = $this->uploadFile($data['image'], "Package" . strtotime(now()), 'Package');
            $package['image'] = $imagename;
        }

        $package->save();
 
        return $package;
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Package::query()->find($id);
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
        $package = Package::query()->find($id);
        $package['title'] = $request['title'];
        $package['description'] = $request['description'];
        $package['price'] = $request['price'];
        $package['slug'] = $request['slug'];
        $package['color'] = $request['color'];
        $package['status'] = $request['status'];        
        $package->save();
        return $package;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $package = Package::query()->find($id);
        $this->deleteFileByPath($package['image']);
        $package->delete();
    }

    
    public function uploadImage(Array $request)
    {
        $package = Package::query()->find($request['id']);
        if ($request['image']) {
            $this->deleteFileByPath($package['image']);
            $imagename = $this->uploadFile($request['image'], "Package" . strtotime(now()), 'Package');
            $package['image'] = $imagename;
        } 
        $package->save();

        return $package;
    }
}
