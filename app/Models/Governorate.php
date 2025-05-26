<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Governorate extends Model
{
    use HasFactory;

      protected $table = 'governorate';

    protected $fillable = [
        'name_en',
        'name_ar',
        'name_fr',
        'lang',
        'lat',
    ];

        /**
     * Get the comments for the blog post.
     */
    public function cities(): HasMany
    {
        return $this->hasMany(City::class);
    }

    /** * Accessor to always load cities. */ 
    public function getCitiesAttribute() { 
        return $this->cities()->get(); 
    }

}
