#!/bin/bash
# -----------------------------------------------------------------------------
# update_web_vector.sh
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
cd /home/${local_filesystem_user}/src/SomeoneElse-vector-extract
sudo -u ${local_filesystem_user} git pull
#
cd /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display
sudo -u ${local_filesystem_user} git pull
#
sudo -u ${local_filesystem_user} /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_extract.sh /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/config-sve01.json /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/process-sve01.lua /home/${local_filesystem_user}/data/tilemaker_sve01.mbtiles   -27.57,34.5,40.17,71.64 europe britain-and-ireland
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_into_apache.sh sve01 sve01 /home/${local_filesystem_user}/data/tilemaker_sve01.mbtiles   http://h12.atownsend.org.uk /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/svwd_into_apache.sh sve01 svwd01 https://h12.atownsend.org.uk /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_spec.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_metadata.json /home/${local_filesystem_user}/src/tilemaker/server/static/fonts /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_style.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd01_index.html svwd01sprite /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources
#

