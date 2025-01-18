import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "styles"

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 600
    title: "Login Portfolio"

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
            width: parent.width * 0.8
            spacing: 20
            
            Image {
                Layout.alignment: Qt.AlignHCenter
                source: "qrc:/assets/images/logo.png"
                Layout.preferredWidth: 140
                Layout.preferredHeight: 140
            }
            
            Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Welcome Back"
                font.pixelSize: 24
                font.bold: true
                font.family: StyleSystem.current().fontFamily
                color: StyleSystem.current().textColor
            }
            
            StyledInput {
                Layout.fillWidth: true
                placeholderText: "Email or Username"
            }
            
            StyledInput {
                Layout.fillWidth: true
                placeholderText: "Password"
                isPassword: true
            }
            
            StyledButton {
                Layout.fillWidth: true
                text: "Log In"
                font.bold: true
            }
        }
    }

}
