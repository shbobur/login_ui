pragma Singleton
import QtQuick

QtObject {
    id: style

    readonly property color primaryColor: "#2196F3"
    readonly property color accentColor: "#1976D2"
    readonly property color backgroundColor: "#FFFFFF"
    readonly property color textColor: "#333333"
    readonly property int borderRadius: 8
    readonly property real defaultPadding: 16
    readonly property real defaultSpacing: 20
}
