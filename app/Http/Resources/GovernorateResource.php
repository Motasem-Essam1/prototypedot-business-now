<?php

namespace App\Http\Resources;

use App\Models\City;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GovernorateResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name_en' => $this->name_en,
            'name_ar' => $this->name_ar,
            'name_fr' => $this->name_fr,
            'lang' => $this->lang,
            'lat' => $this->lat,
            'cities' => CityResource::collection($this->cities),
            'created_at' => $this->created_at ? $this->created_at->diffForHumans(): "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans(): ""
        ];
 
    }
}
