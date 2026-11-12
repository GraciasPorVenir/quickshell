pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import qs

Singleton {
  id: root
  readonly property PwNode activeNode: Pipewire.defaultAudioSink
  PwObjectTracker { objects: [root.activeNode] }

  readonly property PwNodeAudio audio: activeNode ? activeNode.audio : null
  readonly property real volume: audio ? audio.volume : 0.0 
  readonly property bool isMuted: audio ? audio.muted : false
  readonly property bool isSink: activeNode ? activeNode.isSink ?? true : true

  readonly property string audioIcon: {
    if (!activeNode || !audio) return "";
    if (root.isMuted) return root.isSink ? "" : "󰍭";
    if (!root.isSink) return "󰍬";
    return SIcon.icon(["", "", "", ""], root.volume);
  }

  function setVolume(val) {
    if (root.audio) root.audio.volume = Math.max(0.0, Math.min(1.0, val));
  }

  function toggleMute() {
    if (root.audio) root.audio.muted = !root.audio.muted;
  }
}
