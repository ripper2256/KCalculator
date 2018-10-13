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
