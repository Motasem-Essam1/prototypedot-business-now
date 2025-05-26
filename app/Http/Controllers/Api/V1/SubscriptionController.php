<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;

use App\Models\Package;
use App\Models\Payment;
use App\Services\PaymentService;
use App\Services\SubscriptionService;
use App\Services\PackageDurationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class SubscriptionController extends BaseController
{
    private $subscriptionService;
    private $paymentService;
    private $services_Service;
    private $packageDurationService;
    public function __construct(SubscriptionService $subscriptionService, PaymentService $paymentService, PackageDurationService $packageDurationService) {
        $this->subscriptionService = $subscriptionService;
        $this->paymentService = $paymentService;
        $this->packageDurationService = $packageDurationService;
    }

    public function subscribe(string $package_name) {
        $package = Package::query()->where('title', $package_name)->first();

        $user_id = auth()->user()->id;

        // Check if package is empty
        if (empty($package)) {
            return $this->sendError('something went wrong', 'package not found');
        }
        else{
            // Check if package is un public
            if ($package['status'] == 0) {
                return $this->sendError('something went wrong', 'package not found');
            }

            // If user has package
            $user_package = $this->packageDurationService->getPackageDuration($user_id);

            if($user_package != null) {
                if($user_package['package_id'] == $package['id']) {
                    return $this->sendError('something went wrong', 'you subscribed same package');
                }
            }

            if ($package['price'] == 0) {
                $this->packageDurationService->upgradePackageDuration($user_id, $package['id'], $this->packageDurationService->package_months);
                return $this->sendResponse([], 'success subscribed free package');
            }
            else {

                return $this->sendResponse([], 'success subscribe start checkout payment');
            }
        }
    }

    public function cancel(){
        $package = Package::find(1)->first();
        $user_id = auth()->user()->id;

        // If user has package
        $user_package = $this->packageDurationService->getPackageDuration($user_id);
        if($user_package == null) {
            return $this->sendError('something went wrong', 'user has no package to cancel');
        }

        $this->packageDurationService->cancelPackageDuration($user_id);
        return $this->sendResponse([], 'success cancel package');
    }

    public function payment(Request $request){
        $validatedData = Validator::make($request->all(), [
            'title' => 'required|exists:packages,title',
            'amount' => 'required|numeric|min:0' // Ensure amount is a valid number and not negative
        ]);


        if ($validatedData->fails()) {
            return response()->json([ 'success' => false, 'errors' => $validatedData->errors() ], 400);
            // return $this->sendError('something went wrong', 'package not found or amout not enough');
        }

        
        $data = [
            'package_name' => $request['title'],
            'amount'=> $request['amount'],
            'user_id' => auth()->user()->id,
            // 'package_id' => $request['package_id'],
        ];
        $response = $this->subscriptionService->upgradeAccount(data: $data);
        if (isset($response['payment'])){

            //return Redirect::away($response['payment']->url);
            return $this->sendResponse([], 'payment url');

        }
        if ($response['status']) {
            return $this->sendResponse([], 'verification.congratulations');
        } else {
            return $this->sendError('something went wrong', 'payment is failed');
        }
    }

    public function paymentSuccess(Request $request){
        $payment = Payment::Where('local_token', $request['local_token'])->first();
        $this->paymentService->successPayment($request['local_token']);
        session::flash('title','Congratulations');
        Session::flash('massage', 'thanks for your payment');
        return redirect()->route('status');
    }

    public function paymentFail(Request $request){
        $this->paymentService->failPayment($request['local_token']);
        Session::flash('title','Payment invalid');
//      Session::flash('massage', 'Payment invalid');
        return redirect()->route('status');
    }

}
