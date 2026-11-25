import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

QQC2.Dialog {
    id: dialog
    title: qsTr("Settings")
    modal: true
    standardButtons: QQC2.Dialog.Ok | QQC2.Dialog.Cancel
    property var settings
    property var appStyle
    width: 420
    onOpened: { refreshSpin.value = settings.refreshMinutes; widthSpin.value = settings.wideThreshold; startupCheck.checked = settings.startWithWindows }
    onAccepted: { settings.refreshMinutes = refreshSpin.value; settings.wideThreshold = widthSpin.value; settings.startWithWindows = startupCheck.checked }
    contentItem: ColumnLayout {
        spacing: 14
        QQC2.Label { text: qsTr("Refresh interval (minutes)") }
        QQC2.SpinBox { id: refreshSpin; from: 2; to: 1440; value: dialog.settings ? dialog.settings.refreshMinutes : 15 }
        QQC2.CheckBox { id: startupCheck; text: qsTr("Start EQ-RSS Reader with Windows"); checked: dialog.settings ? dialog.settings.startWithWindows : false }
        QQC2.Label { text: qsTr("Split reader threshold (pixels)") }
        QQC2.SpinBox { id: widthSpin; from: 560; to: 760; value: dialog.settings ? dialog.settings.wideThreshold : 700; stepSize: 20 }
    }
}
