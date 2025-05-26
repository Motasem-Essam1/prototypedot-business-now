<?php

namespace App\Services;

use App\Models\Comment;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class CommentService.
 */
class CommentService
{
    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Comment::query()->get();
    }
 
    public function GetApproved()
    {
        return Comment::query()->where('approved', 1)->get();
    }
 
    /**
     * add New Comment
     *
     * @param array $data
     * @return array
     */
    public function addComment(array $data): array
    {
        $comment = new Comment;
        $comment['ad_id'] = $data['ad_id'];
        $comment['user_id'] = $data['user_id'];
        if(!empty($data['content']))
        {
            $comment['content'] = $data['content'];
        }
        else{
            $comment['content'] = '';
        }
        $comment['user_name'] = auth()->user()['name'];  
        $comment['approved'] = 1;
        $comment['rate'] = $data['rate'];
        $comment->save();
        return $comment->toArray();
    }
 
 
    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Comment::query()->where('approved', 1)
        ->where('status', 1)->find($id);
    }

    /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function getAdComments(int $id)
    {
        return Comment::query()->where('ad_id', $id)->where('approved', 1)->where('status', 1)->get();
    } 


        /**
     * Display the specified resource.
     *
     * @param int $id ,
     * @return Builder|Builder[]|Collection|Model
     */
    public function deleteAdComments(int $id)
    {
        return Comment::query()->where('ad_id', $id)->delete();
    } 
 
    /**
     * update the specified resource
     *
     * @param array $request
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function update(Array $request, int $id)
    {
        $comment = Comment::query()->find($id);
        $comment['ad_id'] = $request['ad_id'];
        if(!empty($request['content']))
        {
            $comment['content'] = $request['content'];
        }
        $comment['rate'] = $request['rate'];
        $comment->save();
        return $comment;
    }
 
 
    /**
     * delete the specified resource
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $comment = Comment::query()->find($id);
        $comment->delete();
    }
    

    /**
     * update the specified resource
     *
     * @param array $request
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function updateApprove(Array $request, int $id)
    {
        $comment = Comment::query()->find($id);
        $comment['approved'] = $request['approved'];
        $comment->save();
        return $comment;
    }

    public function getAverage(int $id)
    {
        return Comment::where('ad_id',$id)->avg('rate');
    }


}
