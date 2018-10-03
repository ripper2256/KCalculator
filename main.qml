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
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.11

ApplicationWindow {
    id: applicationWindow
    title: "KCalc"
    width: 640
    height: 480
    visible: true
    background: Rectangle {
        color: "#232629"
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            Action { text: qsTr("&New...") }
            Action { text: qsTr("&Open...") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("Save &As...") }
            MenuSeparator { }
            Action { text: qsTr("&Quit") }
        }
        Menu {
            title: qsTr("&Edit")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Constants")
            Action { text: qsTr("Mathematics") }
            Action { text: qsTr("Electro") }
            Action { text: qsTr("Gravitation") }
        }
        Menu {
            title: qsTr("&Settings")

            ButtonGroup {
                buttons: column.children
            }

            Column {
                id: column

                RadioButton {
                    checked: true
                    text: qsTr("Simple Mode")
                    onCheckedChanged: {
                        foo.visible = false;
                        bar.visible = false;
                        science.visible = false;
                        bla.visible = false;
                    }
                }

                RadioButton {
                    text: qsTr("Science Mode")
                    onCheckedChanged: {
                        foo.visible = true;
                        bar.visible = true;
                        science.visible = true;
                        bla.visible = true;
                    }
                }
            }

        }
    }


    ColumnLayout{
        anchors.fill: parent
        DisplayTest {
            id: display
            Layout.fillWidth: true
        }

        RowLayout {
            id: bla
            visible: false
            spacing: 50
            RadioButton {
                checked: true
                text: qsTr("Deg")
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color: parent.down ? "#fdbc4b" : "#fcfcfc"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: parent.indicator.width + parent.spacing
                }
            }

            RadioButton {
                id: radioButton
                text: qsTr("Rad")
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color: parent.down ? "#fdbc4b" : "#fcfcfc"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: parent.indicator.width + parent.spacing
                }
            }

            RadioButton {
                text: "Grad"


                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color: parent.down ? "#fdbc4b" : "#fcfcfc"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: parent.indicator.width + parent.spacing
                }

            }
        }


        GridLayout{
            columns: 5
            columnSpacing: 20
            id: grid

            ColumnLayout{
                id: foo
                visible: false
                spacing: 0

                KCalcButton { label: "Hyp"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "Sin"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "Cos"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "Tan"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "Log"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "Ln"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}

            }


            ColumnLayout {
                id: bar
                visible: false
                spacing: 0

                KCalcButton { label: "Mod"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "1/x"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "x!"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "x²"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "xʸ"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "x³"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "EXP"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}

            }


            GridLayout {
                columns: 4
                rows: 5
                columnSpacing: 0
                rowSpacing: 0
                id: main

                KCalcButton {
                    label: "%"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "÷"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "×"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "−"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "7";
                    onClicked: display.label += "7"
                    Shortcut {
                        sequence: "7"
                        onActivated: display.label += "7"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "8";
                    onClicked: display.label += "8"
                    Shortcut {
                        sequence: "8"
                        onActivated: display.label += "8"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "9"
                    onClicked: display.label += "9"
                    Shortcut {
                        sequence: "9"
                        onActivated: display.label += "9"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "+"
                    Layout.rowSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "4"
                    onClicked: display.label += "4"
                    Shortcut {
                        sequence: "4"
                        onActivated: display.label += "4"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "5"
                    onClicked: display.label += "5"
                    Shortcut {
                        sequence: "5"
                        onActivated: display.label += "5"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "6"
                    onClicked: display.label += "6"
                    Shortcut {
                        sequence: "6"
                        onActivated: display.label += "6"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "1"
                    onClicked: display.label += "1"
                    Shortcut {
                        sequence: "1"
                        onActivated: display.label += "1"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "2"
                    onClicked: display.label += "2"
                    Shortcut {
                        sequence: "2"
                        onActivated: display.label += "2"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "3"
                    onClicked: display.label += "3"
                    Shortcut {
                        sequence: "3"
                        onActivated: display.label += "3"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "="
                    Layout.rowSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "0"
                    onClicked: display.label += "0"
                    Shortcut {
                        sequence: "0"
                        onActivated: display.label += "0"
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "."
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                /*KCalcButton {
                    label: "√"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }*/

                KCalcButton {
                    label: "C"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

            }

            ColumnLayout {
                spacing: 0
                id: science
                visible: false

                KCalcButton { label: "Shift"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton { label: "C"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "←"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "AC"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
            }


        }
    }
}
