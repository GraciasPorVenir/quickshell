import QtQuick
import Quickshell
import qs

Rectangle {
  id: root

  property alias label: text
  property string tooltip: ""
  property var leftFn: null
  property var rightFn: null

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
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: function(mouse) {
      const hasLeft = typeof root.leftFn === "function";
      const hasRight = typeof root.rightFn === "function";
      if (hasLeft && !hasRight) root.leftFn();
      else if (hasRight && !hasLeft) root.rightFn();
      else if (mouse.button === Qt.LeftButton && hasLeft) root.leftFn();
      else if (mouse.button === Qt.RightButton && hasRight) root.rightFn();
    }
  }

  PopupWindow {
    visible: root.tooltip !== "" && mouseArea.containsMouse
    color: "transparent"

    anchor.item: root
    anchor.edges: Edges.Top

    Rectangle {
      color: "#000000"
      radius: 4
      implicitWidth: tooltipText.implicitWidth + 12
      implicitHeight: tooltipText.implicitHeight + 8
      x: (root.implicitWidth / 2) * 1.2

      Text {
        text: root.tooltip
        id: tooltipText
        color: "#ffffff"
        font.pixelSize: 11
        anchors.centerIn: parent
      }
    }
  }
}
