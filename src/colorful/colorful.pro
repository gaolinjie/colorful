QT += core gui
QT += core gui declarative
QT += network
QT += sql

SOURCES += \
    main.cpp \
    server.cpp \
    clientsocket.cpp \
    ordermanager.cpp \
    client.cpp \
    devicemanager.cpp \
    digitalclock.cpp

OTHER_FILES += \
    qml/login.qml \
    qml/main.qml \
    images/logo.png \
    images/minus.png \
    images/next.png \
    qml/OrdersModel.qml \
    qml/ItemsModel.qml \
    qml/ItemsDelegate.qml \
    images/button-.png \
    images/button-blue.png \
    images/button-green.png \
    images/button-purple.png \
    images/button-red.png \
    images/display.png \
    qml/Button.qml \
    js/global.js \
    qml/itemsList.qml \
    images/background.png \
    qml/Display.qml \
    js/calculator.js \
    qml/start.qml \
    qml/ordersList.qml \
    images/stripes.png \
    qml/Display2.qml \
    qml/Digitalclk.qml

RESOURCES += \
    resource.qrc

HEADERS += \
    server.h \
    clientsocket.h \
    ordermanager.h \
    client.h \
    devicemanager.h \
    digitalclock.h










































