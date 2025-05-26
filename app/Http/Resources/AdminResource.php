<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AdminResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => (int)$this->id,
            'display_name' => (string)$this->display_name,
            'phone' => (string)$this->phone,
            'profile' => $this->profile ? (string) asset($this->profile) : "",
            'name'=> $this->user->name,
            'email'=> $this->user->email,
            'user_id'=>$this->user->id,
            'role' => [
                'id' => (int)$this->role->id,
                'name' => (string)$this->role->name,
                'create' => (string)$this->role->create,
                'read' => (string)$this->role->read,
                'update' => (string)$this->role->update,
                'delete' => (string)$this->role->delete
            ]
        ];
    }
}
