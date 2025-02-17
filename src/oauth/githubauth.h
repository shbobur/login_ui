#ifndef GITHUBAUTH_H
#define GITHUBAUTH_H

#include <QObject>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QDesktopServices>

class GithubAuth : public QObject
{
    Q_OBJECT

public:
    explicit GithubAuth(QObject *parent = nullptr);
    ~GithubAuth();
    Q_INVOKABLE void startLogin();

signals:
    void loginSucceeded(const QString &username, const QString &name);
    void loginFailed(const QString &error);

private:
    void setupOAuth2();
    
    QOAuth2AuthorizationCodeFlow *oauth2;
    QOAuthHttpServerReplyHandler *replyHandler;
    // Replace these with your GitHub OAuth App credentials
    const QString clientId = "your-github-client-id";
    const QString clientSecret = "your-github-client-secret";
    const QUrl authEndpoint{"https://github.com/login/oauth/authorize"};
    const QUrl tokenEndpoint{"https://github.com/login/oauth/access_token"};
};

#endif // GITHUBAUTH_H 