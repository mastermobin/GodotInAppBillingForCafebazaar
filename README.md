# CafeBazaar InAppBilling For Godot 3.1.Dev
In this repository we implement some classes to connect and communicate with CafeBazaar In App Billing Service 
# How To Use ?
In this section we explain how to use these classes for creating a connection
## Step 1 : Add CafeBazaarIAB Permission
You need to open your export settings ( `Project -> Export` ), and add an android export or select it in case you created one before, go to the `User Permissions` section at the bottom of the fields of the `Options` tab and fill the first empty permission by this value:
> com.farsitel.bazaar.permission.PAY_THROUGH_BAZAAR
## Step 2 : Set Android Export Templates
To export or test your game IAB Implementation, you need to add our export templates to your export settings.
Open android export like you did in Step 1, and go to the `Custom Package` part of the `Options` section, then select **debug** and **release** apk files available in **Android Templates** directory.
## Step 3 : Add GDScripts To Resources
Paste GDScripts into resource directory and link `CafeBazaar.gd` to a simple node on the scene to communicate with it.
## Step 4 : Usage
Just get that node linked to `Cafebazaar.gd` and use its methods :

Method Name | Description
--- | ---
startSetup (String key) | Connect to The Cafebazaar IAB Service and get ready for working with that and emit `on_iab_setup_finished` signal when getting response from Cafebazaar.
launchPurchaseFlow (String skuID, String developerPayload) | Open Cafebazaar purchase dialog and emit `on_iab_purchase_finished` signal at the end.
consumeAsync (Purchase purchase) | Consume a consumable stuff whenever you want, you can do it at end of purchase. This method emits `on_iab_consume_finished` signal at the end.
queryInventoryAsync (bool skuDetailsFlag, List skuList) | Returns skuList items info from Cafebazaar and you can use it when `on_query_inventory_finished` is emitted.

**Note : The second signals param will be a string consisting "Null" value if operation is not successful, so check the results at the first step.** 
# Java Classes
if you add some android modules and have your own custom template so use our java classes to combine your template and ours
Compile instructions for android modules available on Godot Documentation