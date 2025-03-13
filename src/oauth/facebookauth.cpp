#include "facebookauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QUrlQuery>

FacebookAuth::FacebookAuth(QObject *parent)
    : QObject(parent)
    , oauth2(new QOAuth2AuthorizationCodeFlow(this))
    , replyHandler(new QOAuthHttpServerReplyHandler(8082, this))  // Using different port than Google/Github
{
    replyHandler->setCallbackText(
        "<html>"
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
        "</html>"
    );

    setupOAuth2();
}

FacebookAuth::~FacebookAuth()
{
}

void FacebookAuth::setupOAuth2()
{
    oauth2->setAuthorizationUrl(authEndpoint);
    oauth2->setAccessTokenUrl(tokenEndpoint);
    oauth2->setClientIdentifier(clientId);
    oauth2->setClientIdentifierSharedKey(clientSecret);
    oauth2->setScope("public_profile,email");
    
    oauth2->setReplyHandler(replyHandler);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
            &QDesktopServices::openUrl);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::granted, this, [this]() {
        // Get user info after successful authentication
        QUrl userInfoUrl("https://graph.facebook.com/v22.0/me");
        QUrlQuery query;
        query.addQueryItem("fields", "id,name,email");
        userInfoUrl.setQuery(query);
        
        auto reply = oauth2->get(userInfoUrl);

        connect(reply, &QNetworkReply::finished, this, [reply, this]() {
            if (reply->error() != QNetworkReply::NoError) {
                emit loginFailed(reply->errorString());
                return;
            }

            const auto data = reply->readAll();
            const auto document = QJsonDocument::fromJson(data);
            const auto object = document.object();

            const auto userId = object["id"].toString();
            const auto name = object["name"].toString();

            emit loginSucceeded(userId, name);
            reply->deleteLater();
        });
    });

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::error, this,
            [this](const QString &error, const QString &errorDescription) {
        emit loginFailed(errorDescription.isEmpty() ? error : errorDescription);
    });
}

void FacebookAuth::startLogin()
{
    oauth2->grant();
} 