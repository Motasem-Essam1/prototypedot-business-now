<?php

namespace App\Http\Resources;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BannercategoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $category = Category::where('id', $this->category_id)->first();

        return [
            'id' => $this->id,
            'banner_id' => $this->banner_id,
            'category_id' => $this->category_id,
            'category' => $category,
            'created_at' => $this->created_at ? $this->created_at->diffForHumans() : "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans() : "",
        ];    
    }
}
