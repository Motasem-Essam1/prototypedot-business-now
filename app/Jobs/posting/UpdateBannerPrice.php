<?php

namespace App\Jobs;

use App\Models\BannerPrice;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class UpdateBannerPrice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $data;
    /**
     * Create a new job instance.
     */
    public function __construct($data)
    {
        $this->data = $data;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        echo 'Event: Banner added' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $bannerprice = BannerPrice::findOrFail($this->data['id']);


           $bannerprice->update([
            'one_day_price' => $this->data['one_day_price'],
            'three_day_price' => $this->data['three_day_price'],
            'seven_day_price' => $this->data['seven_day_price'],
           ]);



        } catch (\Exception $e) {
            echo $e->getMessage();
        }

    }
}
