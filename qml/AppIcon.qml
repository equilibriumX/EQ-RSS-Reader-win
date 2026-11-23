import QtQuick

Item {
    id: root
    property string source: "rss"
    property color color: "white"
    property int pixelSize: 20
    readonly property var glyphs: ({
        "rss": "\uE768", "view-list-details": "\uE8EF", "list-add": "\uE710",
        "document-open": "\uE8A5", "edit-clear": "\uE894", "view-refresh": "\uE72C",
        "media-playback-pause": "\uE769", "media-playback-start": "\uE768",
        "overflow-menu": "\uE712", "folder": "\uE8B7", "edit": "\uE70F",
        "globe": "\uE774", "open": "\uE8E5", "close": "\uE8BB",
        "go-next": "\uE72A"
    })
    Text {
        anchors.centerIn: parent
        text: root.glyphs[root.source] || "\uE753"
        color: root.color
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: root.pixelSize
    }
}
