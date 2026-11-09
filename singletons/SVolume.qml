pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import qs

Singleton {
  id: root
  readonly property PwNode activeNodeSink: Pipewire.defaultAudioSink
  PwObjectTracker { objects: [root.activeNodeSink] }

  readonly property PwNodeAudio audio: activeNodeSink.audio
  readonly property real volume: audio.volume 
  readonly property bool isMuted: audio ? audio.muted : false
  readonly property bool isSink: activeNodeSink.isSink ?? true

  readonly property string audioIcon: {
    if (!activeNodeSink || !audio) return "";
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

  property string pendingSink: ""

  function setAudio(description) {
    if (trySetSink(description)) return
    pendingSink = description
    retryTimer.restart()
  }

  function trySetSink(description) {
    for (const n of Pipewire.nodes.values) {
      if (n.isSink && n.audio && (n.description.includes(description) || n.name.includes(description))) {
        Pipewire.preferredDefaultAudioSink = n
        return true
      }
    }
    return false
  }

Timer {
  id: retryTimer
  interval: 500
  repeat: true
  property int tries: 0
  onTriggered: {
    if (root.trySetSink(root.pendingSink) || ++tries > 10) {
      stop();
      tries = 0;
      root.pendingSink = "";
    }
  }
}
}
