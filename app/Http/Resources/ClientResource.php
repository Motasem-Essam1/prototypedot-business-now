<?php

namespace App\Http\Resources;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClientResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'client_id' => (int) $this->id,
            'display_name' => (string) $this->display_name,
            'phone' => (string) $this->phone,
            'profile' => $this->profile ? (string) asset($this->profile) : "",
            'address' => (string) $this->address,
            'status' => (string) $this->status,
            'name'=> $this->user->name,
            'first_name' => (string) $this->user->first_name,
            'last_name' => (string) $this->user->last_name,
            'email'=> $this->user->email,
            'user_id'=>$this->user->id,
            'fcm_token'=>$this->user->fcm_token
        ];
    }
}
