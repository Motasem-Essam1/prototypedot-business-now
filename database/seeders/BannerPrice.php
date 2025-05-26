<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BannerPrice extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('banner_prices')->insert([
            [
                'one_day_price' => 80,
                'three_day_price' => 150,
                'seven_day_price' => 200
            ]
        ]);

    }
}
