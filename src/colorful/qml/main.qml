import QtQuick 1.0
import "../js/global.js" as Global

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
            font.pixelSize: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: logo.right; anchors.leftMargin: 15
            color: "white"
        }

        Text {
            id: timer
            text: "12:30"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: date.left; anchors.rightMargin: 15
            color: "white"
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
        width: 600; height: 400
        anchors.top: header.bottom; anchors.topMargin: 20
        anchors.left: header.left; anchors.leftMargin: 25
        color: "#e3e3e3"
        radius: 10
        smooth: true

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
            text: "单号"
            font.pixelSize: 15
            anchors.top: parent.top; anchors.topMargin: 30
            anchors.left: parent.left; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: seatNO
            text: "座位"
            font.pixelSize: 15
            anchors.top: orderNO.top
            anchors.left: orderNO.right; anchors.leftMargin: 75
            color: "grey"
        }

        Text {
            id: time
            text: "时间"
            font.pixelSize: 15
            anchors.top: seatNO.top
            anchors.left: seatNO.right; anchors.leftMargin: 65
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

        ListView {
            id: ordersList
            anchors.left: parent.left
            anchors.top: orderNO.bottom; anchors.topMargin: 20
            width: 600; height:300
            model: OrdersModel{}
            delegate: orderDelegate
            spacing: 5
            smooth: true
        }

        Component {
            id: orderDelegate

            Item {
                id: wraper
                width: 600; height: 30

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        wraper.ListView.view.currentIndex = index
                        Global.orderNO = orderNO
                        itemsListLoader.source = ''
                        itemsListLoader.source = "qrc:/qml/itemsList.qml"
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
    }

    Rectangle {
        id: detailRect
        width: 355; height: 400
        anchors.left: ordersRect.right; anchors.leftMargin: 20
        anchors.top: ordersRect.top
        color: "#e3e3e3"
        radius: 10
        smooth: true

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
            anchors.left: name.right; anchors.leftMargin: 80
            color: "grey"
        }

        Text {
            id: number
            text: "份数"
            font.pixelSize: 15
            anchors.top: price.top
            anchors.left: price.right; anchors.leftMargin: 40
            color: "grey"
        }

        Text {
            id: amount
            text: "小计"
            font.pixelSize: 15
            anchors.top: number.top
            anchors.left: number.right; anchors.leftMargin: 30
            color: "grey"
        }

        Item {
            Loader {
                id: itemsListLoader
                source: "qrc:/qml/itemsList.qml"
            }
            anchors.left: parent.left
            anchors.top: parent.top; anchors.topMargin: 68
        }
    }

    Rectangle {
        id: dashbord
        width: 355; height: 150
        anchors.left: detailRect.left
        anchors.top: detailRect.bottom; anchors.topMargin: 20
        color: "black"
        radius: 10
        smooth: true

        gradient: Gradient {
            GradientStop { position: 0.0;
                           color: Qt.rgba(0.5,0.5,0.5,0.5) }
            GradientStop { position: 0.7; color: "black" }
            GradientStop { position: 1.0; color: "black" }
        }

        Text {
            id: sumText
            text: "合 计:           120.00"
            anchors.top: parent.top; anchors.topMargin: 15
            anchors.left: parent.left; anchors.leftMargin: 110
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: discText
            text: "折 扣:             38.00"
            anchors.top: sumText.bottom; anchors.topMargin: 5
            anchors.left: sumText.left
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: totalText
            text: "82.00"
            anchors.bottom: parent.bottom; anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 55
            color: "white"
        }
    }

    Button {
        id: cashButton
        width: dashbord.width; height: 40
        anchors.left: dashbord.left
        anchors.top: dashbord.bottom; anchors.topMargin: 10
        color: 'green'
        title: "现金收取"
    }

    Button {
        id: creditButton
        width: dashbord.width; height: 40
        anchors.left: dashbord.left
        anchors.top: cashButton.bottom; anchors.topMargin: 10
        color: 'purple'
        title: "刷卡支付"
    }

    Button {
        id: openCashboxButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: ordersRect.bottom; anchors.topMargin: 20
        title: "打开钱箱"
    }

    Button {
        id: lockSystemButton
        width: 295; height: 40
        anchors.left: openCashboxButton.right; anchors.leftMargin: 10
        anchors.top: openCashboxButton.top
        title: "锁定系统"
    }

    Button {
        id: settingsButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: openCashboxButton.bottom; anchors.topMargin: 10
        title: "系统设置"
    }

    Button {
        id: logoutButton
        width: 295; height: 40
        anchors.left: settingsButton.right; anchors.leftMargin: 10
        anchors.top: settingsButton.top
        title: "注销系统"
    }

    Button {
        id: changeDiscountButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: settingsButton.bottom; anchors.topMargin: 10
        title: "修改折扣"
    }

    Button {
        id: accountingButton
        width: 295; height: 40
        anchors.left: changeDiscountButton.right; anchors.leftMargin: 10
        anchors.top: changeDiscountButton.top
        title: "核算收入"
    }

    Button {
        id: testButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: changeDiscountButton.bottom; anchors.topMargin: 20
        title: "设备测试"
    }

    Button {
        id: printButton
        width: 295; height: 40
        anchors.left: testButton.right; anchors.leftMargin: 10
        anchors.top: testButton.top
        title: "打印收据"
    }

    Button {
        id: analyseButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: testButton.bottom; anchors.topMargin: 10
        title: "销售分析"
    }

    Button {
        id: othersButton
        width: 295; height: 40
        anchors.left: analyseButton.right; anchors.leftMargin: 10
        anchors.top: analyseButton.top
        title: "其他功能"
    }

}
