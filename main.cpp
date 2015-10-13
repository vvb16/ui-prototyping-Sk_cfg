#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "candriver.h"

// Define the singleton type provider function (callback).
static QObject *can_driver_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    CANDriver *can_driver = new CANDriver();
    return can_driver;
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType<CANDriver>("CAN.Driver.VCI3", 1, 0, "CANDriver", can_driver_qobject_singletontype_provider);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

