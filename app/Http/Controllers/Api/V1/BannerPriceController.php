<?php

namespace App\Http\Controllers\Api\V1;

use Illuminate\Http\Request;
use App\Jobs\UpdateBannerPrice;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponses;
use Illuminate\Support\Facades\Validator;

class BannerPriceController extends Controller
{
    use ApiResponses;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $bannerPrices = BannerPrice::all();

        return response()->json([
            'data' => $bannerPrices,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $bannerPrice = BannerPrice::findOrFail(request('id'));

        return response()->json([
            'data' => $bannerPrice,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'one_day_price' => 'required|numeric',
            'three_day_price' => 'required|numeric',
            'seven_day_price' => 'required|numeric',
        ]);
        if ($validatedData->fails()) {
            return $this->failed($validatedData->errors(), 422);
        }

        $request['id'] = request('id');

        UpdateBannerPrice::dispatch($request->all())->onQueue('posting');
        return $this->success('done', 'Banner price updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
