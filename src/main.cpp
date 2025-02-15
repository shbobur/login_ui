#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "oauth/googleauth.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/src/qml");

    // Register GoogleAuth type
    qmlRegisterType<GoogleAuth>("com.login_app.oauth", 1, 0, "GoogleAuth");

    const QUrl url(QStringLiteral("qrc:/src/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);
    return app.exec();
}
 
