<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Services\UserService;
use App\Services\UserServiceDashboard;
use App\Traits\ApiResponses;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;


class UserDashboardController extends Controller
{
    use ApiResponses;

    public function __construct(private readonly UserService $user_service)
    {

    }

    /**
     * Get a list of all users.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $per_page = $request->get('per_page', 30); // Get 'per_page' parameter or default to 30
        $users = $this->user_service->getAllUsers($per_page, $request->input('search'));
        
        return response()->json([
            'data' => UserResource::collection($users),
            'links' => [
                'first' => $users->url(1),
                'last' => $users->url($users->lastPage()),
                'prev' => $users->previousPageUrl(),
                'next' => $users->nextPageUrl(),
            ],
            'meta' => [
                'current_page' => $users->currentPage(),
                'from' => $users->firstItem(),
                'last_page' => $users->lastPage(),
                'path' => $users->path(),
                'per_page' => $users->perPage(),
                'to' => $users->lastItem(),
                'total' => $users->total(),
            ],
        ]);
    }

    /**
     * Get a single user by ID.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $user = $this->user_service->getUserById($id);

        if (!$user) {
            return response()->json(['errors' => 'User does not exist'], 422);
        }

        return response()->json(new UserResource($user));
    }

    public function search(Request $request)
    {
        $filters = $request->only(['search']);

        $users = $this->user_service->search($filters);
        return response()->json( UserResource::collection($users));
    }

    /**
     * Create a new user.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|string|email|max:255|unique:users|required_without:phone',
            'password' => ['required', 'confirmed', Password::defaults()],
            'type' => 'required|string|in:client,company,admin',
            'fcm_token' => 'nullable|string',
            'provider_id' => 'nullable|string',
            'provider_type' => 'nullable|string',
            'avatar' => 'nullable|string',
            'platform' => 'nullable|string',
            'phone' => [
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                'required_without:email',
                    function ($attribute, $value, $fail) {
                        // Normalize the phone number by removing all spaces
                        $normalizedPhone = preg_replace('/\s+/', '', $value);

                        // Check if the phone number exists in either the companies or clients table
                        $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->exists();
                        $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->exists();

                        // If the phone number exists in either table, fail the validation
                        if ($company_exists || $client_exists || $admin_exists) {
                            $fail('The phone number has already been taken.');
                        }
                    },
             ],
            'profile' => 'nullable|file|mimes:jpeg,png,jpg,gif,svg',
            'address' => 'nullable|string',
            'status' => 'nullable|string|in:active,inactive',
            'description' => 'nullable|string',
            "commercial_register" => "nullable|max:5000|mimes:pdf",
            "tax_card" => "nullable|max:5000|mimes:pdf",
            'role_id' => [
                'required_if:type,admin',
                'nullable',
                'integer'
            ],
        ]);

        $request['password'] = Hash::make($request['password']);

        if (isset($request['phone'])) {
            //Normalize the phone number by removing all spaces
            $request['phone'] = preg_replace('/\s+/', '', $request['phone']);
        }


        $data = $request->all();
        $user = $this->user_service->createUser($data);
        return response()->json(new UserResource($user), 201);
    }

    /**
     * Update an existing user.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {

        $user = $this->user_service->getUserById($id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $data = $request->validate([
            'name' => 'string|max:255',
            'email' => 'nullable|string|email|max:255|unique:users,email,' . $user['id'],
            'password' => ['confirmed', Password::defaults()],
            'type' => 'string|in:client,company,admin',
            'fcm_token' => 'nullable|string',
            'provider_id' => 'nullable|string',
            'provider_type' => 'nullable|string',
            'avatar' => 'nullable|string',
            'platform' => 'nullable|string',
            'phone' => [
                'nullable',
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                function ($attribute, $value, $fail) use ($user)  {
                    
                    // Normalize the phone number by removing all spaces
                    $normalizedPhone = preg_replace('/\s+/', '', $value);
                    
                    if ($user['type'] == 'client') {
                        $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->where('id', '!=', $user['client']['id'])->exists();
                        $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->exists();
                    }
                    else if ($user['type'] == 'company') {
                        $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->where('id', '!=', $user['company']['id'])->exists();
                        $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->exists();
                        $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->exists();
                    }
                    // else
                    // {
                    //     $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->where('id', '!=', $user['admin']['id'])->exists();
                    //     $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                    //     $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->exists();

                    // }

                    // if ($company_exists || $client_exists || $admin_exists) {
                    if ($company_exists || $client_exists) {
                        $fail('The phone number has already been taken.');
                    }
                },
            ],
            'profile' => 'nullable|string',
            'address' => 'nullable|string',
            'status' => 'nullable|string|in:active,inactive',
            'description' => 'nullable|string',
            // 'role_id' => 'nullable|integer',
            "commercial_register" => "nullable|max:5000|mimes:pdf",
            "tax_card" => "nullable|max:5000|mimes:pdf",
            'role_id' => [
                'required_if:type,admin',
                'nullable',
                'integer'
            ],
        ]);


        if (isset($request['password'])) {
            $request['password'] = Hash::make($request['password']);
        }

        $data = $request->all();
        $this->user_service->updateUser2($id, $data);


        

        return response()->json("Done", 201);

        // return response()->json(new UserResource($user));
    }

    /**
     * Delete a user by ID.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id){
        $this->user_service->deleteUser($id);
        return response()->json("delete is ok");
    }


    public function getUsersWithSamePhone(){
        $userIds = $this->user_service->getUsersWithSamePhone();
        return response()->json(['user_ids' => $userIds]);
    }


    public function getUsersWithPhoneSpaces(){
        $userIds = $this->user_service->getUsersWithPhoneSpaces();
        return response()->json(['user_ids' => $userIds]);
    }
    public function switchUserStatus($userId){
        $user = $this->user_service->switchUserStatus($userId);
        return response()->json($user);
    }

}
