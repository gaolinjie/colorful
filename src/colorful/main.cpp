#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/start.qml"));

 //   view.showFullScreen();
    view.show();

    return a.exec();
}
