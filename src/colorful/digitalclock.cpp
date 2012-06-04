// Begin Issue #5, lijunliang, 2012-04-05 //
#include "digitalclock.h"

DigitalClock::DigitalClock(QObject *parent) :
    QObject(parent)
{
    timer = new QTimer(this);
    timerUpDate();
    connect(timer,SIGNAL(timeout()),this,SLOT(timerUpDate()));
}

void DigitalClock::timerUpDate()
{
    datatime = QDateTime::currentDateTime();

    int y=datatime.date().year();
    int m=datatime.date().month();
    int d=datatime.date().day();
    QDate wdate(y,m,d);
    int temp=wdate.dayOfWeek();
    switch(temp)
    {
        case(1):
        weekday = tr("一");
            break;
        case(2):
        weekday = tr("二");
            break;
        case(3):
        weekday = tr("三");
            break;
        case(4):
        weekday = tr("四");
            break;
        case(5):
        weekday = tr("五");
            break;
        case(6):
        weekday = tr("六");
            break;
        case(7):
        weekday = tr("日");
            break;
        default:
            break;
    }
    year = QString::number(y);
    month= QString::number(m);
    date = QString::number(d);
    time = datatime.toString("hh:mm");
    timer->start(5000);
}

QString DigitalClock::getYear()
{    
    return year;
}
QString DigitalClock::getMonth()
{
    return month;
}
QString DigitalClock::getDate()
{
    return date;
}
QString DigitalClock::getWeek()
{
    return weekday;
}
QString DigitalClock::getTime()
{
    return time;
}
// End Issue #5 //





