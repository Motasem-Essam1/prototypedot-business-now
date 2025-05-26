<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\AdImage
 *
 * @property int $id
 * @property int $ad_id
 * @property string $image
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Ad $ad
* @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Attribute> $attributes
 * @property-read int|null $attributes_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, Category> $children
 * @property-read int|null $children_count
 * @property-read Category|null $parent
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage query()
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage whereAdId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage whereImage($value)
 * @method static \Illuminate\Database\Eloquent\Builder|AdImage whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class AdImage extends Model
{
    use HasFactory;

    protected $fillable = ['ad_id', 'image'];

    public function ad()
    {
        return $this->belongsTo(Ad::class);
    }

    public function getImageAttribute()
    {


        return asset( $this->attributes['image']);
    }

    public function getRelativeImagePathAttribute() { 
        return $this->attributes['image'];
    }
}
