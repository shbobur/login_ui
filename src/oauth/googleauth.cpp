#include "googleauth.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>

GoogleAuth::GoogleAuth(QObject *parent)
    : QObject(parent)
    , oauth2(new QOAuth2AuthorizationCodeFlow(this))
    , replyHandler(new QOAuthHttpServerReplyHandler(8080, this))
{
    replyHandler->setCallbackText(
        "<html>"
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
                "<h1>Successfully Logged In!</h1>"
                "<p>You are now logged in to Qt-login-demo app.</p>"
                "<p>You can safely return to the application.</p>"
            "</div>"
        "</body>"
        "</html>"
    );

    setupOAuth2();
}

GoogleAuth::~GoogleAuth()
{
}

void GoogleAuth::setupOAuth2()
{
    oauth2->setAuthorizationUrl(authEndpoint);
    oauth2->setAccessTokenUrl(tokenEndpoint);
    oauth2->setClientIdentifier(clientId);
    oauth2->setClientIdentifierSharedKey(clientSecret);
    oauth2->setScope("email profile");
    
    oauth2->setReplyHandler(replyHandler);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
            &QDesktopServices::openUrl);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::granted, this, [this]() {
        // Get user info after successful authentication
        QUrl userInfoUrl("https://www.googleapis.com/oauth2/v2/userinfo");
        auto reply = oauth2->get(userInfoUrl);

        connect(reply, &QNetworkReply::finished, this, [reply, this]() {
            if (reply->error() != QNetworkReply::NoError) {
                emit loginFailed(reply->errorString());
                return;
            }

            const auto data = reply->readAll();
            const auto document = QJsonDocument::fromJson(data);
            const auto object = document.object();

            const auto email = object["email"].toString();
            const auto name = object["name"].toString();

            // Use token for authorized requests:
            // your_api_caller.setBearerToken(m_oauth.token().toLatin1());

            emit loginSucceeded(email, name);
            reply->deleteLater();
        });
    });

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::error, this,
            [this](const QString &error, const QString &errorDescription) {
        emit loginFailed(errorDescription.isEmpty() ? error : errorDescription);
    });
}

void GoogleAuth::startLogin()
{
    oauth2->grant();
} 
