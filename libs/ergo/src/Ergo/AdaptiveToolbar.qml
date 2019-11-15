/*
 * Copyright © 2019 Rodney Dawes
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import Ergo 0.0
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

/*! Component to provide a toolbar for building converged applications
 *
 */
Item {
    id: atbRoot

    /*! @cond */
    default property alias content: innerContent.children
    /*! @endcond */

    /*! List of actions to show on the left side of the toolbar, in LTR.
     *
     * The number of actions shown in the toolbar may be limited, and
     * any actions in the list with an empty `iconName` property or which
     * have their `enabled` property set to `false` will be excluded.
     */
    property list<Action> leadingActions

    /*! List of actions to show on the right side of the toolbar, in LTR.
     *
     * The number of actions shown in the toolbar may be limited, and
     * any actions in the list with an empty `iconName` property or which
     * have their `enabled` property set to `false` will be excluded.
     */
    property list<Action> trailingActions

    /* If LayoutMirroring is enabled on this component, let all children
     * also be mirrored.
     */
    LayoutMirroring.childrenInherit: true

    /*
     */
    RowLayout {
        anchors.fill: parent
        Layout.minimumHeight: units.dp(70)

        Row {
            id: leadingToolbar
            Layout.fillHeight: true
            visible: atbRoot.leadingActions !== undefined

            Repeater {
                model: atbRoot.leadingActions

                delegate: ToolButton {
                    height: parent.height
                    width: height
                    enabled: modelData.enabled

                    Icon {
                        Layout.maximumHeight: parent.height
                        Layout.minimumHeight: units.dp(30)
                        Layout.minimumWidth: units.dp(30)

                        anchors.centerIn: parent
                        height: parent.height / 2
                        width: height
                        name: modelData.iconName
                        color: modelData.color
                    }

                    Shortcut {
                        /* Only enabled when visible, so they do not work if
                         * another page is pushed on top of the stack or such.
                         */
                        enabled: modelData.enabled && parent.visible
                        sequences: Array.isArray(modelData.shortcut) ? modelData.shortcut : [modelData.shortcut]
                        onActivated: {
                            modelData.trigger();
                        }
                    }

                    onClicked: {
                        modelData.trigger();
                    }
                }
            }
        }
        Item {
            id: innerContent
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Row {
            id: trailingToolbar
            Layout.fillHeight: true
            visible: atbRoot.trailingActions !== undefined

            Repeater {
                model: atbRoot.trailingActions

                delegate: ToolButton {
                    height: parent.height
                    width: height
                    enabled: modelData.enabled

                    Icon {
                        Layout.maximumHeight: parent.height
                        Layout.minimumHeight: units.dp(30)
                        Layout.minimumWidth: units.dp(30)

                        anchors.centerIn: parent
                        height: parent.height / 2
                        width: height
                        name: modelData.iconName
                        color: modelData.color
                    }

                    Shortcut {
                        /* Only enabled when visible, so they do not work if
                         * another page is pushed on top of the stack or such.
                         */
                        enabled: modelData.enabled && parent.visible
                        sequences: Array.isArray(modelData.shortcut) ? modelData.shortcut : [modelData.shortcut]
                        onActivated: {
                            modelData.trigger();
                        }
                    }

                    onClicked: {
                        modelData.trigger();
                    }
                }
            }
        }
    }
}
