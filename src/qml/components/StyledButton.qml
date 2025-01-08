import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import "../styles"

Button {
    id: control

    height: 45
    font.family: StyleSystem.current().fontFamily

    background: Rectangle {
        id: bgRect
        radius: StyleSystem.current().borderRadius
        color: control.pressed ? StyleSystem.current().accentColor : StyleSystem.current().primaryColor

        // Gaming style glow effect
        Rectangle {
            visible: StyleSystem.currentStyle === "gaming"
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.width: 2
            border.color: StyleSystem.current().glowColor

            layer.enabled: true
            layer.effect: MultiEffect {
                            shadowEnabled: true
                            shadowColor: StyleSystem.current().glowColor
                            shadowBlur: 1.0
                            blurEnabled: true
                            blur: 0.6
                            blurMax: 20
                            brightness: 0.5
                        }
        }

        // Neumorphic pressed state
        states: State {
            name: "pressed"
            when: control.pressed && StyleSystem.currentStyle === "neumorphic"
            PropertyChanges {
                target: bgRect
                scale: 0.98
            }
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: StyleSystem.currentStyle === "neumorphic" ? StyleSystem.current().accentColor : "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
