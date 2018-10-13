import QtQuick 2.0
import QtQuick.Controls 2.4

Button {
    id: calc_button
    implicitHeight: 70
    implicitWidth: 70
    property string label

    Text {
        text: label
        color: parent.pressed ? "#fdbc4b" : "#fcfcfc"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: 40
    }

    background: Rectangle {
        border.color: "#3daee9"
        border.width: 1
        color: "#232629"
    }
}


