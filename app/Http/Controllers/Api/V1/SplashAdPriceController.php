<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Jobs\SplashAdPriceUpdated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SplashAdPriceController extends Controller
{
    public function index(): JsonResponse
    {
        $splashAdPrices = SplashAdPrice::all();

        return response()->json([
            'data' => $splashAdPrices,
        ]);
    }

    public function show(): JsonResponse
    {
        $splashAdPrice = SplashAdPrice::findOrFail(request('id'));

        return response()->json([
            'data' => $splashAdPrice,
        ]);
    }


    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'one_day_price' => 'numeric',
            'three_day_price' => 'numeric',
            'seven_day_price' => 'numeric',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validator->errors()->first(),
            ], 422);
        }
        $request['id'] = request('id');
        SplashAdPriceUpdated::dispatch($request->except(['_method']))->onQueue('posting');

        return response()->json([
            'status' => 'success',
            'message' => 'Splash Ad Price Updated Successfully . . .',
        ], 200);
    }
}
