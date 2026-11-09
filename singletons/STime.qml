pragma Singleton
import Quickshell
import QtQuick

Singleton {
  readonly property string hour: {
    Qt.formatDateTime(clock.date, "hh\nmm");
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
