#ifndef FACEBOOKAUTH_H
#define FACEBOOKAUTH_H

#include "oauthbase.h"

class FacebookAuth : public OAuthBase
{
    Q_OBJECT

public:
    explicit FacebookAuth(QObject *parent = nullptr);

protected:
    void setupProvider() override;
    QUrl userInfoEndpoint() const override;
    QString extractId(const QJsonObject &object) const override;
    QString extractName(const QJsonObject &object) const override;
    QUrlQuery userInfoParameters() const override;
    QString getCallbackHtml() const override;

private:
    const QString clientId = "";
    const QString clientSecret = "";
    const QUrl authEndpoint{"https://www.facebook.com/v22.0/dialog/oauth"};
    const QUrl tokenEndpoint{"https://graph.facebook.com/v22.0/oauth/access_token"};
};

#endif // FACEBOOKAUTH_H 