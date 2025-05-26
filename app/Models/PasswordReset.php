<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PasswordReset extends Model
{
    use HasFactory;

    protected $table = 'password_resets';

    protected $fillable = [
        'phone',
        'email',
        'code',
        'created_at',
        'expires_at'
    ];

    public $timestamps = false; // Disabling timestamps if not using 'created_at' and 'updated_at' columns
}
