package com.salesmanago.sdk;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

import com.appmanago.lib.AmMonitor;
import com.appmanago.lib.AmMonitoring;

public class SalesManagoPlugin extends CordovaPlugin {

    private static final String TAG = "SalesManagoPlugin";
    private AmMonitoring amMonitor = null;

    @Override
    public void initialize(final CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        Log.i(TAG," -- Init SalesManago sdk --");
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {

        Log.i(TAG, "Action Name: " + action);

        if (action.equals("initialize")) {
            boolean result = true;

            try {
                if (amMonitor == null) amMonitor = AmMonitor.initLibrary(this.cordova.getActivity().getApplicationContext());
            } catch (Exception e) {
                Log.i(TAG, "Initialize error: " + e.toString());

                result = false;
            }

            Log.i(TAG, "Initialize ended");

            return result;
        }


        return false;
    }
}