<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Jobs\NotificationCreated;
use Illuminate\Http\Request;
use Validator;
use App\Models\DeviceToken;
use App\Models\Notification;
use Carbon\Carbon;
use App\Http\Controllers\BaseController;
use App\Services\NotificationService;

class NotificationController extends Controller
{
    public function __construct(private readonly NotificationService $notification_service)
    {
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'content' => 'required|max:255',
            'tokens' => 'required|array',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validator->errors()->first()
            ], 422);
        }

        NotificationCreated::dispatch($request->all())->onQueue('messageing');

        return response()->json([
            'status' => 'success',
            'message' => 'Notification Created Successfully . . .',
        ], 200);
    }


    public function saveToken(Request $request) {

        $validator = Validator::make($request->all(), [
            'device_token' => 'required',

        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validator->errors()->first(),
            ], 422);
        }

        $check_device = DeviceToken::where('user_id', auth('sanctum')->user()->id)
            ->where('device_token', '=', $request["device_token"])
            ->where('user_agent', '=', request()->userAgent());

        if (!$check_device->first()) {
            $device = new DeviceToken();
            $device['user_id'] = auth('sanctum')->user()->id;
            $device['device_token'] =  $request['device_token'];
            $device['user_agent'] = request()->userAgent();
            $device->save();
            
            return response()->json([
                'device' => $device,
                'message' => 'Device token saved successfully.',
            ], 200);
        } else {
            $this->removeTokens();
            return response()->json([
                'status' => 'failed',
                'message' => 'Device token exists',
            ], 409);
        }
    }

    public function isRead(Request $request) {
        $request->validate([
            'id' => 'required|exists:notifications,id',
        ]);
        $data = $request->only('id');
        $notify = Notification::find($request->id);
        $data['is_read'] = 1;
        $notify->update($data);

        return $this->sendResponse($notify->first(), 'Notification has been read');
    }

    public function removeTokens() {
        $user_id = auth('sanctum')->user()->id;
        $multiple_tokens_ids = DeviceToken::where('user_id', $user_id)
            ->where('created_at', '<', Carbon::now()->subDays(7))
            ->pluck('id')
            ->toArray();

        $data = DeviceToken::whereIn('id', $multiple_tokens_ids)->delete();

        if ($data) {
            return $this->sendResponse($data, 'Successfully delete device tokens');
        }
    }

    public function fetchNotifications() {


        if (auth('sanctum')->check()) {
            $user_authenticated = auth('sanctum')->user()->id;
            $data = Notification::where('user_id', $user_authenticated)->orderBy('created_at', 'DESC')->get()->all();
            $is_read = Notification::where('user_id', $user_authenticated)->where('is_read', 0)->get()->count();
            $result = [
                'data'    => $data,
                'is_read' => $is_read
            ];

            return $this->sendResponse($result, 'Successfully fetched notifications');
        }
    }

    public function fireNotification(Request $request) {
        
        //check projectId and GOOGLE_APPLICATION_CREDENTIALS
        $projectId = env(key: 'PROJECT_ID');
        $GOOGLE_APPLICATION_CREDENTIALS = env('GOOGLE_APPLICATION_CREDENTIALS');

        if(!$projectId)
        {
            return response()->json([
                'status' => 'failed',
                'message' => "add PROJECT_ID in .env",
            ], 500);

        }
        // return response()->json(['token' => $GOOGLE_APPLICATION_CREDENTIALS]);

        
        if(!$GOOGLE_APPLICATION_CREDENTIALS)
        {
            return response()->json([
                'status' => 'failed',
                'message' => "add GOOGLE_APPLICATION_CREDENTIALS in .env",
            ], 500);

        }

        //Validation
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer|exists:users,id',
            'title' => 'required',
            'body' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validator->errors()->first(),
            ], 422);
        }

        // $firebaseToken = DeviceToken::where('user_id', $request['user_id'])->whereNotNull('device_token')->pluck('device_token')->first();
        // return response()->json(['token' => $firebaseToken]);

        //fireNotification
        $response = $this->notification_service->fireNotification($request->toArray());

        return $response->getStatusCode() === 200
        ? response()->json(['message' => 'Notification sent successfully'])
        : response()->json(['error' => 'Error sending notification: ' . $response->getBody()], 500);
        
    }
}
