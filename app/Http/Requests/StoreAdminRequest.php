<?php

namespace App\Http\Requests;

use App\Traits\ApiResponses;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;
use Illuminate\Validation\ValidationException;

class StoreAdminRequest extends FormRequest
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
     * @return array<string, ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'max:255', 'unique:users'],
            'password' => ['required', 'confirmed', Password::defaults()],
            'phone' => ['required', 'regex:/^\d{1,12}$/'],
            'role_id' => ['required', 'integer']
        ];
    }

    public function failedValidation( $validator)
    {
        $response= $this->failed($validator->errors()->first(),422);

        throw (new ValidationException($validator, $response))->status(422);
    }
}
