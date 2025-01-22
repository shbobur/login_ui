import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "styles"

ApplicationWindow {
    id: window
    visible: true
    width: 420
    height: 640
    title: "Login"

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
                onTriggered: switchStyle("modern") 
                checkable: true
                checked: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("&Neumorphic"); 
                onTriggered: switchStyle("neumorphic") 
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("G&lassmorphic"); 
                onTriggered: switchStyle("glassmorphic") 
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("M&aterial"); 
                onTriggered: switchStyle("material") 
                checkable: true
                ActionGroup.group: styleGroup
            }
            Action { 
                text: qsTr("&Gaming"); 
                onTriggered: switchStyle("gaming") 
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
        }
    }

}
