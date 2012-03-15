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
    query.exec("CREATE TABLE IF NOT EXISTS orderList(orderNO INTEGER key, seatNO INTEGER, date DATE, time TIME, discount REAL, total REAL, pay INTEGER)");
    query.prepare("UPDATE orderList SET pay = ? WHERE orderNO = ?");
    query.addBindValue(1);
    query.addBindValue(orderNO);
    query.exec();

    emit pay(orderNO);
}
