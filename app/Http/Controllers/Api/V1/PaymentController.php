<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Models\Package;
use Illuminate\Http\JsonResponse;
use App\Http\Resources\PaymentResource;
use App\Models\Payment;
use Illuminate\Http\Request;

class PaymentController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $payments = PaymentResource::collection(Payment::all());
        return $this->sendResponse($payments,'data fetched successfully');
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return JsonResponse
     */
    public function show($id): JsonResponse
    {
        $transaction = Payment::find($id);

        if($transaction){
            $transaction = PaymentResource::make($transaction);
            return $this->sendResponse($transaction,'data fetched successfully');
        }
        return $this->sendError('failed',['package dosn\'t exist']);
    }
}
