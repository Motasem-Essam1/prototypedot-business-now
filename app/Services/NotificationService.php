<?php

namespace App\Services;

use App\Models\DeviceToken;
use App\Models\Notification;
use Illuminate\Support\Facades\Auth;
use App\Helpers\FCMHelper;

class NotificationService
{
    public function fireNotification(array $data) {

        $notify = new Notification();
        $notify['user_id'] = $data['user_id'];
        $notify['message'] = $data['title'] . $data['body'];

        $notify->saveOrFail();

        
        return $this->fcm($data['user_id'], $data);
    }

    private function fcm(int $user_id, array $message) {
        $firebaseTokens = DeviceToken::where('user_id', $user_id)->whereNotNull('device_token')->pluck('device_token')->toArray();

        if ($firebaseTokens === null) {
            // Handle the null case (e.g., return a specific response)
            return response()->json(['error' => 'Token is required.'], 400);
        }
            
        $accessToken = FCMHelper::getAccessToken();
        $client = new \GuzzleHttp\Client();
        $projectId = env('PROJECT_ID');

        foreach($firebaseTokens as $firebaseToken)
        {
            $response = $client->post('https://fcm.googleapis.com/v1/projects/' . $projectId . '/messages:send', [
                'headers' => [
                    'Authorization' => 'Bearer ' . $accessToken,
                    'Content-Type' => 'application/json',
                ],
                'json' => [
                    'message' => [
                        'token' => $firebaseToken,
                        'notification' => [
                            'title' => $message['title'],
                            'body' => $message['body'],
                        ],
                    ],
                ],
            ]);
        }
        return $response;
    }

    // public function removeNotifications($id, $type) {
    //     $data = Notification::where('item_id', $id)->where('item_type', $type);
    //     if ($data->count() > 0) {
    //         $data->delete();
    //     }
    // }

    public function removeDeviceTokens($id) {
        $token_ids = DeviceToken::where('user_id', $id)->pluck('id')->toArray();
        if ($token_ids) {
            DeviceToken::whereIn('id', $token_ids)->delete();
        }
    }

}
