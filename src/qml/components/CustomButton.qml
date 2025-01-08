import QtQuick
import QtQuick.Controls
import "../styles" as Styles

Button {
    id: control

    height: 45

    background: Rectangle {
        radius: Styles.DefaultStyle.borderRadius  // Use the namespace
        color: control.pressed ? Styles.DefaultStyle.accentColor : Styles.DefaultStyle.primaryColor
        opacity: enabled ? 1 : 0.3

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
