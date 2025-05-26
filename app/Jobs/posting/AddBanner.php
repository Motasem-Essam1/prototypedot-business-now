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

class AddBanner implements ShouldQueue
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
            Banner::create([
                "image"=>$this->data['file'],
                "action_type"=>$this->data['action_type'],
                "action"=>$this->data['action'],
                "expiry_date"=>Carbon::now()->addDays($this->data['duration']),
             ]);
             echo 'Event: Banner added' . PHP_EOL;
         echo json_encode($this->data) . PHP_EOL;

        } catch (\Exception $e) {
            echo $e->getMessage();
        }




     }
}

