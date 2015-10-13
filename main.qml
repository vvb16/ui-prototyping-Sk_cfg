import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import CAN.Driver.VCI3 1.0

ApplicationWindow {
    visible: true
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                action: noteOpenAction
            }
            MenuItem {
                action: noteSaveAction
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("Action")
            MenuItem {
                action: goNextAction
            }
        }
    }

    Action {
        id: noteOpenAction
        text: qsTr("&Open")
        shortcut: StandardKey.Open
        iconSource: "fileopen.png"
        onTriggered: console.log("Open action triggered");
    }

    Action {
        id: noteSaveAction
        text: qsTr("&Save")
        shortcut: StandardKey.Save
        iconSource: "filesave.png"
        onTriggered: console.log("Save action triggered");
    }

    Action {
        id: goNextAction
        text: qsTr("&Go")
        shortcut: StandardKey.Forward
        iconSource: "actionnext.png"
        onTriggered: CANDriver.initialize();
    }


    Connections {
        target: CANDriver
        onErrorOccured: {
            canErrorDialog.informativeText = errorText
            canErrorDialog.visible = true
        }
    }

    MessageDialog {
        id: canErrorDialog
        title: qsTr("CAN error")
        text: qsTr("CAN error occured")
    }

    toolBar: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                action: noteOpenAction
            }
            ToolButton {
                action: noteSaveAction
            }
            ToolButton {
                action: goNextAction
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }

    ListModel {
        id: possibleDevicesListModel
        ListElement {
            name: "Pulser"
            deviceId: 0x10
        }
        ListElement {
            name: "BM"
            deviceId: 0x80
        }
        ListElement {
            name: "IKN"
            deviceId: 0x11
        }
    }

    ListModel {
        id: selectedDevicesListModel
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        Layout.minimumHeight: 480
        Layout.minimumWidth: 640
        Item {
            id: possibleDevicesView
            Layout.minimumWidth: 200
            Layout.margins: 6
            TableView {
                anchors.fill: parent
                model: possibleDevicesListModel
                TableViewColumn {
                    title: qsTr("Tool")
                    role: "name"
                }
                onDoubleClicked: {
                    console.log("Row double clicked ", row);
                    selectedDevicesListModel.append({"name" : possibleDevicesListModel.get(row).name, "serial" : possibleDevicesListModel.get(row).deviceId});
                }
            }
        }

        Item {
            id: selectedDevicesView
            Layout.minimumWidth: 200
            Layout.margins: 6
            TableView {
                anchors.fill: parent
                model: selectedDevicesListModel
                TableViewColumn {
                    title: qsTr("Tool")
                    role: "name"
                    movable: false
                }
                TableViewColumn {
                    title: qsTr("Serial")
                    role: "serial"
                    movable: false
                }
            }
        }

        Item {
            id: toolStringView
            Layout.minimumWidth: 200
            Layout.fillWidth: true
            Layout.margins: 6
            Image {
                id: pipeImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "simple_pipe.svg"
            }
        }

    }

}

