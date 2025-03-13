#ifndef GITHUBAUTH_H
#define GITHUBAUTH_H

#include "oauthbase.h"

class GithubAuth : public OAuthBase
{
    Q_OBJECT

public:
    explicit GithubAuth(QObject *parent = nullptr);

protected:
    void setupProvider() override;
    QUrl userInfoEndpoint() const override;
    QString extractId(const QJsonObject &object) const override;
    QString extractName(const QJsonObject &object) const override;
    QString getCallbackHtml() const override;

private:
    const QString clientId = "your-github-client-id";
    const QString clientSecret = "your-github-client-secret";
    const QUrl authEndpoint{"https://github.com/login/oauth/authorize"};
    const QUrl tokenEndpoint{"https://github.com/login/oauth/access_token"};
};

#endif // GITHUBAUTH_H 