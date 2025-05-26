<?php

namespace App\Http\Requests;

use App\Traits\ApiResponses;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\DB;

class RegisterRequest extends FormRequest
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
            'email' => ['nullable', 'string', 'max:255', 'unique:users', 'required_without:phone'],
            'password' => ['required', 'confirmed', Password::defaults()],
            'phone' => [
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                'required_without:email',
                    function ($attribute, $value, $fail) {
                        // Normalize the phone number by removing all spaces
                        $normalizedPhone = preg_replace('/\s+/', '', $value);

                        // Check if the phone number exists in either the companies or clients table
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('admins')->where('phone', $normalizedPhone)->exists();

                        // If the phone number exists in either table, fail the validation
                        if ($companyExists || $clientExists) {
                            $fail('The phone number has already been taken.');
                        }
                    },
                ],
            'user_type' => ['required'],
            // 'platform' => [
            //         'required',
            //         'string',
            //         'regex:/^(Android|iOS)$/'
            //     ],
        ];
    }

    public function failedValidation( $validator)
    {
        $response= $this->failed($validator->errors()->first(),422);

        throw (new ValidationException($validator, $response))->status(422);
    }
}
