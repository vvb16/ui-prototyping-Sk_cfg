import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

ColumnLayout {
    anchors.fill: parent
    Item {
        Layout.minimumWidth: initializationProgress.implicitWidth
        Layout.minimumHeight: initializationProgress.implicitHeight
        Layout.fillWidth: true
        Layout.margins: 6
        Layout.bottomMargin: 0
        ProgressBar {
            id: initializationProgress
            anchors.left: parent.left
            anchors.right: parent.right
            maximumValue: 50
        }
    }
    Item {
        id: foundDevicesView
        Layout.fillWidth: true
        Layout.margins: 6
        Layout.topMargin: 0
        Layout.fillHeight: true
        Layout.minimumHeight: foundDevicesTableView.implicitHeight
        TableView {
            id: foundDevicesTableView
            anchors.fill: parent
            model: foundDevicesListModel
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
            TableViewColumn {
                title: qsTr("Test")
                role: "test"
                movable: false
            }
        }
    }
}

/*
    Timer {
        interval: 200; running: true; repeat: true
        onTriggered: {
            ++initializationProgress.value;
            if (initializationProgress.value == initializationProgress.maximumValue) {
                stop();
                foundDevicesListModel.get(0).test = "Passed";
                foundDevicesListModel.get(1).test = "Passed";
                foundDevicesListModel.get(2).test = "Passed";
            }
            else if (initializationProgress.value == 10) {
                foundDevicesListModel.append({"name" : "Pulser", "serial": "", "test": ""});
                foundDevicesListModel.append({"name" : "BM", "serial": "", "test": ""});
                foundDevicesListModel.append({"name" : "IKN", "serial": "", "test": ""});
            }
            else if (initializationProgress.value == 15) {
                foundDevicesListModel.get(0).serial = "12";
                foundDevicesListModel.get(1).serial = "5";
                foundDevicesListModel.get(2).serial = "3";
            }
        }
    }
*/
