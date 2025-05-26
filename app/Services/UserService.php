<?php

namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Client;
use App\Models\Company;
use App\Models\CompanyFile;
use App\Models\Admin;
use App\Models\Ad;
use App\Models\Comment;
use App\Models\Favourite;
use App\Models\Like;
use App\Models\AdImage;
use App\Models\ValueAd;
use App\Traits\ImageTrait;


/**
 * Class CityService.
 */
class UserService
{

    use ImageTrait;

    /**
     * Get a list of all users.
     *
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getAllUsers($per_page, $search)
    {
        $query = User::query();

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', '%' . $search . '%')
                  ->orWhere('email', 'like', '%' . $search . '%')
                  ->orWhere('type', 'like', '%' . $search . '%');
            });
    
            $query->orWhereHas('client', function ($q) use ($search) {
                $q->where('display_name', 'like', '%' . $search . '%')
                  ->orWhere('phone', 'like', '%' . $search . '%');
            });
    
            $query->orWhereHas('company', function ($q) use ($search) {
                $q->where('display_name', 'like', '%' . $search . '%')
                  ->orWhere('phone', 'like', '%' . $search . '%');
            });
        }
    
        return $query->paginate($per_page);
    }

    public function search($filters)
    {        
        return User::filterBySearchAndApproved($filters)->get();
    }


    public function getUserType()
    {
        $user = Auth::user();
        return $user; 
    }

/**
     * Create a new user.
     *
     * @param array $data
     * @return \App\Models\User
     */
    public function createUser(array $data)
    {
        // Create the user
        $user = User::create($data);

        if (isset($data['profile'])) {
            $imagename = $this->uploadFile($data['profile'], "user_profiles" . strtotime(now()), 'profiles');
            $data['profile'] = $imagename;
        }

        // Create type-specific data
        if ($user->type === 'client') {
            Client::create([
                'user_id' => $user->id,
                'display_name' => $data['name'] ?? null,
                'phone' => $data['phone'] ?? null,
                'profile' => $data['profile'] ?? null,
                'address' => $data['address'] ?? null,
                'status' => $data['status'] ?? 'active',
            ]);
        } elseif ($user->type === 'company') {
            $company = Company::create([
                'user_id' => $user->id,
                'display_name' => $data['name'] ?? null,
                'phone' => $data['phone'] ?? null,
                'profile' => $data['profile'] ?? null,
                'address' => $data['address'] ?? null,
                'description' => $data['description'] ?? null,
                'status' => $data['status'] ?? 'active',
        ]);

            $company_file = new CompanyFile;
            $company_file['company_id'] = $company['id'];

            if (array_key_exists('commercial_register', $data) && !is_null($data['commercial_register'])) {
                $imagename = $this->uploadFile($data['commercial_register'], "commercial_register" . strtotime(now()), 'commercial_register');
                $company_file['commercial_register'] = $imagename;
            }
    
            
            if (array_key_exists('tax_card', $data) && !is_null($data['tax_card'])) {

                $imagename = $this->uploadFile($data['tax_card'], "tax_card" . strtotime(now()), 'tax_card');
                $company_file['tax_card'] = $imagename;
            }

            $company_file->save();
        } 
        elseif ($user->type === 'admin') {
            Admin::create([
                'user_id' => $user->id,
                'display_name' => $data['name'] ?? null,
                'phone' => $data['phone'] ?? null,
                'profile' => $data['profile'] ?? null,
                'role_id' => $data['role_id'] ?? null,
            ]);
        }

        return $user;
    }


    /**
     * Get a single user by ID.
     *
     * @param int $id
     * @return \App\Models\User
     */
    public function getUserById($id)
    {
        return User::find($id);
    }

    public function updateUser($request)
    {
        $user = Auth::user();

        if($user['type'] == 'client')
        {
            $user_data = $user['client'];
   
        }
        else if($user['type'] == 'company') {

            $user_data = $user['company'];
        }

        $user_data['display_name'] = $request['display_name'] ?? $user_data['display_name'];
        $user_data['phone'] = $request['phone'] ?? $user_data['phone'];
        $user_data['address'] = $request['address'] ?? $user_data['address'];

        if (isset($request['profile'])) {
            $this->deleteFileByPath($user_data['profile']);
            $imagename = $this->uploadFile($request['profile'], "user_profiles" . strtotime(now()), 'profiles');
            $user_data['profile'] = $imagename;
        }
        $user_data->save();

        $user['name'] = $request['display_name'] ?? $user_data['display_name'];
        $user['email'] = $request['email'] ?? $user['email'];

        if (isset($request['password'])) {
            $user['password'] = Hash::make($request['password']);
        }
        
        $user = $user->save();

        return $user; 


    }

