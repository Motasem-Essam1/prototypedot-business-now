<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;


class ClientExport implements FromCollection, WithHeadings, WithMapping
{
    protected $data;

    public function __construct($data)
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
            'display_name',
            'phone',
            'profile',
            'address',
            'status',
            'user_id'
        ];
    }

    public function map($client): array
    {
        return [
            $client->id,
            $client->name,
            $client->email,
            $client->created_at->toDateTimeString(),
            $client->updated_at->toDateTimeString(),
            $client->address,
            // Add other fields you want to include in the export
        ];
    }
}
