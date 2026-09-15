#!/bin/bash
# -----------------------------------------------------------------------------
# update_sb_vector2.sh
#
# Copyright (C) 2018-2026  Andy Townsend
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
#
# The local user account we are using.
# "local_filesystem_user" is whichever non-root account is used to fetch from
# github.
#
local_filesystem_user=ajtown
#
# First things first - define some shared functions
#
final_tidy_up()
{
    cd /home/${local_filesystem_user}/data
    rm last_modified1.$$ last_modified2.$$ last_modified3.$$ last_modified4.$$
    rm update_vector2.running
}

m_error_01()
{
    final_tidy_up
    date | mail -s "update_vector2 FAILED on `hostname`, 1" ${local_filesystem_user}
    exit 1
}

m_error_02()
{
    final_tidy_up
    date | mail -s "update_vector2 FAILED on `hostname`, 2" ${local_filesystem_user}
    exit 1
}

#
# Next, is another copy of the script already running?
#
cd /home/${local_filesystem_user}/data
if test -e update_vector2.running
then
    echo update_vector2.running exists so exiting
    exit 1
else
    touch update_vector2.running
fi
# -----------------------------------------------------------------------------
# This script works with several different geographic regions.  
# Areas within Great Britain can be processed into CY, GD and EN speaking 
# areas and are handled by the "1" versions of e.v.s.
# Ireland, if needed, needs no language processing and is is handled by the 
# "2" versions of e.v.s.
# The results are then merged together.
#
# If 2 GB counties are merged, they must be from the same Geofabrik extract, 
# otherwise the "osmium merge" will fail, because some node in the GB 
# coastline will have one version in one file and another version in another.
# Any coastal English county (and Wales and Scotland) will include nodes in 
# the coastline which are part of the island of GB, which will be dragged in
# in full to both files.
# "Using current data" (see comment below) will work if something like the
# "Isle of Man" or "Ireland" is used as the second file.
# ----------------------------------------------------------------------------
# What's the first file that we are interested in?
#
#file_prefix1=europe
#file_page1=https://download.geofabrik.de/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=britain-and-ireland
#file_prefix1=united-kingdom
#file_prefix1=ireland-and-northern-ireland
#file_page1=https://download.geofabrik.de/europe/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/europe/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=england
#file_prefix1=scotland
#file_prefix1=wales
#file_page1=https://download.geofabrik.de/europe/united-kingdom/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/europe/united-kingdom/${file_prefix1}-latest.osm.pbf
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
#file_page1=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=new-york
#file_prefix1=oregon
#file_page1=https://download.geofabrik.de/north-america/us/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/north-america/us/${file_prefix1}-latest.osm.pbf
#
#file_prefix1=argentina
#file_page1=https://download.geofabrik.de/south-america/${file_prefix1}.html
#file_url1=https://download.geofabrik.de/south-america/${file_prefix1}-latest.osm.pbf
#
file_prefix1=algeria
file_page1=https://download.geofabrik.de/africa/${file_prefix1}.html
file_url1=https://download.geofabrik.de/africa/${file_prefix1}-latest.osm.pbf
#
# What's the second file that we are interested in?
# Note that if this is commented out, also change the "merge" below to not use it.
#
#file_prefix2=ireland-and-northern-ireland
#file_prefix2=isle-of-man
#file_page2=https://download.geofabrik.de/europe/${file_prefix2}.html
#file_url2=https://download.geofabrik.de/europe/${file_prefix2}-latest.osm.pbf
#file_prefix2=east-yorkshire-with-hull
#file_prefix2=rutland
#file_page2=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix2}.html
#file_url2=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix2}-latest.osm.pbf
#
file_prefix2=mauritania
file_page2=https://download.geofabrik.de/africa/${file_prefix2}.html
file_url2=https://download.geofabrik.de/africa/${file_prefix2}-latest.osm.pbf
#
# What's the third file that we are interested in?
# Note that if this is commented out, also change the "merge" below to not use it.
#
#file_prefix3=isle-of-man
#file_page3=https://download.geofabrik.de/europe/${file_prefix3}.html
#file_url3=https://download.geofabrik.de/europe/${file_prefix3}-latest.osm.pbf
#file_prefix3=north-yorkshire
#file_prefix3=rutland
#file_prefix3=south-yorkshire
#file_page3=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix3}.html
#file_url3=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix3}-latest.osm.pbf
#
file_prefix3=algeria
file_page3=https://download.geofabrik.de/africa/${file_prefix3}.html
file_url3=https://download.geofabrik.de/africa/${file_prefix3}-latest.osm.pbf
#
# What's the fourth file that we are interested in?
# Note that if this is commented out, also change the "merge" below to not use it.
#
#file_prefix4=guernsey-jersey
#file_page4=https://download.geofabrik.de/europe/${file_prefix4}.html
#file_url4=https://download.geofabrik.de/europe/${file_prefix4}-latest.osm.pbf
#file_prefix4=rutland
#file_prefix4=west-yorkshire
#file_page4=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix4}.html
#file_url4=https://download.geofabrik.de/europe/united-kingdom/england/${file_prefix4}-latest.osm.pbf
#
file_prefix4=morocco
file_page4=https://download.geofabrik.de/africa/${file_prefix4}.html
file_url4=https://download.geofabrik.de/africa/${file_prefix4}-latest.osm.pbf
#
# We do not need to turn off any crontabs in this script.
#
# Next get the latest versions of each part of the map style.
#
# This is run from sudo without a connection to an authentication agent, 
# so it makes sense for the git config url to be "https" and the pushurl "git".  
# See https://stackoverflow.com/a/73836045/8145448
#
# Next get the latest versions of each part of the map style.
# Those files that are not expected to be edited here but instead
# generated here have an explicit "git checkout" to avoid:
# "Your local changes to the following files would be overwritten by merge"
#
# How much disk space are we currently using?
#
df
cd /home/${local_filesystem_user}/data
#
# When was the first target file last modified?
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
# When was the second target file last modified?
#
if [ "$1" = "current" ]
then
    ls -t | grep "${file_prefix2}_" | head -1 | sed "s/${file_prefix2}_//" | sed "s/.osm.pbf//" > last_modified2.$$
