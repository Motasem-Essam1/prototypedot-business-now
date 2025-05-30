<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Builder;

/**
 * App\Models\User
 *
 * @property int $id
 * @property string $name
 * @property string $email
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property mixed $password
 * @property string $type
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Notifications\DatabaseNotificationCollection<int, \Illuminate\Notifications\DatabaseNotification> $notifications
 * @property-read int|null $notifications_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Laravel\Sanctum\PersonalAccessToken> $tokens
 * @property-read int|null $tokens_count
 * @method static \Database\Factories\UserFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|User newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|User newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|User query()
 * @method static \Illuminate\Database\Eloquent\Builder|User whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereEmailVerifiedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User wherePassword($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereRememberToken($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereType($value)
 * @method static \Illuminate\Database\Eloquent\Builder|User whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'type',
        'fcm_token',
        'provider_id',
        'provider_type',
        'avatar',
        'governorate_id',
        'city_id',
        // 'is_mobile',
        'platform',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * Client data.
     *
     * @return HasOne
     */
    public function client(): HasOne
    {
        return $this->hasOne(Client::class, 'user_id');
    }
    
    /**
     * Admin data.
     *
     * @return HasOne
     */
    public function admin(): HasOne
    {
        return $this->hasOne(Admin::class);
    }

    /**
     * Company data.
     *
     * @return HasOne
     */
    public function company(): HasOne
    {
        return $this->hasOne(Company::class, 'user_id');
    }

    public function ads()
    {
        return $this->hasMany(Ad::class, 'user_id');
    }

    /**
     * Get user role "Admin".
     *
     * @return string
     */
    public function isAdmin(): string
    {
        return $this->type === 'admin';
    }

    public function getFirstNameAttribute()
    {
        $nameArray = explode(" ", $this->name);
        return $nameArray[0];
    }

    public function getLastNameAttribute()
    {
        $nameArray = explode(" ", $this->name);
        return $nameArray[count($nameArray) - 1];
    }

    public function device_tokens(): HasMany
    {
        return $this->hasMany(DeviceToken::class);
    }

    public function notify()
    {
        return $this->hasMany(Notification::class, 'user_id', 'id');
    }

    public function viewedAds()
    {
        return $this->belongsToMany(Ad::class, 'ad_user_views')->withTimestamps();
    }

    public function scopeFilterBySearchAndApproved(Builder $query, $filters){
        if (isset($filters['search'])) {
            $search = $filters['search'];
    
            $query->where(function ($query) use ($search) {
                $query->where('id', $search)
                      ->orWhere('name', 'like', '%' . $search . '%')
                      ->orWhere('email', 'like', '%' . $search . '%')
                      ->orWhere('type', 'like', '%' . $search . '%')
                      ->orWhereHas('client', function ($query) use ($search) {
                          $query->where('phone', 'like', '%' . $search . '%');
                      })
                      ->orWhereHas('company', function ($query) use ($search) {
                          $query->where('phone', 'like', '%' . $search . '%');
                      });
            });
        }
    
        return $query;
    }
    

}


