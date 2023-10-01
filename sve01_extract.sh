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
# -----------------------------------------------------------------------------
time tilemaker --input ~/data/north-yorkshire_2023-09-25T20:21:15Z.osm.pbf     --output ~/data/tilemaker_sve01.mbtiles --config ~/src/SomeoneElse-vector-extract/resources/config-sve01.json --process ~/src/SomeoneElse-vector-extract/resources/process-sve01.lua
#
