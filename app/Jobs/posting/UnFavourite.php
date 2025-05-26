<?php

namespace App\Jobs;

use App\Models\FavouriteItem;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class UnFavourite implements ShouldQueue
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
        echo 'Event:  deleted from favourite' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {

        $favourite=FavouriteItem::where('ad_id', $this->data['id'])->whereHas('favourite',function($q){
            $q->where('user_id', $this->data['user_id']);
        })->first();

        if($favourite){
            $favourite->delete();

        }
     } catch (\Exception $e) {
        echo $e->getMessage();
    }
    }
}
