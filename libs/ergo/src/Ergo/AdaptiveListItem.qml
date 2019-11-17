/*
 * Copyright © 2018 Rodney Dawes
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

/*! Component to provide a converged interface for list items with actions
 *
 * This component can be used as the delegate for items in a ListView, when
 * it is needed to provide actions, such as copy or delete. The actions are
 * presented in a popup on top of the item, when a long press or right click
 * occurs.
 */
Item {
    id: aliRoot

    /*! @cond */
    default property alias content: inner.children
    /*! @endcond */

    /*! The list of actions to present to the user, for the item.
     *
     * The number of actions shown in the popup is limted to five, and
     * any actions in the list with an empty `iconName` property or which
     * have their `enabled` property set to `false` will also be excluded.
     */
    property list<Action> actions

    /* If LayoutMirroring is enabled on this component, let all children
     * also be mirrored.
     */
    LayoutMirroring.childrenInherit: true

    /* The container used for all children added when using this component. */
    Item {
        id: inner
        anchors.fill: parent
    }

    function openActionMenu() {
        if (aliRoot.actions.length > 0) {
            menuComponent.createObject(aliRoot).open();
        }
    }

    /* A shortcut for opening the menu */
    Shortcut {
        id: menuShortcut
        /* WidgetShortcut seems to not work right, so bind to activeFocus */
        enabled: aliRoot.activeFocus
        sequences: ["Shift+F10"]
        onActivated: {
            aliRoot.openActionMenu();
        }
    }

    /* Add the shortcuts for the actions, so they will work when the list
     * item has focus.
     */
    Repeater {
        model: aliRoot.actions

        delegate: Item {

            Shortcut {
                sequences: Array.isArray(modelData.shortcut) ? modelData.shortcut : [modelData.shortcut]
                /* WidgetShortcut seems to not work right, so bind to focus,
                 * and we only want the shortcut to work while visible.
                 */
                enabled: modelData.enabled && parent.visible && parent.focus
                onActivated: {
                    modelData.trigger();
                }
            }
        }
    }

    signal clicked(var mouse)

    /* We need to handle mouse events for popping up the "menu" on the list
     * item, but pass through regular clicks.
     */
    MouseArea {
        anchors.fill: parent
        //propagateComposedEvents: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onPressAndHold: {
            console.log("AdaptiveListItem.onPressAndHold")
            aliRoot.openActionMenu();
        }

        onClicked: {
            console.log("AdaptiveListItem.onClicked")
            if (mouse.button == Qt.RightButton) {
                aliRoot.openActionMenu();
                return;
            }
            mouse.accepted = false;
            aliRoot.clicked(mouse)
        }
    }

    /* We use a Component here for containg the popup, to prevent QML from
     * spending time to render the items until we need to actually open the
     * "menu" and show them. This should make loading and scrolling of lists
     * with more items, much faster than if we were to load this directly.
     */
    Component {
        id: menuComponent

        Popup {
            id: actionMenu
            modal: true

            padding: units.dp(8)
            // FIXME: need to move this closer to mouse/tap
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2

            /* We do some basic math here to avoid having the menu be too
             * wide or tall, such that it would extend beyond the width or
             * height of the list item.
             */
            height: {
                var optheight = parent.height - units.dp(8) * 2;
                var minheight = units.dp(40);
                var maxheight = (parent.width - units.dp(8) * 2) / 5;
                return Math.max(minheight, Math.min(optheight, maxheight));
            }
            background: Rectangle {
                color: "#111111"
                opacity: 0.93
                radius: 9
            }

            /* We destroy the Popup here, so the object gets freed from
             * memory, and we don't keep creating more objects if the menu
             * is opened multiple times.
             */
            onClosed: {
                destroy();
            }

            RowLayout {
                height: parent.height
                anchors.centerIn: parent
                spacing: units.dp(12)

                Repeater {
                    model: aliRoot.actions
                    // FIXME: There has got to be a better way to do this
                    property int visibleCount: 0
                    onItemAdded: {
                        if (!model[index].enabled
                            || model[index].iconName == ""
                            || ((index + 1) > 5 && visibleCount == 5)) {
                            item.visible = false;
                            return;
                        }
                        visibleCount += 1;
                    }
                    delegate: Item {
                        height: parent.height
                        width: height
                        Icon {
                            anchors.centerIn: parent
                            height: parent.height
                            width: height
                            name: modelData.iconName
                            color: "#efefef"
                        }
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: {
                                actionMenu.close();
                                modelData.trigger();
                            }
                        }
                    }
                }
            }
        }
    }
}
