<?php

namespace App\Traits;

use Illuminate\Support\Facades\File;

trait ImageTrait
{


    public function uploadImage($file, $filename, $folder, $oldfile = null)
    {

        $image = str_replace('data:image/png;base64,', '', $file);
        $image = str_replace(' ', '+', $image);
        $image = base64_decode($image);
        $folder = public_path('images/' . $folder . '/' . $filename);
        file_put_contents($folder, $image);


        //$file->move(public_path('images/'.$folder),$filename);
        if (!is_null($oldfile)) {
            if (file_exists($oldfile)) {
                unlink($oldfile);
            }
        }

        return $filename;
    }

    public function uploadFile($file, string $fileName, string $path): string
    {
        $destinationPath = public_path("uploads/".$path); // upload path
        // Upload Original Image
        $profileImage = $fileName . "." . $file->getClientOriginalExtension();

        $file->move($destinationPath, $profileImage);
        // return $fileName;
        return  "uploads/" . $path . "/" . $profileImage;
    }

    public function uploadFilePdf($file, string $fileName, string $path): string
    {
        $destinationPath = public_path("uploads/".$path); // upload path
        
        // Upload Original Image
        $profileImage = $fileName . "." . 'pdf';

        $file->move($destinationPath, $profileImage);
        // return $fileName;
        return  "uploads/" . $path . "/" . $profileImage;
    }


    public function moveExistingFile(string $currentPath, string $fileName, string $newPath): string
    {
        // Extract the extension from the current file path
        $extension = pathinfo($currentPath, PATHINFO_EXTENSION);
    
        // Construct the new file name and path
        $destinationPath = public_path('uploads/' . $newPath);
        $profileImage = $fileName . '.' . $extension;
    
        // Ensure the destination directory exists
        if (!File::exists($destinationPath)) {
            File::makeDirectory($destinationPath, 0755, true);
        }
    
        // Copy the file to the new location
        File::copy($currentPath, $destinationPath . '/' . $profileImage);
    
        // Return the new file path
        return 'uploads/' . $newPath . '/' . $profileImage;
    }
    

    
    public function uploadFileBase64($file, string $fileName, string $path): string
    {        
        $destinationPath = "uploads/" . $path . "/"; // upload path
        $image = base64_decode($file);
        $fullpath = $destinationPath . $fileName . "." . "png";
        file_put_contents(public_path($fullpath), $image);
        return $fullpath;
    }

    public function deleteFileByPath($path)
    {
        if(File::exists(public_path($path))){
            File::delete(public_path($path));
            return true;
        }else{
            return false;
        }
    }

    public function uploadMultiFiles(array $files, string $fileName, string $path): array
    {
        $listOfPath = array();
        $count = 1;
        foreach ($files as $file){
            $listOfPath[] = $this->uploadFile($file, $fileName. "_". $count, $path);
            $count++;
        }
        return $listOfPath;
    }
}
