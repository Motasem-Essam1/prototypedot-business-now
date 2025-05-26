<?php

namespace App\Services;

use App\Models\Favourite;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class CityService.
 */
class FavouriteService
{

    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function getByAdAndUser(array $data)
    {
        return Favourite::query()->where('user_id', $data['user_id'])
                                 ->where('ad_id',$data['ad_id'])->first();
    }
    /**
     * add New favortie
     *
     * @param array $data
     * @return array
     */
    public function addfavortie(array $data): array
    {
        $favourite = new Favourite;
        $favourite['user_id'] = $data['user_id'];
        $favourite['ad_id'] = $data['ad_id'];
        $favourite['type'] = $data['type'];
        $favourite->save();
        return $favourite->toArray();
    }


        /**
     * delete the specified resource
     *
     * @param array $data
     * @return void
     */
    public function deletefavorties(array $data)
    {
        Favourite::query()->where('user_id', $data['user_id'])
        ->where('ad_id',$data['ad_id'])->delete();
    }
 
    public function deleteAdfavorties(int $id)
    {
        Favourite::query()->where('ad_id',$id)->delete();
    }
 
}
