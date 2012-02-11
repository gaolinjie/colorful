import QtQuick 1.0

Component {
    id: orderDelegate

    Item {
        id: wraper
        width: 600; height: 30

        MouseArea {
            anchors.fill: parent
            onPressed: {
                wraper.ListView.view.currentIndex = index
            }
        }

        Rectangle {
            id: orderRect
            width: 520; height: 30
            radius: 8
            anchors.left: parent.left; anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            color: wraper.ListView.isCurrentItem ? "#f4a83d" : "white"
            smooth: true

            Text {
                id: orderNOText
                text: orderNO
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 10
                color: "black"
            }

            Text {
                id: seatNOText
                text: seatNO
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: orderNOText.right; anchors.leftMargin: 40
                color: "black"
            }

            Text {
                id: timeText
                text: time
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: seatNOText.right; anchors.leftMargin: 80
                color: "black"
            }

            Text {
                id: discountText
                text: discount
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: timeText.right; anchors.leftMargin: 30
                color: "black"
            }

            Text {
                id: commentText
                text: comment
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: discountText.right; anchors.leftMargin: 50
                color: "black"
            }

            Text {
                id: totalText
                text: total
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: commentText.right; anchors.leftMargin: 50
                color: "black"
            }
        }

        Image {
            source: "qrc:/images/minus.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: orderRect.left; anchors.rightMargin: 7
            visible: wraper.ListView.isCurrentItem
        }

        Image {
            id: next
            source: "qrc:/images/next.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: orderRect.right; anchors.leftMargin: -10
            visible: wraper.ListView.isCurrentItem
        }
    }
}

