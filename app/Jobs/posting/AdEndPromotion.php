<?php

namespace App\Jobs;

use App\Models\Ad;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class AdEndPromotion implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $data;
    public function __construct($data)
    {
        $this->data = $data;
    }


    public function handle(): void
    {
        echo 'Event: Ad  End Promotion' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $ad = Ad::findOrFail($this->data['id']);

            $ad->endPromotion();
        } catch (\Exception $e) {
            echo $e->getMessage() . PHP_EOL;
        }
    }
}
