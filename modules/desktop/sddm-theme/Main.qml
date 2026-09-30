// Login screen (SDDM theme) made to look like the hyprlock lock screen
// (modules/home/hyprlock.nix): same colours, sizes and positions.
// hyprlock font sizes are in points, so they are multiplied by 4/3 here to get pixels.

import QtQuick
import QtQuick.Effects

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#110F14"

    readonly property color white: "#DDE5E6"
    readonly property color blue: "#86AAEC"
    readonly property color yellow: "#ECD3A0"
    readonly property color red: "#B73747"
    readonly property string fontName: "JetBrainsMono Nerd Font"

    // Portuguese names, the same as `date` shows on the lock screen
    readonly property var days: ["domingo", "segunda", "terça", "quarta", "quinta", "sexta", "sábado"]
    readonly property var months: ["janeiro", "fevereiro", "março", "abril", "maio", "junho",
                                   "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]

    property string userName: userModel.lastUser !== "" ? userModel.lastUser : config.user
    property int sessionIndex: sessionModel.lastIndex
    property bool failed: false
    property int attempts: 0

    function login() {
        if (password.text === "")
            return
        sddm.login(root.userName, password.text, root.sessionIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            password.text = ""
            root.attempts += 1
            root.failed = true
        }
    }

    // Always start the Hyprland session
    Repeater {
        model: sessionModel
        delegate: Item {
            Component.onCompleted: {
                if (String(model.file).endsWith("hyprland.desktop") && !String(model.file).endsWith("uwsm.desktop"))
                    root.sessionIndex = index
            }
        }
    }

    // Wallpaper, already blurred and darkened when the theme is built (see login.nix)
    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
    }

    // Soft shadow behind text, like hyprlock's shadow_size / shadow_color
    component Shadowed: MultiEffect {
        shadowEnabled: true
        shadowColor: Qt.rgba(0, 0, 0, 0.6)
        shadowBlur: 0.5
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 0
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date()
            time.text = Qt.formatTime(now, "HH:mm")
            date.text = root.days[now.getDay()] + ", " + String(now.getDate()).padStart(2, "0") + " " + root.months[now.getMonth()]
        }
    }

    // TIME
    Text {
        id: time
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height / 2 - 160 - height / 2
        color: root.white
        font.family: root.fontName
        font.weight: Font.ExtraBold
        font.pixelSize: 147
        layer.enabled: true
        layer.effect: Shadowed {}
    }

    // DATE
    Text {
        id: date
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height / 2 - 50 - height / 2
        color: root.white
        font.family: root.fontName
        font.pixelSize: 27
        layer.enabled: true
        layer.effect: Shadowed {}
    }

    // USER
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height / 2 + 90 - height / 2
        text: root.userName
        color: root.blue
        font.family: root.fontName
        font.bold: true
        font.pixelSize: 19
        layer.enabled: true
        layer.effect: Shadowed {}
    }

    // PASSWORD
    Rectangle {
        id: box
        width: 300
        height: 50
        radius: height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height / 2 + 150 - height / 2
        color: Qt.rgba(17 / 255, 15 / 255, 20 / 255, 0.75)
        border.width: 2
        border.color: root.failed ? root.red : (keyboard.capsLock ? root.yellow : root.blue)
        layer.enabled: true
        layer.effect: Shadowed {}

        TextInput {
            id: password
            anchors.fill: parent
            anchors.leftMargin: 25
            anchors.rightMargin: 25
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password
            passwordCharacter: "●"
            color: root.white
            font.family: root.fontName
            font.pixelSize: 16
            font.letterSpacing: 2
            clip: true
            focus: true
            onTextChanged: if (text !== "") root.failed = false
            Keys.onReturnPressed: root.login()
            Keys.onEnterPressed: root.login()
        }

        Text {
            anchors.centerIn: parent
            visible: password.text === ""
            text: root.failed ? "Wrong password (" + root.attempts + ")" : "Password"
            color: root.failed ? root.red : Qt.rgba(221 / 255, 229 / 255, 230 / 255, 0.6)
            font.family: root.fontName
            font.italic: true
            font.pixelSize: 16
        }
    }

    // Restart and shut down, bottom right
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        spacing: 26

        Text {
            text: "󰜉"
            visible: sddm.canReboot
            color: root.white
            opacity: rebootArea.containsMouse ? 1.0 : 0.6
            font.family: root.fontName
            font.pixelSize: 26
            MouseArea {
                id: rebootArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: sddm.reboot()
            }
        }

        Text {
            text: "⏻"
            visible: sddm.canPowerOff
            color: root.red
            opacity: powerArea.containsMouse ? 1.0 : 0.7
            font.family: root.fontName
            font.pixelSize: 26
            MouseArea {
                id: powerArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: sddm.powerOff()
            }
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}
