<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Http\Resources\ClientResource;
use App\Http\Resources\CompanyResource;
use App\Http\Resources\UserResource;
use App\Http\Resources\UserSocialiteResource;
use App\Jobs\UserCreated;
use App\Models\Ad;
use App\Models\Client;
use Twilio\Rest\Client as TwilioClient;
use App\Models\Company;
use App\Models\User;
use App\Models\Comment;
use App\Models\PasswordReset;
use App\Services\AuthService;
use App\Services\SocialService;
use App\Traits\ApiResponses;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Facades\Validator;
use App\Traits\ImageTrait;
use Symfony\Component\HttpFoundation\Response;
use Laravel\Sanctum\PersonalAccessToken;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\DB;


class AuthController extends Controller
{
    use ImageTrait;
    use ApiResponses;

    public function __construct(private readonly SocialService $socialService, private readonly AuthService $auth_service)
    {

    }

    // Send Verification Code
    public function sendVerificationPhone(Request $request)
    {

        $validator = Validator::make($request->all(), [ 
            'phone' => [
                'required','regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                    function ($attribute, $value, $fail) {
                        // Normalize the phone number by removing all spaces
                        $normalizedPhone = preg_replace('/\s+/', '', $value);

                       // Check if the phone number exists in either the companies or clients table
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->exists();

                        // If the phone number does not exist in either table, return an error
                        if (!$companyExists && !$clientExists) {
                            $fail('The phone number does not exist.');
                        }
                    },
                ],
        ]);
        //        
        
        if ($validator->fails()) { 

            $errors = $validator->errors();
            // Print the validation error
            foreach ($errors->all() as $error) {
                error_log($error);
            }
            return response()->json(['error' => $errors->all()], 400); 
            // return response()->json(['error' => 'Invalid phone number format.'], 400); 
        }

        $phone = $request->input('phone');
        $code = rand(100000, 999999); // Generate a random 6-digit code

        // Save the verification code in the database
        PasswordReset::create([
            'phone' => $phone,
            'code' => $code,
            'created_at' => Carbon::now(),
            'expires_at' => Carbon::now()->addMinutes(10) // Set expiration time
        ]);

        // Send SMS using Twilio
        $sid = env('TWILIO_SID');
        $token = env('TWILIO_AUTH_TOKEN');
        $twilioPhoneNumber = env('TWILIO_PHONE_NUMBER');
        $twilio = new TwilioClient($sid, $token);

