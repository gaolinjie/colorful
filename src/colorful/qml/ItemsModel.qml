import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: itemsModel
    Component.onCompleted: loadItemsData()
  //Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                //tx.executeSql('DROP TABLE orderItemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS orderItemsData(orderNO TEXT key, name TEXT, price MONEY, number INTEGER)');
                var rs = tx.executeSql('SELECT * FROM orderItemsData WHERE orderNO = ?', [Global.orderNO]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item = rs.rows.item(index);
                        itemsModel.append({"orderNO": item.orderNO,
                                           "name": item.name,
                                           "price": item.price,
                                           "number": item.number});

                        index++;
                    }
                } else {
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "白菜心拌蜇头",
                                       "price": 10.0,
                                       "number": 4});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "白灵菇扣鸭掌",
                                       "price": 10.5,
                                          "number": 2});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "拌豆腐丝",
                                       "price": 12.5,
                                          "number": 2});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "白切鸡",
                                       "price": 20.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "拌双耳",
                                       "price": 37.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "冰梅凉瓜",
                                       "price": 23.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "冰镇芥兰",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "朝鲜辣白菜",
                                       "price": 22.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "陈皮兔肉",
                                       "price": 13.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212001",
                                       "name": "川北凉粉",
                                       "price": 22.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "刺身凉瓜",
                                       "price": 32.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "豆豉多春鱼",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "夫妻肺片",
                                       "price": 17.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "干拌牛舌",
                                       "price": 14.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "干拌顺风",
                                       "price": 13.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212002",
                                       "name": "怪味牛腱",
                                       "price": 12.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "红心鸭卷",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "姜汁皮蛋",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "酱香猪蹄",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "酱肘花",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "金豆芥兰",
                                       "price": 10.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "韭黄螺片",
                                       "price": 12.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212003",
                                       "name": "老北京豆酱",
                                       "price": 13.0,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "老醋泡花生",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "凉拌金针菇",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "凉拌西芹云耳",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "卤水牛舌",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "美味牛筋",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212004",
                                       "name": "泡椒凤爪",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "乳猪拼盘",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "珊瑚笋尖",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "爽口西芹",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "四宝烤麸",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "松仁香菇",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "蒜茸海带丝",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "跳水木耳",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212005",
                                       "name": "五彩酱鹅肝",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "腌三文鱼",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "tag": "浓汤",
                                       "name": "盐水虾肉",
                                          "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "五味九孔",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "明虾荔枝沙拉",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "香葱酥鱼",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "凉拌黄瓜 ",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "糖拌西红柿",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212006",
                                       "name": "八宝菠菜",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "韭菜鲜桃仁",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "香椿豆腐",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "脆虾白菜心",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "豉油乳鸽皇",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "卤水鸭舌",
                                       "price": 17.5,
                                          "number": 1});
                    itemsModel.append({"orderNO": "120212007",
                                       "name": "香吃茶树菇",
                                       "price": 17.5,
                                          "number": 1});
                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE orderItemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS orderItemsData(orderNO TEXT key, name TEXT, price MONEY, number INTEGER)');
                var index = 0;
                while (index < itemsModel.count) {
                    var item = itemsModel.get(index);
                    tx.executeSql('INSERT INTO orderItemsData VALUES(?,?,?,?)', [item.orderNO, item.name, item.price, item.number]);
                    index++;
                }
            }
        )
    }
}
