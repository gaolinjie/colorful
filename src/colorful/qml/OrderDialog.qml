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
    property color bordercolor

    Connections {
        target: parent
        onTextChanged: {
            textInNum.text = inText;
        }
        onRectDiaChanged:{
            if (Global.dialogTextNo == textNo) {border.color = "red";
                //textInNum.color = "red"
            }
            else {border.color = "white";
                //textInNum.color = "grey"
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
    Text {
        id: textInNum
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

        }
    }
}
