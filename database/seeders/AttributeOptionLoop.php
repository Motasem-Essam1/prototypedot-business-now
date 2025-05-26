<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AttributeOptionLoop extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $options = [];

        for ($i = 1930; $i < 2025; $i++) {
            $options[] = [
                'name_en' => $i,
                'name_ar' => $i,
                'name_fr' => $i,
                'attribute_id' => 19,
            ];
        }

        for ($i = 1930; $i < 2025; $i++) {
            $options[] = [
                'name_en' => $i,
                'name_ar' => $i,
                'name_fr' => $i,
                'attribute_id' => 25,
            ];
        }

        for ($i = 1930; $i < 2025; $i++) {
            $options[] = [
                'name_en' => $i,
                'name_ar' => $i,
                'name_fr' => $i,
                'attribute_id' => 33,
            ];
        }

        for ($i = 1; $i < 51; $i++) {
            $options[] = [
                'name_en' => $i,
                'name_ar' => $i,
                'name_fr' => $i,
                'attribute_id' => 39,
            ];
        }

        DB::table('attribute_options')->insert($options);
    }
}
