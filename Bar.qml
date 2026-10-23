import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 40

            ColumnLayout {
                anchors.centerIn: parent
                ClockWidget {}
                BatteryWidget {}
            }
        }
    }
}
