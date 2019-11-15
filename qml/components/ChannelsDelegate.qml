import Ergo 0.0
import QtQuick 2.7
import QtQuick.Controls 2.2

AdaptiveListItem {
    width: parent.width - app.gu(2)
    x: app.gu(1)
    height: thumb.height + app.gu(1)
    anchors.bottomMargin: app.gu(1)
    id: channels

    Image
    {
        id: thumb
        source: channelImage
        asynchronous: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: app.gu(10)
        height: width
    }

    Column
    {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: app.gu(1)
        anchors.left: thumb.right
        anchors.leftMargin: app.gu(1)

        Text
        {
            id: channelNameLabel
            text: channelName;
            font.weight: Font.Bold;
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Text
        {
            id: channelDescriptionLabel
            text: channelDescription;
            width: parent.width
            font.weight: Font.Light;
            maximumLineCount: 2
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Text
        {
            id: channelSongLabel
            text: song;
            font.weight: Font.Bold;
            maximumLineCount: 1
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }


}
