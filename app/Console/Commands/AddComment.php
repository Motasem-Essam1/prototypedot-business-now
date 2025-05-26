<?php

namespace App\Console\Commands;

use App\Models\Comment;
use Illuminate\Console\Command;

class AddComment extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:add-comment';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        \App\Jobs\AdCreated::dispatch(Comment::inRandomOrder()->first()->toArray());
    }
}
