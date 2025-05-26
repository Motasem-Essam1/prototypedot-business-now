<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreRoleRequest;
use App\Http\Resources\RoleResource;
use App\Models\Role;
use App\Traits\ApiResponses;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleController extends Controller
{
    use ApiResponses;

    public function index(): JsonResponse
    {
        $roles = RoleResource::collection(Role::all());
        return $this->success($roles, 'Done');
    }

    public function show(): JsonResponse
    {
        $role = Role::findOrFail(request('id'));
        return $this->success(new RoleResource($role), 'Done');
    }

    public function store(StoreRoleRequest $request): JsonResponse
    {
        $request->validated($request->all());
        $role = Role::create($request->all());
        return $this->success(new RoleResource($role), 'Created', Response::HTTP_CREATED);
    }

    public function update(Request $request): JsonResponse
    {
        $role = Role::findOrFail(request('id'));
        $role->update($request->all());
        return $this->success($role, 'Done', Response::HTTP_ACCEPTED);
    }

    public function destroy(): JsonResponse
    {
        $role = Role::findOrFail(request('id'));
        $role->delete();
        return $this->success(null, 'Deleted', Response::HTTP_NO_CONTENT);
    }
}
