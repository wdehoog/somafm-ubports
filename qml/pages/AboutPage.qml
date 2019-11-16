import Ergo 0.0
import QtQuick 2.7
import QtQuick.Controls 2.2

import "../components"

Page {
    id: aboutPage
    objectName: "AboutPage"


    header: PageHeader  {
        id: header
        leadingActions: [
            Action {
                iconName: "back"
                onTriggered: pageStack.pop()
            }
        ]
        title: i18n.tr("About") 
    }

    ScrollView  {
        id: flick
        anchors.fill: parent

        Column {
            id: column
            width: flick.width - 2*app.gu(1)
            x: app.gu(1)
            y: x
            spacing: app.gu(5)

            Item {
                width: parent.width
                height: childrenRect.height

                Icon {
                    id: icon
                    width: app.gu(10)
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Qt.resolvedUrl("../resources/somafm-logo.svg")
                }

                Column {
                    id: appTitleColumn

                    anchors {
                        left: parent.left
                        leftMargin: Theme.horizontalPageMargin
                        right: parent.right
                        rightMargin: Theme.horizontalPageMargin
                        top: icon.bottom
                        topMargin: Theme.paddingMedium
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fontPixelSizeLarge
                        text: "SomaFM 0.1"
                    }

                    Label {
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: app.fontPixelSizeLarge
                        text: i18n.tr("SomaFM player for UBPorts")
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }

                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fontPixelSizeSmall
                        text: "Copyright (C) 2019 Willem-Jan de Hoog"
                        width: parent.width
                    }
                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fontPixelSizeMedium
                        text: i18n.tr("sources: https://github.com/wdehoog/somafm-ubports")
                        width: parent.width
                    }
                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fontPixelSizeMedium
                        text: i18n.tr("License: BSD")
                        width: parent.width
                    }
                }

            }

            /*Column {
                width: parent.width

                Label {
                    text: i18n.tr("Translations")
                    font.pixelSize: app.fontPixelSizeLarge
                }

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: app.gu(2)
                        right: parent.right
                        rightMargin: app.gu(2)
                    }
                    font.pixelSize: app.fontPixelSizeLarge
                    wrapMode: Text.WordWrap
                    text: ""
                    }
            }*/

            Column {
                width: parent.width

                Label {
                    text: i18n.tr("Thanks to")
                    font.pixelSize: app.fontPixelSizeLarge
                }

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: app.gu(2)
                        right: parent.right
                        rightMargin: app.gu(2)
                    }
                    font.pixelSize: app.fontPixelSizeLarge
                    wrapMode: Text.WordWrap
                    text:
"SomaFM: www.somafm.com
Rodney: https://gitlab.com/dobey/ergo
Andrea Grandi: sailsoma
UBPorts Team: UBPorts
https://feathericons.com/: play icons
"
                }
            }
        }
    }
}
