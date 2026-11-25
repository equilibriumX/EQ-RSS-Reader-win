/***************************************************************************
 *   EQ-RSS Reader - centralized visual style                              *
 *   Appearance only: no application or RSS logic.                         *
 ***************************************************************************/

import QtQuick

QtObject {
    id: style

    // Used only to detect the active Windows/Qt color scheme.
    property color systemWindowColor: "#FFFFFF"
    property color systemWindowTextColor: "#202020"

    readonly property real systemLuminance:
        systemWindowColor.r * 0.2126 +
        systemWindowColor.g * 0.7152 +
        systemWindowColor.b * 0.0722

    readonly property bool darkMode: systemLuminance < 0.48

    // Main surfaces
    readonly property color windowBackground: darkMode ? "#152020" : "#E9ECEC"
    readonly property color panelBackground: darkMode ? "#1B2929" : "#F3F5F5"
    readonly property color cardBackground: darkMode ? "#223131" : "#FFFFFF"
    readonly property color raisedBackground: darkMode ? "#293A3A" : "#FFFFFF"

    // Text
    readonly property color text: darkMode ? "#F1F4F4" : "#172020"
    readonly property color secondaryText: darkMode ? "#B7C4C4" : "#596565"
    readonly property color mutedText: darkMode ? "#91A2A2" : "#6D7878"

    // Borders, separators and interaction states
    readonly property color border: darkMode ? "#354747" : "#D3DADA"
    readonly property color divider: darkMode ? "#304141" : "#D2DADA"
    readonly property color hoverBackground: darkMode ? "#2B3E3E" : "#E5EBEB"
    readonly property color selectedBackground: darkMode ? "#25465B" : "#DCECF8"
    readonly property color accent: darkMode ? "#78BDF2" : "#1769AA"
    readonly property color accentText: darkMode ? "#F1F8FC" : "#123B58"
    readonly property color inputUnderline: darkMode ? "#657B7B" : "#AAB7B7"
    readonly property color inputFocus: darkMode ? "#78BDF2" : "#1769AA"

    // Status colors
    readonly property color danger: "#D94A42"
    readonly property color success: darkMode ? "#80C99A" : "#287A45"

    // Article reader colors
    readonly property color readerBackground: darkMode ? "#152020" : "#FFFFFF"
    readonly property color readerText: darkMode ? "#EAF0F0" : "#202124"
    readonly property color readerLink: darkMode ? "#80C5FF" : "#0067C0"
    readonly property color readerSubtle: darkMode ? "#B0BDBD" : "#5F6368"
    readonly property color readerCodeBackground: darkMode ? "#223131" : "#F1F3F5"
}
