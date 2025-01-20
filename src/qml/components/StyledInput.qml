import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import "../styles"
import QtQuick.Controls.Material

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
            color: StyleSystem.currentStyle === "neumorphic" ? Qt.lighter(StyleSystem.current().backgroundColor, 1.1) :
                   (control.enabled ? (control.focus ? Qt.darker(StyleSystem.current().surfaceColor, 1.1) :
                   StyleSystem.current().surfaceColor) : Qt.darker(StyleSystem.current().surfaceColor, 1.05))
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

        TextMetrics {
                id: placeholderMetrics
                font: control.font
                text: control.placeholderText
            }

        // Placeholder label background
        Rectangle {
            visible: control.focus || control.text.length !== 0
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: -height / 2
            anchors.leftMargin: 10
            width: placeholderMetrics.width
            height: placeholderMetrics.height * 0.8
            color: StyleSystem.current().backgroundColor
            radius: 10
            border.width: borderRect.border.width
            border.color: borderRect.border.color
        }


    }

    color: StyleSystem.current().textColor
    placeholderTextColor: Qt.darker(StyleSystem.current().textColor, 1.5)

    rightPadding: isPassword ? visibilityButton.width + 8 : 8

    // Add after the existing background Item
    // ToDo: 
        // Add a glow effect to the button, 
        // Make button border visible when focused, 

    ToolButton {
        id: visibilityButton
        visible: parent.isPassword && control.text.length > 0
        width: innerRect.height * 0.8
        height: innerRect.height * 0.8
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 4
        }
        
        contentItem: Image {
            source: control.echoMode === TextInput.Normal 
                ? "qrc:/assets/images/eye-off.png"
                : "qrc:/assets/images/eye.png"
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            opacity: visibilityButton.enabled ? 1.0 : 0.5
            layer.enabled: true

            layer.effect: MultiEffect {
                colorization: 0.9
                colorizationColor: Qt.rgba( StyleSystem.current().textColor.r, StyleSystem.current().textColor.g, StyleSystem.current().textColor.b, 1.0)
            }
        }
        
        background: Rectangle {
            color: "transparent"
        }
        
        onPressed: {
            control.echoMode = TextInput.Normal 
        }
        onReleased: {
            control.echoMode = TextInput.Password
        }
    }

    echoMode: isPassword ? TextInput.Password : TextInput.Normal
}
