#include "githubauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>

GithubAuth::GithubAuth(QObject *parent)
    : QObject(parent)
    , oauth2(new QOAuth2AuthorizationCodeFlow(this))
    , replyHandler(new QOAuthHttpServerReplyHandler(8081, this))  // Using different port than Google
{
    replyHandler->setCallbackText(
        "<html>"
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
        "</html>"
    );

    setupOAuth2();
}

GithubAuth::~GithubAuth()
{
}

void GithubAuth::setupOAuth2()
{
    oauth2->setAuthorizationUrl(authEndpoint);
    oauth2->setAccessTokenUrl(tokenEndpoint);
    oauth2->setClientIdentifier(clientId);
    oauth2->setClientIdentifierSharedKey(clientSecret);
    oauth2->setScope("read:user user:email");
    
    oauth2->setReplyHandler(replyHandler);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
            &QDesktopServices::openUrl);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::granted, this, [this]() {
        // Get user info after successful authentication
        QUrl userInfoUrl("https://api.github.com/user");
        auto reply = oauth2->get(userInfoUrl);

        connect(reply, &QNetworkReply::finished, this, [reply, this]() {
            if (reply->error() != QNetworkReply::NoError) {
                emit loginFailed(reply->errorString());
                return;
            }

            const auto data = reply->readAll();
            const auto document = QJsonDocument::fromJson(data);
            const auto object = document.object();

            const auto username = object["login"].toString();
            const auto name = object["name"].toString();

            emit loginSucceeded(username, name);
            reply->deleteLater();
        });
    });

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::error, this,
            [this](const QString &error, const QString &errorDescription) {
        emit loginFailed(errorDescription.isEmpty() ? error : errorDescription);
    });
}

void GithubAuth::startLogin()
{
    oauth2->grant();
} 