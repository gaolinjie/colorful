#include <string.h>
#include <qstringlist.h>
#include <qstring.h>
#include <qdesktopservices.h>
#include <qfiledialog.h>
#include <qtextdocument.h>
#include <qtextcodec.h>
#include <QPrintDialog>
#include <QPrinterInfo>
#include <QDebug>
#include <QtGui>
#include <QDateTime>
#include <QtCore>
#include <QtSql>

#include "print.h"

Print::Print(QObject *parent) :
    QObject(parent)
{

}
    void Print::printMenutoPdf(QStringList menu) {
        QStringList m_menu = menu;
        QString m_title = QObject::tr(" &nbsp;淘米南京新街口店");
        QString m_time = QDateTime::currentDateTime().toString("yy-MM-dd hh:mm:ss");
        QString m_opeartor = QObject::tr("詹姆斯"); //get from POS
        QString m_html;

        double m_totalcost = 0;
        int m_sitnum = 1;    //get from tablet
        int m_totalitems = 0;
        int m_totalget = 200; //hard code here

        m_html += "<h2 align=\"center\"><font size=\"+2\">" + m_title + "</font></h2>";
        m_html += "<div align=\"center\"><font size=\"+0\">" + QObject::tr("交易时间: ") + m_time + "</font></div>";
        m_html += "<div align=\"center\"><font size=\"+0\">" + QObject::tr("座位号: ") + QString::number(m_sitnum, 'g', 6)
                  + "</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                  + QObject::tr("操作员: ") + m_opeartor + "</div>";
        m_html += "<hr  width=\"50%\" size =\"15\">";
        m_html += "<table align=\"center\" border=\"0\" cellspacing=\"12\" width=\"50%\"><tr  bgcolor=\"lightgray\"><th>" + QObject::tr("菜名") + "</th><th>" + QObject::tr("单价")
                  + "</th><th>" + QObject::tr("份数") + "</th><th>" + QObject::tr("金额") + "</th></tr>";

        foreach (QString entry, m_menu) {
            bool ok;
            ++m_totalitems;
            QStringList fields = entry.split(":");
            QString m_name = QObject::tr(Qt::escape(fields[0]).toStdString().c_str());
            QString m_unitprice = Qt::escape(fields[1]);
            QString m_num = Qt::escape(fields[2]);
            QString m_ammount = QString::number((m_num.toDouble(&ok))*(m_unitprice.toDouble(&ok)), 'g', 6);
            m_totalcost += m_ammount.toDouble(&ok);
            m_html += "<tr><td align=\"center\">" + m_name + "</td><td align=\"center\">" + m_unitprice +
                    "</td><td align=\"center\">" + m_num + "</td><td align=\"center\"><font size=\"+1\">" + m_ammount + "</font></td></tr>";
        }

        m_html += "</table>";
        m_html += "<hr  width=\"50%\" size=\"15\">";
        m_html += "<div align=\"center\">" + QObject::tr("总计: &nbsp;&nbsp;")
                   + "<font size=\"+2\">" + QString::number(m_totalcost, 'g', 6) + "</font>&nbsp;&nbsp;&nbsp;&nbsp;"
                   + QObject::tr("总项数: &nbsp;&nbsp;") + "<font size=\"+1\">" + QString::number(m_totalitems, 'g', 6) + "</font></div>";
        m_html += "<div align=\"center\">" + QObject::tr("预收: &nbsp;&nbsp;") + "<font size=\"+2\">" + QString::number(m_totalget, 'g', 6) + "</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                   + QObject::tr("找零: &nbsp;&nbsp;") + "<font size=\"+2\">" + QString::number(m_totalget-m_totalcost, 'g', 6) + "</font></div>";
        m_html += "<p align=\"center\">" + QObject::tr("*淘米欢迎您再次光临*") + "</p>";
        m_html += "<div align=\"center\">" + QObject::tr("服务热线：&nbsp;&nbsp;88888888") + "</div>";

        //debug: to get the html content
        qDebug(m_html.toUtf8());

        //debug: to get available printer in local area
        QString m_printers = Print::printerList();
        qDebug(m_printers.toUtf8());

        //find the wanted network printer to print
        QPrinterInfo printerInfo = QPrinterInfo();
        QPrinterInfo targetPrinterInfo = QPrinterInfo();

        foreach(QPrinterInfo item, printerInfo.availablePrinters()){
            if(item.printerName() == QString::fromStdString("HP_LaserJet_P4014.P4015_PCL6:3")){
                //m_printer = new QPrinter(item, QPrinter::HighResolution);
                targetPrinterInfo = item;
                qDebug(targetPrinterInfo.printerName().toUtf8());
                break;
            }else{
                qDebug("nothing!!!");
            }
        }

        //QPrinter m_printer(targetPrinterInfo, QPrinter::HighResolution);
        QPrinter  m_printer(QPrinter::HighResolution);

        //m_printer.setOutputFormat(QPrinter::NativeFormat);
        m_printer.setOutputFileName("/home/ljl/menu.pdf");

        QTextDocument m_textDocument;
        m_textDocument.setHtml(m_html); //QTextDocument::setPlainText(const QString &text)
        m_textDocument.setPageSize(QSizeF(m_printer.logicalDpiX()*(75/50),
                                      m_printer.logicalDpiY()*(75/50)));
        m_textDocument.print(&m_printer);

    }

    void Print::printMenutoKitchen(quint32 orderNum){
        quint32 mOrderNum = orderNum;
        QString m_html;
        QSqlQuery queryOrderList;
        QSqlQuery queryOrderItem;

        //通过orderNum来查询OrderList表中的座位号
        queryOrderList.exec("CREATE TABLE IF NOT EXISTS orderList(orderNO INTEGER key, seatNO INTEGER, mac TEXT, date DATE, time TIME, discount REAL, total REAL, pay INTEGER)");
        queryOrderList.prepare("SELECT * FROM orderList WHERE orderNO = ?");
        queryOrderList.addBindValue(mOrderNum);
        queryOrderList.exec();
        // 为厨房创建菜单，只包括订单号、座位号、菜名和对应的数量
        m_html += "<h2 align=\"left\"><font size=\"+1\">" + QObject::tr("订单号: ")  + QString::number(mOrderNum)  + "</font></h2>";

        if(queryOrderList.next()){
            m_html += "<h2 align=\"left\"><font size=\"+1\">" + QObject::tr("座位号: ") + QString::number(queryOrderList.value(1).toInt()) + "</font></h2>";
        }

        m_html += "<br><hr  width=\"50%\" size =\"15\">";
        m_html += "<table align=\"center\" border=\"0\" cellspacing=\"12\" width=\"50%\"><tr bgcolor=\"lightgray\"><th>" + QObject::tr("菜名") + "</th><th>" + QObject::tr("份数") + "</th></tr>";

        queryOrderItem.exec("CREATE TABLE IF NOT EXISTS orderItems(orderNO INTEGER key, name TEXT, price REAL, num INTEGER)");
        queryOrderItem.prepare("SELECT * FROM orderItems WHERE orderNO = ?");
        queryOrderItem.addBindValue(mOrderNum);
        queryOrderItem.exec();

        if (queryOrderItem.next())
        {
            QString name = queryOrderItem.value(1).toString();//colume 1 在表orderItems中对应菜单名
            quint16 num = queryOrderItem.value(3).toInt();    //colume 3 在表orderItems中对应某个菜的数量
            m_html += "<tr><td align=\"center\">" + name + "</td><td align=\"center\">" + QString::number(num) + "</td></tr>";
        }
        m_html += "</table>";
        m_html += "<hr  width=\"50%\" size=\"15\">";
        m_html += "<p align=\"center\">" + QObject::tr("*淘米欢迎您再次光临*") + "</p>";

        //debug: to get available printer in local area
        QString m_printers = printerList();
        qDebug(m_printers.toUtf8());

        //find the wanted network printer to print
        QPrinterInfo printerInfo = QPrinterInfo();
        QPrinterInfo targetPrinterInfo = QPrinterInfo();

        foreach(QPrinterInfo item, printerInfo.availablePrinters()){
            if(item.printerName() == QString::fromStdString("HP_LaserJet_P4014.P4015_PCL6:3")){
                //m_printer = new QPrinter(item, QPrinter::HighResolution);
                targetPrinterInfo = item;
                qDebug(targetPrinterInfo.printerName().toUtf8());
                break;
            }else{
                qDebug("nothing!!!");
            }
        }

        //QPrinter m_printer(targetPrinterInfo, QPrinter::HighResolution);
        QPrinter  m_printer(QPrinter::HighResolution);

        //m_printer.setOutputFormat(QPrinter::NativeFormat);
        m_printer.setOutputFileName("/home/ljl/Kitchen1.pdf");

        QTextDocument m_textDocument;
        m_textDocument.setHtml(m_html); //QTextDocument::setPlainText(const QString &text)
        m_textDocument.setPageSize(QSizeF(m_printer.logicalDpiX()*(75/50),
                                      m_printer.logicalDpiY()*(75/50)));
        m_textDocument.print(&m_printer);
    }

    void Print::printMenutoForeground(quint32 orderNum, QString renderMoney, QString giveMoney, QString changeMoney){
        quint32 mOrderNum = orderNum;
        QString m_html;
        QSqlQuery queryOrderList;
        QSqlQuery queryOrderItem;

        QString m_title = QObject::tr(" &nbsp;淘米南京新街口店");
        QString m_time = QDateTime::currentDateTime().toString("yy-MM-dd hh:mm:ss");
        QString m_opeartor = QObject::tr("詹姆斯"); //get from POS
        int m_seatNo = 0;
        float  totalPrice=0;
        float discount = 0;

        m_html += "<h2 align=\"center\"><font size=\"+2\">" + m_title + "</font></h2>";
        //通过orderNum来查询OrderList表中的座位号
        queryOrderList.exec("CREATE TABLE IF NOT EXISTS orderList(orderNO INTEGER key, seatNO INTEGER, mac TEXT, date DATE, time TIME, discount REAL, total REAL, pay INTEGER)");
        queryOrderList.prepare("SELECT * FROM orderList WHERE orderNO = ?");
        queryOrderList.addBindValue(mOrderNum);
        queryOrderList.exec();
        // 为厨房创建菜单，只包括订单号、座位号、菜名和对应的数量
        m_html += "<h2 align=\"center\"><font size=\"+1\">" + QObject::tr("订单号: ")  + QString::number(mOrderNum)  + "</font></h2>";
        m_html += "<div align=\"center\"><font size=\"+0\">" + QObject::tr("交易时间: ") + m_time + "</font></div>";

        if(queryOrderList.next()){
            m_seatNo = queryOrderList.value(1).toInt();
            discount =   queryOrderList.value(5).toFloat();
        }
        m_html += "<div align=\"center\"><font size=\"+0\">" + QObject::tr("座位号: ") + QString::number(m_seatNo)
                  + "</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                  + QObject::tr("操作员: ") + m_opeartor + "</div>";
        m_html += "<hr  width=\"50%\" size =\"15\">";
        m_html += "<table align=\"center\" border=\"0\" cellspacing=\"12\" width=\"50%\"><tr bgcolor=\"lightgray\"><th>" + QObject::tr("菜名")
                + "</th><th>" + QObject::tr("价格") + "</th><th>" + QObject::tr("份数") + "</th><th>" + QObject::tr("小计") + "</th></tr>";

        queryOrderItem.exec("CREATE TABLE IF NOT EXISTS orderItems(orderNO INTEGER key, name TEXT, price REAL, num INTEGER)");
        queryOrderItem.prepare("SELECT * FROM orderItems WHERE orderNO = ?");
        queryOrderItem.addBindValue(mOrderNum);
        queryOrderItem.exec();

        while (queryOrderItem.next())
        {
            QString name = queryOrderItem.value(1).toString();//colume 1 在表orderItems中对应菜单名
            quint16 num = queryOrderItem.value(3).toInt();    //colume 3 在表orderItems中对应某个菜的数量
            float  price = queryOrderItem.value(2).toFloat();
            totalPrice += price * num;
            m_html += "<tr><td align=\"center\">" + name + "</td><td align=\"center\">" + QString::number(price, 'g', 6)
                    + "</td><td align=\"center\">"+QString::number(num)+ "</td><td align=\"center\">"+QString::number(price*num, 'g', 6)+"</td></tr>";
        }
        m_html += "</table>";
        m_html += "<hr  width=\"50%\" size=\"15\">";
        m_html += "<div align=\"center\">" + QObject::tr("总计: &nbsp;&nbsp;")
                   + "<font size=\"+2\">" + QString::number(totalPrice, 'g', 6)  + "</font>&nbsp;&nbsp;&nbsp;&nbsp;"
                   + QObject::tr("折扣: &nbsp;&nbsp;") + "<font size=\"+1\">" + QString::number(discount, 'g', 6) +"</font>&nbsp;&nbsp;&nbsp;&nbsp;"
                + QObject::tr("应收: &nbsp;&nbsp;") + "<font size=\"+1\">" + renderMoney + "</font></div>";
        m_html += "<div align=\"center\">" + QObject::tr("实收: &nbsp;&nbsp;")
                   + "<font size=\"+2\">" + giveMoney  +"</font>&nbsp;&nbsp;&nbsp;&nbsp;"
                + QObject::tr("找零: &nbsp;&nbsp;") + "<font size=\"+1\">" +  changeMoney + "</font></div>";

        m_html += "<p align=\"center\">" + QObject::tr("*淘米欢迎您再次光临*") + "</p>";
        m_html +="<div align=\"center\">" + QObject::tr("服务热线：&nbsp;&nbsp;88888888") + "</div>";

        //debug: to get available printer in local area
        QString m_printers = printerList();
        qDebug(m_printers.toUtf8());

        //find the wanted network printer to print
        QPrinterInfo printerInfo = QPrinterInfo();
        QPrinterInfo targetPrinterInfo = QPrinterInfo();

        foreach(QPrinterInfo item, printerInfo.availablePrinters()){
            if(item.printerName() == QString::fromStdString("HP_LaserJet_P4014.P4015_PCL6:3")){
                //m_printer = new QPrinter(item, QPrinter::HighResolution);
                targetPrinterInfo = item;
                qDebug(targetPrinterInfo.printerName().toUtf8());
                break;
            }else{
                qDebug("nothing!!!");
            }
        }

        //QPrinter m_printer(targetPrinterInfo, QPrinter::HighResolution);
        QPrinter  m_printer(QPrinter::HighResolution);

        //m_printer.setOutputFormat(QPrinter::NativeFormat);
        m_printer.setOutputFileName("/home/ljl/Kitchen1.pdf");

        QTextDocument m_textDocument;
        m_textDocument.setHtml(m_html); //QTextDocument::setPlainText(const QString &text)
        m_textDocument.setPageSize(QSizeF(m_printer.logicalDpiX()*(75/50),
                                      m_printer.logicalDpiY()*(75/50)));
        m_textDocument.print(&m_printer);
    }

    QString Print::printerList() {
        QString printersName;
        QPrinterInfo printerInfo = QPrinterInfo();
           foreach (QPrinterInfo item, printerInfo.availablePrinters()){
               printersName.append(item.printerName() + "\n");
           }
         return printersName;
    }
