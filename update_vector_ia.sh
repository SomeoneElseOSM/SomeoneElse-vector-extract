#!/bin/bash
# -----------------------------------------------------------------------------
# update_web_vector_ia.sh
#
# Copyright (C) 2024  Andy Townsend
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# -----------------------------------------------------------------------------
# Designed to update rendering database and related styles to latest version.
# Note that it won't run on e.g. an NTFS file system, and makes a number of
# assumptions about where things are.
# -----------------------------------------------------------------------------
#
# The local user account we are using.
# "local_filesystem_user" is whichever non-root account is used to fetch from
# github.
#
local_filesystem_user=ajtown
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/svwd_into_apache.sh sve01 svwd01 https://map.atownsend.org.uk /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_spec.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_metadata.json /home/${local_filesystem_user}/src/tilemaker/server/static/fonts /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_style.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_index.html svwd01sprite /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="About this map" /home/${local_filesystem_user}/src/SomeoneElse-map/vector.md > /var/www/html/maps/map/vector.html
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="schema changelog" /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/changelog_sve01.md > /var/www/html/maps/map/changelog_sve01.html
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="style changelog" /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/changelog_svwd01.md > /var/www/html/maps/map/changelog_svwd01.html
#
