import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_showSecondHand: showSecondHandCheckBox.checked

    Kirigami.FormLayout {
        CheckBox {
            id: showSecondHandCheckBox
            text: i18n("Show seconds hands")
            Kirigami.FormData.label: i18n("General:")
        }
    }
}