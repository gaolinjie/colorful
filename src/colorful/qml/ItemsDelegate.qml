import QtQuick 1.0

Component {
    id: itemDelegate

    Item {
        id: wraper
        width: 355; height: 30

        MouseArea {
            anchors.fill: parent
            onPressed: {
                wraper.ListView.view.currentIndex = index
            }
        }

        Rectangle {
            id: itemRect
            width: 300; height: 30
            radius: 8
            anchors.left: parent.left; anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            color: wraper.ListView.isCurrentItem ? "#f4a83d" : "white"
            smooth: true

            Text {
                id: nameText
                text: name
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 20
                color: "black"
            }

            Text {
                id: priceText
                text: price
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: nameText.right; anchors.leftMargin: 10
                color: "black"
            }

            Text {
                id: numberText
                text: number
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: priceText.right; anchors.leftMargin: 55
                color: "black"
            }

            Text {
                id: subtotalText
                text: price * number
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: numberText.right; anchors.leftMargin: 52
                color: "black"
            }
        }

        Image {
            source: "qrc:/images/minus.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: itemRect.left; anchors.rightMargin: 7
            visible: wraper.ListView.isCurrentItem
        }
    }
}

