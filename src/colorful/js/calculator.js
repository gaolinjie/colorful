
var lastOp = ""
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