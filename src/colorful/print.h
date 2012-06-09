#ifndef PRINT_H
#define PRINT_H
#include <qstringlist.h>
#include <qstring.h>

class Print:public QObject {
    Q_OBJECT

public:
    explicit Print(QObject *parent = 0);
    //methods
   Q_INVOKABLE void printMenutoPdf(QStringList);

   Q_INVOKABLE void printMenutoKitchen(quint32);
   Q_INVOKABLE void printMenutoForeground(quint32, QString, QString, QString);

   QString printerList();

};
#endif // PRINT_H
