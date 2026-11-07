pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property string activePopup: ""

  function toggle(name) {
    if (activePopup === name) activePopup = "";
    else activePopup = name;
  }
}
