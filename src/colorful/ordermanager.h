#ifndef ORDERMANAGER_H
#define ORDERMANAGER_H

#include <QObject>

class OrderManager : public QObject
{
    Q_OBJECT
public:
    explicit OrderManager(QObject *parent = 0);

//    Q_INVOKABLE bool haveDataManualOrder();
    Q_INVOKABLE qint32  genManualOrder();
    Q_INVOKABLE void  saveManualOrder(qint32 orderNo);
    
signals:
    void pay(quint32 orderNO);
    
public slots:
    void payOrder(quint32 orderNO);
};

#endif // ORDERMANAGER_H
