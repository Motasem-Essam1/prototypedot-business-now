<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CommentResource extends JsonResource
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
            'ad_id' => $this->ad_id,
            'user_id' => $this->user_id,
            'content' => $this->content,
            'rate' => $this->rate,
            'approved' => $this->approved,
            'status' => $this->status,
            'created_at' => $this->created_at ? $this->created_at->diffForHumans(): "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans(): ""
        ];
    }
}
