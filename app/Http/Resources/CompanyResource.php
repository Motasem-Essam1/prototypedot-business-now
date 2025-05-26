<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CompanyResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'company_id' => (int) $this->id,
            'client_id' => (int) $this->id,//i mean company_id -> i make this due to client error in profile page ->when user type is company and ge client data make this error  
            'display_name' => (string) $this->display_name ? $this->display_name : null,
            'phone' => (string) $this->phone,
            'profile' => $this->profile ? (string) asset($this->profile) : "",
            'address' => (string) $this->address,
            'status' => (string) $this->status,
            'name' => $this->user->name,
            'first_name' => (string) $this->user->first_name ? $this->user->first_name : "",
            'last_name' => (string) $this->user->last_name ? $this->user->last_name : "",
            'description' => (string)$this->description,
            'email' => $this->user->email,
            'user_id' => $this->user->id,
            'category_id' => $this->category ? $this->category->id : null,
            'category_name_en' => $this->category ? $this->category->name_en : null,
            'category_name_ar' => $this->category ? $this->category->name_ar : null,
            'category_name_fr' => $this->category ? $this->category->name_fr : null,
            // 'HasCommercialRegister' => $this->comanyFile ? 1 : 0,
            'HasCommercialRegister' => $this->comanyFile ? 1 : 0,
            'comanyFile' => $this->comanyFile ? CompanyFileResource::make($this->comanyFile) : null,
            'fcm_token'=>$this->user->fcm_token 
        ];
    }
}
