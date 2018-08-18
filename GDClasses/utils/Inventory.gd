var mSkuMap = {}
var mPurchaseMap = {}

const PurchaseTemp = preload("res://Scripts/utils/Purchase.gd")
const SkuDetailsTemp = preload("res://Scripts/utils/SkuDetails.gd")

func _init(purchaseJson, skuJson):
	var json_conv = JSON.parse(purchaseJson)
	if json_conv.error == OK:
		var purchaseMap = json_conv.result
		for key in purchaseMap:
			var array = purchaseMap[key].split(";")
			var newPurchase = PurchaseTemp.new(array[0], array[1], array[2])
			mPurchaseMap[key] = newPurchase
	json_conv = JSON.parse(skuJson)
	if json_conv.error == OK:
		var skuMap = json_conv.result
		for key in skuMap:
			var array = skuMap[key].split(";")
			var newSkuDetails = SkuDetailsTemp.new(array[0], array[1])
			mSkuMap[key] = newSkuDetails

func getSkuDetails(sku):
	return mSkuMap[sku]

func getPurchase(sku):
	return mPurchaseMap[sku]
    
func hasPurchase(sku):
	return sku in mPurchaseMap.keys()

func hasDetails(sku):
	return sku in mSkuMap.keys()

func getAllOwnedSkus(itemType):
	var result = []
	for p in mPurchaseMap:
		if mPurchaseMap[p].mItemType == itemType:
			result.append(p.mSku)
	return result

func getAllPurchases():
	var result = []
	for p in mPurchaseMap:
		result.append(mPurchaseMap[p])
	return result
