package com.salesmanago.sdk;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;

//import android.app.Activity;
//import android.content.Intent;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

import android.util.Log;

//import com.vogo.playerlib.MainPlayer;

public class SalesmanagoPlugin extends CordovaPlugin {

    private static final String TAG = "SalesmanagoPlugin";

    @Override
    public void initialize(final CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        Log.i(TAG," -- Init SALESMANAGO sdk --");
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {

        Log.i(TAG, "Action Name: " + action);
		/*
        if (action.equals("launchPlayer")){

            Activity activity = this.cordova.getActivity();
            if(activity != null)
            {
                Intent vogoIntent = new Intent(activity, MainPlayer.class);
                JSONObject options = (args != null ? args.getJSONObject(0) : null);
                if(options != null) setupIntent(vogoIntent, options);
                activity.startActivity(vogoIntent);
            }

            return true;
        } 
		*/
		if (action.equals("echo")) {
			String message = args.getString(0);
			this.echo(message, callbackContext);
			return true;
		}

        return false;
    }
	
	private void echo(String message, CallbackContext callbackContext) {
		if (message != null && message.length() > 0) {
			callbackContext.success(message);
		} else {
			callbackContext.error("Expected one non-empty string argument.");
		}
	}
}
