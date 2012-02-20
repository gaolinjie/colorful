import QtQuick 1.0
import "../js/global.js" as Global

ListView {
    id: ordersList
    width: 600; height:300
    model: OrdersModel{}
    delegate: orderDelegate
    smooth: true
}
