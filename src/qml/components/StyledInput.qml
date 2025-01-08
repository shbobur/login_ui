import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import "../styles"

TextField {
    id: control

    property bool isPassword: false

    height: 40
    font.family: StyleSystem.current().fontFamily

    background: Rectangle {
        id: bgRect
        radius: StyleSystem.current().borderRadius
        color: StyleSystem.currentStyle === "neumorphic" ? StyleSystem.current().backgroundColor :
               (control.enabled ? (control.focus ? Qt.lighter(StyleSystem.current().surfaceColor, 1.1) :
               StyleSystem.current().surfaceColor) : Qt.darker(StyleSystem.current().surfaceColor, 1.1))

        // Neumorphic effect
        layer.enabled: StyleSystem.currentStyle === "neumorphic"
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: StyleSystem.current().lightShadow
            shadowHorizontalOffset: -5
            shadowVerticalOffset: -5
            // shadowSpread: 0.5
        }

        // Glassmorphic effect
        Rectangle {
            visible: StyleSystem.currentStyle === "glassmorphic"
            anchors.fill: parent
            radius: parent.radius
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
