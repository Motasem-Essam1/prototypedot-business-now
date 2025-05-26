<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FavouriteItem extends Model
{
    use HasFactory;
    protected $fillable = [
        'favourite_id',
        'ad_id'
    ];

    public  function ad(){
        return $this->belongsTo(Ad::class);
    }

    public function favourite(){
        return $this->belongsTo(Favourite::class);

    }
}
