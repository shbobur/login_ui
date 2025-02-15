import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "../styles"

Dialog {
    id: root
    modal: true
    anchors.centerIn: parent

    required property bool isError
    property alias message: messageLabel.text

    background: Rectangle {
        color: StyleSystem.current().backgroundColor
        border.color: root.isError ? "#f44336" : StyleSystem.current().accentColor
        border.width: 1
        radius: 10
    }

    title: root.isError ? "Login Failed" : "Login Successful"

    ColumnLayout {
        spacing: 20
        
        Label {
            id: messageLabel
            text: root.isError ? "An error occurred during login." : "Welcome!"
            color: StyleSystem.current().textColor
            font.family: StyleSystem.current().fontFamily
            font.pixelSize: 16
            wrapMode: Text.WordWrap
            Layout.maximumWidth: 300
        }
        
        RowLayout {
            Layout.alignment: Qt.AlignRight
            
            StyledButton {
                text: root.isError ? "Close" : "OK"
                onClicked: root.close()
            }
        }
    }
} 