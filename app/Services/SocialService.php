<?php

namespace App\Services;

use App\Models\User;
use App\Models\UserData;
use App\Services\UserService;
use Exception;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;


class SocialService
{
    public function handleSocial(array $social_user, $request)
    {
        try {
            $user = User::where('provider_id', $social_user['provider_id'])->
            where('provider_type', $social_user['provider'])->first();

            if($user){
                $this->handleToken( $social_user, $request);
                return $user;
            }else{
                $new_user = new User();
                $new_user->name = $social_user['name'];
                $new_user->email = $social_user['email'];
                $new_user->password = '';
                $new_user->provider_id = $social_user['provider_id'];
                $new_user->provider_type = $social_user['provider'];
                $new_user->save();
                $this->handleToken( $social_user, $request);

                //avatar
                // if ($social_user['provider'] == 'facebook')
                //     $user_data->avatar = $social_user['avatar'] . '&access_token=' . $social_user['provider_id'];
                // else
                //     $user_data->avatar = $social_user['avatar'];
                return $new_user;
            }
        } catch (Exception $e) {
            return $e->getMessage();
            //dd($e->getMessage());
        }
    }

    public function handleToken(array $social_user, $request){
        $user = User::where('provider_id', $social_user['provider_id'])->
        where('provider_type', $social_user['provider'])->first();
        $user->remember_token = $user->createToken($request->userAgent())->plainTextToken;
        $user->save();
    }
}
