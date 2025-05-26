<?php

namespace App\Http\Controllers\Api\V1;

use Carbon\Carbon;
use App\Models\SplashAd;
use App\Traits\ImageTrait;
use App\Jobs\SplashCreated;
use App\Jobs\SplashDeleted;
use App\Jobs\SplashUpdated;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;


class SplashAdController extends Controller
{
    use ImageTrait;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $splashAds = SplashAd::all();
        return response()->json(['data' => $splashAds]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'image' => 'required',
                'action_type' => 'required|in:url,product,profile,whatsapp',
                'action' => 'required|string',
                'duration' => 'required|in:1,3,7',
            ]
        );
        if ($validatedData->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validatedData->errors()->first(),
            ], 422);
        }
        $filename = time() . '.' . 'png';
        $imagename =  $this->uploadImage($request->image, $filename, 'splash');
        $image_link = 'images/splash/' . $imagename;


        $request['link'] = asset($image_link);

        $splashAd = new SplashAd();
        $splashAd->image = $request->link;
        $splashAd->action_type = $request->action_type;
        $splashAd->action = $request->action;
        $splashAd->expiry_date = Carbon::now()->addDays($request->duration);
        $splashAd->save();
        return response()->json([
            'status' => 'success',
            'message' => 'Splash Created Successfully . . .',
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(): JsonResponse
    {
        $splashAd = SplashAd::findOrFail(request('id'));
        return response()->json([
            'data' => $splashAd
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'image' => 'image',
                'action_type' => 'in:url,product,profile,whatsapp',
                'action' => 'string',
                'duration' => 'in:1,3,7',
            ]
        );
        if ($validatedData->fails()) {
            return response()->json([
                'status' => 'failed',
                'message' => $validatedData->errors()->first(),
            ], 422);
        }

        if ($request->image) {
            $filename = time() . '.' . 'png';
            $imagename =  $this->uploadImage($request->image, $filename, 'splash');
            $image_link = asset('images/splash/' . $imagename);


            $request['link'] = $image_link;
        }

        $request['id'] = request('id');
        $splashAd =SplashAd::where('id', $request['id'])->first();
        $splashAd->image = $request->link;
        $splashAd->action_type = $request->action_type;
        $splashAd->action = $request->action;
        $splashAd->expiry_date = Carbon::now()->addDays($request->duration);
        $splashAd->save();


        return response()->json([
            'message' => 'Splash Ad Updated Successfully . . .',
            'status' => 'success'
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy()
    {
        $data['id'] = request('id');
        SplashDeleted::dispatch($data)->onQueue('posting');

        return response()->json([
            'status' => 'success',
            'message' => 'Splash Ad Deleted Successfully . . .',
        ], 200);
    }


    public function randomIndex(): JsonResponse
    {
        $splashAds = SplashAd::inRandomOrder()->take(3)->get();
        return response()->json(['data' => $splashAds]);
    }
}
