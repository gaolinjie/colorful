import QtQuick 1.0
import "../js/global.js" as Global

BorderImage {
    id: button

    property alias operation: buttonText.text
    property string color: ""
    property int textSize: 1
    property int buttonNo:0

    signal operate
    signal nochanged

    source: "qrc:/images/button-" + color + ".png"; clip: true
    border { left: 10; top: 10; right: 10; bottom: 10 }

    Text {
        id: buttonText
        anchors.centerIn: parent; anchors.verticalCenterOffset: -1
        font.pixelSize: textSize
        style: Text.Sunken; color: "white"; styleColor: "black"; smooth: true
        font.bold: true
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            button.operate()
        }
    }

}
