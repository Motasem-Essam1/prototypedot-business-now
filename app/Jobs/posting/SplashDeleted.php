<?php

namespace App\Jobs;

use App\Models\SplashAd;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SplashDeleted implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $data;
    public function __construct($data)
    {
        $this->data = $data;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        echo 'Event: Splash Deleted' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            SplashAd::findOrFail($this->data['id'])->delete();
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }
}
