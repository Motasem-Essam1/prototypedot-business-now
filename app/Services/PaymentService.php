<?php

namespace App\Services;
use App\Mail\SubscriptionMail;
use App\Models\Package;
use App\Models\Payment;
use App\Models\UserData;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;

class PaymentService
{
    private $packageDurationService;
    public function __construct(PackageDurationService $packageDurationService) {
        $this->packageDurationService = $packageDurationService;
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET'));
    }

    public function makePayment(array $data): Payment
    {
        $local_token = $this->generateRandomToken();
        
        //For test
        // \Stripe\Stripe::setApiKey('sk_test_4eC39HqLyjWDarjtT1zdp7dc'); // Replace with your test API key

        $session = \Stripe\Checkout\Session::create([
            'success_url' => route('subscription.payment.success')."?local_token=".$local_token,
            'cancel_url' => route('subscription.payment.fail')."?local_token=".$local_token,
            'mode' => 'payment',
            'line_items' => [
                [
                    'price_data' => [
                        'unit_amount' => $data['amount'] . "00",
                        'currency'=> $data['currency'],
                        'product_data' => [
                            'name' => $data['package_name']
                        ]
                    ],
                    'quantity' => 1,
                ],
            ],
        ]);

        $payment = new Payment();
        $payment->user_id = $data['user_id'];
        $payment->package_id = $data['package_id'];
        $payment->local_token = $local_token;
        $payment->transaction_id = $session->id;
        $payment->amount_subtotal = $data['amount'];
        $payment->request_create_at = $session->created;
        $payment->currency = $session->currency;
        $payment->expires_at = $session->expires_at;
        $payment->url = $session->url;
        $payment->save();
        return $payment;
    }
    
    public function successPayment(string $local_token){
        $payment = Payment::Where('local_token', $local_token)->first();
        // $user_data = UserData::where('user_id', $payment->user_id)->first();
        // update payment table
        $payment->status = true;
        $payment->transaction_at = Carbon::now()->toDateTimeString();;
        $payment->save();
        //update user table
        // $user_data->user_type = 'Service Provider';
        // $user_data->package_id = $payment->package_id;
        // $user_data->save();
        // calc duration
        // $this->packageDurationService->upgradePackageDuration(
        //     $user_data['user_id'],
        //     $payment['package_id'],
        //     $this->packageDurationService->package_months
        // );
        // Mail::to($user_data->user)->send(new SubscriptionMail($payment));
    }

    /**
     * @throws \Exception
     */
    private function generateRandomToken(): string
    {
        while (true){
            $bytes = random_bytes(20);
            $token = bin2hex($bytes);
            $count = Payment::where('local_token', $token)->count();
            if ($count <= 0){
                return $token;
            }
       }
    }

    public function failPayment(string $local_token){
        $payment = Payment::Where('local_token', $local_token)->first();
        // $user_data = UserData::where('user_id', $payment->user_id)->first();
        // update payment table
        $payment->status = false;
        $payment->transaction_at = Carbon::now()->toDateTimeString();;
        $payment->save();
        //update user table
    }


}
