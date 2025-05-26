<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $resource = [
            'id' => (int) $this->id,
            'name' => (string) $this->name,
            'email' => (string) $this->email,
            'type' => (string) $this->type,
            'first_name' => (string) $this->first_name,
            'last_name' => (string) $this->last_name,
            'user_type' => (string) $this->type,
            // 'is_mobile' => $this->is_mobile,
            'platform' => $this->platform,
            'token' => $this->token,

        ];

        if ($this->type === 'client') {
            $resource['user'] = new ClientResource($this->client);
        } elseif ($this->type === 'admin') {
            $resource['user'] = new AdminResource($this->admin);
        } elseif ($this->type === 'company') {
            $resource['user'] = new CompanyResource($this->company);
        }

        return $resource;
    }
}
