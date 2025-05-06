import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami

PlasmoidItem {
    id: root
    
    /* 
    Timezone offsets (hours from UTC):
    - Roma (Italy): UTC+1 (+2 during DST)
    - Doha (Qatar): UTC+3 (no DST)
    - Ahmedabad (India): UTC+5:30 (no DST)
    */
    
    // Absolute offsets from UTC (will handle DST correctly)
    property double romaOffset: 2  // +2 during summer (DST)
    property double dohaOffset: 3  // Always +3
    property double ahmedabadOffset: 5.5  // Always +5:30 (5 hours and 30 minutes)
    
    property bool showSecondHand: Plasmoid.configuration.showSecondHand
    
    width: isVertical ? Kirigami.Units.gridUnit * 10 : Kirigami.Units.gridUnit * 30
    height: isVertical ? Kirigami.Units.gridUnit * 30 : Kirigami.Units.gridUnit * 10
    
    property bool isVertical: height > width
    
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    
    RowLayout {
        id: horizontalLayout
        anchors.fill: parent
        visible: !isVertical
        spacing: Kirigami.Units.largeSpacing
        
        Clock {
            cityName: "Roma"
            hoursOffset: root.romaOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        Clock {
            cityName: "Doha"
            hoursOffset: root.dohaOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        Clock {
            cityName: "Ahmedabad"
            hoursOffset: root.ahmedabadOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
    
    ColumnLayout {
        id: verticalLayout
        anchors.fill: parent
        visible: isVertical
        spacing: Kirigami.Units.largeSpacing
        
        Clock {
            cityName: "Roma"
            hoursOffset: root.romaOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        Clock {
            cityName: "Doha"
            hoursOffset: root.dohaOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        Clock {
            cityName: "Ahmedabad"
            hoursOffset: root.ahmedabadOffset
            showSecondHand: root.showSecondHand
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}