    public function updateUserByDashboard($request)
    {
        $user = User::find($request['id']);

        if($user['type'] == 'client')
        {
            $user_data = $user['client'];
            $user_data['address'] = $request['address'] ?? $user_data['address'];

        }
        else if($user['type'] == 'company') {

            $user_data = $user['company'];
            $user_data['address'] = $request['address'] ?? $user_data['address'];
        }
        else if($user['type'] == 'admin') {

            $user_data = $user['admin'];
        }

        $user_data['display_name'] = $request['display_name'] ?? $user_data['display_name'];
        $user_data['phone'] = $request['phone'] ?? $user_data['phone'];

        if (isset($request['profile'])) {
            $this->deleteFileByPath($user_data['profile']);
            $imagename = $this->uploadFile($request['profile'], "user_profiles" . strtotime(now()), 'profiles');
            $user_data['profile'] = $imagename;
        }
        $user_data->save();

        $user['name'] = $request['display_name'] ?? $user_data['display_name'];
        $user['email'] = $request['email'] ?? $user['email'];

        if (isset($request['password'])) {
            $user['password'] = Hash::make($request['password']);
        }
        
        $user->save();

        

        return $user; 


    }


    //for new Dashboard
    public function updateUser2($id, array $data)
    {
        $user = User::findOrFail($id);


        if (isset($data['type'])) {

            $this->updateUserType($user, $data['type'], $data);
        }
        else{
            $this->updateUserType($user, $user['type'], $data);

        }

        
        $user->update($data);
        return $user;
    }

