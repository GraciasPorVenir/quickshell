pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property string popup: ""

  function toggle(name) {
    if (popup === name) popup = "";
    else popup = name;
  }
}
