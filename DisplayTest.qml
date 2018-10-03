/*
Copyright 2018  Gilbert Assaf gassaf@gmx.de

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of
the License or (at your option) version 3 or any later version
accepted by the membership of KDE e.V. (or its successor approved
by the membership of KDE e.V.), which shall act as a proxy
defined in Section 14 of version 3 of the license.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.6
import QtQuick.Controls 2.4

Rectangle {
    id: displayTest
    implicitWidth: 500
    implicitHeight: 70
    color: "#232629"
    border.color: "#3daee9"
    border.width: 2
    radius: 10
    property string label
    property string angleMode: "Deg"
    property string numeralSystem: "Dec"

    Text {
        id: displayText
        text: label
        y: 30
        x: 30
        anchors.right: displayTest.right
        anchors.rightMargin: 17
        font.pointSize: 24;
        font.bold: true
        color: "#fcfcfc"
    }

    Text {
        id: numeralSystemText
        x: 50
        y: 5
        width: 23
        height: 19
        text: numeralSystem
        anchors.topMargin: 8
        font.pointSize: 8;
        color: "#fcfcfc"
    }

    Text {
        id: angleModeText
        width: 29
        height: 19
        text: angleMode
        anchors.topMargin: 5
        anchors.top: displayTest.top
        anchors.left: numeralSystemText.right
        anchors.leftMargin: 14
        font.pointSize: 8;
        color: "#fcfcfc"
    }

}
