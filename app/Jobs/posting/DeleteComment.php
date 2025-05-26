<?php

namespace App\Jobs;

use App\Models\Comment;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class DeleteComment implements ShouldQueue
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
         echo 'Event: comment deleted' . PHP_EOL;
         echo json_encode($this->data) . PHP_EOL;
         try {


            $comment = Comment::where('id', $this->data['id'])
            ->where('user_id', $this->data['user_id'])
            ->first();

        if (!$comment) {
           echo 'Comment not found or you are not authorized to delete it.';
        }

           $comment->delete();


         } catch (\Exception $e) {
             echo $e->getMessage();
         }

     }
}
