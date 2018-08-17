extends Node2D

const PurchaseTemp = preload("res://Scripts/utils/Purchase.gd")
const IabResultTemp = preload("res://Scripts/utils/IabResult.gd")

onready var cafeBazaarIAB = Engine.get_singleton("CafeBazaarIAB")

signal on_iab_setup_finished(result)
signal on_iab_purchase_finished(result, purchase)
signal on_iab_consume_finished(result, purchase)

func _ready():
	cafeBazaarIAB.setCallbackId(get_instance_id())

func connectToIab(key):
	cafeBazaarIAB.connect(key)

func onIabSetupFinished(response, message):
	var result = IabResultTemp.new(response, message)
	emit_signal("on_iab_setup_finished", result)

func onIabPurchaseFinished(response, message, itemType, json, signature):
	var result = IabResultTemp.new(response, message)
	if result.isSuccess():
		var purchase = PurchaseTemp.new(itemType, json, signature)
		emit_signal("on_iab_purchase_finished", result, purchase)
	else:
		emit_signal("on_iab_purchase_finished", result, "Null")

func onConsumeFinished(response, message, itemType, json, signature):
	var result = IabResultTemp.new(response, message)
	if result.isSuccess():
		var purchase = PurchaseTemp.new(itemType, json, signature)
		emit_signal("on_iab_consume_finished", result, purchase)
	else:
		emit_signal("on_iab_consume_finished", result, "Null")

func launchPurchaseFlow(sku, developerPayload):
	cafeBazaarIAB.purchase(sku, developerPayload)

func consumeAsync(purchase):
	cafeBazaarIAB.consume(purchase.mItemType, purchase.mOriginalJson, purchase.mSignature)

func queryInventoryAsync(details, skus):
	cafeBazaarIAB.queryInventory(details, skus)