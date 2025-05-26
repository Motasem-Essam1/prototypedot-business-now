<?php

namespace App\Console\Commands;

use App\Models\Banner;
use Carbon\Carbon;
use Illuminate\Console\Command;

class DisableExpiredBanners extends Command
{
    protected $signature = 'banners:disable-expired';

    protected $description = 'Disable expired banners';

    public function handle()
    {
        $expiredBanners = Banner::where('expiry_date', '<=', Carbon::now())->get();

        foreach ($expiredBanners as $banner) {
            $banner->update(['expired' => true]);
        }

        $this->info('Expired banners have been disabled successfully.');
    }
}
