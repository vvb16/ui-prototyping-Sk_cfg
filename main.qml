import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import CAN.Driver.VCI3 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    title: qsTr("Hello World")

    onMinimumWidthChanged: {
        width = Math.max(minimumWidth, 150, width);
    }

    onMinimumHeightChanged: {
        height = Math.max(minimumHeight, 150, height);
    }

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
        property var srcs: ["StartView.qml", "InitializationView.qml", "ToolstringEditor.qml"]
        property int current_src_idx: 0
        onTriggered: {
            current_src_idx = (current_src_idx+1) % srcs.length;
            loader.setSource(srcs[current_src_idx]);

            //CANDriver.initialize();
        }
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

    PossibleDevicesListModel {
        id: possibleDevicesListModel
    }

    ListModel {
        id: selectedDevicesListModel
    }

    ListModel {
        id: foundDevicesListModel
    }

    Loader {
        id: loader
        anchors.fill: parent
        source: "StartView.qml"
//        source: "InitializationView.qml"
//        source: "ToolstringEditor.qml"
        onLoaded: {
            Layout.minimumWidth = item.Layout.minimumWidth;
            Layout.minimumHeight = item.Layout.minimumHeight;
//            Layout.preferredWidth = item.Layout.preferredWidth;
//            Layout.preferredHeight = item.Layout.preferredHeight;
//            Layout.maximumWidth = item.Layout.maximumWidth;
//            Layout.maximumHeight = item.Layout.maximumHeight;
        }
    }
}

