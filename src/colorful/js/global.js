.pragma library

var orderNO="0"
var oldorderNO=""
var displayText = ""
var pay = "0"
var addMenuType = 1

var dialogRectNo
var dialogTextNo = 0
//--订单号相关全局变量--//
var gorderListOrderNo
var gorderListseatNO
var gorderListMac
var gorderListDate
var gorderListTime
var gorderListDiscount
var gorderListTotal
var gorderListPay
var gorderIndex = 0

//--详细订单相关全局变量--//
var gorderItemsOrderNo
var gorderItemsSuborderNO
var gorderItemsName
var gorderItemsPrice
var gorderItemsNum
var gorderItemsType
var gorderItemsprintname
var gprintbool    ////是否要打印到厨房
var gcookbool    ////是否已发送至厨房烹饪

var gorderTotalPrice
var gorderDiscount
var gitemIndex = 0

/////////////////////
var gtextIn =""
var gfinishcancelFlag=0
/////////////////////
var newOrderNo=""
var newSeatNo=""
var newDiscount=""
var newDate
var newTime
var newSumcount




