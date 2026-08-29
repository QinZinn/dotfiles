/***************************************************************************
* Nordic minimal SDDM theme.
* Uses only QtQuick + SddmComponents, no KDE Plasma QML modules.
***************************************************************************/

import QtQuick 2.8
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080

    property int sessionIndex: sessionModel.lastIndex

    TextConstants {
        id: textConstants
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            password.text = ""
            password.focus = true
        }
    }

    Image {
        id: background
        anchors.fill: parent
        source: "assets/bg.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.5
        asynchronous: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#1E242E"
        opacity: 0.72
    }

    Column {
        anchors.centerIn: parent
        spacing: 10
        width: 360

        Text {
            id: clockText
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#D8DEE9"
            font.pixelSize: 52
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), "HH:mm")
        }

        Text {
            id: dateText
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#88C0D0"
            font.pixelSize: 15
            text: Qt.formatDate(new Date(), "dddd, d MMMM yyyy")
        }

        Item {
            width: 1
            height: 22
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#81A1C1"
            font.pixelSize: 11
            text: textConstants.promptUser
        }

        TextBox {
            id: userEntry
            width: parent.width
            height: 42
            radius: 10
            color: "#3B4252"
            borderColor: "#4C566A"
            focusColor: "#88C0D0"
            hoverColor: "#5E81AC"
            font.pixelSize: 14
            textColor: "#D8DEE9"
            text: userModel.lastUser
            focus: true

            Keys.onReturnPressed: loginButton.clicked()
        }

        PasswordBox {
            id: password
            width: parent.width
            height: 42
            radius: 10
            color: "#3B4252"
            borderColor: "#4C566A"
            focusColor: "#88C0D0"
            hoverColor: "#5E81AC"
            font.pixelSize: 14
            textColor: "#D8DEE9"
            focus: false

            Keys.onReturnPressed: loginButton.clicked()
        }

        Button {
            id: loginButton
            width: parent.width
            height: 42
            text: textConstants.login
            font.pixelSize: 14
            textColor: "#2E3440"
            color: "#88C0D0"
            activeColor: "#81A1C1"
            pressedColor: "#5E81AC"

            onClicked: sddm.login(userEntry.text, password.text, sessionIndex)
        }

        ComboBox {
            id: sessions
            width: parent.width
            height: 36
            color: "#3B4252"
            borderColor: "#4C566A"
            focusColor: "#88C0D0"
            hoverColor: "#5E81AC"
            menuColor: "#3B4252"
            textColor: "#D8DEE9"
            font.pixelSize: 13
            model: sessionModel
            index: sessionIndex

            onValueChanged: sessionIndex = index
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 24
        spacing: 12

        Button {
            id: rebootButton
            width: 120
            height: 34
            text: textConstants.reboot
            font.pixelSize: 13
            color: "#3B4252"
            textColor: "#D8DEE9"
            activeColor: "#4C566A"
            pressedColor: "#BF616A"
            visible: sddm.canReboot
            enabled: sddm.canReboot

            onClicked: sddm.reboot()
        }

        Button {
            id: shutdownButton
            width: 120
            height: 34
            text: textConstants.shutdown
            font.pixelSize: 13
            color: "#3B4252"
            textColor: "#D8DEE9"
            activeColor: "#4C566A"
            pressedColor: "#BF616A"
            visible: sddm.canPowerOff
            enabled: sddm.canPowerOff

            onClicked: sddm.powerOff()
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            clockText.text = Qt.formatTime(new Date(), "HH:mm")
            dateText.text = Qt.formatDate(new Date(), "dddd, d MMMM yyyy")
        }
    }
}
