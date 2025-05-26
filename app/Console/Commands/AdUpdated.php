<?php

namespace App\Console\Commands;

use App\Models\Ad;
use Illuminate\Console\Command;

class AdUpdated extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:ad-updated';

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
        \App\Jobs\AdUpdated::dispatch(Ad::inRandomOrder()->first()->toArray());
    }
}
