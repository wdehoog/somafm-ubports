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

import QtQuick 2.7
import QtQuick.Templates 2.2 as T
import QtQuick.Window 2.0


T.BusyIndicator {
    id: rootSpinner

    /*! @cond */
    default property alias content: innerItem.children
    /*! @endcond */

    contentItem: Item {
        id: spinner
        visible: rootSpinner.running
        anchors.fill: parent

        Item {
            anchors.centerIn: parent
            height: Math.min(parent.width, parent.height)
            width: height

            Canvas {
                id: canvas
                antialiasing: true
                property int iterations: 0

                anchors.fill: parent

                /* As Canvas component does not work right with QT_SCALE_FACTOR
                 * values less than 1.0, we need to do some extra math in case
                 * this happens.
                 */
                property real scale: Screen.devicePixelRatio >= 1.0 ? 1.0 : Screen.devicePixelRatio
                property int lineWidth: Math.min(parent.width, parent.height) / 12 * scale
                property real radius: (Math.min(parent.width, parent.height) / 2) - lineWidth * 2
                readonly property int maxVal: 100
                property int curVal: 0

                property real angle: curVal / maxVal * 2 * Math.PI

                rotation: 90
                onCurValChanged: {
                    requestPaint();
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.save();
                    ctx.reset();

                    var inverse = (iterations % 2 != 0) ? true : false;

                    // The "diminishing" portion of the circle
                    ctx.beginPath();
                    ctx.lineWidth = canvas.lineWidth;
                    ctx.strokeStyle = !inverse ? "#343434" : "#efefef";
                    ctx.arc(parent.width / 2 * scale, parent.height / 2 * scale,
                            canvas.radius * scale,
                            canvas.angle,
                            2 * Math.PI);
                    ctx.stroke();

                    // The "increasing" portion of the circle
                    ctx.beginPath();
                    ctx.lineWidth = canvas.lineWidth;
                    ctx.strokeStyle = !inverse ? "#efefef" : "#343434";
                    ctx.arc(parent.width / 2 * scale, parent.height / 2 * scale,
                            canvas.radius * scale,
                            0,
                            canvas.angle);
                    ctx.stroke();

                    ctx.restore();
                }
            }

            Timer {
                interval: 50
                running: rootSpinner.running
                repeat: true
                onTriggered: {
                    if (canvas.curVal >= canvas.maxVal) {
                        canvas.curVal = 0;
                        canvas.iterations += 1;
                    } else {
                        canvas.curVal += 2;
                        canvas.rotation += 2;
                    }
                }
            }
            Item {
                id: innerItem
                anchors.centerIn: parent
            }
        }
    }
}
