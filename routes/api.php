<?php

use App\Http\Controllers\Api\V1\AdminController;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CityController;
use App\Http\Controllers\Api\V1\ClientController;
use App\Http\Controllers\Api\V1\CompanyController;
use App\Http\Controllers\Api\V1\GovernorateController;
use App\Http\Controllers\Api\V1\MessageController;
use App\Http\Controllers\Api\V1\NotificationController;
use App\Http\Controllers\Api\V1\RoleController;
use App\Http\Controllers\Api\V1\UserController;
use App\Http\Controllers\Api\V1\UserDashboardController;
use App\Http\Controllers\Api\V1\PackageController;
use App\Http\Controllers\Api\V1\PackageDurationsController;
use App\Http\Controllers\Api\V1\PaymentController;
use App\Http\Controllers\Api\V1\SubscriptionController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\AdController;
use App\Http\Controllers\Api\V1\LikeController;
use App\Http\Controllers\Api\V1\BannerController;
use App\Http\Controllers\Api\V1\CommentController;
use App\Http\Controllers\Api\V1\CategoryController;
use App\Http\Controllers\Api\V1\SplashAdController;
use App\Http\Controllers\Api\V1\FavouriteController;
use App\Http\Controllers\Api\V1\BannerPriceController;
use App\Http\Controllers\Api\V1\SubcategoryController;
use App\Http\Controllers\Api\V1\PromotionPlanController;
use App\Http\Controllers\Api\V1\SplashAdPriceController;
use App\Http\Controllers\Api\V1\FilterController;
use App\Http\Controllers\Api\V1\ValueController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('', function () {
    \Illuminate\Support\Facades\Artisan::call('config:cache');
});

