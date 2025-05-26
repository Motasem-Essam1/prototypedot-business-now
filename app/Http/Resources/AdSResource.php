<?php

namespace App\Http\Resources;

use App\Models\Comment;
use App\Models\Favourite;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Auth;

class AdSResource extends JsonResource
{

    protected $current_user_id;

    public function __construct($resource, $current_user_id)
    {
        parent::__construct($resource);
        $this->current_user_id = $current_user_id;
    }

    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        $average = Comment::where('ad_id',$this->id)->avg('rate');

        $ad = $this->resource; 
        if ($this->current_user_id == 0) {
             $ad->is_current_user_favourite = false; 
        } 
        else { 
            $favourite = Favourite::where('user_id', $this->current_user_id)
            ->where('ad_id', $ad->id) ->exists(); 
            $ad->is_current_user_favourite = $favourite;
        }

        $favourities_count   = Favourite::where('ad_id', $ad->id)->count();

        $user = User::find($this->user_id);

        return [
            'id' => $this->id,
            'type' => $this->type,
            'title' => $this->title,
            'description' => $this->description,
            'price' => $this->price,
            'region' => $this->region,
            'category_id' => $this->category_id,
            'views' => $this->views,
            'user_id' => $this->user_id,
            'user' => new UserResource($user),
            'company_id' => $this->company_id, 
            'approved' => $this->approved,    
            'promotion_expiry' => $this->promotion_expiry,
            'promotion_price' => $this->promotion_price,
            'promotion_plan_id' => $this->promotion_plan_id,
            'created_at' => $this->created_at ? $this->created_at->diffForHumans(): "",
            'updated_at' => $this->updated_at ? $this->updated_at->diffForHumans(): "",
            'governorate_id' => $this->governorate_id,
            'city_id' => $this->city_id,
            'governorate' => $this->governorate,
            'city' => $this->city,
            'sub_category_id' => $this->sub_category_id,
            'average_rate' => $average,
            'images' => $this->images ? ImageResource::collection($this->images) : "",
            'category' => $this->category ? $this->category : "",
            'likes_count' => $this->likes_count,
            'comments_count' => $this->commentsCount,
            'comments' => $this->comments,
            'status' => $this->status,
            'is_current_user_favourite' => $this->is_current_user_favourite,
            'favourities_count' => $favourities_count,
            'link' => $this->link,
            'values' => $this->values,
            'imagescount' => $this->imagescount,        
            'slug' => $this->slug,              
        ];
    }
}
