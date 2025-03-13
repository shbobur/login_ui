import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "styles"
import com.login_app.oauth 1.0
import QtQuick.Dialogs

ApplicationWindow {
    id: window
    visible: true
    width: 420
    height: 720
    title: "Login"

    readonly property var ssoConfig: ({
        "Google": {
            mainText: "G",
            secondaryText: "oogle",
            color: "#f87e7e",
            textColor: StyleSystem.current().currentStyle != "glassmorphic" ? "#ffffff" : StyleSystem.current().textColor
        },
        "Github": {
            mainText: "Git",
            secondaryText: "",
            color: "#24292e",
            textColor: "#ffffff"
        },
        "Facebook": {
            mainText: "F",
            secondaryText: "acebook",
            color: "#3a86e9",
            textColor: "#ffffff"
        },
        "X": {
            mainText: "X",
            secondaryText: "",
            color: "#4eb3f1",
            textColor: StyleSystem.current().textColor
        }
    })

    function switchStyle(styleName) {
        StyleSystem.switchStyle(styleName)
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&Styles")
            ActionGroup { 
                id: styleGroup 
                exclusive: true
            }
            Action { 
                text: qsTr("&Modern"); 
                onTriggered: window.switchStyle("modern")
                checkable: true
                checked: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("&Neumorphic"); 
                onTriggered: window.switchStyle("neumorphic")
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("G&lassmorphic"); 
                onTriggered: window.switchStyle("glassmorphic")
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("M&aterial"); 
                onTriggered: window.switchStyle("material")
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("&Gaming"); 
                onTriggered: window.switchStyle("gaming")
                checkable: true
                ActionGroup.group: styleGroup
            }
            MenuSeparator { }
            Action { 
                text: qsTr("&Quit"); 
                onTriggered: Qt.quit() 
                checkable: false
            }
        }       
    }
    
    Rectangle {
        anchors.fill: parent

        color: StyleSystem.current().backgroundColor
        
        ColumnLayout {
            anchors.centerIn: parent
            width: Math.min(parent.width * 0.8, 320)
            spacing: 15
            
            Item { // Top spacer
                Layout.fillHeight: true
                Layout.preferredHeight: 20
            }
            
            Image {
                Layout.alignment: Qt.AlignHCenter
                source: "qrc:/assets/images/logo.png"
                Layout.preferredWidth: 140
                Layout.preferredHeight: 140
            }
            
            Item { // Bottom spacer
                Layout.fillHeight: true
                Layout.preferredHeight: 20
            }
            
            Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Welcome!"
                font.pixelSize: 24
                font.bold: true
                font.family: StyleSystem.current().fontFamily
                color: StyleSystem.current().textColor
            }
            
            StyledInput {
                id: emailInput
                Layout.fillWidth: true
                placeholderText: "Email or Username"
            }

            StyledInput {
                id: passwordInput
                Layout.fillWidth: true
                placeholderText: "Password"
                isPassword: true
            }
            
            StyledCheckBox {
                id: rememberMeCheckbox
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Keep me logged in")
                checked: false
            }
            
            StyledButton {
                Layout.fillWidth: true
                text: "Log In"
                font.bold: true
            }

            // Divider
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: StyleSystem.current().textColor
                    opacity: 0.2
                }

                Text {
                    text: "or continue with"
                    font.family: StyleSystem.current().fontFamily
                    color: StyleSystem.current().textColor
                    opacity: 0.6
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: StyleSystem.current().textColor
                    opacity: 0.2
                }
            }

            // SSO Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Layout.preferredHeight: 40

                SSOButton {
                    Layout.fillWidth: true
                    provider: "Google"
                    mainText: window.ssoConfig.Google.mainText
                    secondaryText: window.ssoConfig.Google.secondaryText
                    backgroundColor: window.ssoConfig.Google.color
                    textColor: window.ssoConfig.Google.textColor
                    onClicked: googleAuth.startLogin()
                }

                SSOButton {
                    Layout.fillWidth: true
                    provider: "Github"
                    mainText: window.ssoConfig.Github.mainText
                    secondaryText: window.ssoConfig.Github.secondaryText
                    backgroundColor: window.ssoConfig.Github.color
                    textColor: window.ssoConfig.Github.textColor
                    onClicked: githubAuth.startLogin()
                }

                SSOButton {
                    Layout.fillWidth: true
                    provider: "Facebook"
                    mainText: window.ssoConfig.Facebook.mainText
                    secondaryText: window.ssoConfig.Facebook.secondaryText
                    backgroundColor: window.ssoConfig.Facebook.color
                    textColor: window.ssoConfig.Facebook.textColor
                    onClicked: facebookAuth.startLogin()
                }

                SSOButton {
                    Layout.fillWidth: true
                    provider: "X"
                    mainText: window.ssoConfig.X.mainText
                    secondaryText: window.ssoConfig.X.secondaryText
                    backgroundColor: window.ssoConfig.X.color
                    textColor: window.ssoConfig.X.textColor
                    onClicked: console.log("X SSO clicked")
                }
            }

            // Completely custom
            // SSOButton {
            //     Layout.fillWidth: true
            //     mainText: "Dev"
            //     secondaryText: "to"
            //     backgroundColor: "#333333"
            //     // icon: "qrc:/assets/images/devto.png"
            //     onClicked: console.log("Custom SSO clicked")
            // }
        }
    }

    // Remove the old dialog definitions and add these:
    LoginDialog {
        id: successDialog
        isError: false
    }

    LoginDialog {
        id: errorDialog
        isError: true
    }

    GoogleAuth {
        id: googleAuth
        onLoginSucceeded: function(email, name) {
            console.log("Login succeeded for:", email, name)
            successDialog.message = "Welcome " + name + "!\nLogged in with: " + email
            successDialog.open()
        }
        onLoginFailed: function(error) {
            console.log("Login failed:", error)
            errorDialog.message = "Login failed: " + error
            errorDialog.open()
        }
    }

    // Add GithubAuth handler after GoogleAuth
    GithubAuth {
        id: githubAuth
        onLoginSucceeded: function(username, name) {
            console.log("Github login succeeded for:", username, name)
            successDialog.message = "Welcome " + name + "!\nLogged in with Github as: " + username
            successDialog.open()
        }
        onLoginFailed: function(error) {
            console.log("Github login failed:", error)
            errorDialog.message = "Github login failed: " + error
            errorDialog.open()
        }
    }

    FacebookAuth {
        id: facebookAuth
        onLoginSucceeded: function(email, name) {
            console.log("Facebook login succeeded for:", email, name)
            successDialog.message = "Welcome " + name + "!\nLogged in with: " + email
            successDialog.open()
        }
        onLoginFailed: function(error) {
            console.log("Facebook login failed:", error)
            errorDialog.message = "Facebook login failed: " + error
            errorDialog.open()
        }
    }
}
