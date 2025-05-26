<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Models\PromotionPlan;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PromotionPlanController extends Controller
{
    public function index(): JsonResponse
    {
        $promotionPlans = PromotionPlan::all();

        return response()->json([
            'data' => $promotionPlans,
        ]);
    }

    public function show(): JsonResponse
    {
        $promotionPlan = PromotionPlan::findOrFail(request('id'));

        return response()->json([
            'data' => $promotionPlan,
        ]);
    }
}
