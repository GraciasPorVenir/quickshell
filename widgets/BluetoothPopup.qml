import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs

ColumnLayout {
  RowLayout {
    Button {
      text: ""
      enabled: !SBluetooth.adapter?.discovering
      onClicked: SBluetooth.discover()
    }
    Text { text: SBluetooth.adapter?.name }
  }

  Repeater {
    model: SBluetooth.adapter?.devices
    delegate: RowLayout {
      Layout.fillWidth: true
      required property var modelData

      Button {
        enabled: !modelData.pairing
        onClicked: SBluetooth.connect(modelData)
        contentItem: RowLayout {
          Text { text: `${modelData.pairing ? "..." : SBluetooth.deviceIcon(modelData)}` }
          Text { text: SBluetooth.fName(modelData) }
        }
      }

      Button {
        enabled: !modelData.pairing
        text: SBluetooth.trustIcon(modelData)
        onClicked: SBluetooth.toggleTrust(modelData)
      }
    }
  }
  Item { Layout.fillHeight: true }
}
