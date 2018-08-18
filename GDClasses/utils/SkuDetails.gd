const ITEM_TYPE_INAPP = "inapp"

var mItemType
var mSku
var mType
var mPrice
var mTitle
var mDescription
var mJson

func _init(itemType, jsonSkuDetails):
	mItemType = itemType
	mJson = jsonSkuDetails
	var json_conv = JSON.parse(mJson)
	if json_conv.error == OK:
		var o = json_conv.result
		mSku = o["productId"]
		mType = o["type"]
		mPrice = o["price"]
		mTitle = o["title"]
		mDescription = o["description"]

func toString():
	return "SkuDetails:" + mJson
