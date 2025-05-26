<?php

namespace App\Jobs;

use App\Models\Favourite as ModelsFavourite;
use App\Models\FavouriteItem;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class Favourite implements ShouldQueue
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
        echo 'Event:   Added to favourite' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
        $user= $this->data['user_id'];
        $favourite=ModelsFavourite::where('user_id',$user)->first();
        if(is_null($favourite)){
            $favourite=ModelsFavourite::create([

                'user_id'=>$user
       ]);}
       $item=FavouriteItem::where('favourite_id',$favourite->id)->where('ad_id',$this->data['ad_id'])->first();
       if(is_null($item)){

        $favourite->items()->create([
            'favourite_id'=>$favourite->id,
            'ad_id'=> $this->data['ad_id']
        ]);
    }
 } catch (\Exception $e) {
        echo $e->getMessage();
    }
}
}
