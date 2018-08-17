package org.godotengine.godot;

import java.util.List;

import com.godot.game.R;

import org.godotengine.godot.util.*;

import android.content.Intent;
import android.content.Context;
import android.app.Activity;
import android.util.Log;
import org.json.JSONException;

public class CafeBazaarGodotInterface extends Godot.SingletonBase {

    private IabHelper mHelper;
    private Integer callbackId = 0;
    private Context mContext;
    private Activity mActivity;

    static public Godot.SingletonBase initialize(Activity p_activity) {
        return new CafeBazaarGodotInterface(p_activity);
    }

    public CafeBazaarGodotInterface(Activity p_activity) {
        //register class name and functions to bind
        registerClass("CafeBazaarIAB", new String[]{ "connect", "setCallbackId", "purchase", "consume", "queryInventory" });
        mContext = (Context) p_activity;
        mActivity = p_activity;
    }

    public void setCallbackId(int callbackId) {
        this.callbackId = callbackId;
    }

    public Integer getCallbackId() {
        return callbackId;
    }

    public void connect(String base64EncodedPublicKey){
        mHelper = new IabHelper(mContext, base64EncodedPublicKey);

        mHelper.startSetup(new IabHelper.OnIabSetupFinishedListener() {
            public void onIabSetupFinished(IabResult result) {
                GodotLib.calldeferred(callbackId, "onIabSetupFinished", new Object[] { result.getResponse(), result.getMessage() });
            }
         });
    }

    public void purchase(final String SKU, String developerPayload){
        mHelper.launchPurchaseFlow(mActivity, SKU, 10001,  new IabHelper.OnIabPurchaseFinishedListener() {
            public void onIabPurchaseFinished(IabResult result, Purchase purchase)
            {
                if(result.isSuccess())
                    GodotLib.calldeferred(callbackId, "onIabPurchaseFinished", new Object[] { result.getResponse(), result.getMessage(), purchase.getItemType(), purchase.getOriginalJson(), purchase.getSignature() });
                else
                    GodotLib.calldeferred(callbackId, "onIabPurchaseFinished", new Object[] { result.getResponse(), result.getMessage(), "", "", "" });
            }
         }, developerPayload);
    }

    public void consume(final String itemType, final String Json, final String sign){
        mActivity.runOnUiThread(new Runnable() {
            public void run() {
                try{
                    Purchase purchase = new Purchase(itemType, Json, sign);
                    mHelper.consumeAsync(purchase,
                        new IabHelper.OnConsumeFinishedListener() {
                            public void onConsumeFinished(Purchase purchase, IabResult result) {
                                if (result.isSuccess())
                                    GodotLib.calldeferred(callbackId, "onConsumeFinished", new Object[] { result.getResponse(), result.getMessage(), purchase.getItemType(), purchase.getOriginalJson(), purchase.getSignature() });
                                else
                                    GodotLib.calldeferred(callbackId, "onConsumeFinished", new Object[] { result.getResponse(), result.getMessage(), "", "", "" });
                            }
                        });
                }catch(JSONException e){}
            }
        });
    }

    public void queryInventory(boolean details){
        //Log.d("DEBUGING", "INCOME");
        // for (int i = 0; i < skusList.size(); i++) 
        //     Log.d("DEBIGING", skusList.get(i).toString());
        // mHelper.queryInventoryAsync(true, additionalSkuList,
        // new IabHelper.QueryInventoryFinishedListener() {
        //     public void onQueryInventoryFinished(IabResult result, Inventory inventory)  
        //     {
               
        //     }
        // });
    }

    protected void onMainActivityResult(int requestCode, int resultCode, Intent data) {
        if (!mHelper.handleActivityResult(requestCode, resultCode, data)) {
            onMainActivityResult(requestCode, resultCode, data);
        }
    }

    protected void onMainDestroy() {
        if (mHelper != null) mHelper.dispose();
        mHelper = null;
    }
}