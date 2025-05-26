<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Filter extends Model
{
    use HasFactory;

    
    protected $fillable = [
        'name',
        'category_id',
    ];

    public function values() { 
        return $this->hasMany(Value::class);
    }
}
