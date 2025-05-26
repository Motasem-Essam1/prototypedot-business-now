<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\BannerPrice
 *
 * @property int $id
 * @property string $one_day_price
 * @property string $three_day_price
 * @property string $seven_day_price
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Banner|null $banner
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice query()
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereOneDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereSevenDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereThreeDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BannerPrice whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class BannerPrice extends Model
{
    use HasFactory;

    protected $fillable = [
        'one_day_price', 'three_day_price', 'seven_day_price',
    ];

    /**
     * Get the banner associated with the prices.
     */
    public function banner()
    {
        return $this->belongsTo(Banner::class);
    }
}
