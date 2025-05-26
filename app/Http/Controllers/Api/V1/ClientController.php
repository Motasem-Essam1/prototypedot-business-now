<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\ClientResource;
use App\Models\Client;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponses;
use App\Traits\ImageTrait;
use Hash;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Exports\ClientExport; 
use Maatwebsite\Excel\Facades\Excel;

class ClientController extends Controller
{
    use ApiResponses;
    use ImageTrait;

    /**
     * all clients.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $clients = ClientResource::collection(Client::all());
        return $this->success($clients, 'Done');
    }

    /**
     * Show specific client.
     *
     * @param Client $client
     * @return JsonResponse
     */
    public function show(): JsonResponse
    {      
        $client = Client::find(request('id'));
    
        if (!$client) {
            return response()->json(['message' => 'Client not found.'], Response::HTTP_NOT_FOUND);
        }

        return $this->success( new ClientResource($client), 'Done');
    }

    /**
     * Update specific client.
     *
     * @param Request $request
     * @param Client $client
     * @return JsonResponse
     */
   public function update(Request $request): JsonResponse
    {
        $clientId = $request->input('id');
    
        // العثور على العميل بواسطة معرف الطلب
        $client = Client::find($clientId);
    
        if (!$client) {
            return response()->json(['message' => 'Client not found.'], Response::HTTP_NOT_FOUND);
        }
    
        // بدء معاملة
        DB::beginTransaction();
        
        try {
            // Validate the phone number
            $request->validate([
                'email' => 'nullable|string|email|max:255|unique:users,email,' . $client->user_id,
                'phone' => [
                    'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                    function ($attribute, $value, $fail) use ($clientId)  {

                        // Normalize the phone number by removing all spaces
                        $normalizedPhone = preg_replace('/\s+/', '', $value);

                        $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->exists();
                        $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->exists();
                        $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->where('id', '!=', $clientId)->exists();


                        if ($company_exists || $client_exists || $admin_exists) {
                            $fail('The phone number has already been taken.');
                        }
                    },
                ],
                'password' => 'string|min:8',
            ]);

            // Normalize the phone number by removing all spaces
            $request['phone'] = preg_replace('/\s+/', '', $request['phone']);

            // تحديث بيانات العميل
            $clientData = [
                'display_name' => $request->input('display_name'),
                'phone'        => $request['phone'],
                'address'      => $request->input('address'),
            ];


    
            if ($request->has('profile')) {
                // $filename = time() . '.' . 'png';
                $this->deleteFileByPath($client['profile']);
                // $imagename = $this->uploadImage($request->profile, $filename, 'profiles');
                $imagename = $this->uploadFile($request->profile, "client" . strtotime(now()), 'profiles');
                $clientData['profile'] = $imagename;
            }
    
            $client->update($clientData);
    
            // العثور على المستخدم المرتبط بالعميل
            $user = User::findOrFail($client->user_id);
    
            // تحديث اسم المستخدم
            $userData = [
                'name' => $request->input('display_name'),
            ];
    
            // تحديث كلمة المرور إذا كانت موجودة في الطلب
            if ($request->filled('password')) {
                $userData['password'] = Hash::make($request->input('password'));
            }
    
            // تحديث البريد الإلكتروني إذا كان موجود في الطلب
            if ($request->filled('email')) {
                $userData['email'] = $request->input('email');
            }
    
            // تحديث بيانات المستخدم
            $user->update($userData);
    
            // إنهاء المعاملة بنجاح
            DB::commit();
    
            // إرجاع استجابة النجاح مع مورد العميل المحدّث
            return $this->success(new ClientResource($client), 'Done', Response::HTTP_ACCEPTED);
        } catch (\Exception $e) {
            // في حال وقوع خطأ، يتم التراجع عن المعاملة
            DB::rollBack();
            return response()->json(['message' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);        
        }
    }

    /**
     * Upload profile image for specific client.
     *
     * @param Request $request
     * @param Client $client
     * @return JsonResponse
     */
    public function uploadProfile(Request $request): JsonResponse
    {
        $filename =  time() . '.' . 'png';
        $imagename =  $this->uploadImage($request->profile, $filename, 'profiles');
        $image_link = 'images/profiles/' . $imagename;
        $client=Client::findorfail(request('id'));
        $client->update([
            'profile' => asset($image_link)
        ]);

        return  $this->success(new ClientResource($client), 'Done', Response::HTTP_ACCEPTED);
    }

    /**
     * Delete specific client.
     *
     * @param Client $client
     * @return JsonResponse
     */
    public function destroy(): JsonResponse
    {
        $client = Client::findOrFail(request('id'));
        $user = User::where('id', $client->user_id);
        $user->delete();
        $client->delete();
        return $this->success(null, 'Deleted', Response::HTTP_NO_CONTENT);
    }


    public function exportClient()
    {
        $clients = Client::all();
        return Excel::download(new ClientExport($clients), 'clients.xlsx');
    }
}
