
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
        } else {
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
        display.text = "0"
        realText = ""
        lastOp = ""
    }
}
