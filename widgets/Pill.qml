import QtQuick
import Quickshell
import qs

Rectangle {
  id: root

  property string popup: ""
  property string tooltipText: ""
  property alias label: text

  implicitWidth: label.implicitWidth + 14
  implicitHeight: label.implicitHeight + 8

  radius: 6
  color: "#000000"

  Text {
    id: text
    color: "#FFFFFF"
    anchors.centerIn: parent
  }

  MouseArea {
    id: mouseArea
    visible: Boolean(popup) || Boolean(tooltipText)
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      if (root.popup !== "") PopupState.toggle(root.popup);
    }
  }

  PopupWindow {
    id: tooltipWindow
    visible: root.tooltipText !== "" && mouseArea.containsMouse
    color: "transparent"

    anchor.item: root
    anchor.edges: Edges.Top

    Rectangle {
      color: "#000000"
      radius: 4
      implicitWidth: tipText.implicitWidth + 12
      implicitHeight: tipText.implicitHeight + 8

      Text {
        id: tipText
        text: root.tooltipText
        color: "#ffffff"
        font.pixelSize: 11
        anchors.centerIn: parent
      }
    }
  }
}
