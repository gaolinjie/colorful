import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: ordersModel
    Component.onCompleted: loadOrdersData()
  //Component.onDestruction: saveOrdersData()
    function loadOrdersData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                //tx.executeSql('DROP TABLE ordersData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS ordersData(orderNO TEXT key, seatNO TEXT, date TEXT, time TEXT, discount TEXT, total TEXT, pay TEXT)');
                var rs = tx.executeSql('SELECT * FROM ordersData WHERE pay = ?', [Global.pay]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item = rs.rows.item(index);
                        if (index == 0) {
                            Global.orderNO = item.orderNO
                        }

                        ordersModel.append({"orderNO": item.orderNO,
                                            "seatNO": item.seatNO,
                                            "date": item.date,
                                            "time": item.time,
                                            "discount": item.discount,
                                            "total": item.total,
                                            "pay": item.pay});

                        index++;
                    }
                } else {
                    ordersModel.append({"orderNO": "120212001",
                                        "seatNO": "18",
                                        "date": "2012-02-12",
                                        "time": "11:00",
                                        "discount": "10",
                                        "total": "100",
                                        "pay": "0"});
                    ordersModel.append({"orderNO": "120212002",
                                        "seatNO": "11",
                                        "date": "2012-02-12",
                                        "time": "11:10",
                                        "discount": "10",
                                        "total": "200",
                                        "pay": "0"});
                    ordersModel.append({"orderNO": "120212003",
                                        "seatNO": "13",
                                        "date": "2012-02-12",
                                        "time": "12:00",
                                        "discount": "10",
                                        "total": "200",
                                        "pay": "0"});
                    ordersModel.append({"orderNO": "120212004",
                                        "seatNO": "19",
                                        "date": "2012-02-12",
                                        "time": "12:10",
                                        "discount": "10",
                                        "total": "300",
                                        "pay": "0"});
                    ordersModel.append({"orderNO": "120212005",
                                        "seatNO": "16",
                                        "date": "2012-02-12",
                                        "time": "12:20",
                                        "discount": "10",
                                        "total": "130",
                                        "pay": "0"});
                    ordersModel.append({"orderNO": "120212006",
                                        "seatNO": "14",
                                        "date": "2012-02-12",
                                        "time": "12:30",
                                        "discount": "10",
                                        "total": "150",
                                        "pay": "1"});
                    ordersModel.append({"orderNO": "120212007",
                                        "seatNO": "10",
                                        "date": "2012-02-12",
                                        "time": "12:30",
                                        "discount": "10",
                                        "total": "180",
                                        "pay": "1"});
                    ordersModel.append({"orderNO": "120212008",
                                        "seatNO": "11",
                                        "date": "2012-02-12",
                                        "time": "12:41",
                                        "discount": "10",
                                        "total": "120",
                                        "pay": "1"});
                    ordersModel.append({"orderNO": "120212009",
                                        "seatNO": "15",
                                        "date": "2012-02-12",
                                        "time": "12:45",
                                        "discount": "10",
                                        "total": "110",
                                        "pay": "1"});

                }
            }
        )
    }

    function saveOrdersData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE ordersData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS ordersData(orderNO TEXT key, seatNO TEXT, date TEXT, time TEXT, discount TEXT, total TEXT, pay TEXT)');
                var index = 0;
                while (index < ordersModel.count) {
                    var item = ordersModel.get(index);
                    tx.executeSql('INSERT INTO ordersData VALUES(?,?,?,?,?,?,?)', [item.orderNO, item.seatNO, item.date, item.time, item.discount, item.total, item.pay]);
                    index++;
                }
            }
        )
    }
}
