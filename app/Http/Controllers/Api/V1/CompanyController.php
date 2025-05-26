<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCompanyRequest;
use App\Http\Resources\CompanyResource;
use App\Http\Resources\UserResource;
use App\Jobs\UserCreated;
use App\Models\Company;
use App\Models\CompanyFile;
use App\Models\User;
use App\Traits\ApiResponses;
use App\Traits\ImageTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Exports\CompanyExport; 
use Maatwebsite\Excel\Facades\Excel;

class CompanyController extends Controller
{
    use ApiResponses;
    use ImageTrait;

    public function index(): JsonResponse
    {
        $companies = CompanyResource::collection(Company::all());
        return $this->success($companies, 'Done');
    }


    
    
    public function companyOfCategory($id): JsonResponse
    {
        $companies = Company::where('category_id', $id)->get(); // تصحيح استدعاء get()
        return $this->success(CompanyResource::collection($companies), 'Done');
    }

    private function success($data, $message = '', $code = 200): JsonResponse
    {
        return response()->json([
            'data' => $data,
            'message' => $message,
            'status' => 'success'
        ], $code);
    }
    
    public function show(): JsonResponse
    {
        $company=Company::findOrFail(request('id'));
        return $this->success(new CompanyResource($company), 'Done');
    }
    
    public function companyShow(): JsonResponse
    {
        $company=Company::findOrFail(request('id'));
        return $this->success(new CompanyResource($company), 'Done');
    }
    public function store(StoreCompanyRequest $request): JsonResponse
    {
        $request->validated($request->all());

        $user = User::create([
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'password' => Hash::make($request->input('password')),
            'type' => 'company'
        ]);
        //dd($request->input('category_id'));
        Company::create([
            'display_name' => $request->input('name'),
            'phone' => $request->input('phone'),
            'address' => $request->input('address'),
            'description' => $request->input('description'),
            // 'category_id' => $request->input('id_category'),
            'user_id' => $user->id
        ]);

        UserCreated::dispatch($user->toArray())->onQueue('messageing');

        return $this->success(new UserResource($user), 'Created', Response::HTTP_CREATED);
    }

    public function update(Request $request): JsonResponse
    {
        $companyId = $request->input('id');

        $company = Company::find($companyId);

        if (!$company) {
            return response()->json(['message' => 'company not found.'], Response::HTTP_NOT_FOUND);

        }

        // Validate the request
        $validator = Validator::make($request->all(), [
            'email' => 'nullable|string|email|max:255|unique:users,email,' . $company->user_id,
            'phone' => [
                'regex:/^\d{3}[\s]?\d{3}[\s]?\d{4,5}$|^\d{4}[\s]?\d{3}[\s]?\d{4}$|^\d{4}[\s]?\d{4}[\s]?\d{3}$|^\d{4}[\s]?\d{3}[\s]?\d{3}[\s]?\d{2}$/',
                function ($attribute, $value, $fail) use ($companyId) {

                    // Normalize the phone number by removing all spaces
                    $normalizedPhone = preg_replace('/\s+/', '', $value);

                    $company_exists = DB::table('companies')->where('phone', $normalizedPhone)->where('id', '!=', $companyId)->exists();
                    $admin_exists = DB::table('admins')->where('phone', $normalizedPhone)->exists();
                    $client_exists = DB::table('clients')->where('phone', $normalizedPhone)->exists();

                    if ($company_exists || $client_exists || $admin_exists) {
                        $fail('The phone number has already been taken.');
                    }
                },
            ],
            'password' => 'string|min:8',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        
        //Normalize the phone number by removing all spaces
        $request['phone'] = preg_replace('/\s+/', '', $request['phone']);

        $companyData = [
            'display_name' => $request->input('display_name'),
            'phone'        => $request['phone'],
            'address'      => $request->input('address'),
        ];

        if ($request->has('profile')) {
            // $filename = time() . '.' . 'png';
            $this->deleteFileByPath($company['profile']);
            // $imagename = $this->uploadImage($request->profile, $filename, 'profiles');
            $imagename = $this->uploadFile($request->profile, "company" . strtotime(now()), 'profiles');
            $companyData['profile'] = $imagename;
        }
        
        $company->update($companyData);

        $user=User::find($company->user_id);

        $userData = [
            'name' => $request->input('display_name'),
        ];

        if ($request->filled('password')) {
            $userData['password'] = Hash::make($request->input('password'));
        }
        if ($request->filled('email')) {
            $userData['email'] = $request->input('email');
        }

        $user->update($userData);

        return $this->success(new CompanyResource($company), 'Done', Response::HTTP_ACCEPTED);
    }

    public function uploadProfile(Request $request, Company $company): JsonResponse
    {
        $filename =  time() . '.' . 'png';
        $imagename =  $this->uploadImage($request->profile, $filename, 'profiles');
        $image_link = 'images/profiles/' . $imagename;
        $company->update([
            'profile' => asset($image_link)
        ]);

        return $this->success(new CompanyResource($company), 'Done', Response::HTTP_ACCEPTED);
    }

    public function destroy(): JsonResponse
    {
        $company = Company::findOrFail(request('id'));
        $user = User::where('id', $company->user_id);
        $user->delete();
        $company->delete();

        return $this->success(null, 'Deleted', Response::HTTP_NO_CONTENT);
    }

    public function uploadCommercialFile(Request $request): JsonResponse
    {
        $validatedData = Validator::make($request->all(), [
            "commercial_register" => "required|mimetypes:application/pdf|max:5000",
            "tax_card" => "required|mimetypes:application/pdf|max:5000",
            // 'id' => 'required|integer|exists:companies,id',
        ]);

        if ($validatedData->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validatedData->errors()
            ], 422);
        }
              

        $user = Auth::user();
        $company = Company::where ('user_id',$user['id'])->first();    
        if (!$company) {
            return response()->json(['message' => 'company not found.'], Response::HTTP_NOT_FOUND);
        }
        
        $company_file = CompanyFile::where('company_id', $company['id'])->first();

        if (!$company_file) {
            $company_file = new CompanyFile;
            $company_file['company_id'] = $company['id'];
        }

        ///////////////////////////////
        if ($request->has('commercial_register')) {
            $this->deleteFileByPath($company_file['commercial_register']);
            $imagename = $this->uploadFile($request->commercial_register, "commercial_register" . strtotime(now()), 'commercial_register');
            $company_file['commercial_register'] = $imagename;
        }

        if ($request->has('tax_card')) {
            $this->deleteFileByPath($company_file['tax_card']);
            $imagename = $this->uploadFile($request->tax_card, "tax_card" . strtotime(now()), 'tax_card');
            $company_file['tax_card'] = $imagename;
        }
        $company_file->save();
        return $this->success(new CompanyResource( $company), 'Done', Response::HTTP_ACCEPTED);
    }


    public function exportCompany()
    {
        $companies = Company::all();
        return Excel::download(new CompanyExport($companies), 'companies.xlsx');
    }
}
