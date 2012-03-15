#ifndef ORDERMANAGER_H
#define ORDERMANAGER_H

#include <QObject>

class OrderManager : public QObject
{
    Q_OBJECT
public:
    explicit OrderManager(QObject *parent = 0);
    
signals:
    void pay(quint32 orderNO);
    
public slots:
    void payOrder(quint32 orderNO);
};

#endif // ORDERMANAGER_H
