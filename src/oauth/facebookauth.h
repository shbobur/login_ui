#ifndef FACEBOOKAUTH_H
#define FACEBOOKAUTH_H

#include <QObject>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QDesktopServices>
#include <QFile>

class FacebookAuth : public QObject
{
    Q_OBJECT

public:
    explicit FacebookAuth(QObject *parent = nullptr);
    ~FacebookAuth();
    Q_INVOKABLE void startLogin();

signals:
    void loginSucceeded(const QString &userId, const QString &name);
    void loginFailed(const QString &error);

private:
    void setupOAuth2();
    void loadCredentials();
    
    QOAuth2AuthorizationCodeFlow *oauth2;
    QOAuthHttpServerReplyHandler *replyHandler;
    QString clientId = "";
    QString clientSecret = "";
    const QUrl authEndpoint{"https://www.facebook.com/v22.0/dialog/oauth"};
    const QUrl tokenEndpoint{"https://graph.facebook.com/v22.0/oauth/access_token"};
};

#endif // FACEBOOKAUTH_H 