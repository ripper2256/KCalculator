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
import backend 1.0

ApplicationWindow {
    id: applicationWindow
    title: "KCalc"
    width: 640
    height: 480
    visible: true

    background: Rectangle {
        color: "#232629"
    }

    KCalculator {
            id: backend
    }

    function setScienceMode(vis) {
        scientific_buttons1.visible = vis;
        scientific_buttons2.visible = vis;
        angleMode.visible = vis;
        pbShift.visible = vis;
        pbBackspace.visible = vis;
        pbMemPlusMinus.visible = vis;
        pbMemClear.visible = vis;
        pbMemRecall.visible = vis;
        pbMemStore.visible = vis;
        sideLayout.columns = vis ? 2 : 1;
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
                        setScienceMode(false);
                    }
                }

                RadioButton {
                    text: qsTr("Science Mode")
                    onCheckedChanged: {
                        setScienceMode(true);
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
            label: backend.text_
        }

        RowLayout {
            id: angleMode
            visible: false
            spacing: 50

            RadioButton {
                checked: true
                id: degRadio
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
                id: radRadio
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
                text: qsTr("Grad")
                id: gradRadio

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

            ColumnLayout{
                id: scientific_buttons1
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
                id: scientific_buttons2
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
                KCalcButton {
                    label: "xʸ"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "x³"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "x-10ʸ"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }


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
                    onClicked: backend.slotDivisionclicked()
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "×"
                    onClicked: backend.slotMultiplicationclicked()
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "−"
                    onClicked: backend.slotMinusclicked()
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "7";
                    onClicked: backend.enterDigit(7)
                    Shortcut {
                        sequence: "7"
                        onActivated: backend.enterDigit(7)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "8";
                    onClicked: backend.enterDigit(8)
                    Shortcut {
                        sequence: "8"
                        onActivated: backend.enterDigit(8)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "9"
                    onClicked: backend.enterDigit(9)
                    Shortcut {
                        sequence: "9"
                        onActivated: backend.enterDigit(9)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "+"
                    onClicked: backend.slotPlusclicked();
                    Layout.rowSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "4"
                    onClicked: backend.enterDigit(4)
                    Shortcut {
                        sequence: "4"
                        onActivated: backend.enterDigit(4)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "5"
                    onClicked: backend.enterDigit(5)
                    Shortcut {
                        sequence: "5"
                        onActivated: backend.enterDigit(5)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "6"
                    onClicked: backend.enterDigit(6)
                    Shortcut {
                        sequence: "6"
                        onActivated: backend.enterDigit(6)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "1"
                    onClicked: backend.enterDigit(1)
                    Shortcut {
                        sequence: "1"
                        onActivated: backend.enterDigit(1)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "2"
                    onClicked: backend.enterDigit(2)
                    Shortcut {
                        sequence: "2"
                        onActivated: backend.enterDigit(2)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "3"
                    onClicked: backend.enterDigit(3)
                    Shortcut {
                        sequence: "3"
                        onActivated: backend.enterDigit(3)
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "="
                    onClicked: backend.slotEqualclicked()
                    Layout.rowSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "0"
                    onClicked: backend.enterDigit(0)
                    Shortcut {
                        sequence: "0"
                        onActivated: backend.enterDigit(0)
                    }
                    Layout.columnSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "."
                    onClicked: backend.slotPeriodclicked()
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

            }

            GridLayout {
                id: sideLayout
                columns: 2
                rows: 5
                columnSpacing: 0
                rowSpacing: 0


                KCalcButton {
                    id: pbShift
                    Layout.columnSpan: 2
                    label: "Shift"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "C"
                    onClicked: backend.slotClearclicked();
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbBackspace
                    label: "←"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "AC"
                    onClicked: backend.slotAllClearclicked();
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbMemStore
                    label: "MS"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "("
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbMemClear
                    label: "MC"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: ")"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbMemRecall
                    label: "MR"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbPlusMinus
                    label: "+/-"
                    onClicked: backend.slotPlusMinusclicked()
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    id: pbMemPlusMinus
                    label: "M+"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }


            }


        }
    }
}
