<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

/**
 * App\Models\Ad
 *
 * @property int $id
 * @property string $type
 * @property string $title
 * @property string $description
 * @property string $price
 * @property string $city
 * @property string $region
 * @property int $category_id
 * @property int $views
 * @property int $user_id
 * @property int|null $company_id
 * @property int $approved
 * @property string|null $promotion_expiry
 * @property string|null $promotion_price
 * @property int|null $promotion_plan_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Attribute> $attributes
 * @property-read int|null $attributes_count
 * @property-read \App\Models\Category $category
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Comment> $comments
 * @property-read int|null $comments_count
 * @property-read \App\Models\Comment $commentsCount
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\AdImage> $images
 * @property-read int|null $images_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Like> $likes
 * @property-read int|null $likes_count
 * @property-read \App\Models\Like $likesCount
 * @property-read \App\Models\PromotionPlan|null $promotionPlan
 * @method static \Illuminate\Database\Eloquent\Builder|Ad newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Ad newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Ad query()
 * @method static \Illuminate\Database\Eloquent\Builder|Ad sortedAds()
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereApproved($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereCategoryId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereCity($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereCompanyId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad wherePrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad wherePromotionExpiry($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad wherePromotionPlanId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad wherePromotionPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereRegion($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereTitle($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereType($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereUserId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Ad whereViews($value)
 * @mixin \Eloquent
 */