    /**
     * Update the user type and handle associated data.
     *
     * @param \App\Models\User $user
     * @param string $type
     * @param array $typeData
     * @return void
     */
    protected function updateUserType(User $user, string $type, array $typeData)
    {
        if (!in_array($type, ['client', 'company', 'admin'])) {
            throw new \InvalidArgumentException('Invalid user type');
        }

        // Fetch current type-specific data
        $currentData = null;
        if ($user->type === 'client') {
            $currentData = Client::where('user_id', $user->id)->first();
        } elseif ($user->type === 'company') {
            $currentData = Company::where('user_id', $user->id)->first();
        } 
        elseif ($user->type === 'admin') {
            $currentData = Admin::where('user_id', $user->id)->first();
        }

        if (isset($typeData['profile']) && strpos($typeData['profile'], 'data:image/png;base64,') !== false) {
            $this->deleteFileByPath($currentData['profile']);
            $typeData['profile'] = str_replace('data:image/png;base64,', '', $typeData['profile']);
            $imagename = $this->uploadFileBase64($typeData['profile'], "user_profiles" . strtotime(now()), 'profiles');
            $typeData['profile'] = $imagename;
        }
        

        //get new data
        if ($type === 'company') {
            // Use provided data or fallback to current data if currentData is not null
            $newData = [
                'user_id' => $user->id,
                'display_name' => $typeData['display_name'] ?? ($currentData->display_name ?? null),
                'phone' => $typeData['phone'] ?? ($currentData->phone ?? null),
                'profile' => $typeData['profile'] ?? ($currentData->profile ?? null),
                'address' => $typeData['address'] ?? ($currentData->address ?? null),
                'status' => $typeData['status'] ?? ($currentData->status ?? null),
                'description' => $typeData['description'] ?? ($currentData->description ?? null),
                // 'role_id' => $typeData['role_id'] ?? ($currentData->role_id ?? 1),
            ];
        }
        else if ($type === 'client') {
            // Use provided data or fallback to current data if currentData is not null
            $newData = [
                'user_id' => $user->id,
                'display_name' => $typeData['display_name'] ?? ($currentData->display_name ?? null),
                'phone' => $typeData['phone'] ?? ($currentData->phone ?? null),
                'profile' => $typeData['profile'] ?? ($currentData->profile ?? null),
                'address' => $typeData['address'] ?? ($currentData->address ?? null),
                'status' => $typeData['status'] ?? ($currentData->status ?? null),
                // 'role_id' => $typeData['role_id'] ?? ($currentData->role_id ?? 1),
            ];
        }
        else if ($type === 'admin') {
            // Use provided data or fallback to current data if currentData is not null
            $newData = [
                'user_id' => $user->id,
                'display_name' => $typeData['display_name'] ?? ($currentData->display_name ?? null),
                'phone' => $typeData['phone'] ?? ($currentData->phone ?? null),
                'profile' => $typeData['profile'] ?? ($currentData->profile ?? null),
                'role_id' => $typeData['role_id'] ?? ($currentData->role_id ?? 1),
            ];

        }

        
        //update new data and Delete old type-specific data
        if ($user->type === 'client') {

            if ($type === 'company') {
                Client::where('user_id', $user->id)->delete();
                Company::create($newData);
            }
            else if ($type === 'admin'){
                Client::where('user_id', $user->id)->delete();
                Admin::create($newData);

            }
            else if ($type === 'client'){
                Client::where('user_id', $user->id)->update($newData);
            }

        

        } 
        else if ($user->type === 'company') {

            if ($type === 'client') {
                $company = Company::where('user_id', $user->id)->first();
                CompanyFile::where('company_id', $company['id'])->delete();
                Company::where('user_id', $user->id)->delete();
                Client::create($newData);
            }
            else if ($type === 'admin'){
                $company = Company::where('user_id', $user->id)->first();
                CompanyFile::where('company_id', $company['id'])->delete();
                Company::where('user_id', $user->id)->delete();
                Admin::create($newData);

            }
            else if ($type === 'company'){
                Company::where('user_id', $user->id)->update($newData);
            }


        } 
        else if ($user->type === 'admin') {

            if ($type === 'client') {
                Admin::where('user_id', $user->id)->delete();
                Client::create($newData);
            }
            else if ($type === 'company'){
                Admin::where('user_id', $user->id)->delete();
                Company::create($newData);
            }
            else if ($type === 'admin'){
                Admin::where('user_id', $user->id)->update($newData);
            }
        }

        $user->type = $type; 
        $user->save();


        //update company files
        if($user->type == 'company')
        {

            $company = Company::where('user_id', $user->id)->first();

            $company_file = CompanyFile::where('company_id', $company['id'])->first();
            
            if (!$company_file) {
                    $company_file = new CompanyFile;
                    $company_file['company_id'] = $company->id;
            }
    
            if (!is_null($typeData['commercial_register'])) {
                $this->deleteFileByPath($company_file['commercial_register']);
                $imagename = $this->uploadFilePdf($typeData['commercial_register'], "commercial_register" . strtotime(now()), 'commercial_register');
                $company_file['commercial_register'] = $imagename;
            }
    
            
            if (!is_null($typeData['tax_card'])) {
                $this->deleteFileByPath($company_file['tax_card']);
                $imagename = $this->uploadFilePdf($typeData['tax_card'], "tax_card" . strtotime(now()), 'tax_card');
                $company_file['tax_card'] = $imagename;
            }
    
            $company_file->save();
        }
    }

    public function updateUserImage($request)
    {
        $user = Auth::user();

        if($user['type'] == 'client')
        {
            $user_data = $user['client'];
   
        }
        else if($user['type'] == 'company') {

            $user_data = $user['company'];
        }

        if (isset($request['profile'])) {
            $this->deleteFileByPath($user_data['profile']);
            $imagename = $this->uploadFile($request['profile'], "user_profiles" . strtotime(now()), 'profiles');
            $user_data['profile'] = $imagename;
        }
        $user_data->save();
        return $user; 


    }


    public function getUsersWithSamePhone(){
        // Collect phone numbers and corresponding user IDs
        $clientPhones = User::with('client')->get()->pluck('client.phone', 'id')->filter();
        $companyPhones = User::with('company')->get()->pluck('company.phone', 'id')->filter();
        $adminPhones = User::with('admin')->get()->pluck('admin.phone', 'id')->filter();

        // Merge all phone numbers into one collection
        $allPhones = $clientPhones->merge($companyPhones)->merge($adminPhones);

        // Find duplicate phone numbers
        $duplicatePhones = $allPhones->duplicates();

        // Get user IDs of users with duplicate phone numbers
        $userIdsWithDuplicatePhones = $allPhones->filter(function ($phone) use ($duplicatePhones) {
            return $duplicatePhones->contains($phone);
        })->keys();

        return $userIdsWithDuplicatePhones;
    }

