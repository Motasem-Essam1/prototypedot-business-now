<?php

namespace App\Jobs;

use App\Models\Comment;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class AddComment implements ShouldQueue
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
         echo 'Event: comment Created' . PHP_EOL;
         echo json_encode($this->data) . PHP_EOL;
         try {
            Comment::create([
               "ad_id"=>$this->data['id'],
               "user_id"=>$this->data['user_id'],
               "user_name"=>$this->data['user_name'],
               "content"=>$this->data['content'],
            ]);



         } catch (\Exception $e) {
             echo $e->getMessage();
         }

     }
}
