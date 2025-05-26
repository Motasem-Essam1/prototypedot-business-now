<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Favourite;
use App\Services\FavouriteService;
use App\Traits\ApiResponses;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;


class FavouriteController extends Controller
{

    use ApiResponses;

    public function __construct(private readonly FavouriteService $Favourite_service)
    {
    }


    /**
     * Store a newly created resource in storage.
     */
    public function Favourite(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'ad_id' => 'required|integer|exists:ads,id',
        ]);
        if ($validatedData->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validatedData->errors()
            ], 422);
        }

        $data = $request->only('ad_id');
        $data['user_id'] = Auth::id();
        $data['type'] = 'product';


        $favourite = $this->Favourite_service->getByAdAndUser($data);

        if(!empty($favourite))
        {
            $this->Favourite_service->deletefavorties($data);
            return response()->json([
                'status' => 'success',
                'message' => 'favourite is deleted Succaessfully . . .',
            ], 200);
        }
        else{
            $favourite = $this->Favourite_service->addfavortie($data);

            return response()->json([
                'status' => 'success',
                'message' => 'favourite is added Succaessfully . . .',
            ], 200);
        }

    }

    public function userFavourites(){
        $favourites_ads= Favourite::where('user_id',Auth::id())->with('ad')->paginate(30);
        
        // Transform the collection and test something for each ad 
        $favourites_ads->getCollection()->transform(function ($favourite_ad) { 
        
        $favourite = Favourite::where('user_id', Auth::id())
        ->where('ad_id', $favourite_ad->ad->id)->exists();
        $favourite_ad->ad->is_current_user_favourite = $favourite;

        return $favourite_ad;
        }); 
        
        return $this->success($favourites_ads, 'Done');
    }
}
