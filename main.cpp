#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QtQml/QtQml>

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_DisableHighDpiScaling);
    QQuickStyle::setStyle("Ergo");

    QCoreApplication::setApplicationName("SomaFM");

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:///qml/Main.qml")));
    engine.load(QStringLiteral("qml/Main.qml"));

    return app.exec();
}
