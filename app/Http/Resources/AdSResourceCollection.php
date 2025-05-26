<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\ResourceCollection;

class AdSResourceCollection extends ResourceCollection
{
    protected $current_user_id;

    public function __construct($resource, $current_user_id)
    {
        parent::__construct($resource);
        $this->current_user_id = $current_user_id;
    }

    public function toArray($request)
    {
        return $this->collection->map(function($ad) use ($request) {
            return (new AdSResource($ad, $this->current_user_id))->toArray($request);
        })->all();
    }
}
