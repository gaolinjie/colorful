import QtQuick 1.0

Item {
    ListView {
        id: itemsList
        width: 355; height:350
        model: ItemsModel{}
        delegate: ItemsDelegate{}
        spacing: 5
        smooth: true
    }
}
