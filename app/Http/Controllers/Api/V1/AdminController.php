<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAdminRequest;
use App\Http\Resources\AdminResource;
use App\Http\Resources\UserResource;
use App\Models\Admin;
use App\Models\User;
use App\Traits\ApiResponses;
use App\Traits\ImageTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class AdminController extends Controller
{
    use ApiResponses, ImageTrait;

    /**
     * All admins.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $admins = AdminResource::collection(Admin::all());
        return $this->success($admins, 'Done');
    }

    /**
     * View specific admin.
     *
     * @param Admin $admin
     * @return JsonResponse
     */
    public function show(): JsonResponse
    {
        $admin=Admin::findorfail(request('id'));
        return $this->success(new AdminResource($admin), 'Done');
    }

    /**
     * Create new admin.
     *
     * @param StoreAdminRequest $request
     * @return JsonResponse
     */
    public function store(StoreAdminRequest $request): JsonResponse
    {
        $request->validated($request->all());

        $user = User::create([
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'password' => Hash::make($request->input('password')),
            'type' => 'admin'
        ]);

        Admin::create([
            'display_name' => $request->input('name'),
            'phone' => $request->input('phone'),
            'user_id' => $user->id,
            'role_id' => $request->input('role_id')
        ]);

        return $this->success(new UserResource($user), 'Created', Response::HTTP_CREATED);
    }

    /**
     * Update specific admin.
     *
     * @param Request $request
     * @param Admin $admin
     * @return JsonResponse
     */
    public function update(Request $request): JsonResponse
    {
        $admin = Admin::findOrFail(request('id'));
        $admin->update([
        'display_name' => $request->display_name,
        'phone'        => $request->phone,

        ]);
        if($request->role_id){
            $admin->update([
              'role_id'=>$request->role_id
            ]);

        }
        $user=User::find($admin->user_id);
        $user->update([
            'name'     => $request->name,

        ]);
        if($request->password){
            $user->update(['password'=>bcrypt($request->password)]);
        }
        if($request->email){
            $user->update(['email'=>$request->email]);
        }

        return  $this->success(new AdminResource($admin), 'Done', Response::HTTP_ACCEPTED);
    }

    /**
     * Update admin profile.
     *
     * @param Request $request
     * @param Admin $admin
     * @return JsonResponse
     */
    public function uploadProfile(Request $request): JsonResponse
    {

        $filename =  time() . '.' . 'png';
        $imagename =  $this->uploadImage($request->profile, $filename, 'profiles');
        $image_link = 'images/profiles/' . $imagename;
        $admin=Admin::findorfail(request('id'));
        $admin->update([
            'profile' => asset($image_link),
        ]);

        return  $this->success(new AdminResource($admin), 'Done', Response::HTTP_ACCEPTED);
    }

    /**
     * Delete specific admin.
     *
     * @param Admin $admin
     * @return JsonResponse
     */
    public function destroy(): JsonResponse
    {
        $admin = Admin::findOrFail(request('id'));
        $user = User::where('id', $admin->user_id);
        $user->delete();
        $admin->delete();
        return $this->success(null, 'Deleted', Response::HTTP_NO_CONTENT);
    }
}
