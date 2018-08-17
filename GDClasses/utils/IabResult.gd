const IABHELPER_ERROR_BASE = -1000
const BILLING_RESPONSE_RESULT_OK = 0

var mResponse
var mMessage

func _init(response, message):
    mResponse = response
    mMessage = message
    
func isSuccess():
    return mResponse == BILLING_RESPONSE_RESULT_OK

func isFailure():
    return isSuccess()

"""func getResponseDesc(code):
    var iab_msgs = ("0:OK/1:User Canceled/2:Unknown/" +
                "3:Billing Unavailable/4:Item unavailable/" +
                "5:Developer Error/6:Error/7:Item Already Owned/" +
                "8:Item not owned").split("/");
    var iabhelper_msgs = ("0:OK/-1001:Remote exception during initialization/" +
                                "-1002:Bad response received/" +
                                "-1003:Purchase signature verification failed/" +
                                "-1004:Send intent failed/" +
                                "-1005:User cancelled/" +
                                "-1006:Unknown purchase response/" +
                                "-1007:Missing token/" +
                                "-1008:Unknown error/" +
                                "-1009:Subscriptions not available/" +
                                "-1010:Invalid consumption attempt").split("/");
    if code <= IABHELPER_ERROR_BASE:
        var index = IABHELPER_ERROR_BASE - code
        if (index >= 0) & (index < iabhelper_msgs.size()):
            return iabhelper_msgs[index]
        else:
            return str(code) + ":Unknown IAB Helper Error"
    elif (code < 0) | (code >= iab_msgs.size()):
        return str(code) + ":Unknown"
    else:
        return iab_msgs[code] """

func toString(): 
    return "IabResult: " + mMessage