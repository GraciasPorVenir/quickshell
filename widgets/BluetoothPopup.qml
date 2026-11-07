import Quickshell
import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick.Controls
import qs

PanelWindow {
  implicitWidth: 300
  implicitHeight: 500
  ColumnLayout {
    anchors.fill: parent
    spacing: 5
    Button {
      text: "Buscar"
      onClicked: {
        BluetoothManager.toggleDiscover()
      }
    }

    Repeater {
      model: BluetoothManager.defAdapter?.devices
      delegate: Button {
        id: devButton
        Layout.fillWidth: true
        required property var modelData
        enabled: !modelData.pairing
        text: `${modelData.pairing ? "..." : BluetoothManager.deviceIcon(modelData)} ${modelData.name}`
        onClicked: {
          BluetoothManager.connect(modelData)
        }
        Text {
          text: `paired=${modelData.paired} bonded=${modelData.bonded} trusted=${modelData.trusted} conn=${modelData.connected}`
          font.pixelSize: 10
        } 
      }
    }
  }
}
