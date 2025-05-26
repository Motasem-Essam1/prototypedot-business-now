<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Value extends Model
{
    use HasFactory;

    protected $fillable = [
        'filter_id',
        'name',
    ];

    public function filter() { 
        return $this->belongsTo(Filter::class);
    }
}
