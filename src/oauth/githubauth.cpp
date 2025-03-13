#include "githubauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>

GithubAuth::GithubAuth(QObject *parent)
    : OAuthBase(parent)
{
    setupProvider();
}

void GithubAuth::setupProvider()
{
    setupOAuth2(authEndpoint, tokenEndpoint, clientId, clientSecret,
                "read:user user:email", 8081);
}

QUrl GithubAuth::userInfoEndpoint() const
{
    return QUrl("https://api.github.com/user");
}

QString GithubAuth::extractId(const QJsonObject &object) const
{
    return object["login"].toString();
}

QString GithubAuth::extractName(const QJsonObject &object) const
{
    return object["name"].toString();
}

QString GithubAuth::getCallbackHtml() const
{
    return "<html>"
           "<head>"
               "<style>"
                   "body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background-color: #0d1117; }"
                   "h1 { color: #58a6ff; margin-bottom: 20px; }"
                   "p { color: #c9d1d9; font-size: 18px; }"
                   ".container { background: #161b22; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.2); display: inline-block; }"
               "</style>"
           "</head>"
           "<body>"
               "<div class='container'>"
                   "<h1>Successfully Logged In with GitHub!</h1>"
                   "<p>You are now logged in to Qt-login-demo app.</p>"
                   "<p>You can safely return to the application.</p>"
               "</div>"
           "</body>"
           "</html>";
}
