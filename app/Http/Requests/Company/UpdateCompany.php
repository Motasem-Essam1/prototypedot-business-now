<?php

namespace App\Http\Requests\Company;

use App\Traits\ApiResponses;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\ValidationException;

class UpdateCompany extends FormRequest
{
    use ApiResponses;
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'display_name' => 'required',
            'phone'        => 'required|numeric',
            'address'      => 'required',
            'name'         => 'required',
            'email'        => 'email|unique:users,email',
            'description'  => 'description'

                ];
    }

    public function failedValidation( $validator)
    {
        $response= $this->failed($validator->errors()->first(),422);

        throw (new ValidationException($validator, $response))->status(422);
    }
}
