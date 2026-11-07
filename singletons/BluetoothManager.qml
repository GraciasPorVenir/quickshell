pragma Singleton
import Quickshell.Bluetooth
import QtQuick
import Quickshell

Singleton {
  id: root
  property BluetoothDevice targetDevice: null
  property BluetoothAdapter defAdapter: Bluetooth.defaultAdapter
  
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
      return i[Math.min(Math.floor(device.battery * i.length), i.length - 1)]
    }
    return "󰂱"
  }

  function toggleDiscover(adapter = defAdapter){
    if(adapter && adapter.enabled) adapter.discovering = !adapter.discovering
  }

  function adapterIcon(adapter = defAdapter) {
    if (!adapter || !adapter.enabled) return "󰂲";
    for(const dev of adapter.devices.values){
      if(dev.connected) return deviceIcon(dev)
    }
    return "";
  }

  function cancelActiveOperations(device) {
    if (!device) return;
    if (device.connected) device.disconnect();
    else if (device.pairing) device.cancelPair();
  }

  function connect(device) {
    if (!device) return;
    if (device.connected || device.pairing) return cancelActiveOperations(device);
    targetDevice = device;
    if (device.paired) device.connect();
    else device.pair();
  }

  Connections {
    target: root.targetDevice
    function onConnectedChanged() {
      if (!root.targetDevice) return;
      if (root.targetDevice.connected) root.targetDevice = null;
      else retryTimer.restart();
    }
  }

  Timer {
    id: retryTimer
    interval: 500
    repeat: false
    onTriggered: {
      if (!root.targetDevice) return;
      if (!root.targetDevice.connected && root.targetDevice.paired) root.targetDevice.connect();
      else root.targetDevice = null;
    }
  }
}
