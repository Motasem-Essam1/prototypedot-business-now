<?php

namespace App\Console\Commands;

use App\Models\Banner;
use App\Models\SplashAd;
use Carbon\Carbon;
use Illuminate\Console\Command;

class DisableExpiredSplashAds extends Command
{
    protected $signature = 'splash-ad:disable-expired';

    protected $description = 'disable expired splash ads';

    public function handle()
    {
        $expiredAds = SplashAd::where('expiry_date', '<=', Carbon::now())->get();

        foreach ($expiredAds as $ad) {
            $ad->update(['expired' => true]);
        }

        $this->info('Expired splash ads have been disabled successfully.');
    }
}
