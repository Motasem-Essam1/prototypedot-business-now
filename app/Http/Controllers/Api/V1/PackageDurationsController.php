<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Models\PackageDuration;
use Illuminate\Http\Request;
use App\Http\Resources\PackageDurationsResource;


class PackageDurationsController extends BaseController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = PackageDurationsResource::collection(PackageDuration::all());
        return $this->sendResponse($data,'data fetched successfully');
    }


    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $check = PackageDuration::where('id', $id)->first();
        if ($check) {
            $data = PackageDurationsResource::make($check);
            return $this->sendResponse($data,'data fetched successfully');
        }
        return $this->sendError('faild',['Subscription history doesn\'t exist']);
    }
}
