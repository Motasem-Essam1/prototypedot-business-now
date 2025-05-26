<?php

namespace App\Services;

use App\Models\City;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class CityService.
 */
class CityService
{
    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return City::query()->get();
    }
 
 
    /**
     * add New City
     *
     * @param array $data
     * @return array
     */
    public function addCity(array $data): array
    {
        $city = new City;
        $city['name_en'] = $data['name_en'];
        $city['name_ar'] = $data['name_ar'];
        $city['name_fr'] = $data['name_fr'];

        if(!empty($data['lang']))
        {
            $city['lang'] = $data['lang'];
        }
        else {
             $city['lang'] = "";
        }
        
        if(!empty($data['lat']))
        {
            $city['lat'] = $data['lat'];
        }
        else {
            $city['lat'] = "";
       }

        $city['governorate_id'] = $data['governorate_id'];
        $city->save();
 
        return $city->toArray();
    }

    public function getCityByGovernorateId(int $governorateId): Collection{
        return City::query()->where('governorate_id', $governorateId)->get();
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return City::query()->find($id);
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
        $city = City::query()->find($id);
        $city['name_en'] = $request['name_en'];
        $city['name_ar'] = $request['name_ar'];
        $city['name_fr'] = $request['name_fr'];
        $city['lang'] = $request['lang'];
        $city['lat'] = $request['lat'];
        $city['governorate_id'] = $request['governorate_id'];
        $city->save();
        return $city;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $city = City::query()->find($id);
        $city->delete();
    }
}
