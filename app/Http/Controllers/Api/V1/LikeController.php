<?php

namespace App\Http\Controllers\Api\V1;


use App\Jobs\UnLike;
use App\Traits\ApiResponses;
use App\Http\Controllers\Controller;
use App\Jobs\AddLike;
use App\Models\Like;

class LikeController extends Controller
{
    use ApiResponses;

    public function likeAd()
    {
        $adId = request('id');
        $userId = auth()->user()->id;

        // تحقق مما إذا كان الإعجاب موجودًا
        $like = Like::where('user_id', $userId)
                    ->where('ad_id', $adId)
                    ->first();

        // إذا لم يكن الإعجاب موجودًا، أضفه
        if (!$like) {
            Like::create([
                'user_id' => $userId,
                'ad_id' => $adId,
            ]);
            return $this->success('done', 'Liked Successfully . . .');
        }

        return $this->success('done', 'Already Liked . . .');
    }

    public function unlikeAd()
    {
        $adId = request('id');
        $userId = auth()->user()->id;

        // تحقق مما إذا كان الإعجاب موجودًا
        $like = Like::where('user_id', $userId)
                    ->where('ad_id', $adId)
                    ->first();

        // إذا كان الإعجاب موجودًا، قم بإزالته
        if ($like) {
            $like->delete();
            return $this->success('done', 'Unliked Successfully . . .');
        }

        return $this->success('done', 'Like Not Found . . .');
    }

    // دالة success لراحة التعامل مع الاستجابة JSON
    protected function success($status, $message)
    {
        return response()->json(['status' => $status, 'message' => $message]);
    }

    public function userLikes(){
        $likes= Like::where('user_id',request('id'))->with('ad')->paginate(30);
        return $this->success($likes, 'Done');
    }
}
