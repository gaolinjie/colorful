#include "ordermanager.h"
#include <QDebug>
#include <QtSql>

OrderManager::OrderManager(QObject *parent) :
    QObject(parent)
{
}

void OrderManager::payOrder(quint32 orderNO)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS orderList(orderNO INTEGER key, seatNO INTEGER, mac TEXT, date DATE, time TIME, discount REAL, total REAL, pay INTEGER)");
    query.prepare("UPDATE orderList SET pay = ? WHERE orderNO = ?");
    query.addBindValue(1);
    query.addBindValue(orderNO);
    query.exec();

    emit pay(orderNO);
}

/*bool  OrderManager::haveDataManualOrder()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS manuaOrder(orderNO INTEGER key)");
    query.exec("select * from student");
    while ( query.next() ){return true;}
    return false;
}*/
qint32  OrderManager::genManualOrder()
{
    qint32 orderNo;
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS manuaOrder(orderNO INTEGER key)");
    query.exec("select * from manuaOrder");
    while ( query.next() )
    {
        orderNo = query.value(0).toInt();
        orderNo++;
        return orderNo;
    }
    orderNo = 900000000;
    return orderNo;
}

void OrderManager::saveManualOrder(qint32 orderNo)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS manuaOrder(orderNO INTEGER key)");
    query.exec("select * from manuaOrder");
    if ( query.next() )
    {
        query.prepare("UPDATE manuaOrder SET orderNO = ? ");
        query.addBindValue(orderNo);
        query.exec();
    }
    else
    {
        query.prepare("insert into manuaOrder (orderNO) values(?)");
        query.addBindValue(orderNo);
        query.exec();
     }
}
