import QtQuick 1.0

Rectangle {
    id: background
    width: 1024; height: 768
    color: "#424741"

    Rectangle {
        id: header
        width: 1024; height: 60
        anchors.left: parent.left
        anchors.top: parent.top
        color: "black"

        Image {
            id: logo
            source: "qrc:/images/logo.png"
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left; anchors.leftMargin: 20
        }

        Text {
            id: title
            text: "Colorful POS"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: logo.right; anchors.leftMargin: 15
            color: "white"
        }

        Text {
            id: timer
            text: "01:30"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: date.left; anchors.rightMargin: 15
            color: "white"
            //font.family:
        }

        Text {
            id: date
            text: "2012年2月11日\n星期六"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right; anchors.rightMargin: 15
            color: "white"
        }
    }

    Rectangle {
        id: ordersRect
        width: 600; height: 450
        anchors.top: header.bottom; anchors.topMargin: 20
        anchors.left: header.left; anchors.leftMargin: 25
        color: "#e3e3e3"
        radius: 10

        Rectangle {
            id: ordersRectLabel
            width: 100; height: 30
            anchors.left: parent.left; anchors.leftMargin: -10
            anchors.top: parent.top; anchors.topMargin: -10
            color: "#78b117"

            Text {
                text: "未结订单"
                font.pixelSize: 18
                anchors.centerIn: parent
                color: "white"
            }
        }

        Rectangle {
            id: finishRectLabel
            width: 100; height: 30
            anchors.left: ordersRectLabel.right; anchors.leftMargin: -10
            anchors.top: parent.top; anchors.topMargin: -10
            color: "grey"

            Text {
                text: "已结订单"
                font.pixelSize: 18
                anchors.centerIn: parent
                color: "white"
            }
        }

        Text {
            id: orderNO
            text: "订单号"
            font.pixelSize: 15
            anchors.top: parent.top; anchors.topMargin: 30
            anchors.left: parent.left; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: seatNO
            text: "座位号"
            font.pixelSize: 15
            anchors.top: orderNO.top
            anchors.left: orderNO.right; anchors.leftMargin: 60
            color: "grey"
        }

        Text {
            id: time
            text: "时间"
            font.pixelSize: 15
            anchors.top: seatNO.top
            anchors.left: seatNO.right; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: discount
            text: "折扣"
            font.pixelSize: 15
            anchors.top: time.top
            anchors.left: time.right; anchors.leftMargin: 70
            color: "grey"
        }

        Text {
            id: comment
            text: "备注"
            font.pixelSize: 15
            anchors.top: discount.top
            anchors.left: discount.right; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: total
            text: "总计"
            font.pixelSize: 15
            anchors.top: comment.top
            anchors.left: comment.right; anchors.leftMargin: 50
            color: "grey"
        }

        Image {
            source: "qrc:/images/minus.png"
            anchors.verticalCenter: item1.verticalCenter
            anchors.right: item1.left; anchors.rightMargin: 5
        }

        Rectangle {
            id: item1
            width: 515; height: 30
            anchors.top: orderNO.bottom; anchors.topMargin: 20
            anchors.left: parent.left; anchors.leftMargin: 43
            radius: 8
        }

        Image {
            id: next
            source: "qrc:/images/next.png"
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: item1.right; anchors.leftMargin: -5
        }

        Text {
            text: "01748293"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: orderNO.left;// anchors.leftMargin: 50
            color: "black"
        }

        Text {
            text: "18"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: seatNO.left;// anchors.leftMargin: 50
            color: "black"
        }

        Text {
            text: "2012-02-10"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: time.left;// anchors.leftMargin: 50
            color: "black"
        }

        Text {
            text: "80%"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: discount.left;// anchors.leftMargin: 50
            color: "black"
        }

        Text {
            text: "n/a"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: comment.left;// anchors.leftMargin: 50
            color: "black"
        }

        Text {
            text: "￥100"
            font.pixelSize: 15
            anchors.verticalCenter: item1.verticalCenter
            anchors.left: total.left;// anchors.leftMargin: 50
            color: "black"
        }
    }

    Rectangle {
        id: detailRect
        width: 355; height: 450
        anchors.left: ordersRect.right; anchors.leftMargin: 20
        anchors.top: ordersRect.top
        color: "#e3e3e3"
        radius: 10

        Rectangle {
            id: detailRectLabel
            width: 100; height: 30
            anchors.left: parent.left; anchors.leftMargin: -10
            anchors.top: parent.top; anchors.topMargin: -10
            color: "#78b117"

            Text {
                text: "订单详情"
                font.pixelSize: 18
                anchors.centerIn: parent
                color: "white"
            }
        }

        Text {
            id: name
            text: "菜名"
            font.pixelSize: 15
            anchors.top: parent.top; anchors.topMargin: 30
            anchors.left: parent.left; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: price
            text: "单价"
            font.pixelSize: 15
            anchors.top: name.top
            anchors.left: name.right; anchors.leftMargin: 60
            color: "grey"
        }

        Text {
            id: number
            text: "份数"
            font.pixelSize: 15
            anchors.top: price.top
            anchors.left: price.right; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: amount
            text: "小计"
            font.pixelSize: 15
            anchors.top: number.top
            anchors.left: number.right; anchors.leftMargin: 40
            color: "grey"
        }
    }
}
