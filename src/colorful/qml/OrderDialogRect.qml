import QtQuick 1.0
import "../js/global.js" as Global
import "../js/calculator.js" as CalcEngine

Item {
    id: orderRect
    width: 410; height: 695

    function doOp(operation) { CalcEngine.doOperation3(operation) }
    property string title: ""
    property int orderNo: 1
    property int seatNo: 2
    property int discountNo: 3
    property int orderRectNo: 1
    signal rectDiaChanged()
    signal textChanged()
    signal tonewMainfinish()
    signal tomodifyMainfinish()
    signal toMaincancel()

    Connections {
        target: keyBoard
        onKeyOksignal: {
            okDialogText()
        }
        onTextUpdatesignal: {
            updateDialogText()
            textChanged()
        }
        onCancelsignal: {
            Global.gtextIn = ""
            textIn1.inText= Global.gtextIn;
            textIn2.inText= Global.gtextIn;
            textIn3.inText= Global.gtextIn;
            Global.dialogTextNo=1;
            textChanged()
            rectDiaChanged()
            toMaincancel()
        }
        onFinishsignal: {
            Global.gtextIn = ""
            textIn1.inText= Global.gtextIn;
            textIn2.inText= Global.gtextIn;
            textIn3.inText= Global.gtextIn;
            Global.dialogTextNo=1;
            textChanged()
            rectDiaChanged()

            finishFun()
            if (orderRectNo==1){tonewMainfinish(); orderManager.saveManualOrder(Global.orderNO);}
            else if (orderRectNo==2)tomodifyMainfinish();
        }
    }
    Connections{
         target: parent
         onMainDiaJumpsignal:{
             if (orderRectNo==1)
             {
                 Global.newOrderNo=orderManager.genManualOrder();
                 textIn1.inText = Global.newOrderNo;
                 textChanged();
             }
             if (orderRectNo==2){ textIn1.inText = Global.orderNO; textChanged(); }

             rectDiaChanged()
         }
    }

    Rectangle {
        id: rect
        width: 410; height: 695
        color: "black"
        smooth: true
        opacity: 0.9
        radius: 10
    }

    Rectangle {
        id: header
        width: parent.width; height: 60
        color: "black"

        gradient: Gradient {
            GradientStop { position: 0.0;
                           color: Qt.rgba(0.5,0.5,0.5,0.5) }
            GradientStop { position: 0.8; color: "black" }
            GradientStop { position: 1.0; color: "black" }
        }

        Text {
            id: headTitle
            text: "title"
            font.pixelSize: 20
            font.bold: true
            anchors.centerIn: parent
            color: "white"
            Component.onCompleted: headTitle.text = title
        }
    }


    OrderDialog {
        id: textIn1
        titleText: "单号："
        inText: ""
        textNo:orderNo
        bordercolor:"red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom; anchors.topMargin: 20
    }
    OrderDialog {
        id: textIn2
        titleText: "座号："
        inText: ""
        textNo:seatNo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textIn1.bottom; anchors.topMargin: 20
    }
    OrderDialog {
        id: textIn3
        titleText: "折扣："
        inText: ""
        textNo:discountNo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textIn2.bottom; anchors.topMargin: 20
    }

    KeyBoard {
        id: keyBoard
        anchors.horizontalCenter: orderRect.horizontalCenter
        anchors.bottom: orderRect.bottom; anchors.bottomMargin: 0
    }

    function updateDialogText() {
        switch(Global.dialogTextNo){
            case(1):
                textIn1.inText= Global.gtextIn;
                break;
            case(2):
                textIn2.inText= Global.gtextIn;
                break;
            case(3):
                textIn3.inText= Global.gtextIn;
                break;
            default:
                break;
        }
    }

    function okDialogText() {
        switch(Global.dialogTextNo){
/*            case(1):
                Global.newOrderNo= Global.gtextIn;
                break;*/
            case(2):
                Global.newSeatNo= Global.gtextIn;
                break;
            case(3):
                Global.newDiscount= Global.gtextIn;
                break;
            default:
                break;
        }
        Global.gtextIn =""
        Global.dialogTextNo++
        if (Global.dialogTextNo == 4 ) Global.dialogTextNo=2;
        rectDiaChanged()
    }

    function finishFun() {
        if (orderRectNo==1){
            if(Global.newOrderNo == ""){Global.newOrderNo= 0}
            if(Global.newSeatNo == ""){Global.newSeatNo= 0}
            if(Global.newDiscount == ""){Global.newDiscount=0}

           ordersave.saveData(Global.newOrderNo,Global.newSeatNo,Global.newDiscount)            
           Global.orderNO = Global.newOrderNo

            Global.newOrderNo= ""
            Global.newSeatNo= ""
            Global.newDiscount= ""
        }
        else {
            if(Global.newSeatNo == ""){Global.newSeatNo= -1}
            if(Global.newDiscount == ""){Global.newDiscount=-1}
            ordersave.changeData(Global.orderNO,Global.newSeatNo,Global.newDiscount)
            Global.newSeatNo= ""
            Global.newDiscount= ""
        }
    }
}
