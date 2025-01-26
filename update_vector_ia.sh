#!/bin/bash
# -----------------------------------------------------------------------------
# update_vector_ia.sh
#
# Copyright (C) 2024-2025  Andy Townsend
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
# This is a helper script designed to call scripts to extract OSM data and
# create a .mbtiles file, make that available below apache, and install the
# latest json map style.
# See individual scripts for the parameters that each requires.
# -----------------------------------------------------------------------------
#
# The local user account we are using.
# "local_filesystem_user" is whichever non-root account is used to fetch from
# github.
#
local_filesystem_user=ajtown
#
#
# Load the svwd01 style into apache
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/svwd_into_apache.sh sve01 svwd01 https://map.atownsend.org.uk /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_spec.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_metadata.json /home/${local_filesystem_user}/src/tilemaker/server/static/fonts /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_style.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_index.html svwd01sprite /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources
#
# Load the svwd06 style into apache
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/svwd_into_apache.sh sve01 svwd06 https://map.atownsend.org.uk /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd06_spec.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_metadata.json /home/${local_filesystem_user}/src/tilemaker/server/static/fonts /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd06_style.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd06_index.html svwd01sprite /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources
#
#
# Update the documentation
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="About this map" /home/${local_filesystem_user}/src/SomeoneElse-map/vector.md > /var/www/html/maps/map/vector.html
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="schema changelog" /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/changelog_sve01.md > /var/www/html/maps/map/changelog_sve01.html
#
pandoc -s -f markdown -t html -H /home/${local_filesystem_user}/src/SomeoneElse-map/vector_header.html --metadata title="style changelog" /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/changelog_svwd01.md > /var/www/html/maps/map/changelog_svwd01.html
#
