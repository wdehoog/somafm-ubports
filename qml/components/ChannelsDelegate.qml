import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2

//Component
//{
//    id: channelDelegate

    ListItem
    {
        width: parent.width
        height: thumb.height
        id: channels

        Image
        {
            id: thumb
            source: channelImage
            asynchronous: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingSmall
            width: units.gu(10)
            height: width
        }

        Column
        {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            anchors.left: thumb.right
            anchors.leftMargin: Theme.paddingMedium

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
//}
