pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs

Singleton {
  property UPowerDevice battery: UPower.displayDevice
  readonly property string fPercentage: `${Math.round(battery.percentage * 100)}%`;
  
  readonly property string icon: {
    const i = !UPower.onBattery ? 
      ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"] : 
      ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
    return SIcon.icon(i, battery.percentage);
  }

  readonly property string fTime: {
    const s = !UPower.onBattery ? battery.timeToFull : battery.timeToEmpty;
    const h = Math.floor(s / 3600);
    const m = Math.floor((s - (3600 * h)) / 60);
    return h > 0 ? `${h}h ` : "" + m > 0 ? `${m}m` : "";
  }
}
