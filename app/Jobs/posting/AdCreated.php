<?php

namespace App\Jobs;

use App\Http\Traits\AdTrait;
use App\Models\Ad;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class AdCreated implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use AdTrait ;
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
        echo 'Event: Ad Created' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $this->store($this->data);


        } catch (\Exception $e) {
            echo $e->getMessage();
        }

    }
}
