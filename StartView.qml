import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ColumnLayout {
    anchors.fill: parent
    Text {
        id: startText
        Layout.alignment: Qt.AlignCenter
        font.pointSize: 18
        text: qsTr("Выберите действие")
    }
}
