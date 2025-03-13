#include "facebookauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QUrlQuery>

FacebookAuth::FacebookAuth(QObject *parent)
    : OAuthBase(parent)
{
    setupProvider();
}

void FacebookAuth::setupProvider()
{
    setupOAuth2(authEndpoint, tokenEndpoint, clientId, clientSecret,
                "public_profile,email", 8082);
}

QUrl FacebookAuth::userInfoEndpoint() const
{
    return QUrl("https://graph.facebook.com/v22.0/me");
}

QString FacebookAuth::extractId(const QJsonObject &object) const
{
    return object["id"].toString();
}

QString FacebookAuth::extractName(const QJsonObject &object) const
{
    return object["name"].toString();
}

QUrlQuery FacebookAuth::userInfoParameters() const
{
    QUrlQuery query;
    query.addQueryItem("fields", "id,name,email");
    return query;
}

QString FacebookAuth::getCallbackHtml() const
{
    return "<html>"
           "<head>"
               "<style>"
                   "body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background-color: #f0f2f5; }"
                   "h1 { color: #1877f2; margin-bottom: 20px; }"
                   "p { color: #1c1e21; font-size: 18px; }"
                   ".container { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); display: inline-block; }"
               "</style>"
           "</head>"
           "<body>"
               "<div class='container'>"
                   "<h1>Successfully Logged In with Facebook!</h1>"
                   "<p>You are now logged in to Qt-login-demo app.</p>"
                   "<p>You can safely return to the application.</p>"
               "</div>"
           "</body>"
           "</html>";
} 