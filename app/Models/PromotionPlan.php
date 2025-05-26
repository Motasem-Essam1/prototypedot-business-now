<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\PromotionPlan
 *
 * @property int $id
 * @property string $name
 * @property string $one_day_price
 * @property string $three_day_price
 * @property string $seven_day_price
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Ad> $ads
 * @property-read int|null $ads_count
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan query()
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereOneDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereSevenDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereThreeDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PromotionPlan whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class PromotionPlan extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'one_day_price',
        'three_day_price',
        'seven_day_price'
    ];

    public function ads()
    {
        return $this->hasMany(Ad::class);
    }

    public function getPromotionPrice($duration)
    {
        switch ($duration) {
            case 1:
                return $this->one_day_price;
            case 3:
                return $this->three_day_price;
            case 7:
                return $this->seven_day_price;
            default:
                return 0;
        }
    }

}
