import QtQuick 1.0

BorderImage {
    id: image

    property alias text : displayText.text

    source: "qrc:/images/display.png"
    border { left: 10; top: 10; right: 10; bottom: 10 }

    Text {
        id: displayText
        anchors {
            right: parent.right; verticalCenter: parent.verticalCenter; verticalCenterOffset: 5
            rightMargin: 6
        }
        font.pixelSize: parent.height * .8; horizontalAlignment: Text.AlignRight; elide: Text.ElideRight
        color: "#343434"; smooth: true; font.bold: true
        text: ""
    }
}
