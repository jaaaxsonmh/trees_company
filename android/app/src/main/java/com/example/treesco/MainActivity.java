package com.example.treesco;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), "samples.flutter.io/ar").setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        Intent launchIntent = getPackageManager().getLaunchIntentForPackage("com.ar.treeco");
                        if (launchIntent != null) {
                            launchIntent.addCategory("tree_co");
                            startActivity(launchIntent);
                            result.success(null);
                        }else {
                            result.error("AR is not supported", "AR is not supported", null);
                        }

                    }
                });
    }
}
