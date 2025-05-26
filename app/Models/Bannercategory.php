<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bannercategory extends Model
{
    use HasFactory;

    protected $fillable = [
        'banners',
        'categories',
    ];

    public function banner()
    {
        return $this->belongsTo(Banner::class, 'banner_id');
    }

}
