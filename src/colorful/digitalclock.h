// Begin Issue #5, lijunliang, 2012-04-05 //
#ifndef DIGITALCLOCK_H
#define DIGITALCLOCK_H

#include <QObject>
#include <qdatetime.h>
#include <qtimer.h>

class DigitalClock : public QObject
{
    Q_OBJECT
public:
    explicit DigitalClock(QObject *parent = 0);
    Q_INVOKABLE QString getYear();
    Q_INVOKABLE QString getMonth();
    Q_INVOKABLE QString getDate();
    Q_INVOKABLE QString getTime();
    Q_INVOKABLE QString getWeek();


public:
    QTimer *timer;
    QDateTime datatime;
    QString year;
    QString month;
    QString date;
    QString weekday;
    QString time;

signals:


public slots:
    void timerUpDate();



};

#endif // DIGITALCLOCK_H
// End Issue #5 //
