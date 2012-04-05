#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QUdpSocket>

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server(QObject *parent = 0);

signals:
    void refreshUi();
    void registered(quint32 deviceNO);

public slots:
    void sendRefreshUiSignal();
    //void sendRegisteredSignal(quint32 deviceNO);
    void processPendingDatagrams();

private:
    void incomingConnection(int socketId);
    void readRegistration(QDataStream &in);

    QUdpSocket udpSocket;
};

#endif // SERVER_H
