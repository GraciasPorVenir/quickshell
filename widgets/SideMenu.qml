import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs

PanelWindow {
  anchors {
    top: true
    bottom: true
    right: true
  }

  exclusiveZone: 0
  implicitWidth: 300
  color: "#FFFFFF"

  Loader {
    Layout.fillWidth: true
    Layout.fillHeight: true
    sourceComponent: {
      switch(SPopup.popup) {
        case "battery": return battery
        case "bluetooth": return bluetooth
        default: return null
      }
    }
  }

  Component { id: battery; BatteryPopup{} }
  Component { id: bluetooth; BluetoothPopup{} }
}