Route::group(['prefix' => 'auth/'], function () {
    Route::post('register', [AuthController::class, 'registration']);
    Route::post('login', [AuthController::class, 'login']);
    Route::get('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
    Route::post('/fcm-token', [AuthController::class, 'fcmToken'])->middleware('auth:sanctum');
    Route::get('/{provider}/redirect', [AuthController::class, 'redirectToSocialProvider']);
    Route::get('/{provider}/callback', [AuthController::class, 'handleSocialProviderCallback']);
    Route::post('/get-user-data', [AuthController::class, 'getUserData']);
    Route::post('/login_for_Social', [AuthController::class, 'loginForSocial']);
    Route::post('/get-user-data-social', [AuthController::class, 'getUserDataSocial']);
    Route::post('send-verification-phone', [AuthController::class, 'sendVerificationPhone']);
    Route::post('send-verification-email', [AuthController::class, 'sendVerificationEmail']);
    Route::post('verify-code-reset-password', [AuthController::class, 'verifyCodeAndResetPassword']);
});

Route::delete('delete-user', [AuthController::class, 'deleteUser'])
->middleware( 'auth:sanctum');


//Users for web
Route::get('user', [UserController::class, 'show'])
->middleware('auth:sanctum');
Route::patch('user', [UserController::class, 'update'])
->middleware('auth:sanctum');

//Users for new Dashboard
Route::group(['prefix' => 'users/dashboard', 'middleware' => ['auth:sanctum', 'is.admin']], function () {
    Route::get('', [UserDashboardController::class, 'index']);
    Route::get('{user}', [UserDashboardController::class, 'show']);
    Route::post('', [UserDashboardController::class, 'store']);
    Route::post('update/{user}', [UserDashboardController::class, 'update']); // Include user identifier
    Route::delete('{user}', [UserDashboardController::class, 'destroy']); // Include user identifier

});

Route::get('with-same-phone', [UserDashboardController::class, 'getUsersWithSamePhone'])->middleware(['auth:sanctum', 'is.admin']);// Add the endpoint here
Route::get('with-spaces-phone', [UserDashboardController::class, 'getUsersWithPhoneSpaces'])->middleware(['auth:sanctum', 'is.admin']);// Add the endpoint here
Route::patch('switch-status/{user}/', [UserDashboardController::class, 'switchUserStatus'])->middleware(['auth:sanctum', 'is.admin']);

//Users for old Dashboard
Route::post('dashboard/users', [UserController::class, 'createUser'])->middleware(['auth:sanctum', 'is.admin']);
Route::put('dashboard/users', [UserController::class, 'userUpdate'])->middleware(['auth:sanctum', 'is.admin']);
Route::post('dashboard/users/password', [UserController::class, 'userPassword'])->middleware(['auth:sanctum', 'is.admin']);
Route::get('dashboard/users/search', [UserDashboardController::class, 'search'])->middleware(['auth:sanctum', 'is.admin']);
Route::get('platform-count', [UserController::class, 'getPlatformCount']);

//create export files
Route::get('/export-users', [UserController::class, 'exportUsers'])->middleware(['auth:sanctum', 'is.admin']);
Route::get('/export-companies', [CompanyController::class, 'exportCompany'])->middleware(['auth:sanctum', 'is.admin']);
Route::get('/export-clients', [ClientController::class, 'exportUsers'])->middleware(['auth:sanctum', 'is.admin']);

Route::get('get_by_token', [UserController::class, 'userByToken'])
->middleware('auth:sanctum');  

//profile
Route::post('profile', [UserController::class, 'updateProfile'])
->middleware('auth:sanctum');     
Route::post('profile/image', [UserController::class, 'updateProfileImage'])
->middleware('auth:sanctum');  
Route::post('profile/password', [UserController::class, 'updatePassword'])
->middleware('auth:sanctum');   
Route::get('profile', [UserController::class, 'userProfile'])
->middleware('auth:sanctum'); 


//Filter
Route::middleware(['auth:sanctum', 'is.admin'])->apiResource('filters', FilterController::class);
Route::get('all-filters', [FilterController::class, 'index']);   


//Value
Route::middleware(['auth:sanctum', 'is.admin'])->apiResource('values', ValueController::class);

//admins
Route::patch('admins', [AdminController::class, 'update'])
    ->middleware(['auth:sanctum', 'is.admin']);
Route::delete('admins', [AdminController::class, 'destroy'])
    ->middleware(['auth:sanctum', 'is.admin']);
Route::get('admin', [AdminController::class, 'show'])
    ->middleware(['auth:sanctum', 'is.admin']);
Route::resource('admins', AdminController::class)
    ->middleware(['auth:sanctum', 'is.admin'])->only(['index', 'store']);
Route::post('admins/profile', [AdminController::class, 'uploadProfile'])
    ->middleware(['auth:sanctum', 'is.admin']);

//roles
Route::patch('roles', [RoleController::class, 'update'])->middleware(['auth:sanctum', 'is.admin']);
Route::delete('roles', [RoleController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
Route::get('role', [RoleController::class, 'show'])->middleware(['auth:sanctum', 'is.admin']);
Route::resource('roles', RoleController::class)->only(['index', 'store'])
    ->middleware(['auth:sanctum', 'is.admin']);



//client endpoints
    Route::get('client', [AuthController::class, 'userInfo'])
        ->middleware('auth:sanctum');
Route::group(['prefix' => 'clients'], function () {
    Route::get('', [ClientController::class, 'index'])
        ->middleware(['auth:sanctum', 'is.admin']);
    Route::post('', [ClientController::class, 'update'])
        ->middleware('auth:sanctum');
    Route::post('/profile', [ClientController::class, 'uploadProfile'])
        ->middleware('auth:sanctum');
    Route::delete('', [ClientController::class, 'destroy'])
        ->middleware(['auth:sanctum', 'is.admin']);
});


Route::get('/get-client', [ClientController::class, 'show'])    ->middleware('auth:sanctum');



//company endpoints
Route::get('company', [CompanyController::class, 'show'])
->middleware('auth:sanctum');
Route::group(['prefix' => 'companies'], function () {
    Route::get('', [CompanyController::class, 'index'])
        ->middleware(['auth:sanctum']);
    Route::post('', [CompanyController::class, 'store'])
        ->middleware('auth:sanctum');
    Route::get('{id}/category', [CompanyController::class, 'companyOfCategory']);
    Route::get('{id}/show', [CompanyController::class, 'companyShow']);
    Route::patch('', [CompanyController::class, 'update'])
        ->middleware('auth:sanctum');
    Route::post('{company}/profile', [CompanyController::class, 'uploadProfile'])
        ->middleware('auth:sanctum');
    Route::delete('', [CompanyController::class, 'destroy'])
        ->middleware(['auth:sanctum', 'is.admin']);
    Route::post('/uploadfiles', [CompanyController::class, 'uploadCommercialFile'])
        ->middleware(['auth:sanctum']);
    
});


Route::post('messages', [MessageController::class, 'store'])
    ->middleware(['auth:sanctum']);

Route::patch('promotion_plan', App\Http\Controllers\Api\V1\PlanController::class)->middleware(['auth:sanctum', 'is.admin']);
Route::patch('splash-ad', [SplashAdController::class, 'update'])->middleware(['auth:sanctum', 'is.admin']);
Route::delete('splash-ad', [SplashAdController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
Route::apiResource('splash-ad', SplashAdController::class)->middleware(['auth:sanctum', 'is.admin'])->only(['store']);

    //comment and like
    //Dashboard
    Route::group(['prefix' => '/admin/comment'], function () {
        Route::get('', [CommentController::class, 'index'])->middleware(['auth:sanctum', 'is.admin']);
        Route::delete('/{id}', [CommentController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
        Route::post('updateApprove/{id}', [CommentController::class, 'updateApprove'])->middleware(['auth:sanctum', 'is.admin']);
    });

    //web
    Route::group(['prefix' => '/comment'], function () {
        Route::post('', [CommentController::class, 'store'])->middleware(['auth:sanctum']);
        Route::put('/{id}', [CommentController::class, 'update'])->middleware(['auth:sanctum']);
        Route::delete('/{id}', [CommentController::class, 'destroy2'])->middleware(['auth:sanctum']);
        Route::get('/{id}', [CommentController::class, 'show'])->middleware(['auth:sanctum']);
    });
    Route::get('/ad/comments', [CommentController::class, 'adComments']);
    Route::get('/user/comments', [CommentController::class, 'userComments']);


    Route::post('/like', [App\Http\Controllers\Api\V1\LikeController::class, 'likeAd'])->middleware(['auth:sanctum']);
    Route::delete('/unlike', [App\Http\Controllers\Api\V1\LikeController::class, 'unlikeAd'])->middleware(['auth:sanctum']);

    //banner endpoints
    // Route::group(['prefix' => 'banner'], function () {
    //     Route::post('', [BannerController::class, 'store']);
    //     Route::put('{id}', [BannerController::class, 'update'])->middleware(['auth:sanctum']);
    //     Route::post('/uploadimages/{id}', [BannerController::class, 'uploadImages'])->middleware(['auth:sanctum']);
    //     Route::delete('/{id}', [BannerController::class, 'destroy'])->middleware(['auth:sanctum']);
    //     Route::get('', [BannerController::class, 'index']);
    //     Route::get('/{id}', [BannerController::class, 'show']);
    // });
    Route::apiResource('banner', BannerController::class)->middleware(['auth:sanctum', 'is.admin'])->only(['store']);
    Route::delete('banner', [BannerController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
    Route::patch('banner', [BannerController::class, 'update'])->middleware(['auth:sanctum', 'is.admin']);
    Route::post('banner/uploadimages/{id}', [BannerController::class, 'uploadImages'])->middleware(['auth:sanctum', 'is.admin']);
    Route::get('banners', [BannerController::class, 'index']);
    Route::get('banner', [BannerController::class, 'show']);



 // banner pricing
 Route::get('banner-pricings', [BannerPriceController::class, 'index']);
 Route::get('banner-pricing', [BannerPriceController::class, 'show']);
Route::patch('banner-pricing', [App\Http\Controllers\Api\V1\BannerPriceController::class, 'update'])->middleware(['auth:sanctum']);

Route::patch('splash-ad-pricing', SplashAdPriceController::class)->middleware(['auth:sanctum', 'is.admin']);


// Route::prefix('V1')->group(function () {

    //categories endpoints
    Route::group(['prefix' => 'categories'], function () {
        Route::post('', [CategoryController::class, 'store'])->middleware(['auth:sanctum', 'is.admin']);
        Route::put('{id}', [CategoryController::class, 'update'])->middleware(['auth:sanctum', 'is.admin']);
        Route::post('/uploadimages/{id}', [CategoryController::class, 'uploadImages'])->middleware(['auth:sanctum', 'is.admin']);
        Route::delete('/{id}', [CategoryController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
        Route::get('', [CategoryController::class, 'index']);
        Route::get('/{id}', [CategoryController::class, 'show']);
    });
    Route::get('attribute/show', [CategoryController::class, 'attribute']);

    
    //subcategories endpoints
    Route::group(['prefix' => 'subcategories'], function () {
        Route::post('', [SubcategoryController::class, 'store'])->middleware(['auth:sanctum', 'is.admin']);
        Route::put('{id}', [SubcategoryController::class, 'update'])->middleware(['auth:sanctum', 'is.admin']);
        Route::post('/uploadimages/{id}', [SubcategoryController::class, 'uploadImages'])->middleware(['auth:sanctum', 'is.admin']);
        Route::delete('/{id}', [SubcategoryController::class, 'destroy'])->middleware(['auth:sanctum', 'is.admin']);
        //get Subcategories by category id - [not get Subcategory by Subcategory id] 
        Route::get('', [SubcategoryController::class, 'index']);
        Route::get('/{id}', [SubcategoryController::class, 'show']);
    });
    Route::delete('subcategories-delete-with-ads/{id}', [SubcategoryController::class, 'destroyWithAds'])->middleware(['auth:sanctum', 'is.admin']);

    //ads endpoints

    //web
    Route::post('ad/store', [AdController::class, 'store'])->middleware(['auth:sanctum']);
    Route::post('/ad/update', [AdController::class, 'update'])->middleware(['auth:sanctum']);
    Route::delete('/ad', [AdController::class, 'destroy'])->middleware(['auth:sanctum']);
    Route::post('/ad/promote', [AdController::class, 'promote'])->middleware(['auth:sanctum']);
    Route::get('/ad/end-promotion', [AdController::class, 'endPromotion'])->middleware(['auth:sanctum']);
    Route::post('/update-approved-ad', [AdController::class, 'UpdateApprovedAd'])->middleware(['auth:sanctum', 'is.admin']);
    Route::get('/approved-ads', [AdController::class, 'getApprovedAds']);
    Route::get('/ad', [AdController::class, 'index']);
    Route::get('/ad/show', [AdController::class, 'show']);
    Route::get('/ad/show-ad-user', [AdController::class, 'showAdUser'])->middleware(['auth:sanctum']);
    Route::get('/ad/types', [AdController::class, 'getTypes']);
    Route::get('/ad/pending', [AdController::class, 'getPending']);
    Route::get('/ad/category', [AdController::class, 'byCategory']);
    Route::get('/ad/subcategory', [AdController::class, 'bySubCategory']);
    Route::get('/ad/company', [AdController::class, 'byCompany']);
    Route::post('/ad/filter', [AdController::class, 'filterByAttributes']);
    Route::get('/ad/search/{search?}', [AdController::class, 'searchAd']);
    Route::get('/user/ads', [AdController::class, 'userAds'])->middleware(['auth:sanctum']);
    Route::post('/ad/upload-images/', [AdController::class, 'uploadImages'])->middleware(['auth:sanctum']);
    Route::delete('/ad/delete-images/', [AdController::class, 'deleteImages'])->middleware(['auth:sanctum']);
    Route::get('/ad/filter/', [AdController::class, 'filter'])->middleware(['auth:sanctum', 'is.admin']);

    //dashbaord
    Route::get('/ad/show2', [AdController::class, 'show2'])->middleware(['auth:sanctum', 'is.admin']);
    Route::get('/ad2', [AdController::class, 'index2'])->middleware(['auth:sanctum', 'is.admin']);
    Route::get('/ad/dashboard/status', [AdController::class, 'dashboardStatus'])->middleware(['auth:sanctum', 'is.admin']);
    Route::post('/ad/dashboard/update', [AdController::class, 'dashboardUpdate'])->middleware(['auth:sanctum', 'is.admin']);
    Route::post('/ad/dashboard/store', [AdController::class, 'dashboardStore'])->middleware(['auth:sanctum', 'is.admin']);
    Route::post('/ad/dashboard/delete', [AdController::class, 'dashboardDestroy'])->middleware(['auth:sanctum', 'is.admin']);
    Route::post('/ad/dashboard/update-status', [AdController::class, 'dashboardUpdateStatus'])->middleware(['auth:sanctum', 'is.admin']);

    
    //favourite
    Route::post('/favourite', [FavouriteController::class, 'Favourite'])->middleware(['auth:sanctum']);
    Route::get('/user/favourites', [FavouriteController::class, 'userFavourites'])->middleware(['auth:sanctum']);

    //user endpoints
    Route::get('/user/likes', [LikeController::class, 'userLikes']);

    Route::get('/user/prometedads', [AdController::class, 'prometedUserAds']);

    //promotion plans
    Route::get('promotion_plans', [PromotionPlanController::class, 'index']);
    Route::get('promotion_plan', [PromotionPlanController::class, 'show']);

    // splash ad pricing
    Route::get('splash-ad-pricings', [SplashAdPriceController::class, 'index']);
    Route::get('splash-ad-pricing', [SplashAdPriceController::class, 'show']);

    //splash ads
    Route::get('/splash-ad/random', [SplashAdController::class, 'randomIndex']);
    Route::get('splash-ads', [SplashAdController::class, 'index']);
    Route::get('splash-ad', [SplashAdController::class, 'show']);
// });

//governorates and cities endpoints for Dashboard
Route::group(['middleware' => ['auth:sanctum', 'is.admin']], function () {
    Route::apiResources([
        'governorates'    => GovernorateController::class,
        'cities'    => CityController::class,
    ]);    
});

//governorates and cities endpoints for Web
Route::get('governorates-index', [GovernorateController::class, 'index']);
Route::get('governorates-show/{id}', [GovernorateController::class, 'show']);


//notifications
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/save-token', [NotificationController::class, 'saveToken'])->name('save-token'); // Push
    Route::post('/is-read', [NotificationController::class, 'isRead'] )->name('isRead');
    Route::get('/fetch-notifications', [NotificationController::class, 'fetchNotifications'] )->name('fetchNotifications');
    Route::get('/remove-tokens', [NotificationController::class, 'removeTokens'] )->name('removeTokens');
    Route::post('/fire-notification', [NotificationController::class, 'fireNotification'])->middleware(['is.admin']);;
});

Route::group(['prefix' => 'notifications'], function () {
    Route::resource('', NotificationController::class)
        ->middleware(['auth:sanctum', 'is.admin'])->only(['store']);
});


//Payment and Package
Route::prefix('subscription')->middleware('auth:sanctum')->group(function () {
    Route::get('checkout/{package}', [SubscriptionController::class, 'subscribe']);
    Route::get('cancel', [SubscriptionController::class, 'cancel']);
    Route::get('payment', [SubscriptionController::class, 'payment']);
    Route::get('payment/callback/success', [SubscriptionController::class, 'paymentSuccess'])->name('subscription.payment.success');
    Route::get('payment/callback/fail', [SubscriptionController::class, 'paymentFail'])->name('subscription.payment.fail');
});


Route::group(['middleware' => ['auth:sanctum', 'is.admin']], function () {
    Route::apiResources([
        'packages' => PackageController::class,
        'package-durations' => PackageDurationsController::class,
        'transactions'  => PaymentController::class,
    ]);
 
    Route::prefix('packages')->group(function () {
        Route::post('/upload-image', [PackageController::class, 'uploadImage']);
        Route::post('/is-public', [PackageController::class, 'isPublic']);
    });   
});


