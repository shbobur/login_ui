pragma Singleton
import QtQuick

QtObject {
    // Can be: "modern", "neumorphic", "glassmorphic", "material", "gaming"
    property string currentStyle: "modern"

    property var styles: ({
        "modern": {
            primaryColor: "#2196F3",
            accentColor: "#1976D2",
            backgroundColor: "#FFFFFF",
            inputBackgroundColor: "#F5F5F5",
            textColor: "#333333",
            surfaceColor: "#F5F5F5",
            borderRadius: 8,
            shadowColor: "#20000000",
            blurRadius: 10,
            borderWidth: 2,
            borderColor: "#c58c22",
            elevation: 2,
            fontFamily: "Roboto",
            glowColor: "#00FF6666"
        },
        "neumorphic": {
            primaryColor: "#E0E5EC",
            accentColor: "#4B70E2",
            backgroundColor: "#adccf7",
            textColor: "#1A1B1F",
            surfaceColor: "#E0E5EC",
            borderRadius: 15,
            shadowColor: "#A3B1C6",
            lightShadow: "#FFFFFF",
            elevation: 5,
            fontFamily: "Poppins",
            blurRadius: 10,
            borderWidth: 1,
            borderColor: "#2e3941", 
            glowColor: "#00FF6666"
        },
        "glassmorphic": {
            primaryColor: "#FFFFFF80",
            accentColor: "#3498db",
            backgroundColor: "#FFFFFF10",
            textColor: "#ee8989",
            surfaceColor: "#FFFFFF20",
            borderRadius: 20,
            shadowColor: "#00000020",
            blurRadius: 10,
            borderWidth: 1,
            borderColor: "#a8a81e",
            fontFamily: "Inter",
            glowColor: "#00FF6666"
        },
        "material": {
            primaryColor: "#6200EE",
            accentColor: "#03DAC6",
            backgroundColor: "#FFFFFF",
            textColor: "#000000",
            surfaceColor: "#c4cdf7",
            borderRadius: 4,
            shadowColor: "#00000088",
            elevation: 3,
            fontFamily: "Roboto",
            blurRadius: 10,
            borderWidth: 1,
            borderColor: "#aeecd8",
            glowColor: "#00FF6666"
        },
        "gaming": {
            primaryColor: "#FF0055",
            accentColor: "#00FF66",
            backgroundColor: "#0A0A0A",
            textColor: "#FFFFFF",
            surfaceColor: "#1A1A1A",
            borderRadius: 0,
            shadowColor: "#FF005566",
            glowColor: "#00FF6666",
            fontFamily: "Share Tech Mono",
            blurRadius: 10,
            borderWidth: 1,
            borderColor: "#FFFFFF30",
            glowColor: "#00FF6666"
        }
    })

    function current() {
        return styles[currentStyle]
    }

    function switchStyle(styleName) {
        if (styles[styleName]) {
            currentStyle = styleName
        }
    }
}
