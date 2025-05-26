<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PromotionPlan extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $promotionPlans = [
            [
                'name' => 'gold',
                'one_day_price' => 15.99,
                'three_day_price' => 39.99,
                'seven_day_price' => 69.99,
            ],
            [
                'name' => 'silver',
                'one_day_price' => 10.99,
                'three_day_price' => 29.99,
                'seven_day_price' => 49.99,
            ],

        ];

        DB::table('promotion_plans')->insert($promotionPlans);

    }
}
