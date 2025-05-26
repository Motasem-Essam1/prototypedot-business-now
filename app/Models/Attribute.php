<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Attribute
 *
 * @property int $id
 * @property string $name_en
 * @property string $name_ar
 * @property string $name_fr
 * @property int $category_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Ad> $ads
 * @property-read int|null $ads_count
 * @property-read \App\Models\Category $category
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\AttributeOption> $options
 * @property-read int|null $options_count
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute query()
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereCategoryId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereNameAr($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereNameEn($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereNameFr($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Attribute whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class Attribute extends Model
{
    use HasFactory;

    protected $fillable = ['name_en', 'name_ar', 'name_fr', 'category_id'];

    protected $with = ['options'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function ads()
    {
        return $this->belongsToMany(Ad::class, 'ad_attribute', 'attribute_id', 'ad_id')
            ->withPivot('attribute_option_id')
            ->withTimestamps();
    }


    public function options()
    {
        return $this->hasMany(AttributeOption::class)->orderBy('name_en','Asc');
    }
}
