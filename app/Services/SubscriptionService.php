<?php

namespace App\Services;

use App\Models\Package;
use App\Models\UserData;
use Illuminate\Routing\Route;
use Carbon\Carbon;

class SubscriptionService
{
    private $paymentService;
    public function __construct(PaymentService $paymentService){
        $this->paymentService = $paymentService;
    }

    public function upgradeAccount(array $data): array{

        $package = Package::where('title', $data['package_name'])->first();
        
        $response = [
            "status" => "",
            "massage" => ""
        ];
        // if (!$package->has_price){
        //     if (!$package->has_condition){
        //         // $this->moveToServiceProvider($data['user_id']);
        //         // $this->assignPackageToUser($package, $data['user_id']);
        //         $response['status'] = true;
        //         $response['massage'] = "Congrats you are upgrade to " . $data['package_name'];
        //     }else {
        //         $response['status'] = true;
        //         $response['massage'] = "thanks for requesting this package one of our agent will contact you shortly";
        //     }
        // }else{
            $payment_data = [
                'package_name'=>$package['title'],
                'amount'=>$package['price'],
                'currency'=>'usd',
                'user_id'=> $data['user_id'],
                'package_id' => $package['id']
            ];
            $payment = $this->paymentService->makePayment($payment_data);
            $response['status'] = true;
            $response['massage'] = "";
            $response['payment'] = $payment;
        // }
        return $response;
    }
    // private function moveToServiceProvider(int $user_id){
    //     $user_data = UserData::where('user_id', $user_id)->first();
    //     $user_data->user_type = "Service Provider";
    //     $user_data->save();
    // }
    // private function assignPackageToUser(Package $package, int $user_id){
    //     $user_data = UserData::where('user_id', $user_id)->first();
    //     $user_data->package_id = $package->id;
    //     $user_data->save();
    // }

    // public function welcomeEmail(int $user_id, int $package_id){

    // }

}
