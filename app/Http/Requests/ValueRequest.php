<?php
// app/Http/Requests/ValueRequest.php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ValueRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize()
    {
        return true; // Adjust this based on your authorization logic
    }

    /**
     * Get the validation rules that apply to the request.
     */
    public function rules()
    {
        return [
            'name' => 'required|string',
            'filter_id' => 'required|exists:filters,id' // Ensure the filter_id exists in the filters table
        ];
    }
}
