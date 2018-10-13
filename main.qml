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

        Row {
            id: bla
            visible: false

            RadioButton {
                checked: true
                text: qsTr("Deg")
            }

            RadioButton {
                text: qsTr("Rad")
            }

            RadioButton {
                text: qsTr("Grad")
            }
        }


        GridLayout{
            columns: 5
            columnSpacing: 0
            rowSpacing: 0

            Column{
                id: foo
                visible: false
                spacing: 16

                signal buttonPressed

                Button { text: "Hyp"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                Button { text: "Sin"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                Button { text: "Cos"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                Button { text: "Tan"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                Button { text: "Log"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                Button { text: "Ln"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}

            }

            Column {
                id: bar
                visible: false
                spacing: 16

                signal buttonPressed

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
                //anchors.fill: parent

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

                KCalcButton {
                    label: "−"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                KCalcButton {
                    label: "√"
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
                    label: "C"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                KCalcButton {
                    label: "="
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }



            GridLayout {
                columns: 2
                columnSpacing: 0
                rowSpacing: 0
                id: science
                visible: false

                signal buttonPressed

                KCalcButton { label: "Shift"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "C"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "<-"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
                KCalcButton { label: "AC"
                    Layout.fillHeight: true
                    Layout.fillWidth: true}
            }
        }
    }
}
