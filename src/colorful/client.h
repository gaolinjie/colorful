#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = 0);
    ~Client();
    
public slots:
    void sendPaiedOrder(quint32 orderNO);
    void sendDeviceNO(quint32 deviceNO);

private slots:
    void sendData();
    void getData();
    void connectionClosedByServer();
    void error();

private:
    void connectToServer(const QString &ip);
    void closeConnection();

    QTcpSocket tcpSocket;
    quint16 nextBlockSize;
    QByteArray *block;
};

#endif // CLIENT_H
