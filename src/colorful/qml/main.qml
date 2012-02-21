import QtQuick 1.0
import "../js/global.js" as Global
import "../js/calculator.js" as CalcEngine

Image {
    sourceSize.width: 1024
    sourceSize.height: 768
    source: "qrc:/images/background.png"

    Component.onCompleted: {
        itemsListLoader.source = ''
        itemsListLoader.source = "qrc:/qml/itemsList.qml"
    }

    signal loadLogin()
    function doOp(operation) { CalcEngine.doOperation(operation) }

    Rectangle {
        id: header
        width: 1024; height: 60
        anchors.left: parent.left
        anchors.top: parent.top
        color: "black"
        //opacity: 0.8

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
            anchors.right: datea.left; anchors.rightMargin: 15
            color: "white"
        }

        Text {
            id: datea
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
        //opacity: 0.8

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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ordersRectLabel.color = "#78b117"
                    finishRectLabel.color = "grey"
                    Global.pay = "0"
                    ordersListLoader.source = ""
                    ordersListLoader.source = "qrc:/qml/ordersList.qml"
                    itemsListLoader.source = ''
                    itemsListLoader.source = "qrc:/qml/itemsList.qml"
                }
            }
        }

        Rectangle {
            id: finishRectLabel
            width: 100; height: 30
            anchors.left: ordersRectLabel.right
            anchors.top: parent.top; anchors.topMargin: -10
            color: "grey"

            Text {
                id: finishRectLabelText
                text: "已结订单"
                font.pixelSize: 18
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    finishRectLabel.color = "#78b117"
                    ordersRectLabel.color = "grey"
                    Global.pay = "1"
                    ordersListLoader.source = ""
                    ordersListLoader.source = "qrc:/qml/ordersList.qml"
                    itemsListLoader.source = ''
                    itemsListLoader.source = "qrc:/qml/itemsList.qml"
                }
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
            id: date
            text: "日期"
            font.pixelSize: 15
            anchors.top: seatNO.top
            anchors.left: seatNO.right; anchors.leftMargin: 50
            color: "grey"
        }

        Text {
            id: time
            text: "时间"
            font.pixelSize: 15
            anchors.top: date.top
            anchors.left: date.right; anchors.leftMargin: 65
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
            id: total
            text: "总计"
            font.pixelSize: 15
            anchors.top: discount.top
            anchors.left: discount.right; anchors.leftMargin: 55
            color: "grey"
        }

        Item {
            Loader {
                id: ordersListLoader
                source: "qrc:/qml/ordersList.qml"
            }
            anchors.left: parent.left
            anchors.top: parent.top; anchors.topMargin: 68
        }

        Component {
            id: orderDelegate


            Item {
                id: wraper
                width: 600; height: 30
                Component.onCompleted: {
                    sumText.text = wraper.ListView.view.model.get(0).total
                    discText.text = wraper.ListView.view.model.get(0).discount
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        wraper.ListView.view.currentIndex = index
                        Global.orderNO = orderNO
                        itemsListLoader.source = ''
                        itemsListLoader.source = "qrc:/qml/itemsList.qml"
                        sumText.text = total
                        discText.text = discount
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
                    border.color: "grey"
                    border.width: 1

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
                        anchors.left: parent.left; anchors.leftMargin: 120
                        color: "black"
                    }

                    Text {
                        id: dateText
                        text: date
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 180
                        color: "black"
                    }

                    Text {
                        id: timeText
                        text: time
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 290
                        color: "black"
                    }

                    Text {
                        id: discountText
                        text: discount
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 393
                        color: "black"
                    }


                    Text {
                        id: totalText
                        text: total
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 480
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
        //opacity: 0.8

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
            id: sumTitle
            text: "合 计:"
            anchors.top: parent.top; anchors.topMargin: 15
            anchors.left: parent.left; anchors.leftMargin: 110
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: sumText
            text: Global.orderNO
            anchors.top: sumTitle.top
            anchors.right: parent.right; anchors.rightMargin: 110
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: discTitle
            text: "折 扣:"
            anchors.top: sumTitle.bottom; anchors.topMargin: 5
            anchors.left: sumTitle.left
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: discText
            text: ""
            anchors.top: sumText.bottom; anchors.topMargin: 5
            anchors.right: sumText.right
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: totalText
            text: sumText.text - discText.text
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
        operation: "现金收取"
        textSize: 16

        onOperate: {
            foreground.visible = true
            cashDialog.y = 0
        }
    }

    Button {
        id: creditButton
        width: dashbord.width; height: 40
        anchors.left: dashbord.left
        anchors.top: cashButton.bottom; anchors.topMargin: 10
        color: 'purple'
        operation: "刷卡支付"
        textSize: 16

        onOperate: {
            foreground.visible = true
            cardDialog.y = 0
        }
    }

    Button {
        id: openCashboxButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: ordersRect.bottom; anchors.topMargin: 20
        operation: "打开钱箱"
        textSize: 16
    }

    Button {
        id: lockSystemButton
        width: 295; height: 40
        anchors.left: openCashboxButton.right; anchors.leftMargin: 10
        anchors.top: openCashboxButton.top
        operation: "锁定系统"
        textSize: 16

        onOperate: {
            loadLogin()
        }
    }

    Button {
        id: settingsButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: openCashboxButton.bottom; anchors.topMargin: 10
        operation: "系统设置"
        textSize: 16
    }

    Button {
        id: logoutButton
        width: 295; height: 40
        anchors.left: settingsButton.right; anchors.leftMargin: 10
        anchors.top: settingsButton.top
        operation: "注销系统"
        textSize: 16
    }

    Button {
        id: changeDiscountButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: settingsButton.bottom; anchors.topMargin: 10
        operation: "修改折扣"
        textSize: 16
    }

    Button {
        id: accountingButton
        width: 295; height: 40
        anchors.left: changeDiscountButton.right; anchors.leftMargin: 10
        anchors.top: changeDiscountButton.top
        operation: "核算收入"
        textSize: 16
    }

    Button {
        id: testButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: changeDiscountButton.bottom; anchors.topMargin: 20
        operation: "设备测试"
        textSize: 16
    }

    Button {
        id: printButton
        width: 295; height: 40
        anchors.left: testButton.right; anchors.leftMargin: 10
        anchors.top: testButton.top
        operation: "打印收据"
        textSize: 16
    }

    Button {
        id: analyseButton
        width: 295; height: 40
        anchors.left: ordersRect.left
        anchors.top: testButton.bottom; anchors.topMargin: 10
        operation: "销售分析"
        textSize: 16
    }

    Button {
        id: othersButton
        width: 295; height: 40
        anchors.left: analyseButton.right; anchors.leftMargin: 10
        anchors.top: analyseButton.top
        operation: "其他功能"
        textSize: 16
    }

    Rectangle {
        id: foreground
        width: parent.width; height: parent.height
        color: "black"
        opacity: 0.6
        visible: false
    }

    Item {
        id: cashDialog
        width: 600; height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        y: 768

        Behavior on y {
            NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
        }

        Rectangle {
            id: cashDialogRect
            width: 600; height: 400
            color: "black"
            smooth: true
            opacity: 0.8
            radius: 10
        }

        Rectangle {
            id: cashDialogHeader
            width: parent.width; height: 60
            color: "black"

            gradient: Gradient {
                GradientStop { position: 0.0;
                               color: Qt.rgba(0.5,0.5,0.5,0.5) }
                GradientStop { position: 0.5; color: "black" }
                GradientStop { position: 1.0; color: "black" }
            }

            Text {
                id: cashDialogTitle
                text: "现金收取"
                font.pixelSize: 20
                font.bold: true
                anchors.centerIn: parent
                color: "white"
            }
        }

        Text {
            id: totalDueTitle
            text: "应收金额"
            font.pixelSize: 16
            font.bold: true
            color: "grey"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cashDialogHeader.bottom; anchors.topMargin: 20
        }

        Text {
            id: totalDue
            text: "6.44"
            font.pixelSize: 56
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cashDialogHeader.bottom; anchors.topMargin: 40
        }

        Text {
            id: tenderedTitle
            text: "实收金额"
            font.pixelSize: 16
            font.bold: true
            color: "grey"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cashDialogHeader.bottom; anchors.topMargin: 130
        }

        Text {
            id: tendered
            text: "10.01"
            font.pixelSize: 66
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cashDialogHeader.bottom; anchors.topMargin: 150
        }

        Button {
            id: cancelButton
            width: 260; height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cashDialogHeader.bottom; anchors.topMargin: 250
            operation: "取 消"
            textSize: 18

            onOperate: {
                cashDialog.y = 768
                foreground.visible = false
            }
        }
    }

    Item {
        id: cardDialog
        width: 600; height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        y: 768

        Behavior on y {
            NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
        }

        Rectangle {
            id: cardDialogRect
            width: 600; height: 400
            color: "black"
            smooth: true
            opacity: 0.8
            radius: 10
        }

        Rectangle {
            id: cardDialogHeader
            width: parent.width; height: 60
            color: "black"

            gradient: Gradient {
                GradientStop { position: 0.0;
                               color: Qt.rgba(0.5,0.5,0.5,0.5) }
                GradientStop { position: 0.5; color: "black" }
                GradientStop { position: 1.0; color: "black" }
            }

            Text {
                id: cardDialogTitle
                text: "刷卡支付"
                font.pixelSize: 20
                font.bold: true
                anchors.centerIn: parent
                color: "white"
            }
        }

        Text {
            id: totalDue2Title
            text: "应收金额"
            font.pixelSize: 16
            font.bold: true
            color: "grey"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cardDialogHeader.bottom; anchors.topMargin: 20
        }

        Text {
            id: total2Due
            text: "6.44"
            font.pixelSize: 56
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cardDialogHeader.bottom; anchors.topMargin: 40
        }

        Button {
            id: printReceiptButton
            width: 260; height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cardDialogHeader.bottom; anchors.topMargin: 250
            operation: "打印收据"
            textSize: 18
            color: "green"

            onOperate: {
                cardDialog.y = 768
                foreground.visible = false
            }
        }
    }
}