else
    wget $file_page2 -O file_page2.$$
    grep " and contains all OSM data up to " file_page2.$$ | sed "s/.*and contains all OSM data up to //" | sed "s/. File size.*//" > last_modified2.$$
    rm file_page2.$$
fi
#
file_extension2=`cat last_modified2.$$`
#
if test -e ${file_prefix2}_${file_extension2}.osm.pbf
then
    echo "File2 already downloaded"
else
    wget $file_url2 -O ${file_prefix2}_${file_extension2}.osm.pbf
fi
#
# When was the third target file last modified?
#
if [ "$1" = "current" ]
then
    ls -t | grep "${file_prefix3}_" | head -1 | sed "s/${file_prefix3}_//" | sed "s/.osm.pbf//" > last_modified3.$$
else
    wget $file_page3 -O file_page3.$$
    grep " and contains all OSM data up to " file_page3.$$ | sed "s/.*and contains all OSM data up to //" | sed "s/. File size.*//" > last_modified3.$$
    rm file_page3.$$
fi
#
file_extension3=`cat last_modified3.$$`
#
if test -e ${file_prefix3}_${file_extension3}.osm.pbf
then
    echo "File3 already downloaded"
else
    wget $file_url3 -O ${file_prefix3}_${file_extension3}.osm.pbf
fi
#
# When was the fourth target file last modified?
#
if [ "$1" = "current" ]
then
    ls -t | grep "${file_prefix4}_" | head -1 | sed "s/${file_prefix4}_//" | sed "s/.osm.pbf//" > last_modified4.$$
else
    wget $file_page4 -O file_page4.$$
    grep " and contains all OSM data up to " file_page4.$$ | sed "s/.*and contains all OSM data up to //" | sed "s/. File size.*//" > last_modified4.$$
    rm file_page4.$$
fi
#
file_extension4=`cat last_modified4.$$`
#
if test -e ${file_prefix4}_${file_extension4}.osm.pbf
then
    echo "File4 already downloaded"
else
    wget $file_url4 -O ${file_prefix4}_${file_extension4}.osm.pbf
fi
# -----------------------------------------------------------------------------
# Optionally stop rendering altogether (both renderd and apache2) 
# er to free up memory
# Alternatively, just restart renderd to reduce memory use.
# -----------------------------------------------------------------------------
/etc/init.d/renderd restart
echo ${file_prefix1} ${file_prefix2} ${file_prefix3} ${file_prefix4}
#/etc/init.d/apache2 stop
#
if osmium merge ${file_prefix1}_${file_extension1}.osm.pbf ${file_prefix2}_${file_extension2}.osm.pbf ${file_prefix3}_${file_extension3}.osm.pbf ${file_prefix4}_${file_extension4}.osm.pbf -O -o langs_${file_extension1}_merged.pbf
then
    echo Merge OK
else
    echo Merge Error
    m_error_01
fi

#
# Run Tilemaker to create the vector tiles
#
cd /home/${local_filesystem_user}/src/shortbread-tilemaker
if nice -n 15 sudo -u ${local_filesystem_user} tilemaker --bbox -18.68,-0.36,20.39,37.83  --input /home/${local_filesystem_user}/data/langs_${file_extension1}_merged.pbf     --output /home/${local_filesystem_user}/data/tilemaker_sve03.mbtiles --config /home/${local_filesystem_user}/src/shortbread-tilemaker/config.json --process /home/${local_filesystem_user}/src/shortbread-tilemaker/process.lua 
then
    echo Tilemaker load OK
else
    echo Tilemaker load Error
    m_error_02
fi

# Install our .mbtiles below apache
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_into_apache.sh sve03 sve03 /home/${local_filesystem_user}/data/tilemaker_sve03.mbtiles   http://h31.atownsend.org.uk /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf
#
# Load the svwd11 style into apache
#
sudo /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/svwd_into_apache.sh sve03 svwd11 https://h31.atownsend.org.uk /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd11_spec.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd03_metadata.json /home/${local_filesystem_user}/src/tilemaker/server/static/fonts /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd03_style.json /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources/svwd03_index_nodebug.html svwd03sprite /home/${local_filesystem_user}/src/SomeoneElse-vector-web-display/resources
#
date | mail -s "Tilemaker reload complete on `hostname`" ${local_filesystem_user}

# Tidy temporary files
#
cd /home/${local_filesystem_user}/data
rm langs_${file_extension1}_merged.pbf
#
# Here the raster code reinitialised updating (pyosmium), n/a here
# renderd and apache were also restarted here
#
# And final tidying up
#
final_tidy_up
#
