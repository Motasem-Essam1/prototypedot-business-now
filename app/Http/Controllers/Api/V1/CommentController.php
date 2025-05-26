<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\BaseController;
use App\Http\Requests\CommentRequest;
use App\Http\Resources\CommentResource;
use App\Jobs\DeleteComment;
use App\Models\Comment;
use App\Services\CommentService;
use App\Traits\ApiResponses;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CommentController extends BaseController
{

    use ApiResponses;


    public function __construct(private readonly CommentService $comment_service)
    {
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $comments = $this->comment_service->index();
        return $this->sendResponse(CommentResource::collection($comments), "success");
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CommentRequest $request)
    {    
        $data = $request->only('ad_id', 'content', 'rate');
        $data['user_id'] = auth()->id();
        $response = $this->comment_service->addComment($data);
        return $this->sendResponse($response, "Comment created successfully");
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $comment = $this->comment_service->show($id);

        if(!empty($comment))
        {
            return $this->sendResponse(CommentResource::make($comment), "success");
        }
        else{
            return $this->sendError('failed',['Comment element does not exist to show']);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CommentRequest $request, string $id)
    {
        $comment = $this->comment_service->show($id);

        if(!empty($comment))
        {
            $data = $request->only('ad_id', 'content', 'rate');
            $data['user_id'] = auth()->id();
            $response = $this->comment_service->update($data, $id);
            return $this->sendResponse($response,'Comment updated successfully');
 
        }
        else{
            return $this->sendError('failed',['Comment element does not exist to updated']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {

        $comment = $this->comment_service->show($id);

        if(!empty($comment))
        {
            $this->comment_service->destroy($id);
 
            return $this->sendResponse([], "Comment deleted successfully");
        }
        else{
            return $this->sendError('failed',['Comment element does not exist to delete']);
        }
    }

        /**
     * Remove the specified resource from storage for web
     */
    public function destroy2(string $id)
    {

        $comment = $this->comment_service->show($id);

        if(!empty($comment))
        {

            if($comment['user_id'] == auth()->user()->id) {
                $this->comment_service->destroy($id);
 
                return $this->sendResponse([], "Comment deleted successfully");
            }
            else{
                return $this->sendError('failed',['cannot delete Comment of other users']);
 
            }

        }
        else{
            return $this->sendError('failed',['Comment element does not exist to delete']);
        }
    }


    

    public function userComments(){

        $comments= Comment::where('user_id',request('id'))->where('approved', 1)
        ->where('status', 1)->with('ad')->paginate(30);
        return $this->success($comments, 'Done');
    }

    public function adComments(Request $request){

        $validatedData = Validator::make($request->all(), [
            'ad_id' => 'required|exists:ads,id',
        ]);
    
        // إذا فشل التحقق من البيانات، يتم إرجاع رسالة خطأ
        if ($validatedData->fails()) {
            return response()->json(['errors' => $validatedData->errors()], 422);
        }

        $comments =  $this->comment_service->getAdComments($request['ad_id']);
        $data['comments'] = CommentResource::collection($comments);
        $data['ad_average_rate'] =  sprintf("%0.2f", $this->comment_service->getAverage($request['ad_id']));
        return $this->sendResponse($data, "success");
    }

    public function updateApprove(Request $request, string $id)
    {

        $validatedData = Validator::make($request->all(), [
            'approved' => 'required',
        ]);
    
        // إذا فشل التحقق من البيانات، يتم إرجاع رسالة خطأ
        if ($validatedData->fails()) {
            return response()->json(['errors' => $validatedData->errors()], 422);
        }
    
        $comment = $this->comment_service->show($id);

        if(!empty($comment))
        {
            $data = $request->only('approved');
            $response = $this->comment_service->updateApprove($data, $id);
            return $this->sendResponse($response,'Comment approved successfully');
 
        }
        else{
            return $this->sendError('failed',['Comment element does not exist to approved']);
        }
    }
}
