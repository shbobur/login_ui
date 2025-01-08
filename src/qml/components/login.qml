// main.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 600
    title: "Modern Login Template"
    
    // Theme management
    QtObject {
        id: theme
        property color primaryColor: "#2196F3"
        property color accentColor: "#1976D2"
        property color backgroundColor: "#FFFFFF"
        property color textColor: "#333333"
        property int borderRadius: 8
    }
    
    // Reusable styled input field component
    Component {
        id: styledTextField
        TextField {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            background: Rectangle {
                radius: theme.borderRadius
                color: parent.focused ? Qt.lighter(theme.backgroundColor) : theme.backgroundColor
                border.color: parent.focused ? theme.primaryColor : "#E0E0E0"
                border.width: 1
            }
            color: theme.textColor
            font.pixelSize: 14
            leftPadding: 16
            rightPadding: 16
        }
    }
    
    // Main content
    Rectangle {
        anchors.fill: parent
        color: "#F5F5F5"
        
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.8
            spacing: 20
            
            // Logo/Brand area
            Image {
                Layout.alignment: Qt.AlignHCenter
                source: "qrc:/assets/logo.png"
                width: 120
                height: 120
            }
            
            // Title
            Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Welcome Back"
                font.pixelSize: 24
                font.bold: true
                color: theme.textColor
            }
            
            // Input fields
            Loader {
                Layout.fillWidth: true
                sourceComponent: styledTextField
                onLoaded: {
                    item.placeholderText = "Email or Username"
                }
            }
            
            Loader {
                Layout.fillWidth: true
                sourceComponent: styledTextField
                onLoaded: {
                    item.placeholderText = "Password"
                    item.echoMode = TextInput.Password
                }
            }
            
            // Remember me & Forgot password
            RowLayout {
                Layout.fillWidth: true
                CheckBox {
                    text: "Remember me"
                    font.pixelSize: 12
                }
                Item { Layout.fillWidth: true }
                Label {
                    text: "Forgot Password?"
                    font.pixelSize: 12
                    color: theme.primaryColor
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Handle forgot password
                        }
                    }
                }
            }
            
            // Login button
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                text: "Log In"
                font.bold: true
                
                background: Rectangle {
                    radius: theme.borderRadius
                    color: parent.pressed ? theme.accentColor : theme.primaryColor
                    
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 8.0
                        samples: 17
                        color: "#20000000"
                    }
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            // Social login options
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                
                Repeater {
                    model: ["google", "facebook", "apple"]
                    delegate: Image {
                        source: "qrc:/assets/" + modelData + ".png"
                        width: 24
                        height: 24
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                // Handle social login
                            }
                        }
                    }
                }
            }
            
            // Sign up link
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4
                Label {
                    text: "Don't have an account?"
                    font.pixelSize: 12
                }
                Label {
                    text: "Sign Up"
                    font.pixelSize: 12
                    color: theme.primaryColor
                    font.bold: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Handle sign up
                        }
                    }
                }
            }
        }
    }
}