import QtQuick 1.0
import "../js/global.js" as Global
import "../js/calculator.js" as CalcEngine

Item {
    id: keyBoard
    width: 230; height:340
    function doOp(operation) { CalcEngine.doOperation3(operation) }

    signal keyOksignal()
    signal textUpdatesignal()
    signal cancelsignal()
    signal finishsignal()

    Grid {
        rows: 5; columns: 3; spacing: 8
        anchors.centerIn: parent.Center

        Button { width: 70; height: 60; operation: "7"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "8"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "9"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "4"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "5"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "6"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "1"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "2"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "3"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "."; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "0"; textSize: 20
            onOperate: {
                   textUpdatesignal()
            }
        }

        Button { width: 70; height: 60; operation: "OK"; color: "green"; textSize: 20
            onOperate: {
                   keyOksignal()
            }
        }
        Button { width: 70; height: 60; operation: "\u2190"; color: "red"; textSize: 25
            onOperate: {
                   textUpdatesignal()
            }
        }
        Button { width: 70; height: 60; operation: "取消"; color: "red"; textSize: 25
            onOperate: {
                   cancelsignal()
            }
        }
        Button { width: 70; height: 60; operation: "完成"; color: "red"; textSize: 25
            onOperate: {
                   finishsignal()
            }
        }
    }
}
