<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Ad;
class CategoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        $ads = Ad::where('category_id', (int) $this->id)->count();

        return [
            'id' => (int) $this->id,
            'parent_id' => (string) $this->parent_id,
            'name_ar' => (string) $this->name_ar,
            'name_en' => (string) $this->name_en,
            'name_fr' => (string) $this->name_fr,
            'image_app' => $this->image_app ? (string) asset($this->image_app) : "",
            'image_web' => $this->image_web ? (string) asset($this->image_web) : "",
            'created_at' => $this->created_at ? $this->created_at->diffForHumans() : "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans() : "",
            'ads_number' => $ads,

        ];
    }
}
