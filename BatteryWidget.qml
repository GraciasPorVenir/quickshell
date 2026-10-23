import Quickshell
import QtQuick
import Quickshell.Services.UPower

Rectangle {
    property var battery: UPower.displayDevice
    property bool isCharging: !UPower.onBattery
    visible: battery.isPresent
    implicitWidth: text.implicitWidth + 14
    implicitHeight: text.implicitHeight + 8

    radius: 6
    color: "#000000"

    Text {
        id: text
        anchors.centerIn: parent
        color: "#FFFFFF"
        text: {
            let p = battery.percentage;
            if (p == 1)
                return isCharging ? "󰂅" : "󰁹";
            else if (p > 0.9)
                return isCharging ? "󰂋" : "󰂂";
            else if (p > 0.8)
                return isCharging ? "󰂊" : "󰂁";
            else if (p > 0.7)
                return isCharging ? "󰢞" : "󰂀";
            else if (p > 0.6)
                return isCharging ? "󰂉" : "󰁿";
            else if (p > 0.5)
                return isCharging ? "󰢝" : "󰁾";
            else if (p > 0.4)
                return isCharging ? "󰂈" : "󰁽";
            else if (p > 0.3)
                return isCharging ? "󰂇" : "󰁼";
            else if (p > 0.2)
                return isCharging ? "󰂆" : "󰁻";
            else if (p > 0.1)
                return isCharging ? "󰢜" : "󰁺";
            else
                return isCharging ? "󰢟" : "󰂎";
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Popup.toggle("battery");
        }
    }
}
