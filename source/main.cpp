#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "obliczenia.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext() ;
    Obliczenia obl;
    context->setContextProperty("obliczenia",&obl);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
