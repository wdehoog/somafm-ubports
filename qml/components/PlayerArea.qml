import QtQuick 2.4
import Ubuntu.Components 1.3
import QtMultimedia 5.6

Row {
    id: playerUI

    property int audioPlaybackState

    signal pause()
    signal previous()
    signal next()

    anchors {
        bottom: parent.bottom
        topMargin: units.gu(1)
    }
    width: parent.width - 2*units.gu(1)
    x: units.gu(1)

    Icon {
        id: imageItem
        source: channelImageUrl.length > 0 ? channelImageUrl : Qt.resolvedUrl("../resources/somafm-logo.svg")
        width: units.gu(10)
        height: width
        anchors.verticalCenter: parent.verticalCenter
        //fillMode: Image.PreserveAspectFit
    }

    Column {
        id: meta
        width: parent.width - imageItem.width - playerButton.width
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: m1
            x: units.gu(1)
            width: parent.width - units.gu(1)
            font.bold: true
            color: UbuntuColors.orange
            wrapMode: Text.Wrap
            text: streamMetaText1
        }
        Text {
            id: m2
            x: units.gu(1)
            width: parent.width - units.gu(1)
            anchors.right: parent.right
            wrapMode: Text.Wrap
            font.bold: true
            color: UbuntuColors.darkGrey
            text: streamMetaText2
        }

    }


    Button {
        id: playerButton
        width: units.gu(4)
        height: width
        anchors.verticalCenter: parent.verticalCenter

        action: Action {
              iconSource: audioPlaybackState == Audio.PlayingState
                            ? Qt.resolvedUrl("../resources/pause.svg")
                            : Qt.resolvedUrl("../resources/play.svg")
              onTriggered: playPause()
        }
    }
}
