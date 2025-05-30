<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Favourite extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'ad_id',
        'type'
    ];
    public function user() {
        return $this->belongsTo(User::class,'user_id');
    }

    public  function ad(){
        return $this->belongsTo(Ad::class);
    }
}
