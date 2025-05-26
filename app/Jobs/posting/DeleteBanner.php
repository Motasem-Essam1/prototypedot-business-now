<?php

namespace App\Jobs;

use App\Http\Traits\ImageTrait;
use App\Models\Banner;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class DeleteBanner implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

   use ImageTrait;
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
        echo 'Event: Banner deleted' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            $banner = Banner::findOrFail($this->data['id']);
            if($banner){
             $banner->delete();
            }


        } catch (\Exception $e) {
            echo $e->getMessage();
        }


    }
}
