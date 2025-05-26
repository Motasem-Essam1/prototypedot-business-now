<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\SplashAdPrice
 *
 * @property int $id
 * @property string $one_day_price
 * @property string $three_day_price
 * @property string $seven_day_price
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice query()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereOneDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereSevenDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereThreeDayPrice($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAdPrice whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class SplashAdPrice extends Model
{
    use HasFactory;

    protected $fillable = [
        'one_day_price', 'three_day_price', 'seven_day_price',
    ];
}
