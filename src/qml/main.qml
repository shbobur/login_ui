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

    // Style switcher component
    Rectangle {
        anchors {
            top: parent.top
            right: parent.right
            margins: 10
        }
        width: styleCombo.width + 20
        height: styleCombo.height + 10
        color: StyleSystem.current().surfaceColor
        radius: StyleSystem.current().borderRadius

        ComboBox {
            id: styleCombo
            anchors.centerIn: parent
            model: ["modern", "neumorphic", "glassmorphic", "material", "gaming"]
            currentIndex: model.indexOf(StyleSystem.currentStyle)
            onCurrentTextChanged: StyleSystem.switchStyle(currentText)
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
                Layout.preferredWidth: 140  // 30% of parent width
                Layout.preferredHeight: 140// Make it square
                fillMode: Image.PreserveAspectFit
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
