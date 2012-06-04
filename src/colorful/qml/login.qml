import QtQuick 1.0
import "../js/calculator.js" as CalcEngine

Image {
    sourceSize.width: 1024
    sourceSize.height: 768
    source: "qrc:/images/background.png"

    signal loadMain()
    function doOp(operation) { CalcEngine.doOperation(operation) }

    Rectangle {
        id: window
        anchors.centerIn: parent
        width: 260; height: 365
        color: "#282828"
        radius: 5
        opacity: 0.8
/*
        Text {
            id: promopt
            text: "请输入密码"
            font.pixelSize: 20
            //font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top; anchors.topMargin: 15
        }*/

        Display {
            id: display
            width: box.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top; anchors.topMargin: 20
        }

        Column {
            id: box; spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: display.bottom; anchors.topMargin: 15

            Column {
                id: column; spacing: 10

                Grid {
                    id: grid; rows: 4; columns: 3; spacing: 8

                    Button { width: 70; height: 60; operation: "7"; textSize: 20}
                    Button { width: 70; height: 60; operation: "8"; textSize: 20}
                    Button { width: 70; height: 60; operation: "9"; textSize: 20}
                    Button { width: 70; height: 60; operation: "4"; textSize: 20}
                    Button { width: 70; height: 60; operation: "5"; textSize: 20}
                    Button { width: 70; height: 60; operation: "6"; textSize: 20}
                    Button { width: 70; height: 60; operation: "1"; textSize: 20}
                    Button { width: 70; height: 60; operation: "2"; textSize: 20}
                    Button { width: 70; height: 60; operation: "3"; textSize: 20}
                    Button { width: 70; height: 60; operation: "\u2190"; color: "red"; textSize: 20}
                    Button { width: 70; height: 60; operation: "0"; textSize: 20}
                    Button { width: 70; height: 60; operation: "OK"; color: "green"; textSize: 20
                        onOperate: {
                            if (CalcEngine.trueText == "8") {
                                loadMain()
                            }
                        }
                    }
                }
            }
        }
    }
}
