import QtQuick 1.0
import "../js/global.js" as Global

ListView {
    id: sumCategoryList
    model: sumCategoryModel
    delegate: sumCategoryDelegate
    orientation: ListView.Horizontal
    smooth: true
    signal categoryChangeSignal()

    ListModel{
        id: sumCategoryModel
    }


    Component {
        id: sumCategoryDelegate

        Item {
            id: wraper
            width: 80; height: 50
            Component.onCompleted: {
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                     wraper.ListView.view.currentIndex = index
                     Global.addMenuType = categoryName
                     wraper.ListView.view.sendChangeSignal()
                }
            }
            Rectangle{
                id: categoryHighlight
                width: 80; height: 50
            }

            Rectangle {
                id: categoryRect
                width: 80; height: 50
                anchors.left: parent.left; anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                color: wraper.ListView.isCurrentItem ? "#7B3349":"black"
                smooth: true
                border.color: "white"
                border.width: 1

                Text {
                    id: categoryText
                    text: categoryName
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                }
            }
        }
    }


    function getCategoryList() {
            //sumCategoryModel.clear();
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE orderList');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS sumCategoryList(categoryName TEXT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS sumMenuList(name TEXT, image TEXT, detail TEXT, price REAL,type TEXT,printname TEXT,printbool INTEGER,cookbool INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM sumMenuList');
                    var rstemp;
                    var index = 0;
                    if (rs.rows.length > 0) {
                        while (index < rs.rows.length) {
                            rstemp = tx.executeSql('SELECT * FROM sumCategoryList');
                            var indextemp = 0;
                            if (rstemp.rows.length == 0){
                                var item = rs.rows.item(index);
                                tx.executeSql('INSERT INTO sumCategoryList VALUES(?)', [item.type]);
                                index++;
                            }
                            else {
                                item = rs.rows.item(index);
                                var itemtemp;
                                while (indextemp < rstemp.rows.length){
                                 itemtemp = rstemp.rows.item(indextemp);
                                    if ( item.type == itemtemp.categoryName) break;
                                    indextemp++;
                                }
                                if( indextemp == rstemp.rows.length ){
                                tx.executeSql('INSERT INTO sumCategoryList VALUES(?)', [item.type]);
                                }
                                index++;
                            }
                        }
                    }
                }
           )
     }
function getCategoryModel() {
        sumCategoryModel.clear();
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS sumCategoryList(categoryName TEXT)');
                    var rs = tx.executeSql('SELECT * FROM sumCategoryList');
                    var index = 0;
                    while (index < rs.rows.length) {
                        var item = rs.rows.item(index);
                        sumCategoryModel.append({"categoryName": item.categoryName});
                        index++;
                    }
            }
        )
    }
function sendChangeSignal() {
         categoryChangeSignal()
    }
function getfistCategory() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS sumCategoryList(categoryName TEXT)');
                    var rs = tx.executeSql('SELECT * FROM sumCategoryList');
                    if( rs.rows.length > 0 ){
                        var item = rs.rows.item(0);
                        Global.addMenuType = item.categoryName;
                    }
                    else Global.addMenuType = "";
            }
        )
        categoryChangeSignal()
    }
}
