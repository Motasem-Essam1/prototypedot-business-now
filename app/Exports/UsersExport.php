<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Illuminate\Support\Collection;

class UsersExport implements FromCollection, WithHeadings, WithMapping
{
    protected $data;

    public function __construct(Collection $data)
    {
        $this->data = $data;
    }

    public function collection()
    {
        return $this->data;
    }

    public function headings(): array
    {
        return [
            'id',
            'name',
            'email',
            'email_verified_at',
            'password',
            'type',
            'remember_token',
            'created_at',
            'updated_at',
            'fcm_token',
            'provider_id',
            'provider_type',
            'avatar',
            'status',
            'platform',
        ];
    }

    public function map($user): array
    {
        return [
            $user->id,
            $user->name,
            $user->email,
            $user->email_verified_at,
            $user->password,
            $user->type,
            $user->remember_token,
            $user->created_at->toDateTimeString(),
            $user->updated_at->toDateTimeString(),
            $user->fcm_token,
            $user->provider_id,
            $user->provider_type,
            $user->avatar,
            $user->status,
            $user->platform,
        ];
    }


}
