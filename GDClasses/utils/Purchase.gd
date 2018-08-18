var mItemType  # ITEM_TYPE_INAPP or ITEM_TYPE_SUBS
var mOrderId
var mPackageName
var mSku
var mPurchaseTime
var mPurchaseState
var mDeveloperPayload
var mToken = ""
var mOriginalJson
var mSignature

func _init(itemType, jsonPurchaseInfo, signature):
	mItemType = itemType
	mOriginalJson = jsonPurchaseInfo
	var json_conv = JSON.parse(mOriginalJson)
	if json_conv.error == OK:
		var o = json_conv.result
		mOrderId = o["orderId"]
		mPackageName = o["packageName"]
		mSku = o["productId"]
		mPurchaseTime = o["purchaseTime"]
		mPurchaseState = o["purchaseState"]
		mDeveloperPayload = o["developerPayload"]
		if 'token' in o.keys():
			mToken = o["token"]
		else:
			mToken = o["purchaseToken"]
	mSignature = signature

func toString():
	return "PurchaseInfo(type:" + mItemType + "):" + mOriginalJson
