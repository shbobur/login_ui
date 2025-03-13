#include "googleauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>

GoogleAuth::GoogleAuth(QObject *parent)
    : OAuthBase(parent)
{
    setupProvider();
}

void GoogleAuth::setupProvider()
{
    setupOAuth2(authEndpoint, tokenEndpoint, clientId, clientSecret,
                "email profile", 8080);
}

QUrl GoogleAuth::userInfoEndpoint() const
{
    return QUrl("https://www.googleapis.com/oauth2/v2/userinfo");
}

QString GoogleAuth::extractId(const QJsonObject &object) const
{
    return object["email"].toString();
}

QString GoogleAuth::extractName(const QJsonObject &object) const
{
    return object["name"].toString();
}

QString GoogleAuth::getCallbackHtml() const
{
    return "<html>"
           "<head>"
               "<style>"
                   "body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background-color: #f0f2f5; }"
                   "h1 { color: #1a73e8; margin-bottom: 20px; }"
                   "p { color: #5f6368; font-size: 18px; }"
                   ".container { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); display: inline-block; }"
               "</style>"
           "</head>"
           "<body>"
               "<div class='container'>"
                   "<h1>Successfully Logged In with Google!</h1>"
                   "<p>You are now logged in to Qt-login-demo app.</p>"
                   "<p>You can safely return to the application.</p>"
               "</div>"
           "</body>"
           "</html>";
}