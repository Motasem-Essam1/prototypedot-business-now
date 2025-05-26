<?php

namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Client;
use App\Models\Company;

/**
 * Class CityService.
 */
class AuthService
{

        /**
     * Display the specified resource.
     *
     * @param $request ,
     * @return array
     */
    public function checkAuthWithEmail($request): array        
    {
        if (!Auth::attempt($request->only('email', 'password'))) {
            $data = ['flag' => false];
            return $data;
        }

        $user = User::where('email', $request->input('email'))->first();
        $data = ['flag' => true, 'user' => $user];

        return $data;
    }

    public function checkAuthWithPhone($request)
    {
        $client = Client::where('phone', $request['email'])->first();

        if ($client) {

            $user = User::where('id', $client['user_id'])->first();

            if ($user && Hash::check($request['password'], $user->password)) {
                $data = ['flag' => true, 'user' => $user];
                return $data;
            }

            $data = ['flag' => false];
            return $data; 
        }

        $company = Company::where('phone', $request['email'])->first();

        if ($company) {
            
            $user = User::where('id', $company['user_id'])->first();
            
            if ($user && Hash::check($request['password'], $user->password)) {
                $data = ['flag' => true, 'user' => $user];
                return $data;
            }

            $data = ['flag' => false];
            return $data;
        }

        $data = ['flag' => false];
        return $data;
    }


    public function getUserByPhone($request){
        $client = Client::where('phone', $request['phone'])->first();

        if ($client) {

            $user = User::where('id', $client['user_id'])->first();
            $data = ['flag' => true, 'user' => $user];
            return $data;
        }

        $company = Company::where('phone', $request['phone'])->first();

        if ($company) {

            $user = User::where('id', $company['user_id'])->first();
            $data = ['flag' => true, 'user' => $user];

            return $data;
        }

        $data = ['flag' => false];
        return $data;
    }


    public function getUserByEmail($request){
        $user = User::where('email', $request['email'])->first();
        
        if ($user) {
            $data = ['flag' => true, 'user' => $user];
            return $data;
        }

        $data = ['flag' => false];
        return $data;
    }
}
