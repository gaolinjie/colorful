#ifndef ORDERSAVE_H
#define ORDERSAVE_H

#include <QObject>

class OrderSave : public QObject
{
    Q_OBJECT
public:
    explicit OrderSave(QObject *parent = 0);
    Q_INVOKABLE void saveData(qint32 orderNo,qint32 seatNo,float discount);
    Q_INVOKABLE void changeData(qint32 orderNo,qint32 seatNo,float discount);

public:
    QString mac;

signals:

public slots:

};

#endif // ORDERSAVE_H
