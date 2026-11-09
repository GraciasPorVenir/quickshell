import Quickshell
import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick.Controls
import qs

ColumnLayout {
  Item { Layout.fillHeight: true }
  RowLayout { 
    Text { text: [SBattery.icon, SIcon.fPercentage(SBattery.battery.percentage)].join(" ") }
    Text { text: SBattery.fTime }
  }
  RowLayout {
    Button {
      text: ""
      highlighted: PowerProfiles.profile === PowerProfile.Balanced
      onClicked: PowerProfiles.profile = PowerProfile.Balanced
    }

    Button {
      text: "󰌵"
      visible: PowerProfiles.hasPerformanceProfile
      highlighted: PowerProfiles.profile === PowerProfile.Performance
      onClicked: PowerProfiles.profile = PowerProfile.Performance
    }

    Button {
      text: ""
      highlighted: PowerProfiles.profile === PowerProfile.PowerSaver
      onClicked: PowerProfiles.profile = PowerProfile.PowerSaver
    }
  }
  Item { Layout.fillHeight: true }
}
