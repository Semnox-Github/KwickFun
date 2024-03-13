package com.semnox.parafait.barcode_reader;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** BarcodeReaderPlugin */
public class BarcodeReaderPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PDABarcodeReader.ScanResultCallback {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "barcode_reader");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
//    if (call.method.equals("getPlatformVersion")) {
//      result.success("Android " + android.os.Build.VERSION.RELEASE);
//    }
    if (call.method.equals("register")) {
      if(activity !=null) {
        PDABarcodeReader.registerCallback(activity, this);
        result.success("");
        return;
      }
      result.error("No-activity", "No Activity Registered", null);
      return;

    }
   else if (call.method.equals("unregister")) {
      if(activity !=null) {
        PDABarcodeReader.unregisterCallback(activity);
        result.success("");
        return;
      }
      result.error("No-activity", "No Activity Registered", null);
      return;

    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    PDABarcodeReader.unregisterCallback(activity);

  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    PDABarcodeReader.registerCallback(activity, this);

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
    PDABarcodeReader.unregisterCallback(activity);

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    PDABarcodeReader.registerCallback(activity, this);

  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
    PDABarcodeReader.unregisterCallback(activity);

  }

  @Override
  public void onData(String data) {
    channel.invokeMethod("on_data",data);
  }
}
