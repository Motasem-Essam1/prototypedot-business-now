<?php

namespace App\Http\Resources;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Ad;

class SubcategoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $ads = Ad::where('sub_category_id', (int) $this->id)->count();

        $category =  Category::query()->Where('id', $this->parent_id)->first();

        return [
            'id' => (int) $this->id,
            'name_ar' => (string) $this->name_ar,
            'name_en' => (string) $this->name_en,
            'name_fr' => (string) $this->name_fr,
            'image_app' => $this->image_app ? (string) asset($this->image_app) : "",
            'image_web' => $this->image_web ? (string) asset($this->image_web) : "",
            'created_at' => $this->created_at ? $this->created_at->diffForHumans(): "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans(): "",
            'parent_id' => (string) $this->parent_id,
            'parent_category' => $category,
            'ads_number' => $ads,

        ];    
    }
}
