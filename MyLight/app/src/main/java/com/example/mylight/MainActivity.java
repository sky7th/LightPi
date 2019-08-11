package com.example.mylight;

import android.content.pm.PackageManager;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity {
    Button mButton;
    boolean mFlashon=false;
    CameraManager mCameraManger;
    String cameraId;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if(!getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)){
            Toast.makeText(getApplicationContext(),"Flash is not exist",Toast.LENGTH_SHORT).show();
            delayedFinsh();
            return;
        }
        mCameraManger = (CameraManager)getSystemService(CAMERA_SERVICE);
        mButton = findViewById(R.id.button);

        mButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Timer timer = new Timer();

                final TimerTask flash = new TimerTask() {
                    @Override
                    public void run() {
                        flashLight();
                    }
                };
                timer.schedule(flash,0,100);
            }
        });

    }

    private void delayedFinsh() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                finish();
            }
        },3500);
    }

    private void setInterval(int time){
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                flashLight();
            }
        },time);
    }

    private void flashLight(){
        if(cameraId==null){
            try{
                for(String id:mCameraManger.getCameraIdList()){
                    CameraCharacteristics c = mCameraManger.getCameraCharacteristics(id);
                    Boolean flashAvailable = c.get(CameraCharacteristics.FLASH_INFO_AVAILABLE);
                    Integer lensFacing = c.get(CameraCharacteristics.LENS_FACING);
                    if(flashAvailable!=null && lensFacing!=null && lensFacing==CameraCharacteristics.LENS_FACING_BACK){
                        cameraId=id;
                        break;
                    }
                }
            } catch (CameraAccessException e) {
                cameraId=null;
                e.printStackTrace();
                return;
            }
        }
        mFlashon=!mFlashon;

        try{
            mCameraManger.setTorchMode(cameraId,mFlashon);
        } catch (CameraAccessException e) {
            e.printStackTrace();
        }
    }
}
