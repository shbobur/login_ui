#ifndef OAUTHBASE_H
#define OAUTHBASE_H

#include <QObject>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QDesktopServices>
#include <QUrlQuery>

class OAuthBase : public QObject
{
    Q_OBJECT

public:
    explicit OAuthBase(QObject *parent = nullptr);
    virtual ~OAuthBase();
    Q_INVOKABLE void startLogin();

signals:
    void loginSucceeded(const QString &id, const QString &name);
    void loginFailed(const QString &error);

protected:
    virtual void setupProvider() = 0;
    virtual QUrl userInfoEndpoint() const = 0;
    virtual QString extractId(const QJsonObject &object) const = 0;
    virtual QString extractName(const QJsonObject &object) const = 0;
    virtual QUrlQuery userInfoParameters() const;
    virtual QString getCallbackHtml() const;
    
    void setupOAuth2(const QUrl &authUrl, const QUrl &tokenUrl, 
                    const QString &clientId, const QString &clientSecret,
                    const QString &scope, int port);

    QOAuth2AuthorizationCodeFlow *oauth2;
    QOAuthHttpServerReplyHandler *replyHandler;
};

#endif // OAUTHBASE_H 