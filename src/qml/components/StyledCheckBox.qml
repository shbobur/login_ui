import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../styles"

CheckBox {
    id: control
    
    font.family: StyleSystem.current().fontFamily
    focusPolicy: Qt.StrongFocus
    leftPadding: 2
    topPadding: 5
    bottomPadding: 5
    implicitHeight: 24

    background: Rectangle {
        // implicitWidth: control.width
        // implicitHeight: control.height
        color: "transparent"
        border.color: control.focus ? StyleSystem.current().borderColor : "transparent"
        border.width: control.focus ? StyleSystem.current().borderWidth : 0
        radius: StyleSystem.current().borderRadius
        
        // Add padding for focus border
        anchors {
            fill: parent
            topMargin: -3
            bottomMargin: -3
            leftMargin: -3
            rightMargin: -3
        }
        
        // Glassmorphic effect
        Rectangle {
            visible: StyleSystem.currentStyle === "glassmorphic" && control.focus
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
            }
        }
    }

    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: StyleSystem.current().borderRadius / 2

        color: StyleSystem.currentStyle === "neumorphic" ? 
            Qt.lighter(StyleSystem.current().backgroundColor, 1.1) : 
            StyleSystem.current().surfaceColor

        border.color: control.focus ? StyleSystem.current().borderColor : "transparent"
        border.width: 1

        // Neumorphic effect
        layer.enabled: StyleSystem.currentStyle === "neumorphic"
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: StyleSystem.current().lightShadow
            shadowHorizontalOffset: -2
            shadowVerticalOffset: -2
            shadowScale: 0.3
        }

        Rectangle {
            width: 12
            height: 12
            anchors.centerIn: parent
            radius: StyleSystem.current().borderRadius / 2
            color: StyleSystem.current().borderColor
            visible: control.checked
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: StyleSystem.current().textColor
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
} 
