pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
  property UPowerDevice battery: UPower.displayDevice
  readonly property bool isCharging: !UPower.onBattery
  readonly property real percentage: battery.isPresent ? battery.percentage : 0.0
  readonly property string fPercentage: `${Math.round(percentage * 100)}%`;
  readonly property string icon: {
    const i = isCharging ? 
      ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"] : 
      ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
    return i[Math.min(Math.floor(percentage * i.length), i.length - 1)]
  }
  readonly property string color: {
    let r = 0;
    let g = 0;
    if(percentage < 0.5){
      r = 255;
      g = Math.round(percentage * 510);
    } else {
      r = Math.round((1.0 - (percentage - 0.5) * 2) * 255);
      g = 255;
    }
    const hex = c => c.toString(16).padStart(2, "0");
    return `#${hex(r)}${hex(g)}00`
  }
  readonly property string fTime: {
    const s = isCharging ? battery.timeToFull : battery.timeToEmpty;
    const h = Math.floor(s / 3600);
    const m = Math.floor((s - (3600 * h)) / 60);
    return h > 0 ? `${h}h ` : "" + m > 0 ? `${m}m` : "";
  }
}
