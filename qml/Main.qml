import Ergo 0.0
import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtMultimedia 5.9
import QtQuick.Window 2.0

import "components"

Window {
    id: app
    objectName: 'mainView'
    //applicationName: 'somafm.wdehoog'
    //automaticOrientation: true

    
    //width: units.dp(1080)
    //height: units.dp(1920)

    // Use these colors for the UI.
    //readonly property color bgColor: "#232323"
    //readonly property color fgColor: "#efefef"

    property color text1color: "#E95420" // Ubuntu orange
    property color text2color: "#333333" // some dark grey 

    title: i18n.tr("SomaFM")
    visible: true

    ChannelsModel { id: channelsModel }

    property int currentItem: -1

    property string channelImageUrl: ""
    property string channelStreamUrl: ""
    property string streamMetaText1: audio.metaData.title ? audio.metaData.title : i18n.tr("no title info")

    property string streamMetaText2: audio.metaData.publisher ? audio.metaData.publisher : i18n.tr("no publisher info")

    StackView {
        id: pageStack
        anchors {
            bottom: playerArea.top
            fill: undefined
            left: parent.left
            right: parent.right
            top: parent.top
        }
        clip: true

        Component.onCompleted: {
          pageStack.push(mainPage)
        }
    }


    Page {
        id: mainPage

        header: PageHeader {
            id: header

            trailingActions: [
                Action {
                    iconName: "info"
                    text: i18n.tr("About")
                    onTriggered: pageStack.push(Qt.resolvedUrl("pages/AboutPage.qml") )
                },
                Action {
                    iconName: "reload"
                    text: i18n.tr("Reload")
                    onTriggered: reload()
                }
            ]
            title: "SomaFM" 
        }

        Component.onCompleted: {
          console.log("Component.onCompleted")
          listView.model = channelsModel
        }

        ListView {
            id: listView
            anchors.fill: parent
            spacing: units.dp(8)
            //model: channelsModel
            interactive: contentHeight > height
            delegate: ChannelsDelegate {
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        channelImageUrl = model.channelImage
                        streamMetaText1 = model.channelName + ": " + model.channelDj
                        streamMetaText2 = model.channelDescription
                        loadStation(model.songUrlFast)
                    }
                }
            }
        }

    }

    PlayerArea {
        id: playerArea
        height: visible ? childrenRect.height : 0
        //visible: pageStack.currentPage.objectName !== "AboutPage"
        //         && pageStack.currentPage.objectName !== "HelpPage"
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

    function playPause() {
        console.log("pause() audio.source:" + audio.source)
        if(audio.playbackState === Audio.PlayingState)
            audio.pause()
        else
          audio.play()
    }
    
    function reload() {
        channelsModel.reload()
    }

    function loadStation(playlistUri) {

        var xhr = new XMLHttpRequest
        xhr.open("GET", playlistUri)
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                var playlist = xhr.responseText;
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
        //PopupUtils.open(dialog, app, {messageTitle: title, messageText: text})
    }

    function showErrorDialog(text) {
        //PopupUtils.open(dialog, app, {messageTitle: i18n.tr("Error"), messageText: text})
    }

    // trial and error
    function gu(value) {
        return units.dp(16) * value
    }
}
