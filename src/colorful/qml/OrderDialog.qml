import QtQuick 1.0
import "../js/global.js" as Global

Rectangle {
    id: orderDialog
    width: 340; height: 40
    color: "white"
    radius: 0
    border.width: 3
    border.color:bordercolor
    property string titleText: ""
    property string inText: ""
    property int textNo:1
    property int textNum:0
    property color bordercolor
    signal textNoChange()

    Connections {
        target: parent
        onTextChanged: {
            textInNum.text = inText;
            textInNum.cursorPosition = inText.length;
        }
        onRectDiaChanged:{
            if (Global.dialogTextNo == textNo) {border.color = "red";
                //textInNum.color = "red"
                Global.gtextIn = inText;
                textInNum.cursorPosition = inText.length;
                textInNum.cursorVisible = true;
            }
            else {border.color = "white";
                textInNum.cursorVisible = false;
            }
        }
    }

    Text {
        id: textInTitle
        anchors.left: parent.left; anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        text: titleText
        font.pixelSize: 25
        font.bold: true
        color: "grey"
    }

    TextEdit{
        id: textInNum
        width: 240
        anchors.left: textInTitle.right; anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        text: inText
        font.pixelSize: 25
        font.bold: true
        color: "grey"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
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
            Global.dialogTextNo = textNo;
            textNoChange();
        }
    }
}

