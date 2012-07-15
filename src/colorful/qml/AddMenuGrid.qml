import QtQuick 1.0
import "../js/global.js" as Global

GridView {
    id: addMenuGrid
    model: addMenuModel
    delegate: addMenuDelegate
    cacheBuffer: 200
    cellWidth: 100
    cellHeight: 100
    width: 1024
    height: 200
    flow: GridView.TopToBottom

   //Component.onCompleted: loadSumMenuData()
   //Component.onDestruction: saveSumMenuData()
    signal addsignal()
    Connections {
        target: parent.parent
        onMainCategoryChangeSignal: {
            loadSumMenuData()
        }
    }

   ListModel{
        id: addMenuModel
    }

    Component {
        id: addMenuDelegate

        Rectangle {
            id: itemRect
            width: 95
            height: 95
            color:"grey"
            radius:10
            opacity:1
           // signal addsignal(string lname, double lprice, int ltype)
            MouseArea {
                 id: addMouseArea
                 anchors.fill: parent
                 onClicked: {
                   Global.gorderItemsName =name
                   Global.gorderItemsPrice =price
                   Global.gorderItemsType = type
                   Global.gorderItemsprintname = printname
                   Global.gprintbool = printbool
                   Global.gcookbool = 0
                   if(Global.oldorderNO != "")addMenuGrid.sendAddsignal()
                 }
            }

            Text {
                 id: nameText
                 text: name
              // anchors.top: parent.top; anchors.topMargin: 30
              // anchors.left: parent.left; anchors.leftMargin: 10
                 anchors.verticalCenter: parent.verticalCenter;
                 anchors.horizontalCenter: parent.horizontalCenter;
                 font.pixelSize: 15
                 color: "white"
             }

            Text {
                 id: priceText
                 text: "￥" + price + " 元"
                 anchors.right: parent.right; anchors.rightMargin: 2
                 anchors.top: parent.top; anchors.topMargin: 3
                 font.pixelSize: 16
                 color: "white"
             }
            states: State {
               name: "pressed"; when: addMouseArea.pressed == true
               PropertyChanges { target: itemRect; color: "black" }
           }
        }
    }

    function loadSumMenuData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                //tx.executeSql('DROP TABLE sumMenuList');
                tx.executeSql('CREATE TABLE IF NOT EXISTS sumMenuList(name TEXT, image TEXT, detail TEXT, price REAL,type TEXT,printname TEXT,printbool INTEGER,cookbool INTEGER)');
                //var rs = tx.executeSql('SELECT * FROM sumMenuList ORDER BY id');
                var rs = tx.executeSql('SELECT * FROM sumMenuList WHERE type = ?', [Global.addMenuType]);
                var index = 0;
                if (rs.rows.length > 0) {
                    addMenuModel.clear();
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        addMenuModel.append({"name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price,
                                                "type":item0.type,"printname":item0.printname,"printbool":item0.printbool,"cookbool":item0.cookbool});
                        index++;
                    }
                } else {
                    addMenuModel.append({"name": "白菜心拌蜇头", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "香拌豆腐丝", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "凉拌双耳", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰梅凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白灵菇扣鸭掌", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "朝鲜辣白菜", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "陈皮兔肉", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "川北凉粉", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "刺身凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "豆豉多春鱼", "image": "", "detail": "此菜", "price": 10.0,"type":"畅销菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "夫妻肺片", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "干拌牛舌", "image": "", "detail": "此菜", "price": 10.0,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "干拌顺风", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "怪味牛腱", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "红心鸭卷", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "姜汁皮蛋", "image": "", "detail": "此菜", "price": 10.0,"type":"酒水","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "酱香猪蹄", "image": "", "detail": "此菜", "price": 10.5,"type":"酒水","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白切鸡", "image": "", "detail": "此菜", "price": 10.5,"type":"酒水","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰镇芥兰", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "豆豉多春鱼", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "干拌牛舌", "image": "", "detail": "此菜", "price": 10.0,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "干拌顺风", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "怪味牛腱", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"热菜","cookbool":0});
                    addMenuModel.append({"name": "红心鸭卷", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "姜汁皮蛋", "image": "", "detail": "此菜", "price": 10.0,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "酱香猪蹄", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白切鸡", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰镇芥兰", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "豆豉多春鱼", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白切鸡", "image": "", "detail": "此菜", "price": 10.5,"type":"酒水","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰镇芥兰", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "豆豉多春鱼", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"热菜","cookbool":0});
                    addMenuModel.append({"name": "干拌顺风", "image": "", "detail": "此菜", "price": 10.5,"type":"畅销菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "怪味牛腱", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "红心鸭卷", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "香拌豆腐丝", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "凉拌双耳", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰梅凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白灵菇扣鸭掌", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "朝鲜辣白菜", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "陈皮兔肉", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "川北凉粉", "image": "", "detail": "此菜", "price": 10.0,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "刺身凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"特色菜品","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰梅凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"茶点","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白灵菇扣鸭掌", "image": "", "detail": "此菜", "price": 10.5,"type":"茶点","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "朝鲜辣白菜", "image": "", "detail": "此菜", "price": 10.0,"type":"茶点","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "陈皮兔肉", "image": "", "detail": "此菜", "price": 10.5,"type":"茶点","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "川北凉粉", "image": "", "detail": "此菜", "price": 10.0,"type":"茶点","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "冰梅凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"面点","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "白灵菇扣鸭掌", "image": "", "detail": "此菜", "price": 10.5,"type":"面点","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "朝鲜辣白菜", "image": "", "detail": "此菜", "price": 10.0,"type":"面点","printname":"GP-H80250 Series","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "陈皮兔肉", "image": "", "detail": "此菜", "price": 10.5,"type":"面点","printname":"热菜","printbool":1,"cookbool":0});
                    addMenuModel.append({"name": "川北凉粉", "image": "", "detail": "此菜", "price": 10.0,"type":"面点","printname":"GP-H80250 Series","printbool":0,"cookbool":0});
                    addMenuModel.append({"name": "冰梅凉瓜", "image": "", "detail": "此菜", "price": 10.5,"type":"海鲜","printname":"GP-H80250 Series","printbool":0,"cookbool":0});
                    addMenuModel.append({"name": "白灵菇扣鸭掌", "image": "", "detail": "此菜", "price": 10.5,"type":"海鲜","printname":"热菜","printbool":0,"cookbool":0});
                    addMenuModel.append({"name": "朝鲜辣白菜", "image": "", "detail": "此菜", "price": 10.0,"type":"中厨","printname":"GP-H80250 Series","printbool":0,"cookbool":0});
                    addMenuModel.append({"name": "陈皮兔肉", "image": "", "detail": "此菜", "price": 10.5,"type":"中厨","printname":"热菜","printbool":0,"cookbool":0});
                    addMenuModel.append({"name": "川北凉粉", "image": "", "detail": "此菜", "price": 10.0,"type":"中厨","printname":"GP-H80250 Series","printbool":0,"cookbool":0});
                }
            }
        )
     }
    function saveSumMenuData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE sumMenuList');
                tx.executeSql('CREATE TABLE IF NOT EXISTS sumMenuList(name TEXT, image TEXT, detail TEXT, price REAL,type TEXT,printname TEXT,printbool INTEGER,cookbool INTEGER)');
                var index = 0;
                while (index < addMenuModel.count) {
                    var item = addMenuModel.get(index);
                    tx.executeSql('INSERT INTO sumMenuList VALUES(?,?,?,?,?,?,?,?)', [item.name, item.image, item.detail, item.price, item.type,item.printname,item.printbool,item.cookbool]);
                    index++;
                }
            }
        )
    }
    function sendAddsignal(){
        addsignal()
    }
}
