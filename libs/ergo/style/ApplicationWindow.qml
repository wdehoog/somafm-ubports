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


T.ApplicationWindow {
    font.family: "Ubuntu"

    background: Rectangle {
        color: "#232323"
    }

    overlay.modal: Rectangle {
        color: "#dd000000"
    }

    overlay.modeless: overlay.modal
}
