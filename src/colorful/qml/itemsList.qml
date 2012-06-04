import QtQuick 1.0
import "../js/global.js" as Global
import "../js/calculator.js" as CalcEngine
ListView {
        id: itemsList
        width: 355; height:250
        model: itemsModel
        delegate: itemDelegate
        smooth: true
        signal orderListUpdateSignal()

        Connections {
            target: parent.parent
            onMainAddsignal: {

                updateItemsModelData();
                itemsList.currentIndex = Global.gitemIndex
                updateOrderListData();
            }
        }
        Connections {
            target: parent.parent
            onMainUpdateItemsignal: {
                loadItemsData();
            }
        }


        ListModel{
            id: itemsModel
        }

        Component {
            id: itemDelegate

            Item {
                id: wraper
                width: 355; height: 30

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        wraper.ListView.view.currentIndex = index
                        Global.gitemIndex = index
                   //     console.log(Global.orderNO);
                    }
                }

                Rectangle {
                    id: itemRect
                    width: 300; height: 30
                    radius: 8
                    anchors.left: parent.left; anchors.leftMargin: 35
                    anchors.verticalCenter: parent.verticalCenter
                    color: wraper.ListView.isCurrentItem ? "#f4a83d" : "white"
                    smooth: true
                    border.color: "grey"
                    border.width: 1

                    Text {
                        id: nameText
                        text: name
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 10
                        color: "black"
                    }

                    Text {
                        id: priceText
                        text: price
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 120
                        color: "black"
                    }

                    Text {
                        id: numberText
                        text: num
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 200
                        color: "black"
                    }

                    Text {
                        id: subtotalText
                        text: price * num
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 255
                        color: "black"
                    }
                }

                Image {
                    source: "qrc:/images/minus.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: itemRect.left; anchors.rightMargin: 5
                    visible: wraper.ListView.isCurrentItem
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                        //    wraper.ListView.view.model.remove(index)
                        //    wraper.ListView.view.saveItemsData()
                        //    wraper.ListView.view.updateOrderListData()
                            //console.log(Global.orderNo);
                            wraper.ListView.view.minusItemData()
                            wraper.ListView.view.updateOrderListData()
                        }
                    }
                }
                Image {
                    source: "qrc:/images/add.png"
                    width: 31; height: 31
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: itemRect.right; anchors.leftMargin: 5
                    visible: wraper.ListView.isCurrentItem
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            wraper.ListView.view.addItemData()
                            wraper.ListView.view.updateOrderListData()
                        }
                    }
                 }
            }
        }

        function loadItemsData() {
            if (Global.orderNO == "") {
               // return
            }
            itemsModel.clear();
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE orderItems');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS orderItems(orderNO INTEGER key,name TEXT, price REAL, num INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM orderItems WHERE orderNO = ?', [Global.orderNO]);
                    var index = 0;
                   // if (rs.rows.length > 0) {
                        while (index < rs.rows.length) {
                            var item = rs.rows.item(index);
                            itemsModel.append({"orderNO": item.orderNO,
                                               "name": item.name,
                                               "price": item.price,
                                               "num": item.num});

                            index++;
                        }
                   /* } else {
                        itemsModel.append({"orderNO": "120212001",
                                           "name": "白菜心拌蜇头",
                                           "suborderNO":1,
                                           "price": 10.0,
                                              "num": 4});
                        itemsModel.append({"orderNO": "120212001",
                                           "name": "白灵菇扣鸭掌",
                                           "suborderNO":2,
                                           "price": 10.5,
                                              "num": 2});
                        itemsModel.append({"orderNO": "120212001",
                                           "name": "拌豆腐丝",
                                           "suborderNO":3,
                                           "price": 12.5,
                                              "num": 2});
                        itemsModel.append({"orderNO": "120212002",
                                           "name": "陈皮兔肉",
                                           "suborderNO":1,
                                           "price": 13.0,
                                              "num": 1});
                        itemsModel.append({"orderNO": "120212002",
                                           "name": "川北凉粉",
                                           "suborderNO":2,
                                           "price": 22.5,
                                              "num": 1});
                        itemsModel.append({"orderNO": "120212002",
                                           "name": "刺身凉瓜",
                                           "suborderNO":3,
                                           "price": 32.0,
                                              "num": 1});
                        itemsModel.append({"orderNO": "120212002",
                                           "name": "豆豉多春鱼",
                                           "suborderNO":4,
                                           "price": 10.0,
                                              "num": 1});
                    }*/
                }
            )
        }

        function saveItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    tx.executeSql('DROP TABLE orderItems');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS orderItems(orderNO INTEGER key,name TEXT, price REAL, num INTEGER)');
                    var index = 0;
                    while (index < itemsModel.count) {
                        var item = itemsModel.get(index);
                        tx.executeSql('INSERT INTO orderItems VALUES(?,?,?,?)', [item.orderNO, item.name, item.price, item.num]);
                        index++;
                    }
                }
            )
        }
        function updateItemsModelData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            var fname = Global.gorderItemsName;
            var fprice = Global.gorderItemsPrice;
            var index = 0;
            var item;
            while (index < itemsModel.count) {
                item = itemsModel.get(index);
                if (item.name == Global.gorderItemsName) break;
                index++;
            }
            //index = 0;///
            if ( index == itemsModel.count ) {
                itemsModel.append({"orderNO": Global.orderNO,
                                   "name": fname,
                                   "price": fprice,
                                   "num": 1});

                db.transaction(
                    function(tx) {
                            tx.executeSql('INSERT INTO orderItems VALUES(?,?,?,?)', [Global.orderNO,fname, fprice, 1]);
                        }
                  )
            }
            else {
                var itemnum = item.num;//item.num+1 = 11,item.num不能直接++操作，因此用中间量
                itemnum++;
                itemsModel.setProperty(index,"num",itemnum);
                db.transaction(
                    function(tx) {
                            tx.executeSql('UPDATE orderItems SET num = ? WHERE orderNO = ? AND name = ?', [itemnum,Global.orderNO,item.name]);
                        }
                  )
            }
            Global.gitemIndex = index ;
       }

       function minusItemData(){
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            var item;
            item = itemsModel.get(Global.gitemIndex);
            var itemnum = item.num;
            itemnum--;
            var itemname = item.name;
            if ( itemnum == 0){
                itemsModel.remove(Global.gitemIndex);
                //saveItemsData();
                db.transaction(
                    function(tx) {
                            tx.executeSql('DELETE FROM orderItems WHERE orderNO = ? AND name = ?', [Global.orderNO,itemname]);////删除语句似乎不能直接用item.name,不知道为什么，需要用中间变量过渡
                            }
                  )
                if (Global.gitemIndex == itemsModel.count) Global.gitemIndex--;
                //else Global.gitemIndex++;
            }
            else{
                itemsModel.setProperty(Global.gitemIndex,"num",itemnum);
                db.transaction(
                    function(tx) {
                             //console.log(Global.orderNO);
                             //console.log(itemnum);
                            tx.executeSql('UPDATE orderItems SET num = ? WHERE orderNO = ? AND name = ?', [itemnum,Global.orderNO,itemname]);
                            //console.log(Global.orderNO);
                            //console.log(itemnum);
                        }
                  )
            }
       }

       function addItemData(){
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            var item;
            item = itemsModel.get(Global.gitemIndex);
            var itemnum = item.num;
            itemnum++;

            itemsModel.setProperty(Global.gitemIndex,"num",itemnum);
            //console.log(Global.gitemIndex)
            //console.log(itemnum)
            db.transaction(
                function(tx) {
                        tx.executeSql('UPDATE orderItems SET num = ? WHERE orderNO = ? AND name = ?', [itemnum,Global.orderNO,item.name]);
                         //    console.log(Global.orderNO)
                         //   console.log(item.name)
                    }
              )
       }

       function updateOrderListData() {
                Global.gorderTotalPrice = 0;////计算总价格
                var index = 0;
                var item;
                while (index < itemsModel.count) {
                    item = itemsModel.get(index);
                    var tempPrice = item.price;
                    var tempNum = item.num;
                    Global.gorderTotalPrice += (tempPrice*tempNum);
                    index++;
                }
                orderListUpdateSignal();
        }
}
