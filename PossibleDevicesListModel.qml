import QtQuick 2.5

ListModel {
    id: possibleDevicesListModel
    ListElement {
        name: "МП"
        deviceId: 0x10
    }
    ListElement {
        name: "МБ"
        deviceId: 0x80
    }
    ListElement {
        name: "МИГ"
        deviceId: 0x11
    }
}
