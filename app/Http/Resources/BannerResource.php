<?php

namespace App\Http\Resources;

use App\Models\Bannercategory;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BannerResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

       $Banner_categories = Bannercategory::where('banner_id', $this->id)->get();

        return [
            'id' => $this->id,
            'image' => $this->image ? (string) asset($this->image) : "",
            'action_type' => $this->action_type,
            'action' => $this->action,
            'expiry_date' => $this->expiry_date,
            'category_id' => $this->category_id,
            'Banner_categories' => BannercategoryResource::collection($Banner_categories),
            'created_at' => $this->created_at ? $this->created_at->diffForHumans() : "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans() : "",
        ];    
    }
}
