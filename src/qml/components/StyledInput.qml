import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import "../styles"

TextField {
    id: control

    property bool isPassword: false

    height: 40
    font.family: StyleSystem.current().fontFamily

    background: Item {
        // Bottom rectangle (border)
        Rectangle {
            id: borderRect
            anchors.fill: parent
            radius: StyleSystem.current().borderRadius
            color: StyleSystem.currentStyle === "neumorphic" ? StyleSystem.current().backgroundColor :
                   (control.enabled ? (control.focus ? Qt.lighter(StyleSystem.current().surfaceColor, 1.1) :
                   StyleSystem.current().surfaceColor) : Qt.darker(StyleSystem.current().surfaceColor, 1.1))
            border.color: control.focus ? StyleSystem.current().borderColor : "transparent"
            border.width: control.focus ? StyleSystem.current().borderWidth : 0

            // Existing neumorphic effect
            layer.enabled: StyleSystem.currentStyle === "neumorphic"
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: StyleSystem.current().lightShadow
                shadowHorizontalOffset: -5
                shadowVerticalOffset: -5
                shadowScale: 0.5
            }

            TextMetrics {
                id: placeholderMetrics
                font: control.font
                text: control.placeholderText
            }

            // Placeholder label background
            Rectangle {
                visible: control.focus
                anchors.top: parent.top
                anchors.left: parent.left
                // anchors.topMargin: 10
                anchors.leftMargin: 10
                // width: borderRect.width / 2
                width: placeholderMetrics.width
                height: 5
                color: StyleSystem.current().backgroundColor
            }
        }

        // Top rectangle (inner)
        Rectangle {
            id: innerRect
            anchors {
                fill: parent
                topMargin: control.focus ? StyleSystem.current().borderWidth : 0
                leftMargin: control.focus ? StyleSystem.current().borderWidth : 0
                rightMargin: control.focus ? StyleSystem.current().borderWidth : 0
                bottomMargin: control.focus ? StyleSystem.current().borderWidth : 0
            }
            radius: StyleSystem.current().borderRadius - (control.focus ? StyleSystem.current().borderWidth : 0)
            color: borderRect.color
        }

        // Existing glassmorphic effect
        Rectangle {
            visible: StyleSystem.currentStyle === "glassmorphic"
            anchors.fill: parent
            // radius: parent.  
            color: "transparent"
            border.width: StyleSystem.current().borderWidth
            border.color: StyleSystem.current().borderColor

            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: StyleSystem.current().blurRadius
                blurMax: 32
                autoPaddingEnabled: true
            }
        }
    }

    color: StyleSystem.current().textColor
    placeholderTextColor: Qt.darker(StyleSystem.current().textColor, 1.5)

    echoMode: isPassword ? TextInput.Password : TextInput.Normal
}
