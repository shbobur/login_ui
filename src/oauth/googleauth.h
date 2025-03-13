#ifndef GOOGLEAUTH_H
#define GOOGLEAUTH_H

#include "oauthbase.h"

class GoogleAuth : public OAuthBase
{
    Q_OBJECT

public:
    explicit GoogleAuth(QObject *parent = nullptr);

protected:
    void setupProvider() override;
    QUrl userInfoEndpoint() const override;
    QString extractId(const QJsonObject &object) const override;
    QString extractName(const QJsonObject &object) const override;
    QString getCallbackHtml() const override;

private:
    const QString clientId = "your_google_app_id";
    const QString clientSecret = "your_client_secret";
    const QUrl authEndpoint{"https://accounts.google.com/o/oauth2/v2/auth"};
    const QUrl tokenEndpoint{"https://oauth2.googleapis.com/token"};
};

#endif // GOOGLEAUTH_H 
