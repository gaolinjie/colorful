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

private slots:
    void readClient();

private:
    void readOrder(QDataStream &in);
    void registerDevice(QDataStream &in);

private:
    quint16 nextBlockSize;
};

#endif // CLIENTSOCKET_H
