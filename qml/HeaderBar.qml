/***************************************************************************
 *   EQ-RSS Reader - application header                                    *
 *   Copyright 2026 by Barnak Zlatko <saradnja.barnak@gmail.com>           *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2

RowLayout {
    id: headerRoot
    SystemPalette { id: systemPalette }
    property var controller
    signal settingsRequested()

    readonly property int unreadCount: controller ? (controller.unreadNewArticlesCount !== undefined ? controller.unreadNewArticlesCount : (controller.root ? controller.root.unreadNewArticlesCount : 0)) : 0

    QQC2.Label {
        text: "EQ-RSS Reader"
        font.bold: true
        font.pointSize: 10 + 2
        Layout.fillWidth: true
    }

    // Indikator i labela za broj novih vesti u hederu
    RowLayout {
        spacing: 4
        visible: headerRoot.unreadCount > 0

        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: "#c42b1c"
            anchors.verticalCenter: parent.verticalCenter
        }

        QQC2.Label {
            text: qsTr("New:") + " " + headerRoot.unreadCount
            font.pointSize: 9
            color: "#c42b1c"
            font.bold: true
        }

        QQC2.ToolButton {
            icon.name: "edit-clear"
            onClicked: {
                if (controller && controller.clearNewArticlesCount) {
                    controller.clearNewArticlesCount()
                }
            }

            QQC2.ToolTip.visible: hovered
            QQC2.ToolTip.text: qsTr("Clear new articles count")
        }
    }

    QQC2.ToolButton {
        icon.name: "view-refresh"
        text: qsTr("Refresh")
        onClicked: {
            if (controller && controller.refreshAll) {
                controller.refreshAll()
            }
        }
    }
    QQC2.ToolButton {
        text: ""
        icon.name: controller.autoRefreshEnabled ? "media-playback-pause" : "media-playback-start"
        onClicked: controller.toggleAutoRefresh()

        QQC2.ToolTip.text: controller.autoRefreshEnabled
            ? qsTr("Stop automatic feed refresh")
            : qsTr("Start automatic feed refresh")
        QQC2.ToolTip.delay: 500
        QQC2.ToolTip.visible: hovered

        // Crvena tačka / indikator kada je pauzirano
        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: "#c42b1c" // ili slobodno stavi "red"
            visible: !controller.autoRefreshEnabled

            // Pozicioniramo je u gornji desni ugao dugmeta (ili prilagodi po želji)
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 4
        }
    }

    QQC2.ToolButton {
        id: additionalOptionsButton
        icon.name: "overflow-menu"
        text: qsTr("Additional Options")
        onClicked: additionalOptionsMenu.open()
    }

    QQC2.Menu {
        id: additionalOptionsMenu

        QQC2.MenuItem {
            text: qsTr("Settings")
            onTriggered: headerRoot.settingsRequested()
        }
        QQC2.MenuItem {
            text: qsTr("Full Refresh")
            icon.name: "view-refresh"
            onTriggered: {
                if (controller && controller.fullRefreshAll) {
                    controller.fullRefreshAll()
                }
            }
        }
    }
}
