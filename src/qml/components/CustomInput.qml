import QtQuick
import QtQuick.Controls
import "../styles" as Styles

TextField {
    id: control

    property bool isPassword: false
    property string floatingLabel: placeholderText  // Store original placeholder

    height: 56  // Increased height to accommodate floating label

    // Clear default placeholder when using floating label
    placeholderText: ""

    background: Rectangle {
        id: backgroundRect
        radius: 8
        color: control.enabled ? (control.focus ? "#F5F5F5" : "white") : "#F0F0F0"
        border.color: control.focus ? Styles.DefaultStyle.primaryColor : "#E0E0E0"
        border.width: 1

        // Floating label
        Text {
            id: floatingText
            text: control.floatingLabel
            color: control.focus ? Styles.DefaultStyle.primaryColor : "#666666"
            font.pixelSize: control.focus || control.text ? 12 : 14

            // Positioning and anchors
            anchors {
                left: parent.left
                leftMargin: 16
                top: parent.top
                topMargin: control.focus || control.text ? 8 : 18
            }

            // Animations for size and position
            Behavior on font.pixelSize {
                NumberAnimation { duration: 200 }
            }
            Behavior on anchors.topMargin {
                NumberAnimation { duration: 200 }
            }
        }
    }

    // Main text
    color: Styles.DefaultStyle.textColor
    font.pixelSize: 14
    leftPadding: 16
    rightPadding: 16
    topPadding: 24  // Increased to accommodate floating label

    // Password mode
    echoMode: isPassword ? TextInput.Password : TextInput.Normal
}
