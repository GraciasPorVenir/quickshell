import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs

Scope {
  Variants {
    model: Quickshell.screens
    Scope {
      id: screenScope
      required property var modelData
      PanelWindow {
        id: panel
        screen: screenScope.modelData
        color: "transparent"

        readonly property int barWidth: 40
        readonly property int radius: 20
        readonly property color barColor: "#252525"

        anchors {
          top: true
          left: true
          bottom: true
        }

        implicitWidth: barWidth + radius
        exclusiveZone: barWidth

        mask: Region {
          item: barArea
        }

        Item {
          id: root
          anchors.fill: parent

          Item {
            id: barArea
            width: panel.barWidth
            height: parent.height
          }

          Rectangle {
            id: background
            anchors.fill: parent
            color: panel.barColor
            layer.enabled: true
            layer.effect: MultiEffect {
              maskEnabled: true
              maskSource: maskItem
              maskInverted: true
              maskThresholdMin: 0.5
              maskSpreadAtMin: 1.0
            }
          }

          Item {
            id: maskItem
            anchors.fill: parent
            layer.enabled: true
            layer.smooth: true
            visible: false

            Rectangle {
              x: panel.barWidth
              y: 0
              width: parent.width - panel.barWidth + panel.radius * 2
              height: parent.height
              radius: panel.radius
              antialiasing: true
            }
          }

          ColumnLayout {
            x: 5
            y: 5
            width: panel.barWidth - 10
            height: parent.height - 10
            spacing: 5

            Pill {
              label.text: STime.hour
            }
            Pill {
              popup: "battery"
              label.text: SBattery.icon
              label.color: SIcon.color(SBattery.battery.percentage)
              tooltipText: `${SIcon.fPercentage(SBattery.battery.percentage)} ${SBattery.fTime}`
            }
            Pill {
              popup: "bluetooth"
              label.color: SBluetooth.color
              label.text: SBluetooth.adapterIcon
            }
            Pill {
              label.text: SVolume.audioIcon
            }
            Item { Layout.fillHeight: true }
          }
        }
      }
      SideMenu{
        screen: screenScope.modelData
        visible: SPopup.popup !== ""
      }
    }
  }
}
