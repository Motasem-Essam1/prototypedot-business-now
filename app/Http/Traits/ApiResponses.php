<?php

namespace App\Http\Traits;

use Illuminate\Http\JsonResponse;

trait ApiResponses{

    public function success($data, $message = null, $code = 200): JsonResponse
    {
        return response()->json([
            'status' => 'success',
            'message' => $message,
            'data' => $data
        ], $code);
    }

    public function failed($message, $code = 400): JsonResponse
    {
        return response()->json([
            'status' => 'failed',
            'message' => $message
        ], $code);
    }
}
