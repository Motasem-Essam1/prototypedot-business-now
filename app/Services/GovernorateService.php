<?php

namespace App\Services;

use App\Models\Governorate;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class GovernorateService.
 */
class GovernorateService
{

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Governorate::query()->get();
    }
 
 
    /**
     * add New Governorate
     *
     * @param array $data
     * @return array
     */
    public function addGovernorate(array $data): array
    {
        $governorate = new Governorate;
        $governorate['name_en'] = $data['name_en'];
        $governorate['name_ar'] = $data['name_ar'];
        $governorate['name_fr'] = $data['name_fr'];

        if(!empty($data['lang']))
        {
            $governorate['lang'] = $data['lang'];
        }
        else {
             $governorate['lang'] = "";
        }
        
        if(!empty($data['lat']))
        {
            $governorate['lat'] = $data['lat'];
        }
        else {
            $governorate['lat'] = "";
       }

        $governorate->save();
 
        return $governorate->toArray();
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Governorate::query()->find($id);
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
        $governorate = Governorate::query()->find($id);
        $governorate['name_en'] = $request['name_en'];
        $governorate['name_ar'] = $request['name_ar'];
        $governorate['name_fr'] = $request['name_fr'];
        $governorate['lang'] = $request['lang'];
        $governorate['lat'] = $request['lat'];        
        $governorate->save();
        return $governorate;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $governorate = Governorate::query()->find($id);
        $governorate->cities()->delete();
        $governorate->delete();
    }
}
