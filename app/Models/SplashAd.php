<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\SplashAd
 *
 * @property int $id
 * @property string $image
 * @property string $action_type
 * @property string $action
 * @property string $expiry_date
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd query()
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereAction($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereActionType($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereExpiryDate($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereImage($value)
 * @method static \Illuminate\Database\Eloquent\Builder|SplashAd whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class SplashAd extends Model
{
    use HasFactory;
    protected $fillable = ['image', 'action_type', 'action', 'expiry_date'];
}
