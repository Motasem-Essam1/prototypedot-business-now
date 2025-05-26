<?php 

namespace App\Helpers;

use Google_Client;
use Google_Service_FirebaseCloudMessaging;

class FCMHelper
{
    public static function getAccessToken()
    {
        $client = new Google_Client();
        $client->useApplicationDefaultCredentials();
        $client->addScope(Google_Service_FirebaseCloudMessaging::CLOUD_PLATFORM);

        return $client->fetchAccessTokenWithAssertion()['access_token'];
    }
}
