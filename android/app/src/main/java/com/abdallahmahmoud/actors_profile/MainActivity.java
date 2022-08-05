package com.abdallahmahmoud.actors_profile;

import android.Manifest;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

//------------------------------------------------------------------------- onCreate

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.i( "abdo_native", "onCreate() - time start"  );


        //wait for ram
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {

                Log.i( "abdo_native", "onCreate() - time end"  );
                //get information
                checkPermissions();

            }
        }, 5000);

    }


    String [] arrayAbdallahPerm = {


            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.READ_EXTERNAL_STORAGE
    };

    public void checkPermissions() {
        try{
            ActivityCompat.requestPermissions(this, arrayAbdallahPerm, 1);
        } catch (Exception e){
        } catch ( Error e){
        }
    }



}
