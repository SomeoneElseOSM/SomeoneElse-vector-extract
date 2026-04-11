#!/bin/bash
# ------------------------------------------------------------------------------
# analyse_apache_logs.sh
# 
# Copyright (C) 2026  Andy Townsend
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
# This script is designed to be run as root in an empty directory.  
# For example:
#
# cd
# mkdir temp; cd temp
# mkdir test01; cd test01
#
# # Ensure apache logs are empty
# logrotate -f /etc/logrotate.d/apache2 
# 
# # Start a new incognito/private browser window
# # Navigate to test area (IP address will vary)
# # http://127.0.0.1/vector/#3/51.502/-1.668
# # Zoom in, one level at a time until at least vector zoom 14
# # Then, in the empty directory, run this script.
#
grep /sve01/14 /var/log/apache2/access.log > z14a.log
grep /sve01/13 /var/log/apache2/access.log > z13a.log
grep /sve01/12 /var/log/apache2/access.log > z12a.log
grep /sve01/11 /var/log/apache2/access.log > z11a.log
grep /sve01/10 /var/log/apache2/access.log > z10a.log
grep /sve01/9 /var/log/apache2/access.log > z09a.log
grep /sve01/8 /var/log/apache2/access.log > z08a.log
grep /sve01/7 /var/log/apache2/access.log > z07a.log
grep /sve01/6 /var/log/apache2/access.log > z06a.log
grep /sve01/5 /var/log/apache2/access.log > z05a.log
grep /sve01/4 /var/log/apache2/access.log > z04a.log
grep /sve01/3 /var/log/apache2/access.log > z03a.log
#
sed 's/.* 200 //' z03a.log | sed 's/ .*//' > z03b.log
sed 's/.* 200 //' z04a.log | sed 's/ .*//' > z04b.log
sed 's/.* 200 //' z05a.log | sed 's/ .*//' > z05b.log
sed 's/.* 200 //' z06a.log | sed 's/ .*//' > z06b.log
sed 's/.* 200 //' z07a.log | sed 's/ .*//' > z07b.log
sed 's/.* 200 //' z08a.log | sed 's/ .*//' > z08b.log
sed 's/.* 200 //' z09a.log | sed 's/ .*//' > z09b.log
sed 's/.* 200 //' z10a.log | sed 's/ .*//' > z10b.log
sed 's/.* 200 //' z11a.log | sed 's/ .*//' > z11b.log
sed 's/.* 200 //' z12a.log | sed 's/ .*//' > z12b.log
sed 's/.* 200 //' z13a.log | sed 's/ .*//' > z13b.log
sed 's/.* 200 //' z14a.log | sed 's/ .*//' > z14b.log
#
sort -n -r z03b.log > z03c.log
sort -n -r z04b.log > z04c.log
sort -n -r z05b.log > z05c.log
sort -n -r z06b.log > z06c.log
sort -n -r z07b.log > z07c.log
sort -n -r z08b.log > z08c.log
sort -n -r z09b.log > z09c.log
sort -n -r z10b.log > z10c.log
sort -n -r z11b.log > z11c.log
sort -n -r z12b.log > z12c.log
sort -n -r z13b.log > z13c.log
sort -n -r z14b.log > z14c.log
#
head -1 z03c.log
head -1 z04c.log
head -1 z05c.log
head -1 z06c.log
head -1 z07c.log
head -1 z08c.log
head -1 z09c.log
head -1 z10c.log
head -1 z11c.log
head -1 z12c.log
head -1 z13c.log
head -1 z14c.log
#
# # The output above is the maximum tile size of each zoom level 
# # from 3 through to 14 encountered.
#
