<?php

namespace App\Http\Traits;

use App\Models\Ad;
use App\Models\AdImage;

trait  AdTrait
{
    use ImageTrait;
    public function store($data)
    {

        $ad = Ad::create([

            'type' => $this->data['type'],
            'title' => $this->data['title'],
            'description' => $this->data['description'],
            'price' => $this->data['price'],
            'city' => $this->data['city'],
            'region' => $this->data['region'],
            'category_id' => $this->data['category_id'],
            'user_id' => $this->data['user_id'],
            'company_id' => $this->data['company_id'] ?? null,
        ]);

        // Handle image uploads
        if (isset($data['links'])) {

            foreach ($data['links'] as $image) {

                AdImage::create(['ad_id' => $ad->id, 'image' => $image]);
            }
        }


        // Attach attributes and options to the ad
        // if (isset($data['attributes'])) {
        //     $ad->attributes()->attach($data['attributes']);
        // }





        return $data;
    }

    public function update($data)
    {
        $ad = Ad::findOrFail($data['id']);

        // Update the ad
        $ad->update([
            'type' => $data['type'],
            'title' => $data['title'],
            'description' => $data['description'],
            'price' => $data['price'],
            'city' => $data['city'],
            'region' => $data['region'],
            'category_id' => $data['category_id'],
            'user_id' => $data['user_id'],
            //'company_id' => $this->data['company_id'] ?? null,
            'approved' => ($data['approved'] ? 1 :  0),

        ]);

             // Handle image uploads
             if (isset($data['links'])) {

                foreach ($data['links'] as $image) {
                $ad->images()->create(['ad_id' => $ad->id, 'image' => $image]);
            }
        }

        // Sync attributes and options for the ad
        // if (isset($request['attributes'])) {
        //     $ad->attributes()->sync($request['attributes']);
        // }

        return $data;
    }
}
