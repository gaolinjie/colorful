#include "client.h"
#include <QtNetwork>
#include <QtSql>

Client::Client(QObject *parent) :
    QObject(parent)
{
    connect(&tcpSocket, SIGNAL(connected()), this, SLOT(sendData()));
    connect(&tcpSocket, SIGNAL(disconnected()),
            this, SLOT(connectionClosedByServer()));
    connect(&tcpSocket, SIGNAL(readyRead()),
            this, SLOT(getData()));
    connect(&tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(error()));
}

Client::~Client()
{
    delete block;
    block = 0;
}

void Client::sendPaiedOrder(quint32 orderNO)
{
    block = new QByteArray();
    QDataStream out(block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_7);

    QSqlQuery query;
    query.prepare("SELECT * FROM orderList WHERE orderNO = ?");
    query.addBindValue(orderNO);
    query.exec();

    QString mac;
    if (query.next())
    {
        mac = query.value(2).toString();
    }

    query.prepare("SELECT * FROM devices WHERE mac = ?");
    query.addBindValue(mac);
    query.exec();

    QString ip;
    if (query.next())
    {
        ip = query.value(1).toString();
    }

    out << quint16(0) << quint8('S') << orderNO << 0xFFFF;

    out.device()->seek(0);
    out << quint16(block->size() - sizeof(quint16));

    connectToServer(ip);
}

void Client::sendDeviceNO(quint32 deviceNO)
{
    block = new QByteArray();
    QDataStream out(block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_7);

    // get device ip
    QSqlQuery query;
    query.prepare("SELECT * FROM devices WHERE deviceNO = ?");
    query.addBindValue(deviceNO);
    query.exec();

    QString deviceIP;
    if (query.next())
    {
        deviceIP = query.value(1).toString();
    }

    // get host ip
    QNetworkInterface *qni;
    qni = new QNetworkInterface();
    *qni = qni->interfaceFromName(QString("%1").arg("wlan0"));
    QString hostIP;
    hostIP = qni->addressEntries().at(0).ip().toString();

    out << quint16(0) << quint8('R') << deviceNO << hostIP << 0xFFFF;

    out.device()->seek(0);
    out << quint16(block->size() - sizeof(quint16));

    connectToServer(deviceIP);
}

void Client::connectToServer(const QString &ip)
{
    tcpSocket.connectToHost(ip, 6177);
    nextBlockSize = 0;
}

void Client::sendData()
{
    tcpSocket.write(*block);

    delete block;
    block = 0;
}

void Client::getData()
{

}


void Client::connectionClosedByServer()
{
    if (nextBlockSize != 0xFFFF)
        ;
    closeConnection();
}

void Client::error()
{
    closeConnection();
}

void Client::closeConnection()
{
    tcpSocket.close();
}
