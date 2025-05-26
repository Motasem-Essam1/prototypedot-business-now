<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CompanyFile extends Model
{
    use HasFactory;

    protected $fillable = [
        'commercial_register',
        'tax_card',
    ];
	
}
