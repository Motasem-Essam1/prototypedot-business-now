<?php

namespace App\Jobs;

use Carbon\Carbon;
use App\Models\Banner;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class UpdateBanner implements ShouldQueue
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

        try {
            $banner = Banner::findOrFail($this->data['id']);

                $existingExpiryDate = ($banner->expiry_date ?Carbon::parse($banner->expiry_date) : Carbon::now());



           $banner->update([
              "image"=>$this->data['file'] ?? $banner->image,
              "action_type"=>$this->data['action_type'] ?? $banner->action_type,
              "action"=>$this->data['action'] ?? $banner->action,
              "expiry_date"=> ($this->data['duration'] ? $existingExpiryDate->addDays($this->data['duration'] ) : $banner->expiry_date),
           ]);
           echo 'Event: Banner updated' . PHP_EOL;
           echo json_encode($this->data) . PHP_EOL;


        } catch (\Exception $e) {
            echo $e->getMessage();
        }

    }
}

