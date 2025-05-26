<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CompanyFileResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => (int) $this->id,
            'commercial_register' => $this->commercial_register ? (string) asset($this->commercial_register) : "",
            'tax_card' => $this->tax_card ? (string) asset($this->tax_card) : "",
        ];
    }
}