    public function getUsersWithPhoneSpaces()
    {
        // Collect phone numbers and corresponding user IDs
        $clientPhones = User::with('client')->get()->pluck('client.phone', 'id')->filter();
        $companyPhones = User::with('company')->get()->pluck('company.phone', 'id')->filter();
        $adminPhones = User::with('admin')->get()->pluck('admin.phone', 'id')->filter();
    
        // Merge all phone numbers into one collection
        $allPhones = $clientPhones->merge($companyPhones)->merge($adminPhones);
    
        // Filter phone numbers that contain spaces
        $phonesWithSpaces = $allPhones->filter(function ($phone) {
            return strpos($phone, ' ') !== false;
        });
    
        // Get user IDs of users with phone numbers containing spaces
        $userIdsWithPhoneSpaces = $phonesWithSpaces->keys();
    
        return $userIdsWithPhoneSpaces;
    }
    


    /**
     * Delete a user by ID.
     *
     * @param int $id
     * @return void
     */
    public function deleteUser($id)
    {
        $user = User::findOrFail($id);

        $this->deleteAdsByUser($id);


        // Delete type-specific data
        if ($user->type === 'client') {
            $client = Client::where('user_id', $user->id)->first();
            if ($client && $client->profile) {
                $this->deleteFileByPath($client->profile);
            }
            Client::where('user_id', $user->id)->delete();
        } elseif ($user->type === 'company') {
            $company = Company::where('user_id', $user->id)->first();
            if ($company && $company->profile) {
                $this->deleteFileByPath($company->profile);
            }

            //delete Company Files
            $company_file = CompanyFile::where('company_id', $company['id'])->first();
            $this->deleteFileByPath($company_file->commercial_register);
            $this->deleteFileByPath($company_file->tax_card);
            CompanyFile::where('company_id', $company['id'])->delete();
            Company::where('user_id', $user->id)->delete();
        } 
        // elseif ($user->type === 'admin') {
        //     $admin = Admin::where('user_id', $user->id)->first();
        //     if ($admin && $admin->profile) {
        //         $this->deleteFileByPath($admin->profile);
        //     }
        //     Admin::where('user_id', $user->id)->delete();
        // }

        // Delete ad favorites
        Favourite::where('user_id', $id)->delete();

        // Delete user_id comments
        Comment::where('user_id', $id)->delete();
   
        // Delete user likes
        Like::where('user_id', $id)->delete();
        
        // Delete the user
        $user->delete();
    }
    public function deleteAdsByUser($userId)
    {
        // 1. Retrieve all ad IDs for the user
        $adIds = Ad::where('user_id', $userId)->pluck('id');

        // 2. Delete all related records for each ad
        foreach ($adIds as $adId) {
            // Delete ad values
            ValueAd::where('ad_id', $adId)->delete();

            // Delete ad favorites
            Favourite::where('ad_id', $adId)->delete();

            // Delete ad comments
            Comment::where('ad_id', $adId)->delete();

            // Delete user likes and other likes for ads
            Like::where('ad_id', $adId)->delete();

            // Delete ad images
            $ad_images = AdImage::where('ad_id', $adId)->get();
            foreach ($ad_images as $ad_image) {
                $this->deleteFileByPath($ad_image->image);
            }
            AdImage::where('ad_id', $adId)->delete();


            // Delete ad itself
            Ad::find($adId)->delete();
        }
    }


    public function switchUserStatus($userId){
        $user = User::findOrFail($userId);
        $newStatus = $user['status'] === 0 ? 1 : 0;
    
        // Update user status
        $user['status'] = $newStatus;
        $user->save();
    
        // Update ads related to this user
        Ad::where('user_id', $userId)->update(['status' => $newStatus]);
    
        // Update comments related to this user
        Comment::where('user_id', $userId)->update(['status' => $newStatus]);
    
        return $user;
    }
}
