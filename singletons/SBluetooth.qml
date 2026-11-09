pragma Singleton
import Quickshell.Bluetooth
import QtQuick
import Quickshell
import qs

Singleton {
  id: root
  property BluetoothDevice targetDevice: null
  property BluetoothAdapter adapter: Bluetooth.defaultAdapter
  property string color: "#FFFFFF";
  readonly property string adapterIcon: {
    if (!adapter || (adapter && !adapter.enabled)) return "󰂲";
    for(const dev of adapter.devices.values){
      if(dev.connected) return deviceIcon(dev)
    }
    return "";
  }

  function fName(device) {
    const bat = device.batteryAvailable ? SIcon.fPercentage(device.battery) : "";
    return [bat, device.name].join(" | ");
  }

  function trustIcon(device) {
    return device.trusted ? "󰒘" : "󰦞";
  }

  function toggleTrust(device) {
    device.trusted = !device.trusted;
  }

  function deviceIcon(device) {
    if(!device.connected){
      switch(device.icon){
        case "audio-headset": return "󰥰";
        case "input-mouse": return "󰦋";
        case "phone": return "󰏳";
        case "speaker": return "󰦢";
        default: return ""
      }
    }

    if (device.batteryAvailable) {
      const i = ["󰥇", "󰤾", "󰤿", "󰥀", "󰥁", "󰥂", "󰥃", "󰥄", "󰥅", "󰥆", "󰥈"]
      color = SIcon.color(device.battery);
      return SIcon.icon(i, device.battery);
    }

    color = "#FFFFFF"
    return "󰂱"
  }

  function discover(){
    if(!adapter || (adapter && !adapter.enabled)) return;
    adapter.discovering = true;
    discoverTimer.restart();
  }

  function connect(device) {
    if (!device) return;

    if(device.connected) {
      targetDevice = null;
      device.disconnect();
      return;
    }

    if(device.pairing) {
      device.cancelPair();
      return;
    }

    targetDevice = device;
    if(device.paired) device.connect();
    else device.pair();
  }

  Timer {
    id: discoverTimer
    interval: 15000
    repeat: false
    onTriggered: { root.adapter.discovering = false; }
  }

  Connections {
    target: root.targetDevice
    ignoreUnknownSignals: true

    function onPairedChanged() {
      if(!root.targetDevice) return
      if (root.targetDevice.paired && !root.targetDevice.connected) root.targetDevice.connect();
    }

    function onConnectedChanged() {
      if (root.targetDevice && root.targetDevice.connected) {
        const deviceName = root.targetDevice.name;
        const deviceIcon = root.targetDevice.icon ?? "";
        root.targetDevice = null;
        if (deviceIcon.includes("audio")) SVolume.setAudio(deviceName);
      }
    }
  }
}
