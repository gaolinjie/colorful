// Begin Issue #5, lijunliang, 2012-04-05 //
import QtQuick 1.0

 Item {
        id: digitalclk
  //    width: 230; height: 30
  //    anchors.verticalCenter: parent.verticalCenter
  //    anchors.right: parent.right; anchors.leftMargin: 15
        Component.onCompleted: initializeTime()
        function initializeTime()
        {
            systemYear.text=systemClock.getYear();
            systemMonth.text = systemClock.getMonth();
            systemDate.text = systemClock.getDate();
            systemWeekday.text = systemClock.getWeek();
            systemTime.text = systemClock.getTime();
        }

        Text {
            id: systemTime
            text: ""
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left; anchors.leftMargin: 30
            color: "white"
        }
        Text {
            id: systemYear
            text: ""
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: systemTime.right; anchors.leftMargin: 15
            color: "white"
        }
        Text {
            id:nian
            text: "年"
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: systemYear.right; anchors.leftMargin: 3
            color: "white"
        }
        Text {
            id: systemMonth
            text:""
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: nian.right; anchors.leftMargin: 3
            color: "white"
        }
        Text {
            id:yue
            text: "月"
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: systemMonth.right; anchors.leftMargin: 3
            color: "white"
        }
        Text {
            id: systemDate
            text:""
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: yue.right; anchors.leftMargin: 3
            color: "white"
        }
        Text {
            id:ri
            text: "日"
            font.pixelSize: 12
            anchors.top: parent.top; anchors.topMargin: 1
            anchors.left: systemDate.right; anchors.leftMargin: 3
            color: "white"
        }
        Text {
            id:xingqi
            text: "星期"
            font.pixelSize: 12
            anchors.top: systemYear.top; anchors.topMargin: 15
            anchors.left: systemTime.right; anchors.leftMargin: 15
            color: "white"
        }
        Text {
            id:systemWeekday
            text: ""
            font.pixelSize: 12
            anchors.top: systemYear.top; anchors.topMargin: 15
            anchors.left: xingqi.right; anchors.leftMargin: 3
            color: "white"
        }
        Timer {
            interval: 10000
            running: true
            repeat: true
            onTriggered: {
               systemYear.text=systemClock.getYear();
               systemMonth.text = systemClock.getMonth();
               systemDate.text = systemClock.getDate();
               systemWeekday.text = systemClock.getWeek();
               systemTime.text = systemClock.getTime();
            }
        }
 }
// End Issue #5 //






