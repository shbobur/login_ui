#include "oauthbase.h"
#include <QtNetwork/QNetworkReply>
#include <QJsonObject>

OAuthBase::OAuthBase(QObject *parent)
    : QObject(parent)
    , oauth2(new QOAuth2AuthorizationCodeFlow(this))
{
}

OAuthBase::~OAuthBase()
{
}

void OAuthBase::setupOAuth2(const QUrl &authUrl, const QUrl &tokenUrl,
                          const QString &clientId, const QString &clientSecret,
                          const QString &scope, int port)
{
    replyHandler = new QOAuthHttpServerReplyHandler(port, this);
    replyHandler->setCallbackText(getCallbackHtml());

    oauth2->setAuthorizationUrl(authUrl);
    oauth2->setAccessTokenUrl(tokenUrl);
    oauth2->setClientIdentifier(clientId);
    oauth2->setClientIdentifierSharedKey(clientSecret);
    oauth2->setScope(scope);
    oauth2->setReplyHandler(replyHandler);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
            &QDesktopServices::openUrl);

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::granted, this, [this]() {
        auto url = userInfoEndpoint();
        auto query = userInfoParameters();
        if (!query.isEmpty()) {
            url.setQuery(query);
        }
        
        auto reply = oauth2->get(url);

        connect(reply, &QNetworkReply::finished, this, [reply, this]() {
            if (reply->error() != QNetworkReply::NoError) {
                emit loginFailed(reply->errorString());
                return;
            }

            const auto data = reply->readAll();
            const auto document = QJsonDocument::fromJson(data);
            const auto object = document.object();

            const auto id = extractId(object);
            const auto name = extractName(object);

            emit loginSucceeded(id, name);
            reply->deleteLater();
        });
    });

    connect(oauth2, &QOAuth2AuthorizationCodeFlow::error, this,
            [this](const QString &error, const QString &errorDescription) {
        emit loginFailed(errorDescription.isEmpty() ? error : errorDescription);
    });
}

QUrlQuery OAuthBase::userInfoParameters() const
{
    return QUrlQuery();
}

void OAuthBase::startLogin()
{
    oauth2->grant();
}

QString OAuthBase::getCallbackHtml() const
{
    return "<html><body><h1>Successfully logged in!</h1></body></html>";
} 
