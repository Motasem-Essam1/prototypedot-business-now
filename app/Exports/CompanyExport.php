<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Illuminate\Support\Collection;

class CompanyExport implements FromCollection, WithHeadings, WithMapping
{
    /**
    * @return \Illuminate\Support\Collection
    */
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
            'display_name',
            'phone',
            'address',
            'description',
            'profile',
            'status',
            'category_id',
            'user_id'
        ];
    }

    public function map($company): array
    {
        return [
            $company->id,
            $company->name,
            $company->email,
            $company->created_at->toDateTimeString(),
            $company->updated_at->toDateTimeString(),
            $company->address,
            // Add other fields you want to include in the export
        ];
    }
}
