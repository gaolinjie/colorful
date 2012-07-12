
var lastOp = ""
var realText = ""
var trueText = ""

function doOperation(op) {
    if (op.toString().length==1 && ((op >= "0" && op <= "9"))) {
        if (display.text.toString().length >= 12)
            return; // No arbitrary length numbers
        if (lastOp.toString().length == 1 && (lastOp >= "0" && lastOp <= "9")) {
            display.text = display.text + "*"
            trueText = trueText + op.toString()
        } else {                                          //一个字符未输入时，lastop长度为0执行此处
            display.text = "*"
            trueText = op
        }
        lastOp = op.toString()
        return
    } else if (op == "\u2190") {
        display.text = display.text.toString().slice(0, -1)
        trueText = trueText.toString().slice(0, -1)
    }
}

function doOperation2(op) {
    if (op.toString().length==1 && ((op >= "0" && op <= "9"))) {
        if (display.text.toString().length >= 6)
            return; // No arbitrary length numbers
        if (lastOp.toString().length == 1 && (lastOp >= "0" && lastOp <= "9")) {
            realText = realText + lastOp;
            display.text = realText + "." + op.toString()
        } else {
            display.text = "0." + op.toString()
        }
        lastOp = op.toString()
        return
    } else if (op == "\u2190") {
        display.text = "0.0"
        realText = ""
        lastOp = ""
    }
}

function doOperation3(op) {
    if (op.toString().length==1 && ((op >= "0" && op <= "9")||(op == ".")||op == "\u2190")) {
        if (Global.gtextIn.toString().length >= 10)
            return; // No arbitrary length numbers
        if (op == "\u2190") {
            if (Global.gtextIn != ""){
                Global.gtextIn = Global.gtextIn.toString().slice(0,-1);
            }
        }
        else {
            Global.gtextIn = Global.gtextIn + op;
        }
    }
    else{
    }
}

function changeAddMenuData() {
    addMenuGrid.model.clear();
    var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
    db.transaction(
        function(tx) {
            //tx.executeSql('DROP TABLE sumMenuList');
            tx.executeSql('CREATE TABLE IF NOT EXISTS sumMenuList(name TEXT, image TEXT, detail TEXT, price REAL,type INTEGER,printname TEXT,printbool INTEGER,cookbool INTEGER)');
            //var rs = tx.executeSql('SELECT * FROM sumMenuList ORDER BY id');
            var rs = tx.executeSql('SELECT * FROM sumMenuList WHERE type = ?', [Global.addMenuType]);
            var index = 0;
            if (rs.rows.length > 0) {
                while (index < rs.rows.length) {
                    var item0 = rs.rows.item(index);
                    addMenuGrid.model.append({"name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price,
                                                 "type":item0.type,"printname":item0.printname,"printbool":item0.printbool,"cookbool":item0.cookbool});
                    index++;
                 }
              }
           }
       )
 }
function addMenuBack() {
    addMenuGrid.model.clear();
    var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
    db.transaction(
        function(tx) {
            //tx.executeSql('DROP TABLE sumMenuList');
            tx.executeSql('CREATE TABLE IF NOT EXISTS sumMenuList(name TEXT, image TEXT, detail TEXT, price REAL,type INTEGER)');
            //var rs = tx.executeSql('SELECT * FROM sumMenuList ORDER BY id');
            var rs = tx.executeSql('SELECT * FROM sumMenuList WHERE type = ?', [Global.addMenuType]);
            var index = 0;
            if (rs.rows.length > 0) {
                while (index < rs.rows.length) {
                    var item0 = rs.rows.item(index);
                    addMenuGrid.model.append({"name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price,
                                                 "type":item0.type,"printname":item0.printname,"printbool":item0.printbool,"cookbool":item0.cookbool});
                    index++;
                }
             }
            addMenuButton1.color = "blue"
            addMenuButton2.color = "green"
            addMenuButton3.color = "green"
            addMenuButton4.color = "green"
            addMenuButton5.color = "green"
            addMenuButton6.color = "green"
            addMenuButton7.color = "green"
           }
       )
 }
