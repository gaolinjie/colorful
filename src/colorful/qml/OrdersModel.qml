import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: orderModel
    Component.onCompleted: {
        Global.orderNO = orderNO
    }

    ListElement {
        orderNO: "120212001"
        seatNO: "18"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥100"
    }

    ListElement {
        orderNO: "120212002"
        seatNO: "16"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥200"
    }

    ListElement {
        orderNO: "120212003"
        seatNO: "23"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥110"
    }

    ListElement {
        orderNO: "120212004"
        seatNO: "22"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥140"
    }

    ListElement {
        orderNO: "120212005"
        seatNO: "11"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥170"
    }

    ListElement {
        orderNO: "120212006"
        seatNO: "16"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥120"
    }

    ListElement {
        orderNO: "120212007"
        seatNO: "17"
        time: "2012-02-12"
        discount: "80%"
        comment: "n/a"
        total: "￥180"
    }
}
