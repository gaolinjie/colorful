import QtQuick 1.0

Item {
    id: screen
    width: 1024; height: 768

    Loader {
        id: mainLoader
        source: "qrc:/qml/main.qml"
    }

    Connections{
        target: mainLoader.item
        onLoadMain: {mainLoader.source = "qrc:/qml/main.qml"}
        onLoadLogin: {mainLoader.source = "qrc:/qml/login.qml"}
    }
}
