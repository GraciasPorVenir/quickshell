pragma Singleton
import Quickshell
import Quickshell.Hyprland

Singleton {
  id: root
  readonly property string appId: "terminal-popup"

  function classOf(tl) {
    return tl.wayland?.appId ?? tl.lastIpcObject?.class
  }

  function openTUI(program) {
    let same = []
    let others = []
    for (const tl of Hyprland.toplevels.values) {
      if (classOf(tl) !== appId) continue
      if (tl.title === program) same.push(tl)
      else others.push(tl)
    }

    for (const tl of others) tl.wayland?.close()
    if (same.length > 0) {
      for (const tl of same) tl.wayland?.close()
    } else Hyprland.dispatch(`hl.dsp.exec_cmd("foot --app-id=${appId} --title=${program} -e ${program}")`)
  }
}
