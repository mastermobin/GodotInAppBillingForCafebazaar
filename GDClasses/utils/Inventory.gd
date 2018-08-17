var mSkuMap
var mPurchaseMap

func _init(skuMap, purchaseMap):
	mSkuMap = skuMap
	mPurchaseMap = purchaseMap

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
