#!/bin/bash
# -----------------------------------------------------------------------------
# sve01_extract.sh
#
# Copyright (C) 2023-2024  Andy Townsend
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
#
# ----------------------------------------------------------------------------
# What's the file that we are interested in?
#
# The data file is downloaded in ~/data which allows it to be shared with data
# files user by update_render.sh (raster maps) or garmin_map_etrex_03.sh 
# (Garmin) if either of those are also installed.
#
# Four parameters can be set, such as:
# europe great-britain england north-yorkshire
#
# This script uses
# ~/src/SomeoneElse-vector-extract/resources/process-sve01.lua
# which in turn relies on "shared_lua.lua", including from somewhere that the
# local lua expects to include from.  This code can be found at
# https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/shared_lua.lua
# and the "update_render.sh" of that project will install it to
# "usr/local/share/lua/5.3/" if a raster tile data import is performed.
# Running this script without the file will list the locations it is expected
# to be found in one of.
# ----------------------------------------------------------------------------
if [ -z "$4" ]
then
    if [ -z "$3" ]
    then
	if [ -z "$2" ]
	then
	    if [ -z "$1" ]
	    then
		echo "1-4 arguments needed (continent, country, state, region).  No arguments passed - exiting"
		exit 1
	    else
		# ----------------------------------------------------------------------
		# Sensible options here might be "antarctica" or possibly "central-america".
		# ----------------------------------------------------------------------
		echo "1 argument passed - processing a continent"
		file_prefix1=${1}
		file_page1=http://download.geofabrik.de/${file_prefix1}.html
		file_url1=http://download.geofabrik.de/${file_prefix1}-latest.osm.pbf
	    fi
	else
	    # ----------------------------------------------------------------------
	    # Sensible options here might be e.g. "europe" and "albania".
	    # ----------------------------------------------------------------------
	    echo "2 arguments passed - processing a continent and a country"
	    file_prefix1=${2}
	    file_page1=http://download.geofabrik.de/${1}/${file_prefix1}.html
	    file_url1=http://download.geofabrik.de/${1}/${file_prefix1}-latest.osm.pbf
	fi
    else
	# ----------------------------------------------------------------------
	# Sensible options here might be e.g. "europe" "united-kingdom" and "england".
	# ----------------------------------------------------------------------
	echo "3 arguments passed - processing a continent, a country and a subregion"
	file_prefix1=${3}
	file_page1=http://download.geofabrik.de/${1}/${2}/${file_prefix1}.html
	file_url1=http://download.geofabrik.de/${1}/${2}/${file_prefix1}-latest.osm.pbf
    fi
else
    # ----------------------------------------------------------------------
    # Sensible options here might be e.g. "europe" "united-kingdom", "england" and "bedfordshire"
    # ----------------------------------------------------------------------
    echo "3 arguments passed - processing a continent, a country and a subregion"
    file_prefix1=${4}
    file_page1=http://download.geofabrik.de/${1}/${2}/${3}/${file_prefix1}.html
    file_url1=http://download.geofabrik.de/${1}/${2}/${3}/${file_prefix1}-latest.osm.pbf
fi

#
# How much disk space are we currently using?
#
df
cd ~/data
#
# When was the target file last modified?
#
if [ "$1" = "current" ]
then
    echo "Using current data"
    ls -t | grep "${file_prefix1}_" | head -1 | sed "s/${file_prefix1}_//" | sed "s/.osm.pbf//" > last_modified1.$$
else
    wget $file_page1 -O file_page1.$$
    grep " and contains all OSM data up to " file_page1.$$ | sed "s/.*and contains all OSM data up to //" | sed "s/. File size.*//" > last_modified1.$$
    rm file_page1.$$
fi
#
file_extension1=`cat last_modified1.$$`
#
if test -e ${file_prefix1}_${file_extension1}.osm.pbf
then
    echo "File1 already downloaded"
else
    wget $file_url1 -O ${file_prefix1}_${file_extension1}.osm.pbf
fi
#
# -----------------------------------------------------------------------------
time tilemaker --input ~/data/${file_prefix1}_${file_extension1}.osm.pbf     --output ~/data/tilemaker_sve01.mbtiles --config ~/src/SomeoneElse-vector-extract/resources/config-sve01.json --process ~/src/SomeoneElse-vector-extract/resources/process-sve01.lua
#
