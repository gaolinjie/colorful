#include <QtNetwork>
#include <QtSql>
#include <QDebug>
#include <QDateTime>

#include "clientsocket.h"

ClientSocket::ClientSocket(QObject *parent)
    : QTcpSocket(parent)
{
    connect(this, SIGNAL(readyRead()), this, SLOT(readClient()));
    connect(this, SIGNAL(disconnected()), this, SLOT(deleteLater()));

    nextBlockSize = 0;
}

void ClientSocket::readClient()
{
    QDataStream in(this);
    in.setVersion(QDataStream::Qt_4_7);

    if (nextBlockSize == 0) {
        if (bytesAvailable() < sizeof(quint16))
            return;
        in >> nextBlockSize;
    }

    if (bytesAvailable() < nextBlockSize)
        return;

    quint8 requestType = 0;

    in >> requestType;
    if (requestType == 'C') {
        readOrder(in);
    }
    else if (requestType == 'D') {

    }

    close();
}

void ClientSocket::readOrder(QDataStream &in)
{
    quint32 orderNO = 0;
    quint16 suborderNO = 0;
    quint16 seatNO = 0;
    QDate date;
    QTime time;
    qreal discount = 0;
    qreal total = 0;

    QString name;
    qreal price;
    quint16 num;

    QSqlQuery query;

    in >> orderNO >> suborderNO >> seatNO;
    qDebug() << QString("%1").arg(orderNO) << QString("%1").arg(seatNO);
    QDateTime *datatime=new QDateTime(QDateTime::currentDateTime());
    date = datatime->date();
    time = datatime->time();

    while(in >> name, name != "FFFF")
    {
        in >> price >> num;
        total += price * num;

        qDebug() << QString("%1").arg(name) << QString("%1").arg(price) << QString("%1").arg(num);

        query.exec("CREATE TABLE IF NOT EXISTS orderItems(orderNO INTEGER key, suborderNO INTEGER, name TEXT, price REAL, num INTEGER)");
        query.prepare("INSERT INTO orderItems(orderNO, suborderNO, name, price, num) VALUES (?, ?, ?, ?, ?)");
        query.addBindValue(orderNO);
        query.addBindValue(suborderNO);
        query.addBindValue(name);
        query.addBindValue(price);
        query.addBindValue(num);
        query.exec();
    }

    query.exec("CREATE TABLE IF NOT EXISTS orderList(orderNO INTEGER key, seatNO INTEGER, date DATE, time TIME, discount REAL, total REAL, pay INTEGER)");
    query.prepare("SELECT * FROM orderList WHERE orderNO = ?");
    query.addBindValue(orderNO);
    query.exec();

    if (query.next())
    {
        qreal preTotal = query.value(5).toReal();
        total += preTotal;

        query.prepare("UPDATE orderList SET total = ? WHERE orderNO = ?");
        query.addBindValue(total);
        query.addBindValue(orderNO);
        query.exec();
    }
    else
    {
        query.prepare("INSERT INTO orderList(orderNO, seatNO, date, time, discount, total, pay) VALUES (?, ?, ?, ?, ?, ?, ?)");
        query.addBindValue(orderNO);
        query.addBindValue(seatNO);
        query.addBindValue(date);
        query.addBindValue(time);
        query.addBindValue(discount);
        query.addBindValue(total);
        query.addBindValue(0);
        query.exec();
    }

    emit dbChanged();
}

void ClientSocket::registerDevice(QDataStream &in)
{

}
