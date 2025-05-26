<?php

namespace App\Services;

use App\Models\Package;
use App\Models\UserData;
use App\Models\PackageDuration;
use Carbon\Carbon;

class PackageDurationService
{
    public $package_months = 12;
    public function __construct() {

    }

    public function upgradePackageDuration(int $user_id, int $package_id, int $number_of_months) {
        $check_package = PackageDuration::where('user_id', $user_id)->where('canceled_at', null)->orderBy('id', 'DESC')->first();
        if ($check_package) {
            PackageDuration::where('user_id', $user_id)->where('canceled_at', null)->orderBy('id', 'DESC')->take(1)->update(['canceled_at' => Carbon::now()->format('Y-m-d')]);
        }
        $package = Package::where('id', $package_id)->first();
        $total_price = $package['price'] * $number_of_months;
        $data = new PackageDuration;
        $data['user_id']            = $user_id;
        $data['package_id']         = $package_id;
        $data['number_of_months']   = $number_of_months;
        $data['start_date']         = Carbon::now()->format('Y-m-d');
        $data['end_date']           = Carbon::now()->addMonth($number_of_months);
        $data['total_price']        = $total_price;
        $data->save();
    }

    public function cancelPackageDuration(int $user_id) {
        $check_package = PackageDuration::where('user_id', $user_id)->where('canceled_at', null)->orderBy('id', 'DESC')->first();

        if ($check_package) {
            PackageDuration::where('user_id', $user_id)->orderBy('id', 'DESC')->take(1)->update(['canceled_at' => Carbon::now()->format('Y-m-d')]);
        }

        $package = Package::where('id', 1)->first();
        $total_price = $package['price'] * $this->package_months;
        $data = new PackageDuration;
        $data['user_id']            = $user_id;
        $data['package_id']         = $package['id'];
        $data['number_of_months']   = $this->package_months;
        $data['start_date']         = Carbon::now()->format('Y-m-d');
        $data['end_date']           = Carbon::now()->addMonth($this->package_months);
        $data['total_price']        = $total_price;
        $data->save();
    }

    public function getPackageDuration(int $user_id) {
        $check_package = PackageDuration::where('user_id', $user_id)
        ->where('end_date', '>', now()) // Assuming 'now' is the current date
        ->whereNull('canceled_at')->orderBy('id', 'DESC')->first();
        
        return $check_package;
        
    }

}
