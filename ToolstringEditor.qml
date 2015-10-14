import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

SplitView {
    anchors.fill: parent
    orientation: Qt.Horizontal
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
