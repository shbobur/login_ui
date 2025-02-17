#ifndef GOOGLEAUTH_H
#define GOOGLEAUTH_H

#include <QObject>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QDesktopServices>

class GoogleAuth : public QObject
{
    Q_OBJECT

public:
    explicit GoogleAuth(QObject *parent = nullptr);
    ~GoogleAuth();
    Q_INVOKABLE void startLogin();

signals:
    void loginSucceeded(const QString &email, const QString &name);
    void loginFailed(const QString &error);

private:
    void setupOAuth2();
    
    QOAuth2AuthorizationCodeFlow *oauth2;
    QOAuthHttpServerReplyHandler *replyHandler;
    const QString clientId = "your_client_id";
    const QString clientSecret = "your_client_secret";
    const QUrl authEndpoint{"https://accounts.google.com/o/oauth2/v2/auth"};
    const QUrl tokenEndpoint{"https://oauth2.googleapis.com/token"};
};

#endif // GOOGLEAUTH_H 
