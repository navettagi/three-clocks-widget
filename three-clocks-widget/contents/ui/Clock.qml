import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

Item {
    id: clock
    
    width: 120
    height: 150
    
    property string cityName: "City"
    property int hoursOffset: 0
    property bool showSecondHand: false
    
    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    
    // Timer to update the clock every second
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: updateTime()
    }
    
    // Initialize clock
    Component.onCompleted: {
        updateTime()
    }
    
    // Update the clock time based on absolute UTC offset
    function updateTime() {
        var date = new Date();
        
        // Get current UTC time in total minutes
        var utcHours = date.getUTCHours();
        var utcMinutes = date.getUTCMinutes();
        var utcSeconds = date.getUTCSeconds();
        var utcTotalMinutes = utcHours * 60 + utcMinutes;
        
        // Convert offset to minutes (e.g., 5.5 hours = 330 minutes)
        var offsetMinutes = Math.round(hoursOffset * 60);
        
        // Apply offset to get destination time in total minutes
        var destTotalMinutes = utcTotalMinutes + offsetMinutes;
        
        // Convert back to hours and minutes
        var destHours = Math.floor(destTotalMinutes / 60) % 24;
        var destMinutes = destTotalMinutes % 60;
        
        // Handle negative time (rarely happens)
        if (destTotalMinutes < 0) {
            destHours = (destHours + 24) % 24;
            if (destMinutes < 0) {
                destMinutes += 60;
                destHours = (destHours - 1 + 24) % 24;
            }
        }
        
        hours = destHours;
        minutes = destMinutes;
        seconds = utcSeconds;
        
        canvas.requestPaint();
    }
    
    Rectangle {
        anchors.fill: parent
        color: "transparent"  // Transparent background
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 2  // Reduce spacing
            
            PlasmaComponents.Label {
                text: cityName
                font.bold: true
                color: "#000000"  // Black text for better visibility
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 0  // Reduce bottom margin
            }
            
            Canvas {
                id: canvas
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(parent.width, parent.height - 40) // Leave space for labels
                Layout.alignment: Qt.AlignHCenter
                
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    
                    var centerX = width / 2;
                    var centerY = height / 2;
                    var radius = Math.min(centerX, centerY) - 5;
                    
                    // Draw clock face with white background and black border
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
                    ctx.fillStyle = "white";
                    ctx.fill();
                    ctx.strokeStyle = "#000000";
                    ctx.lineWidth = 2;
                    ctx.stroke();
                    
                    // Draw hour markers with black strokes for better visibility
                    ctx.strokeStyle = "#000000";
                    ctx.lineWidth = 1.5;
                    for (var i = 0; i < 12; i++) {
                        var angle = i * Math.PI / 6;
                        var markerLength = (i % 3 === 0) ? 10 : 5; // Longer markers for 3, 6, 9, 12
                        var startX = centerX + (radius - markerLength) * Math.sin(angle);
                        var startY = centerY - (radius - markerLength) * Math.cos(angle);
                        var endX = centerX + radius * 0.9 * Math.sin(angle);
                        var endY = centerY - radius * 0.9 * Math.cos(angle);
                        
                        ctx.beginPath();
                        ctx.moveTo(startX, startY);
                        ctx.lineTo(endX, endY);
                        ctx.stroke();
                    }
                    
                    // Draw hour numbers for better readability
                    ctx.fillStyle = "#000000";
                    ctx.font = "bold " + Math.round(radius / 5) + "px sans-serif";
                    ctx.textAlign = "center";
                    ctx.textBaseline = "middle";
                    
                    for (var i = 1; i <= 12; i++) {
                        var angle = (i - 3) * Math.PI / 6; // -3 to start at 12 o'clock
                        var x = centerX + radius * 0.75 * Math.cos(angle);
                        var y = centerY + radius * 0.75 * Math.sin(angle);
                        ctx.fillText(i, x, y);
                    }
                    
                    // Draw hour hand with shadow for better visibility
                    var hourAngle = (hours % 12 + minutes / 60) * Math.PI / 6;
                    // Shadow
                    ctx.beginPath();
                    ctx.moveTo(centerX + 1, centerY + 1);
                    ctx.lineTo(
                        centerX + radius * 0.5 * Math.sin(hourAngle) + 1, 
                        centerY - radius * 0.5 * Math.cos(hourAngle) + 1
                    );
                    ctx.strokeStyle = "rgba(0, 0, 0, 0.3)";
                    ctx.lineWidth = 5;
                    ctx.stroke();
                    
                    // Actual hand
                    ctx.beginPath();
                    ctx.moveTo(centerX, centerY);
                    ctx.lineTo(
                        centerX + radius * 0.5 * Math.sin(hourAngle), 
                        centerY - radius * 0.5 * Math.cos(hourAngle)
                    );
                    ctx.strokeStyle = "#000000";
                    ctx.lineWidth = 4;
                    ctx.stroke();
                    
                    // Draw minute hand with shadow
                    var minuteAngle = minutes * Math.PI / 30;
                    // Shadow
                    ctx.beginPath();
                    ctx.moveTo(centerX + 1, centerY + 1);
                    ctx.lineTo(
                        centerX + radius * 0.7 * Math.sin(minuteAngle) + 1, 
                        centerY - radius * 0.7 * Math.cos(minuteAngle) + 1
                    );
                    ctx.strokeStyle = "rgba(0, 0, 0, 0.3)";
                    ctx.lineWidth = 3;
                    ctx.stroke();
                    
                    // Actual hand
                    ctx.beginPath();
                    ctx.moveTo(centerX, centerY);
                    ctx.lineTo(
                        centerX + radius * 0.7 * Math.sin(minuteAngle), 
                        centerY - radius * 0.7 * Math.cos(minuteAngle)
                    );
                    ctx.strokeStyle = "#000000";
                    ctx.lineWidth = 2;
                    ctx.stroke();
                    
                    // Draw second hand if enabled
                    if (showSecondHand) {
                        var secondAngle = seconds * Math.PI / 30;
                        ctx.beginPath();
                        ctx.moveTo(centerX, centerY);
                        ctx.lineTo(
                            centerX + radius * 0.8 * Math.sin(secondAngle), 
                            centerY - radius * 0.8 * Math.cos(secondAngle)
                        );
                        ctx.strokeStyle = "#FF0000";  // Bright red for seconds
                        ctx.lineWidth = 1;
                        ctx.stroke();
                    }
                    
                    // Draw center dot with shadow for better visibility
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, 4, 0, 2 * Math.PI);
                    ctx.fillStyle = "#000000";
                    ctx.fill();
                }
            }
            
            Rectangle {
                color: "#FFFFFF"  // White background for time display
                border.color: "#CCCCCC"
                border.width: 1
                radius: 3
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: timeLabel.width + 10
                Layout.preferredHeight: timeLabel.height + 6
                Layout.topMargin: 2
                
                PlasmaComponents.Label {
                    id: timeLabel
                    anchors.centerIn: parent
                    text: {
                        function zeroPad(n) {
                            return n < 10 ? "0" + n : n;
                        }
                        return zeroPad(hours) + ":" + zeroPad(minutes) + (showSecondHand ? ":" + zeroPad(seconds) : "");
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: "#000000"  // Black text for better visibility
                    font.pixelSize: 14
                    font.bold: true
                }
            }
        }
    }
}