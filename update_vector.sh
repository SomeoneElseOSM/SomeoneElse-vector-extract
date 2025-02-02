#!/bin/bash
# -----------------------------------------------------------------------------
# update_vector.sh
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
cd /home/${local_filesystem_user}/src/SomeoneElse-vector-extract
sudo -u ${local_filesystem_user} git pull
#
cd /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display
sudo -u ${local_filesystem_user} git checkout resources/svwd06_style.json
sudo -u ${local_filesystem_user} git pull
#
#
# Run Tilemaker to create the vector tiles
#
mkdir -p /usr/local/share/lua/5.3/
cp /home/${local_filesystem_user}/src/SomeoneElse-style/shared_lua.lua /usr/local/share/lua/5.3/
#
sudo -u ${local_filesystem_user} /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_extract.sh /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/config-sve01.json /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/process-sve01.lua /home/${local_filesystem_user}/data/tilemaker_sve01.mbtiles  -27.57,34.5,40.17,71.64 nocoast   europe britain-and-ireland
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_into_apache.sh sve01 sve01 /home/${local_filesystem_user}/data/tilemaker_sve01.mbtiles   http://map.atownsend.org.uk /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf
#
#
# Create the svwd06 style for Android Native from svwd01
#
cat /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_style.json | sed "s/viewport/map/" > /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd06_style.json 
chown ${local_filesystem_user} /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd06_style.json 
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