        try {
            // $message = $twilio->messages->create($phone, [
            //     'from' => $twilioPhoneNumber,
            //     'body' => 'Your verification code is ' . $code
            // ]);
            return response()->json(['message' => 'Verification code sent to phone.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to send verification code.'], 400);
        }
    }


    // Send Verification Email
    public function sendVerificationEmail(Request $request)
    {

        $validator = Validator::make($request->all(), [ 
            'email' => 'required|email|exists:users,email'
        ]);
        //        
        
        if ($validator->fails()) { 

            $errors = $validator->errors();
            // Print the validation error
            foreach ($errors->all() as $error) {
                error_log($error);
            }
            return response()->json(['error' => $errors->all()], 400); 
            // return response()->json(['error' => 'Invalid phone number format.'], 400); 
        }


        $email = $request->input('email');
        $code = rand(100000, 999999); // Generate a random 6-digit code

        // Save the verification code in the database using the model
        PasswordReset::create([
            'email' => $email,
            'code' => $code,
            'created_at' => Carbon::now(),
            'expires_at' => Carbon::now()->addMinutes(10) // Set expiration time
        ]);

        // Send email using Mail
        try {
            Mail::raw('Your verification code is ' . $code, function ($message) use ($email) {
                $message->to($email)->subject('Verification Code');
            });
            return response()->json(['message' => 'Verification code sent to email.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to send verification code.'], 400);
        }
    }


    // Verify Code and Reset Password
    public function verifyCodeAndResetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [ 
            'phone' => [
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                'required_without:email',
                    function ($attribute, $value, $fail) {
                        // Normalize the phone number by removing all spaces
                        $normalizedPhone = preg_replace('/\s+/', '', $value);

                       // Check if the phone number exists in either the companies or clients table
                        $companyExists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $clientExists = DB::table('clients')->where('phone', $normalizedPhone)->exists();

                        // If the phone number does not exist in either table, return an error
                        if (!$companyExists && !$clientExists) {
                            $fail('The phone number does not exist.');
                        }
                    },           
                ],
            'password' => 'required|min:8', 
            'password_confirmation' => 'required|same:password' ,    
            'code' => 'required'
        ]);
        //        
        
        if ($validator->fails()) { 

            $errors = $validator->errors();
            // Print the validation error
            foreach ($errors->all() as $error) {
                error_log($error);
            }
            return response()->json(['error' => $errors->all()], 400); 
            // return response()->json(['error' => 'Invalid phone number format.'], 400); 
        }


        $phone = $request->input('phone');
        $email = $request->input('email');
        $code = $request->input('code');
        $newPassword = $request->input('password');

        // Retrieve the verification code from the database
        $verification = PasswordReset::where(function ($query) use ($phone, $email) {
            $query->where('phone', $phone)
                  ->orWhere('email', $email);
        })
        ->where('code', $code)
        ->where('expires_at', '>', Carbon::now())
        ->first();

        if ($verification) {
            // Find the user by phone number or email
            // $user = User::where('phone', $phone)->orWhere('email', $email)->first();


            if ($request->has('phone')) {
                $data = $this->auth_service->getUserByPhone($request);
            }
            else if ($request->has('email')) {
                $data = $this->auth_service->getUserByEmail($request);
            }
            else{
                $data['flag'] = false; 
            }

            if ($data['flag']) {
                $user = $data['user'];
                
                // Update the user's password
                $user->password = Hash::make($newPassword);
                $user->save();

                // Remove the verification record from the database
                PasswordReset::where(function ($query) use ($phone, $email) {
                    $query->where('phone', $phone)
                          ->orWhere('email', $email);
                })
                ->where('code', $code)
                ->delete();

                // Remove any expired verification records
                PasswordReset::where('expires_at', '<', Carbon::now())->delete();

                return response()->json(['message' => 'Password reset successfully.']);
            } else {
                return response()->json(['error' => 'User not found.'], 404);
            }
        } else {
            return response()->json(['error' => 'Invalid verification code or phone number/email.'], 400);
        }
    }

    /**
     * Admin & User Login.
     *
     * @param LoginRequest $request
     * @return JsonResponse
     */
    public function login(LoginRequest $request): JsonResponse
    {
        $request->validated($request->all());

        if ($request->has('email'))
        {
            $data = $this->auth_service->checkAuthWithEmail($request);

            if (!$data['flag']) {

                // Normalize the phone number by removing all spaces
                if ($request->has('phone')) {
                    $request['phone'] = preg_replace('/\s+/', '', $request['phone']);
                }

                $data = $this->auth_service->checkAuthWithPhone($request);

                if (!$data['flag']) {
                    return $this->failed('Wrong Credentials', Response::HTTP_UNAUTHORIZED);
                }
    
            }
    
            $user = $data['user'];
            $token = $user->createToken('API token of ' . $user->name)->plainTextToken;
    
            $data = ['token' => $token, 'user' => new UserResource($user)];
    
            if($user['status'] == 0)
            {
                return $this->failed('User deleted', Response::HTTP_UNAUTHORIZED);
            }

            if (isset($request['platform'])) {
                $user['platform'] = $request['platform'];
            } else {
                $user['platform'] = '';
            }
            
            $user->save();
            
            return $this->success($data, 'Done', Response::HTTP_ACCEPTED);
        }
        else{
            return $this->failed('email or phone required', Response::HTTP_UNAUTHORIZED);
        }
    }

    /**
     * Admin & User Registration.
     *
     * @param RegisterRequest $request
     * @return JsonResponse
     */
    public function registration(RegisterRequest $request): JsonResponse
    {
        if($request['user_type'] == 'user')
        {
            $request['user_type'] = 'client';
        }

        // Normalize the phone number by removing all spaces
        $request['phone'] = preg_replace('/\s+/', '', $request['phone']);

        $user = User::create([
            'name' => $request->input('name'),
            'email' => $request->input('email') ?? null,
            'password' => Hash::make($request->input('password')),
            'type' => $request->input('user_type'),
            'wallet' =>0
        ]);

        if (isset($request['platform'])) {
            $user['platform'] = $request['platform'];
        } else {
            $user['platform'] = '';
        }

        $user->save();

        if($request['user_type'] == 'client')
        {
            Client::create([
                'display_name' => $request->input('name'),
                'phone' => $request['phone'] ?? null,
                'user_id' => $user->id
            ]);
        }
        
        else if($request['user_type'] == 'company')
        {
            Company::create([
                'display_name' => $request->input('name'),
                'phone' => $request['phone'] ?? null,
                'description' => "",
                'user_id' => $user->id
            ]);
        }
        

        $token = $user->createToken('API token of ' . $user->name)->plainTextToken;

        $data = ['token' => $token, 'user' => new UserResource($user)];

        UserCreated::dispatch($user->toArray())->onQueue('messageing');

        return $this->success($data, 'Done', Response::HTTP_CREATED);
    }

    /**
     * Admin & User Logout.
     *
     * @return JsonResponse
     */
    public function logout(): JsonResponse
    {
           Auth::user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'You have successfully been logged out.'
        ], 400);
    }

    public function fcmToken(Request $request)
    {
        auth()->user()->update([
            'fcm_token' => $request->fcm_token,
        ]);

        return response()->json([
            'status' => 'success',
        ], 200);
    }

    public function redirectToSocialProvider($provider)
    {
        return Socialite::driver($provider)->stateless()->redirect();
        // return Socialite::driver($provider)->scopes(['public_profile', 'email', 'user_mobile_phone'])->stateless()->redirect();
    }

    public function handleSocialProviderCallback($provider)
    {
        $socialUser = Socialite::driver($provider)->stateless()->user();

        $password = "";
        $find_user =User::where('email', $socialUser->getEmail())->first();

        if($find_user)
        {
            $password = $find_user['password'];
        }
        else{
            $password = encrypt(Str::random(10));
        }

          $user = User::updateOrCreate(
                ['email' => $socialUser->getEmail() ],
            [
                'name'  => $socialUser->getName(),
                'provider_id' => $socialUser->getId(),
                'provider_type' => $provider,
                'password' => $password,
                'email_verified_at' => now(),
                'avatar' => $socialUser->getAvatar(),
                'type' => 'client',
                // Other user fields
            ]
        );   
        

          $client = Client::query()->where('user_id', $user->id)->first();

            if(empty($client))
            {
                Client::create([
                    'display_name' => $socialUser->getName(),
                    'phone' => '',
                    'user_id' => $user->id
                ]);
        
            }
            
        $token = $user->createToken("WEB_TOKEN")->plainTextToken;
        // Redirect back to React app with token
        // return redirect(to: "http://127.0.0.1:8000/api/v1/auth/get-user-data?provider=$provider&token=$token");
         return redirect( "https://business-egy.com" . "/login?provider=$provider&token=$token");
    }


    public function getUserData(Request $request)
    {
        $currentRequestPersonalAccessToken = PersonalAccessToken::findToken($request->token);

        if(!empty($currentRequestPersonalAccessToken))
        {
            $user = $currentRequestPersonalAccessToken->tokenable;
            $user['token'] = $request->token;

            if($user['status'] == 0)
            {
                return $this->failed('User deleted', Response::HTTP_UNAUTHORIZED);
            }    

            return $this->success(UserSocialiteResource::make($user), 'Done', Response::HTTP_ACCEPTED);
        }
        else{
            return $this->failed('Wrong token', Response::HTTP_UNAUTHORIZED);

        }
    }

    public function getUserDataSocial(Request $request){
//        return User::all();
        $validatedData = Validator::make($request->all(), [
            'userId' => 'required|string',
              'userName' => 'required|string',
              'eMail' => 'required|string',
              'image' => 'required|string',
              'token' => 'required|string',
        ]);


        if ($validatedData->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validatedData->errors()
            ], 422);
        }

        $userData = [
            'name' => $request['userName'],
            'email' => $request['eMail'],
            'avatar' => $request['image'],
            'provider_id' => $request['userId'],
            'provider_type' => 'Social Login',
            'password' => Hash::make(Str::random(10)),
            'type' => 'client',
        ];
        $user = User::updateOrCreate(
            [
                'email' => $request['eMail'],
            ],
            $userData
        );
        $token = $user->createToken('Social Mobile Token ' . $user->name)->plainTextToken;

        $data = ['token' => $token, 'user' => new UserResource($user)];
        return $this->success($data, 'Done', Response::HTTP_ACCEPTED);

    }

    public function loginForSocial(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'name' => 'required|string',
            'email' => 'required|email',
        ]);


        if ($validatedData->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validatedData->errors()
            ], 422);
        }

        $check_user = User::where("email", operator: $request['email'])->first();

        if(empty($check_user))
        {
            $user = new User;
            $user['name'] = $request['name'];
            $user['email'] = $request['email'];
            $user['password'] = Hash::make(Str::random(10));
            $user['type'] = 'client';
            $user->save();

            $client = new Client;
            $client['display_name'] = $request['name'];
            $client['phone'] = "";
            $client['user_id'] = $user['id'];

            if ($request->has('image')) {
                $imagename = $this->uploadFile($request['image'], "client" . strtotime(now()), 'profiles');
                $client['profile'] = $imagename;
            }
            $client->save();
    
            $token = $user->createToken('API token of ' . $user->name)->plainTextToken;
    
            $data = ['token' => $token, 'user' => new UserResource($user)];
    
            UserCreated::dispatch($user->toArray())->onQueue('messageing');
    
            return $this->success($data, 'Done', Response::HTTP_CREATED);
        }
        else{
            $user = User::where('email', $request->input('email'))->first();

            $token = $user->createToken('API token of ' . $user->name)->plainTextToken;
    
            $data = ['token' => $token, 'user' => new UserResource($user)];
    
            return $this->success($data, 'Done', Response::HTTP_ACCEPTED);

        }
    }


    public function userInfo(){

        $user = Auth::user();

        if ($user['type'] == 'client') {
            $client = Client::where ('user_id',$user['id'])->first();
            return $this->success(new ClientResource($client), 'Done');
        } else if ($user['type'] == 'company') {
            $client = Company::where ('user_id',$user['id'])->first();
            return $this->success(new CompanyResource($client), 'Done');
        }
        else{
            return $this->success(new UserResource($user), 'Done');
        }
    }

    public function deleteUser(){
     
        $user = Auth::user();
        $user['status'] = 0;
        Ad::where('user_id', $user['id'])->update(['status' => 0]);
        Comment::where('user_id', $user['id'])->update(['status' => 0]);
        $user->save();
        return $this->success([], 'user deleted successfully', Response::HTTP_ACCEPTED);
        
    }

}
