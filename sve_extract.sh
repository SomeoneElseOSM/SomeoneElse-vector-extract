#!/bin/bash
# -----------------------------------------------------------------------------
# sve_extract.sh
#
# Copyright (C) 2023-2026  Andy Townsend
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
# Five parameters can be set on the end, such as:
# (bbox) europe united-kingdom england north-yorkshire
# At least two of these are required.
#
# One of the expected uses for this script is with
# ~/src/SomeoneElse-vector-extract/resources/process-sve01.lua
# which in turn relies on "shared_lua.lua", including from somewhere that the
# local lua expects to include from.  This code can be found at
# https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/shared_lua.lua
# and the "update_render.sh" of that project will install it to
# "usr/local/share/lua/5.3/" if a raster tile data import is performed.
# Running this script without the file will list the locations it is expected
# to be found in one of.
# ----------------------------------------------------------------------------
if [ -z "$9" ]
then
    if [ -z "$8" ]
    then
	if [ -z "$7" ]
	then
	    if [ -z "$6" ]
	    then
		echo "6-9 arguments needed (bbox, continent, country, state, region).  No arguments passed - exiting"
		exit 1
	    else
		# ----------------------------------------------------------------------
		# Sensible options here might be "antarctica" or possibly "central-america".
		# ----------------------------------------------------------------------
		echo "2 geographic arguments passed - processing a continent"
		file_prefix1=${6}
		file_page1=http://download.geofabrik.de/${file_prefix1}.html
		file_url1=http://download.geofabrik.de/${file_prefix1}-latest.osm.pbf
	    fi
	else
	    # ----------------------------------------------------------------------
	    # Sensible options here might be e.g. "europe" and "albania".
	    # ----------------------------------------------------------------------
	    echo "3 geographic arguments passed - processing a continent and a country"
	    file_prefix1=${7}
	    file_page1=http://download.geofabrik.de/${6}/${file_prefix1}.html
	    file_url1=http://download.geofabrik.de/${6}/${file_prefix1}-latest.osm.pbf
	fi
    else
	# ----------------------------------------------------------------------
	# Sensible options here might be e.g. "europe" "united-kingdom" and "england".
	# ----------------------------------------------------------------------
	echo "4 geographic arguments passed - processing a continent, a country and a subregion"
	file_prefix1=${8}
	file_page1=http://download.geofabrik.de/${6}/${7}/${file_prefix1}.html
	file_url1=http://download.geofabrik.de/${6}/${7}/${file_prefix1}-latest.osm.pbf
    fi
else
    # ----------------------------------------------------------------------
    # Sensible options here might be e.g. "europe" "united-kingdom", "england" and "bedfordshire"
    # ----------------------------------------------------------------------
    echo "5 geographic arguments passed - processing a continent, a country, a subregion and a county"
    file_prefix1=${9}
    file_page1=http://download.geofabrik.de/${6}/${7}/${8}/${file_prefix1}.html
    file_url1=http://download.geofabrik.de/${6}/${7}/${8}/${file_prefix1}-latest.osm.pbf
fi

#
# How much disk space are we currently using?
#
df
cd ~/data
#
# When was the target file last modified?
#
wget $file_page1 -O file_page1.$$
grep " and contains all OSM data up to " file_page1.$$ | sed "s/.*and contains all OSM data up to //" | sed "s/. File size.*//" > last_modified1.$$
rm file_page1.$$
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
# Expected parameters at the front that are passed to Tilemaker are
# --config  $1
# --process $2
# --output  $3
# --bbox    $4
#
# In addition a 5th parameter is required that is either the full path to a 
# set of coastline tiles (which will be copied to the "output" name and our 
# new data will then be merged into) or "nocoast" which implies no coastline 
# processing is to be performed
# 
# If you're not passing "nocoast", you'll need to create a set of coastline 
# tiles.  See:
# https://github.com/systemed/tilemaker/blob/master/README.md#coastline-and-landcover
# to download the shapefile and then run something like
#
# tilemaker --output ~/data/coastline.mbtiles \
#           --bbox -27.57,34.5,40.17,71.64 \
#           --process resources/process-coastline.lua \
#           --config resources/config-coastline.json
#
# Unless you _really_ want sea tiles for the whole world use a bbox restricted 
# to your area of interest above.
# The layer created by that is called "water", so that will need to go in the 
# style .json as '"source-layer": "water",'.
#
# To save memory, add an extra parameter after "--process $2" such as
# --store /home/someuser/temp/tilemaker_store
# where that directory is on a fast SSD.
#
# Some configs have relative references in them, so cd there first.
# -----------------------------------------------------------------------------
cd `dirname $1`
#
if [ "$5" = "nocoast" ]
then
    echo "No coastline tiles will be used"
    time tilemaker --bbox $4 --input ~/data/${file_prefix1}_${file_extension1}.osm.pbf     --output $3 --config $1 --process $2
else
    echo "copying $5 to $3 and merging into that"
    cp $5 $3
    time tilemaker --bbox $4 --input ~/data/${file_prefix1}_${file_extension1}.osm.pbf     --output $3 --merge --config $1 --process $2
fi
#
#