class Ad extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'description', 'price', 'region', 'category_id', 'user_id', 'company_id', 'type', 'views', 'image','sub_category_id', 'approved', 'promotion_expiry', 'promotion_price', 'promotion_plan_id', 'governorate_id', 'city_id', 'slug'];

    protected $with = ['images', 'category', 'subcategory', 'attributes', 'likesCount', 'commentsCount', 'governorate', 'city'];

    /**
     * Append link attribute to model's array form.
     *
     * @var array
     */
    protected $appends = ['link', 'values', 'imagescount'];

    protected $orderBy = 'created_at';
    protected $sortDirection = 'desc';

    public function scopeSortedAds($query)
    {
        return $query->orderByRaw("CASE
                WHEN promotion_plan_id = 1 THEN 0
                WHEN promotion_plan_id = 2 THEN 1
                ELSE 2
            END, $this->orderBy $this->sortDirection");
    }

    public function images()
    {
        return $this->hasMany(AdImage::class);
    }


    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }

    public function subcategory()
    {
        return $this->belongsTo(Category::class, 'sub_category_id', 'id');
    }


    public function attributes()
    {
        return $this->belongsToMany(Attribute::class, 'ad_attribute')
            ->withPivot(['attribute_option_id'])
            ->withTimestamps()
            ->with('options');
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }

    public function likesCount()
    {
        return $this->hasOne(Like::class)
            ->selectRaw('ad_id, count(*) as likes_count')
            ->groupBy('ad_id')
            ->withDefault(['likes_count' => 0]);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    
    // Define the relationship to Governorate
    public function governorate()
    {
        return $this->belongsTo(Governorate::class);
    }

        // Define the relationship to Governorate
        public function city()
        {
            return $this->belongsTo(City::class);
        }

    public function commentsCount()
    {
        return $this->hasOne(Comment::class)
                ->selectRaw('ad_id, count(*) as comments_count')
                ->selectRaw('ad_id, SUM(rate) as total_rating')
                ->selectRaw('ad_id, AVG(rate) as average_rating')
                ->groupBy('ad_id')
                ->withDefault(['comments_count' => 0]);
    }

    public function promotionPlan()
    {
        return $this->belongsTo(PromotionPlan::class);
    }

    public function isPromoted()
    {
        return $this->promotion_plan_id !== null && $this->promotion_expiry !== null && $this->promotion_expiry >= Carbon::now();
    }

    public function promote($promotionPlan, $duration)
    {
        $this->promotion_plan_id = $promotionPlan->id;
        $this->promotion_price = $this->getPromotionPrice($promotionPlan, $duration);
        $this->promotion_expiry = Carbon::now()->addDays($duration);
        $this->save();
    }

    public function getPromotionPrice($promotionPlan, $duration)
    {
        switch ($duration) {
            case 1:
                return $promotionPlan->one_day_price;
            case 3:
                return $promotionPlan->three_day_price;
            case 7:
                return $promotionPlan->seven_day_price;
            default:
                return null;
        }
    }

    public function endPromotion()
    {
        $this->promotion_plan_id = null;
        $this->promotion_price = null;
        $this->promotion_expiry = null;
        $this->save();
    }

        /**
     * Generate the link for the ad.
     *
     * @return string
     */
    public function getLinkAttribute()
    {
        return  "https://business-egy.com/shop/{$this->id}";
    }

    public function getPriceAttribute($value)
    {
        // Convert to integer
        $intValue = (int)$value;

        // Format as a string with comma as thousand separator
        $formattedValue = number_format($intValue, 0, '.', ',');

        return $formattedValue;
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }


    public function values() { 
        return $this->belongsToMany(Value::class, 'value_ads', 'ad_id', 'value_id');
    }

    public function getValuesAttribute() { 
        return $this->values()->get()->toArray();
    }

    public function getimagescountAttribute()
    {
        return $this->images()->count();
    }

    public function viewers()
    {
        return $this->belongsToMany(User::class, 'ad_user_views')->withTimestamps();
    }

    // Define the dynamic relationship to Client (only if user is a client)
    public function client()
    {
        return $this->belongsTo(Client::class, 'user_id', 'user_id');
    }

    // Define the dynamic relationship to Company (only if user is a company)
    public function company()
    {
        return $this->belongsTo(Company::class, 'user_id', 'user_id');
    }

    /**
     * Apply filters to the Ads.
     *
     * @param Builder $query
     * @param array $filters
     * @return Builder
     */
    public function scopeFilterAds(Builder $query, $filters)
    {
        //id use or ad
        if (isset($filters['type'])) {
            $query->whereHas('user', function ($query) use ($filters) {
                $query->where('type', $filters['type']);
            });
        }
        
        if (isset($filters['name'])) {
            $query->whereHas('user', function ($query) use ($filters) {
                $query->where('name', 'like', '%' . $filters['name'] . '%');
            });
        }
        
        if (isset($filters['email'])) {
            $query->whereHas('user', function ($query) use ($filters) {
                $query->where('email', 'like', '%' . $filters['email'] . '%');
            });
        }
        
        if (isset($filters['display_name'])) {
            $query->whereHas('user.client', function ($query) use ($filters) {
                $query->where('display_name', 'like', '%' . $filters['display_name'] . '%');
            })
            ->orWhereHas('user.company', function ($query) use ($filters) {
                $query->where('display_name', 'like', '%' . $filters['display_name'] . '%');
            });
        }
        
        if (isset($filters['phone'])) {
            $query->whereHas('user.client', function ($query) use ($filters) {
                $query->where('phone', 'like', '%' . $filters['phone'] . '%');
            })
            ->orWhereHas('user.company', function ($query) use ($filters) {
                $query->where('phone', 'like', '%' . $filters['phone'] . '%');
            });
        }
        
        if (isset($filters['address'])) {
            $query->whereHas('user.client', function ($query) use ($filters) {
                $query->where('address', 'like', '%' . $filters['address'] . '%');
            })
            ->orWhereHas('user.company', function ($query) use ($filters) {
                $query->where('address', 'like', '%' . $filters['address'] . '%');
            });
        }
        
        if (isset($filters['title'])) {
            $query->where('title', 'like', '%' . $filters['title'] . '%');
        }
        
        if (isset($filters['description'])) {
            $query->where('description', 'like', '%' . $filters['description'] . '%');
        }
        
        if (isset($filters['price'])) {
            $query->where('price', '=', $filters['price']);
        }
        
        if (isset($filters['region'])) {
            $query->where('region', 'like', '%' . $filters['region'] . '%');
        }
        
        if (isset($filters['category_id'])) {
            $query->where('category_id', '=', $filters['category_id']);
        }
        
        if (isset($filters['sub_category_id'])) {
            $query->where('sub_category_id', '=', $filters['sub_category_id']);
        }
        
        if (isset($filters['governorate_id'])) {
            $query->where('governorate_id', '=', $filters['governorate_id']);
        }
        
        if (isset($filters['city_id'])) {
            $query->where('city_id', '=', $filters['city_id']);
        }

        return $query;    
    }

    public function scopeFilterBySearchAndApproved(Builder $query, $filters)
    {
        if (isset($filters['search'])) {
            $search = $filters['search'];
    
            $query->where(function ($query) use ($search) {
                $query->where('id', $search)
                    ->orWhere('title', 'like', '%' . $search . '%')
                    ->orWhere('description', 'like', '%' . $search . '%')
                    ->orWhere('type', 'like', '%' . $search . '%')
                    ->orWhere('price', $search)
                    ->orWhereHas('category', function ($query) use ($search) {
                        $query->where('name_en', 'like', '%' . $search . '%')
                        ->orWhere('name_ar', 'like', '%' . $search . '%')
                        ->orWhere('name_fr', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('subcategory', function ($query) use ($search) {
                        $query->where('name_en', 'like', '%' . $search . '%')
                        ->orWhere('name_ar', 'like', '%' . $search . '%')
                        ->orWhere('name_fr', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('governorate', function ($query) use ($search) {
                        $query->where('name_en', 'like', '%' . $search . '%')
                        ->orWhere('name_ar', 'like', '%' . $search . '%')
                        ->orWhere('name_fr', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('city', function ($query) use ($search) {
                        $query->where('name_en', 'like', '%' . $search . '%')
                        ->orWhere('name_ar', 'like', '%' . $search . '%')
                        ->orWhere('name_fr', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('user', function ($query) use ($search) {
                        $query->where('id', $search)
                            ->orWhere('name', 'like', '%' . $search . '%')
                            ->orWhere('email', 'like', '%' . $search . '%')
                            ->orWhere('type', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('user.client', function ($query) use ($search) {
                        $query->where('phone', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('user.company', function ($query) use ($search) {
                        $query->where('phone', 'like', '%' . $search . '%');
                    });
            });
        }
    
        if (isset($filters['approved'])) {
            $query->where('approved', $filters['approved']);
        }
    
        return $query;
    }
    
    

    
}
