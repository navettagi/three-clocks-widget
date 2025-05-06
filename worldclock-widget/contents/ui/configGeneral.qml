/*
    SPDX-FileCopyrightText: 2013 David Edmundson <davidedmundson@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.20 as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_showSecondHand: showSecondHandCheckBox.checked
    property alias cfg_showTimezoneString: showTimezoneCheckBox.checked
    property alias cfg_customTimezone: timezoneComboBox.currentText
    property alias cfg_displayCity: cityNameField.text

    property var timezones: [
        "Local",
        "Africa/Cairo",
        "Africa/Johannesburg",
        "Africa/Lagos",
        "America/Argentina/Buenos_Aires",
        "America/Bogota",
        "America/Chicago",
        "America/Denver",
        "America/Los_Angeles",
        "America/Mexico_City",
        "America/New_York",
        "America/Sao_Paulo",
        "Asia/Dhaka",
        "Asia/Dubai",
        "Asia/Hong_Kong",
        "Asia/Jakarta",
        "Asia/Karachi",
        "Asia/Kolkata",
        "Asia/Qatar",
        "Asia/Seoul",
        "Asia/Shanghai",
        "Asia/Singapore",
        "Asia/Tokyo",
        "Australia/Melbourne",
        "Australia/Perth",
        "Australia/Sydney",
        "Europe/Amsterdam",
        "Europe/Berlin",
        "Europe/Dublin",
        "Europe/Istanbul",
        "Europe/London",
        "Europe/Madrid",
        "Europe/Moscow",
        "Europe/Paris",
        "Europe/Prague",
        "Europe/Rome",
        "Europe/Stockholm",
        "Europe/Zurich",
        "Pacific/Auckland",
        "Pacific/Honolulu"
    ]

    Kirigami.FormLayout {
        CheckBox {
            id: showSecondHandCheckBox
            text: i18n("Show seconds hand")
            Kirigami.FormData.label: i18n("General:")
        }

        CheckBox {
            id: showTimezoneCheckBox
            text: i18n("Show time zone")
        }

        ComboBox {
            id: timezoneComboBox
            Kirigami.FormData.label: i18n("Time zone:")
            model: timezones
            currentIndex: {
                // Find the current value in the model
                for (var i = 0; i < timezones.length; i++) {
                    if (timezones[i] === cfg_customTimezone) {
                        return i;
                    }
                }
                return 0; // Default to "Local" if not found
            }
        }

        TextField {
            id: cityNameField
            Kirigami.FormData.label: i18n("City name:")
            placeholderText: i18n("Enter city name (optional)")
        }
    }
}