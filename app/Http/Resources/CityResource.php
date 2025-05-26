<?php

namespace App\Http\Resources;

use App\Models\Governorate;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CityResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $governorate = Governorate::where('id', $this->governorate_id)->first();

        return [
            'id' => $this->id,
            'name_en' => $this->name_en,
            'name_ar' => $this->name_ar,
            'name_fr' => $this->name_fr,
            'lang' => $this->lang,
            'lat' => $this->lat,
            'governorate_id' => $governorate->id,
            'governorate_name_en' => $governorate->name_en,
            'governorate_name_ar' => $governorate->name_ar,
            'governorate_name_fr' => $governorate->name_fr,
            'created_at' => $this->created_at ? $this->created_at->diffForHumans(): "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans(): ""
        ];
    }
}
