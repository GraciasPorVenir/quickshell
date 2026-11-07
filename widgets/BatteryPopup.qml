import Quickshell
import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick.Controls
import qs

PanelWindow {
  implicitWidth: 300
  ColumnLayout {
    spacing: 5
    
    Text {
      text: [BatteryManager.icon, BatteryManager.fPercentage].join(" ")
    }
    
    RowLayout {
      Text {
        text: BatteryManager.fTime
      }
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
  }
}
