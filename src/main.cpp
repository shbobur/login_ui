#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "oauth/googleauth.h"
#include "oauth/githubauth.h"
#include "oauth/facebookauth.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/src/qml");

    // Register auth types
    qmlRegisterType<GoogleAuth>("com.login_app.oauth", 1, 0, "GoogleAuth");
    qmlRegisterType<GithubAuth>("com.login_app.oauth", 1, 0, "GithubAuth");
    qmlRegisterType<FacebookAuth>("com.login_app.oauth", 1, 0, "FacebookAuth");

    const QUrl url(QStringLiteral("qrc:/src/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);
    return app.exec();
}
 
