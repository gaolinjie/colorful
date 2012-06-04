#include "server.h"
#include "clientsocket.h"
#include <QtSql>

Server::Server(QObject *parent)
    : QTcpServer(parent)
{
    udpSocket.bind(6178);
    connect(&udpSocket, SIGNAL(readyRead()), this, SLOT(processPendingDatagrams()));
}

void Server::incomingConnection(int socketId)
{
    ClientSocket *socket = new ClientSocket(this);
    socket->setSocketDescriptor(socketId);
    connect(socket, SIGNAL(dbChanged()), this, SLOT(sendRefreshUiSignal()));
    //connect(socket, SIGNAL(registering(quint32)), this, SLOT(sendRegisteredSignal(quint32)));

}

void Server::sendRefreshUiSignal()
{
    emit refreshUi();
}
/*
void Server::sendRegisteredSignal(quint32 deviceNO)
{
    emit registered(deviceNO);
}*/

void Server::processPendingDatagrams()
{    
    QByteArray datagram;
    QDataStream in(&datagram, QIODevice::ReadOnly);
    in.setVersion(QDataStream::Qt_4_7);

    do {
        datagram.resize(udpSocket.pendingDatagramSize());
        udpSocket.readDatagram(datagram.data(), datagram.size());
    } while (udpSocket.hasPendingDatagrams());

    quint16 size;
    quint8 type;   
    in >> size >> type;
    if (type == 'R')
    {
        qDebug() << "register";
        readRegistration(in);
    }
}

void Server::readRegistration(QDataStream &in)
{
    quint32 deviceNO = 100;
    QString mac;
    QString ip;
    in >> mac >> ip;
    qDebug() << mac << ip;

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS devices(mac TEXT key, ip TEXT, deviceNO INTEGER)");
    query.prepare("SELECT * FROM devices WHERE mac = ?");
    query.addBindValue(mac);
    query.exec();

    if (query.next())
    {
        deviceNO = query.value(2).toUInt();
        query.prepare("UPDATE devices SET ip = ? WHERE mac = ?");
        query.addBindValue(ip);
        query.addBindValue(mac);
        query.exec();
    }
    else
    {
        query.exec("select max(deviceNO) from devices");
        if (query.next())
        {
            deviceNO = query.value(0).toUInt();
        }
        deviceNO++;

        query.prepare("INSERT INTO devices(mac, ip, deviceNO) VALUES (?, ?, ?)");
        query.addBindValue(mac);
        query.addBindValue(ip);
        query.addBindValue(deviceNO);
        query.exec();
    }

    emit registered(deviceNO);
}
