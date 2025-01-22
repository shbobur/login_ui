import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import "../styles"

Item {
    id: control
    
    // Customizable properties
    property string provider: ""
    property string icon
    property string mainText
    property string secondaryText
    property string backgroundColor: "#666666"  // Default fallback color
    property string textColor: "#ffffff"        // Default fallback color
    
    property bool pressed: mouseArea.pressed
    
    signal clicked()

    // Use custom values or fallback to first letter/rest
    // readonly property string effectiveMainText: mainText || provider[0]
    // readonly property string effectiveSecondaryText: secondaryText || provider.substring(1)
    // readonly property string effectiveColor: backgroundColor
    // readonly property string effectiveTextColor: textColor

    // Make the Item respect Layout properties
    implicitWidth: Layout.preferredWidth
    implicitHeight: Layout.preferredHeight || 40 // Default height if not set
    Layout.fillWidth: true
    Layout.fillHeight: true

    Rectangle {
        id: background
        anchors.fill: parent
        radius: StyleSystem.current().borderRadius

        // Background color
        color: control.pressed ? Qt.darker(control.backgroundColor, 1.1) : control.backgroundColor

        // Focus border
        border.color: control.activeFocus ? StyleSystem.current().borderColor : "transparent"
        border.width: control.activeFocus ? StyleSystem.current().borderWidth : 0

        // Neumorphic effect
        layer.enabled: StyleSystem.currentStyle === "neumorphic"
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: StyleSystem.current().lightShadow
            shadowHorizontalOffset: -5
            shadowVerticalOffset: -5
            shadowScale: 0.5
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
            }
        }

        // Content
        RowLayout {
            anchors.centerIn: parent
            spacing: 2

            // Icon (if provided)
            Image {
                visible: control.icon !== ""
                source: control.icon
                sourceSize.width: 20
                sourceSize.height: 20
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
            }

            // Main text
            Text {
                visible: control.mainText !== ""
                text: control.mainText
                font {
                    family: StyleSystem.current().fontFamily
                    pixelSize: 16
                    bold: true
                }
                color: control.textColor ? control.textColor : StyleSystem.current().textColor
                opacity: 0.9
            }

            // Secondary text
            Text {
                visible: control.secondaryText !== ""
                text: control.secondaryText
                font {
                    family: StyleSystem.current().fontFamily
                    pixelSize: 14
                }
                color: control.textColor
                opacity: 0.7
            }
        }

        // Mouse area
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: control.clicked()
        }
    }

    // Keyboard handling
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            control.clicked()
        }
    }

    // Make it focusable
    activeFocusOnTab: true
    Accessible.role: Accessible.Button
    Accessible.name: "Continue with " + provider
    Accessible.onPressAction: control.clicked()
} 