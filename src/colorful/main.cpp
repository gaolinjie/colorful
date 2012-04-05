#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeContext>
#include <iostream>
#include <QtSql>
#include <QDebug>
#include <QDate>
#include <QtNetwork>

#include "server.h"
#include "client.h"
#include "ordermanager.h"

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QTextCodec::setCodecForTr(QTextCodec::codecForLocale());

    QString privatePathQt(QApplication::applicationDirPath());
    QString path(privatePathQt);
    path = QDir::toNativeSeparators(path);

    Server server;
    if (!server.listen(QHostAddress::Any, 6178)) {
        std::cerr << "Failed to bind to port" << std::endl;
        return 1;
    }

    OrderManager orderManager;
    QDeclarativeView view;
    view.engine()->setOfflineStoragePath(path);
    view.rootContext()->setContextProperty("server", &server);
    view.rootContext()->setContextProperty("orderManager", &orderManager);
    view.setSource(QUrl("qrc:/qml/start.qml"));
    view.show();

    QString md5;
    QString dbname="DemoDB";
    QByteArray ba;
    ba = QCryptographicHash::hash (dbname.toAscii(), QCryptographicHash::Md5);
    md5.append(ba.toHex());
    md5.append(".sqlite");

    path.append(QDir::separator()).append("Databases");
    path.append(QDir::separator()).append(md5);
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(path);
    if (!db.open()) {
        std::cerr << "Cannot open database" << std::endl;
        return 1;
    }

    Client client;
    QObject::connect(&orderManager, SIGNAL(pay(quint32)), &client, SLOT(sendPaiedOrder(quint32)));
    QObject::connect(&server, SIGNAL(registered(quint32)), &client, SLOT(sendDeviceNO(quint32)));

    return a.exec();
}
