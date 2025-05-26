<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PackageDurationsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'user_id' => +$this->user_id,
            'package_id' => +$this->package_id,
            'package_name' => $this->package->package_name,
            'number_of_months' => +$this->number_of_months,
            'total_price' => +$this->total_price,
            'start_date' => $this->start_date,
            'end_date' => $this->end_date,
            'canceled_at' => $this->canceled_at,
            'created_at' => $this->created_at->diffForHumans(),
            'updated_at' => $this->updated_at->diffForHumans()
        ];
    }
}
