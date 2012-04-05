#ifndef CLIENTSOCKET_H
#define CLIENTSOCKET_H

#include <QTcpSocket>

class ClientSocket : public QTcpSocket
{
    Q_OBJECT

public:
    ClientSocket(QObject *parent = 0);

signals:
    void dbChanged();
    //void registering(quint32 deviceNO);

private slots:
    void readClient();

private:
    void readOrder(QDataStream &in);
    //void readRegistration(QDataStream &in);

private:
    quint16 nextBlockSize;
};

#endif // CLIENTSOCKET_H
