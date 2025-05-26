<?php

namespace App\Jobs;

use App\Http\Traits\AdTrait;
use App\Traits\ApiResponses;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class AdUpdated implements ShouldQueue
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
        echo 'Event: Ad updated' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {

            $this->update($this->data);
            
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }
}
