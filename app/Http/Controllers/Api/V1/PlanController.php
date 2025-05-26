<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Jobs\PlanUpdated;
use Illuminate\Http\Request;
use Validator;

class PlanController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'string',
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

        PlanUpdated::dispatch($request->all())->onQueue('posting');

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation error',
                'errors' => $validator->errors(),
            ], 422);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Promotion Plan Updated Successfully . . .',
        ], 200);
    }
}
