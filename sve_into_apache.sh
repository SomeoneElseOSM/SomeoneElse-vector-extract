#!/bin/bash
# -----------------------------------------------------------------------------
# sve_into_apache.sh
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
# -----------------------------------------------------------------------------
# See also
# https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/svwd_into_apache.sh
# which also installs a map style as well.
#
# This script makes some assumptions about where things are:
#
# Apache subdirectory for generated tiles, json and html files, etc.
APACHE_SUBDIR=/var/www/html/vector
#
# File extension of json files is assumed to be ".json";
# File extension of html file is assumed to be ".html".
# Generated .mbtiles files are currently assumed to be prefixed with "tilemaker_".
# -----------------------------------------------------------------------------
# After running Tilemaker to create some vector tiles, this script is designed
# to copy the necessary support files to an apache website.
#
# Install https://github.com/systemed/mod_mbtiles , then edit the apache site 
# config such as "000-default.conf" to contain something like:
#
# MbtilesEnabled true
#
# After that, this script will add something like:
# MbtilesAdd sve01 "/var/www/html/vector/sve01/output_sve01.mbtiles"
#
# (modifying the path in that line as needed)
#
# -----------------------------------------------------------------------------
# Then (as root) run this script, with the following parameters.
# These must not contain spaces.  Full paths, no "~".
#
# Parameter: For example:                                                   Meaning:
# $1         omt_ny                                                         name of this tileset.  
# $2         omt_ny_1                                                       name of this deployment.
# $3         /home/ajtown/data/tilemaker_omt_ny.mbtiles                     location of this tileset.
# $4         http://localhost                                               target index URL part 1
# $5         /etc/apache2/sites-available/000-default.conf                  location of one Apache config file
# $6         /etc/apache2/sites-available/default-ssl.conf                  location of other Apache config file
#
# Set e.v.s for these parameters
TILESET_NAME=$1
DEPLOYMENT_NAME=$2
TILESET_LOCATION=$3
DEPLOYMENT_URL=$4
APACHECONF_LOCATION1=$5
APACHECONF_LOCATION2=$6
#
# -----------------------------------------------------------------------------
# Now we have all the information we need.
# Create a directory for the generated vector tiles and copy the files there
# -----------------------------------------------------------------------------
if [ "${TILESET_NAME}" = "" ]
then
    echo "No tileset installed; no name provided"
else
    if [ "${TILESET_LOCATION}" = "" ]
    then
	echo "No tileset installed; no source provided"
    else
	if [ -f "${TILESET_LOCATION}" ]
	then
	    mkdir -p ${APACHE_SUBDIR}/${TILESET_NAME}
	    cp ${TILESET_LOCATION} ${APACHE_SUBDIR}/${TILESET_NAME}
	    echo "Copied tileset into:   ${APACHE_SUBDIR}/${TILESET_NAME}"
	else
	    echo "No tileset installed; source does not exist: ${TILESET_LOCATION}"
	fi
    fi
    #
    # -----------------------------------------------------------------------------
    # Add tileset location to one apache config file
    # -----------------------------------------------------------------------------
    if [ "${APACHECONF_LOCATION1}" = "" ]
    then
	echo "Apache config file 1 untouched; name not provided"
    else
	if [ -f "${APACHECONF_LOCATION1}" ]
	then
	    if grep 'MbtilesEnabled true' ${APACHECONF_LOCATION1} > /dev/null
	    then
		grep -v "MbtilesAdd ${TILESET_NAME}" ${APACHECONF_LOCATION1} > apacheconf_temp.$$
		sed "/MbtilesEnabled /a MbtilesAdd ${TILESET_NAME} /var/www/html/vector/${TILESET_NAME}/tilemaker_${TILESET_NAME}.mbtiles" apacheconf_temp.$$ > ${APACHECONF_LOCATION1}
		rm apacheconf_temp.$$
		systemctl restart apache2
		echo "Apache config file updated: ${APACHECONF_LOCATION1}"

		# -----------------------------------------------------------------------------
		# Add tileset location to other apache config file
		# -----------------------------------------------------------------------------
		if [ "${APACHECONF_LOCATION2}" = "" ]
		then
		    echo "Apache config file 2 untouched; name not provided"
		else
		    if [ -f "${APACHECONF_LOCATION2}" ]
		    then
			if grep 'MbtilesEnabled true' ${APACHECONF_LOCATION2} > /dev/null
			then
			    grep -v "MbtilesAdd ${TILESET_NAME}" ${APACHECONF_LOCATION2} > apacheconf_temp.$$
			    sed "/MbtilesEnabled /a MbtilesAdd ${TILESET_NAME} /var/www/html/vector/${TILESET_NAME}/tilemaker_${TILESET_NAME}.mbtiles" apacheconf_temp.$$ > ${APACHECONF_LOCATION2}
			    rm apacheconf_temp.$$
			    systemctl restart apache2
			    echo "Apache config file updated: ${APACHECONF_LOCATION2}"
			else
			    echo "Apache config file untouched; MbtilesEnabled true missing from ${APACHECONF_LOCATION2}"
			fi
		    else
			echo "Apache config file untouched; does not exist: ${APACHECONF_LOCATION2}"
		    fi
		fi
		# if [ "${APACHECONF_LOCATION2}" = "" ]
	    else
		echo "Apache config file untouched; MbtilesEnabled true missing from ${APACHECONF_LOCATION1}"
	    fi
	else
	    echo "Apache config file untouched; does not exist: ${APACHECONF_LOCATION1}"
	fi
    fi
    #
fi # [ "${TILESET_NAME}" = "" ]
#
