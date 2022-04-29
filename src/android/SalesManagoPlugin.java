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
import com.appmanago.lib.AmProperties;

import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.ConnectionResult;

import com.google.firebase.FirebaseApp;

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

        boolean result = true;

        try {
            if (action.equals("initialize")) {
                if (amMonitor == null) amMonitor = AmMonitor.initLibrary(this.cordova.getActivity().getApplicationContext());
            } else if (action.equals("syncEmail")) {
                amMonitor.syncEmail(args.getString(0));
            } else if (action.equals("syncPhone")) {
                amMonitor.syncMsisdn(args.getString(0));
            } else if (action.equals("syncPushToken")) {
                if (checkPlayServices()) {
                    amMonitor.resolveRegistrationToken();
                }
            }
        } catch (Exception e) {
            Log.i(TAG, "Exception in " + action + " : " + e.toString());
            result = false;
        }

        return result;
    }

    private boolean checkPlayServices() {
        GoogleApiAvailability apiAvailability = GoogleApiAvailability.getInstance();
        int resultCode = apiAvailability.isGooglePlayServicesAvailable(this.cordova.getActivity().getApplicationContext());
        if (resultCode != ConnectionResult.SUCCESS) {
            if (apiAvailability.isUserResolvableError(resultCode)) {
                apiAvailability.getErrorDialog(this.cordova.getActivity(), resultCode, 9000)
                .show();
            } else {
                Log.i(TAG, "This device is not supported.");
            }

            return false;
        }
        return true;
    }
}