pragma Singleton
import QtQuick

QtObject {
    property string activePopup: ""

    function toggle(name) {
        if (activePopup === name)
            activePopup = "";
        else
            activePopup = name;
    }
}
