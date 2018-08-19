# CafeBazzar InAppBilling For Godot
In this repository we implement some classes to connect and communicate with CafeBazaar In App Billing Service 
# How To Use ?
This section explain how use this classes for create a connection
## Step 1 : Add CafeBazaarIAB Permission
You need to open your export setting ( `Project -> Export` ) and add an android export or select it in that case you created before, going to the bottom of fields at first tab and fill first empty `User Permission` by this value :
> com.farsitel.bazaar.permission.PAY_THROUGH_BAZAAR
## Step 2 : Set Android Export Templates
To export or test your game IAB Implementation, you need to add our export templates to your export setting.
Like Step 1 select android export in the `Custom Package` part select debug and release apk downloaded from **Android Templates** directory.
## Step 3 : Add GDScripts To Resources
Paste GDScripts into resource directory and link `CafeBazaar.gd` to a simple node on the scene to communicate with it.
## Step 4 : Usage
Just get that node linked to `Cafebazaar.gd` and use its methods :
Method Name                                               |Description                                                                                                                                            
----------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------
startSetup (String key)                                   |Connect to The Cafebazaar IAB Service and get ready for working with that and emit `on_iab_setup_finished` signal when getting response from Cafebazaar
launchPurchaseFlow (String skuID, String developerPayload)|Open Cafebazaar purchase dialog and emit `on_iab_purchase_finished` signal at the end                                                                  
consumeAsync (Purchase purchase)                          |Consume a consumable stuff whenever you want, you can do it at end of purchase. this method emit `on_iab_consume_finished` signal at the end           
queryInventoryAsync (bool skuDetailsFlag, List skuList)   |Return skuList items info from Cafebazaar and you can use it when `on_query_inventory_finished` emitted                                                

**Note : the second signals param will be a string consist "Null" value if operation wasn't success, so check result at the first step.** 