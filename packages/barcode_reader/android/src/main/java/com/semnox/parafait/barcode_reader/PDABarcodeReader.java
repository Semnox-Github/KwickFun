package com.semnox.parafait.barcode_reader;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import androidx.annotation.Nullable;

public class PDABarcodeReader {
    private static final String BARCODE_ACTION = "com.barcode.sendBroadcast";
    private static final String BARCODE_PARAM = "BARCODE";


    private static BroadcastReceiver barcodeBroadcastReceiver = new BroadcastReceiver() {
        public void onReceive(Context context, Intent intent) {
            if (PDABarcodeReader.BARCODE_ACTION.equals(intent.getAction())) {
                if(PDABarcodeReader.callback !=null){
                    PDABarcodeReader.callback.onData(intent.getStringExtra(PDABarcodeReader.BARCODE_PARAM));
                }
//                ((BarcodeReader.OnBarcodeReadListener) PDABarcodeReader.this.callerActivity).onBarcodeRead(intent.getStringExtra(PDABarcodeReader.BARCODE_PARAM));
            }
        }
    };
    @Nullable
    static private ScanResultCallback callback;


    static void registerCallback(Activity activity,ScanResultCallback resultCallback){
        callback = resultCallback;

        activity.registerReceiver(barcodeBroadcastReceiver, new IntentFilter(BARCODE_ACTION));

    }

    static  void unregisterCallback(Activity activity){
        callback = null;
        activity.unregisterReceiver(barcodeBroadcastReceiver);
    }

    static  void isRegistred(Activity activity){
        callback = null;
        activity.unregisterReceiver(barcodeBroadcastReceiver);
    }
     /*
      *
      * Pass Result through this callback
      *
      *
      */
    public interface ScanResultCallback{
        void onData(String data);

    }
}
