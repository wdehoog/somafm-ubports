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
            width: flick.width - 2*units.gu(1)
            x: units.gu(1)
            y: x
            spacing: units.gu(5)

            Item {
                width: parent.width
                height: childrenRect.height

                Icon {
                    id: icon
                    width: units.gu(10)
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
                        font.pixelSize:FontUtils.sizeToPixels("large")
                        text: "SomaFM 0.1"
                    }

                    Label {
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize:FontUtils.sizeToPixels("large")
                        text: i18n.tr("SomaFM player for UBPorts")
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }

                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize:FontUtils.sizeToPixels("small")
                        text: "Copyright (C) 2019 Willem-Jan de Hoog"
                        width: parent.width
                    }
                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize:FontUtils.sizeToPixels("medium")
                        text: i18n.tr("sources: https://github.com/wdehoog/somafm-ubports")
                        width: parent.width
                    }
                    Label {
                        horizontalAlignment: implicitWidth > width ? Text.AlignLeft : Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize:FontUtils.sizeToPixels("medium")
                        text: i18n.tr("License: BSD")
                        width: parent.width
                    }
                }

            }

            Column {
                width: parent.width

                Label {
                    text: i18n.tr("Translations")
                }

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        right: parent.right
                        rightMargin: units.gu(2)
                    }
                    font.pixelSize:FontUtils.sizeToPixels("large")
                    wrapMode: Text.WordWrap
                    text: ""
                    }
            }

            Column {
                width: parent.width

                Label {
                    text: i18n.tr("Thanks to")
                }

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        right: parent.right
                        rightMargin: units.gu(2)
                    }
                    font.pixelSize:FontUtils.sizeToPixels("large")
                    wrapMode: Text.WordWrap
                    text:
"SomaFM: www.somafm.com
Andrea Grandi: sailsoma
UBPorts Team: UBPorts
https://feathericons.com/: play icons
"
                }
            }
        }
    }
}
