//import Ergo 0.0
import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtMultimedia 5.9

import "components"
//import "pages"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'somafm.wdehoog'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    ChannelsModel { id: channelsModel }

    property int currentItem: -1

    property string channelImageUrl: ""
    property string channelStreamUrl: ""
    property string streamMetaText1: audio.metaData.title ? audio.metaData.title : i18n.tr("no title info")
    property string streamMetaText2: audio.metaData.publisher ? audio.metaData.publisher : i18n.tr("no publisher info")

    Page {
        id: page
        anchors {
            bottom: playerArea.top
            fill: undefined
            left: parent.left
            right: parent.right
            top: parent.top
        }
        clip: true

        header: PageHeader {
            id: header
            title: 'SomaFM'
            trailingActionBar.actions: [
                Action {
                    iconName: "reload"
                    text: i18n.tr("Reload")
                    onTriggered: reload()
                }
            ]
        }

        ListView {
            id: listView
            anchors.fill: parent
            spacing: units.dp(8)
            model: channelsModel
            interactive: contentHeight > height
            delegate: ChannelsDelegate {
                onClicked: {
                    channelImageUrl = model.channelImage
                    loadStation(model.songUrlFast)
                }
            }
        }

    }

    PlayerArea {
        id: playerArea
        height: visible ? childrenRect.height : 0
        visible: pageStack.currentPage.objectName !== "AboutPage"
                 && pageStack.currentPage.objectName !== "HelpPage"
    }

    Connections {
        target: playerArea
        onPause: pause()
        onPrevious: previous()
        onNext: next()
    }

    signal previous()
    signal next()

    signal audioBufferFull()
    onAudioBufferFull: play()

    Audio {
        id: audio

        autoLoad: true
        autoPlay: true
        source: channelStreamUrl

        onPlaybackStateChanged: playerArea.audioPlaybackState = playbackState

        onError: {
            console.log("Audio Player error:" + errorString)
            console.log("source: " + source)
            showErrorDialog(qsTr("Audio Player:") + "\n\n" + errorString)
        }
    }

    function reload() {
        //showBusy = true
        channelsModel.reload()
    }

    function playPause() {
        console.log("pause() audio.source:" + audio.source)
        if(audio.playbackState === Audio.PlayingState)
            audio.pause()
        else
          audio.play()
    }
    
    function loadStation(playlistUri) {

        var xhr = new XMLHttpRequest
        xhr.open("GET", playlistUri)
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                var playlist = xhr.responseText;
                //console.log("Playlist for stream: \n" + playlist)
                var streamURL
                streamURL = extractURLFromPLS(playlist)
                console.log("URL: \n" + streamURL)
                if(streamURL.length > 0) {
                    channelStreamUrl = streamURL
                    //stationChanged(info)
                } else {
                    showErrorDialog(qsTr("Failed to retrieve stream URL."))
                    console.log("Error could not find stream URL: \n" + playlistUri + "\n" + playlist + "\n")
                    //stationChangeFailed(info)
                }
            }
        }
        xhr.send();
    }

    function startsWith(str, start) {
      return str.match("^"+start) !== null;
    }

    function extractURLFromPLS(text) {
      var lines = text.split('\n');
      for(var i = 0;i < lines.length;i++) {
        var match = lines[i].match("File[^=]+\s*=\s*(http.*)\s*")
          if(match && match.length>=2)
            return match[1];
      }
      return "";
    }

    function showMessageDialog(title, text) {
        PopupUtils.open(dialog, app, {messageTitle: title, messageText: text})
    }

    function showErrorDialog(text) {
        PopupUtils.open(dialog, app, {messageTitle: i18n.tr("Error"), messageText: text})
    }
}
