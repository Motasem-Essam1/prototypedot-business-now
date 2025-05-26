<?php

namespace App\Jobs;

use App\Models\Like;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class AddLike implements ShouldQueue
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
        echo 'Event:  Like Added' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $like= Like::where('user_id',$this->data['user_id'])->where('ad_id',$this->data['id'])->first();

        if(is_null($like)){

           Like::create([
              "ad_id"=>$this->data['id'],
              "user_id"=>$this->data['user_id'],
           ]);
        }

        } catch (\Exception $e) {
            echo $e->getMessage();
        }

    }
}
