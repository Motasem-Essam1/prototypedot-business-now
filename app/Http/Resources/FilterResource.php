<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class FilterResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'category_id' => $this->category_id,
            'values' => ValueResource::collection($this->whenLoaded('values')), // Load related values using ValueResource
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
