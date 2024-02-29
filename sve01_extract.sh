#!/bin/bash
# -----------------------------------------------------------------------------
# sve01_extract.sh
#
# Copyright (C) 2023  Andy Townsend
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
#file_prefix1=europe
#file_page1=http://download.geofabrik.de/${file_prefix1}.html
#file_url1=http://download.geofabrik.de/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=britain-and-ireland
#file_prefix1=great-britain
#file_prefix1=ireland-and-northern-ireland
#file_page1=http://download.geofabrik.de/europe/${file_prefix1}.html
#file_url1=http://download.geofabrik.de/europe/${file_prefix1}-latest.osm.pbf
#
file_prefix1=england
#file_prefix1=scotland
#file_prefix1=wales
file_page1=http://download.geofabrik.de/europe/great-britain/${file_prefix1}.html
file_url1=http://download.geofabrik.de/europe/great-britain/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=bedfordshire
#file_prefix1=berkshire
#file_prefix1=bristol
#file_prefix1=buckinghamshire
#file_prefix1=cambridgeshire
#file_prefix1=cheshire
#file_prefix1=cornwall
#file_prefix1=cumbria
#file_prefix1=derbyshire
#file_prefix1=devon
#file_prefix1=dorset
#file_prefix1=durham
#file_prefix1=east-sussex
#file_prefix1=east-yorkshire-with-hull
#file_prefix1=essex
#file_prefix1=gloucestershire
#file_prefix1=greater-london
#file_prefix1=greater-manchester
#file_prefix1=hampshire
#file_prefix1=herefordshire
#file_prefix1=hertfordshire
#file_prefix1=isle-of-wight
#file_prefix1=kent
#file_prefix1=lancashire
#file_prefix1=leicestershire
#file_prefix1=lincolnshire
#file_prefix1=merseyside
#file_prefix1=norfolk
#file_prefix1=north-yorkshire
#file_prefix1=northamptonshire
#file_prefix1=northumberland
#file_prefix1=nottinghamshire
#file_prefix1=oxfordshire
#file_prefix1=rutland
#file_prefix1=shropshire
#file_prefix1=somerset
#file_prefix1=south-yorkshire
#file_prefix1=staffordshire
#file_prefix1=suffolk
#file_prefix1=surrey
#file_prefix1=tyne-and-wear
#file_prefix1=warwickshire
#file_prefix1=west-midlands
#file_prefix1=west-sussex
#file_prefix1=west-yorkshire
#file_prefix1=wiltshire
#file_prefix1=worcestershire
#file_page1=http://download.geofabrik.de/europe/great-britain/england/${file_prefix1}.html
#file_url1=http://download.geofabrik.de/europe/great-britain/england/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=new-york
#file_prefix1=oregon
#file_page1=http://download.geofabrik.de/north-america/us/${file_prefix1}.html
#file_url1=http://download.geofabrik.de/north-america/us/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=argentina
#file_page1=http://download.geofabrik.de/south-america/${file_prefix1}.html
#file_url1=http://download.geofabrik.de/south-america/${file_prefix1}-latest.osm.pbf
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
