import QtQuick 2.5

ListModel {
    id: possibleDevicesListModel
    ListElement {
        name: "MP"
        deviceId: 0x10
    }
    ListElement {
        name: "MB"
        deviceId: 0x80
    }
    ListElement {
        name: "IKN"
        deviceId: 0x11
    }
}
