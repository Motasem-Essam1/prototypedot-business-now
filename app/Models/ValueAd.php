<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ValueAd extends Model
{
    use HasFactory;

    protected $fillable = [
        'value_id',
        'ad_id',
    ];
}
