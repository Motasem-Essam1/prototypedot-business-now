<?php

namespace App\Http\Traits;

trait ImageTrait{


    public function uploadImage($file,$filename,$folder,$oldfile=null){


        $file->move(public_path('images/'.$folder),$filename);
        if(!is_null($oldfile)){
            if(file_exists($oldfile)){
                 unlink($oldfile);
            }

        }

       return $filename;
    }
}
