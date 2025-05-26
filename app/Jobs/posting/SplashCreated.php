<?php

namespace App\Jobs;

use App\Models\SplashAd;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SplashCreated implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $data;
    public function __construct($data)
    {
        $this->data = $data;
    }


    public function handle(): void
    {
        echo 'Event: Splash Created' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $splashAd = new SplashAd();
            $splashAd->image = $this->data['link'];
            $splashAd->action_type = $this->data['action_type'];
            $splashAd->action = $this->data['action'];
            $splashAd->expiry_date = Carbon::now()->addDays($this->data['duration']);
            $splashAd->save();
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }
}
