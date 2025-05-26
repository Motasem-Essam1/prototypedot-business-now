<?php

namespace App\Jobs;

use App\Models\Ad;
use App\Models\PromotionPlan;
use App\Models\Transaction;
use DB;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class AdPromotion implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $data;
    public function __construct($data)
    {
        $this->data = $data;
    }


    public function handle(): void
    {
        echo 'Event: Ad Promoted' . PHP_EOL;
        echo json_encode($this->data) . PHP_EOL;
        try {
            DB::beginTransaction();

            $ad = Ad::findOrFail($this->data['id']);
            if ($ad->promotion_expiry >= now()) {
                echo 'Ad Already Promoted' . PHP_EOL;
                return;
            }
            $promotionPlan = PromotionPlan::findOrFail($this->data['promotion_plan_id']);
            $duration = $this->data['duration'];

            $promotionPrice = $promotionPlan->getPromotionPrice($duration);

            $ad->promote($promotionPlan, $duration);
            $ad->save();

            // Create a new transaction record
            $transaction = new Transaction();
            $transaction->type = 'ad_promotion';
            $transaction->ad_id = $ad->id;
            $transaction->amount = $promotionPrice;
            $transaction->save();

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            echo $e->getMessage();
        }
    }
}
