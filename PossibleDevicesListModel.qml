import QtQuick 2.5

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
