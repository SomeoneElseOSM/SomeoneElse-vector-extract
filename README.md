# SomeoneElse-vector-extract

This repository contains:

* Scripts for managing vector map schemas for use with [Tilemaker](https://github.com/systemed/tilemaker) and associated software.
* An example [schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md).

It is designed to be used together with:

* Scripts for managing vector map display styles (with Apache)
* An example [web map style](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md).

The scripts here are:

* `sve_extract.sh`, which (using a download from [Geofabrik](https://download.geofabrik.de/)) creates a ".mbtiles" file in a "~/data" directory.
* `sve_into_apache.sh`, which installs that ".mbtiles" file into apache so that it can be served using [mod_mbtiles](https://github.com/systemed/mod_mbtiles).
* `sve_delete.sh`, which removes a ".mbtiles" file from Apache.

The parameters passed to `sve_extract.sh` include a set of Tilemaker data extraction rules (see e.g. https://github.com/systemed/tilemaker/blob/master/resources/config-example.json and https://github.com/systemed/tilemaker/blob/master/resources/process-example.lua ) that offer similar data extraction capabilities to https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua (for raster web maps) or https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua (for mkgmap-built maps for Garmin devices).

It also allows this to be merged in with an existing set of [previously=extracted](https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#creating-a-map-with-varying-detail) "sea" tiles.


## Running the scripts - a simple example

Note that there is a [helper script](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/update_vector.sh) that can be modified to automate the schema and style processes for your own server and account names.

Each script takes lots of parameters - taking the calls one at a time:

"sve_extract.sh" needs to know the location of the [config](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/config-sve01.json) and [processing lua](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/process-sve01.lua) for the schema, and the output location for the ".mbtiles" file.  It also needs a bounding box ("-27.57,34.5,40.17,71.64" is "Brtian and Ireland and a bit more").

The next parameter is either a a path to a "coastline.mbtiles" file or "nocoast" to not merge with a set of coastline tiles.  When a coastline path is provided, that is copied to the output file and the OSM data merged into that, so the original "coastline.mbtiles" file is not modified.

Finally parameters are supplied for downloading a Geofabrik region - the format is something like:

* europe united-kingdom england north-yorkshire

Between one and four parameters will be needed here, depending on the region.  Downloads are cached in the ~/data directory.  Files are created at Geofabrik daily, and if a particular day's file has been downloaded it won't be downloaded again.

Note that the lua processing uses a [lua script](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/shared_lua.lua) shared with the "[raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style)" code.  See [the script itself](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/sve_extract.sh#L31) for more details.  The location that Tilemaker / lua looks in for these shared functions varies by lua version, but helpfully if it can't find the shared code it will say where it has looked and you can put the code there.

After a successful run, you should see:

    Filled the tileset with good things at /home/username/data/tilemaker_sve01.mbtiles

The "config" and "process" files in the example above are for [one particular schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md), but you can use it with other schemas too, for example "[shortbread tilemaker](https://shortbread-tiles.org/make-vectortiles/)":

    ./sve_extract.sh ~/src/shortbread-tilemaker/config.json ~/src/shortbread-tilemaker/process.lua ~/data/tilemaker_sve03.mbtiles   -27.57,34.5,40.17,71.64 nocoast europe britain-and-ireland

Again, the parameters after the bounding box are the path to select at http://download.geofabrik.de/ to locate the initial file to download.  

Once the .mbtiles file has been created, it can be installed below Apache using something like this

    sudo /home/username/src/SomeoneElse-vector-extract/sve_into_apache.sh sve01 sve01 /home/username/data/tilemaker_sve01.mbtiles   http://localipaddress /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf

The first "sve01" used above is part of the "name of the tileset created by sve_extract.sh and Tilemaker"; the second is the "name of the deployment".  This allows for testing of the same schema with minor changes under different names.  Although that script takes parameters for both an http and https Apache config, to prevent mixed content warnings you'll want to be consistent about only using either https or http throughout.  That script will look for a "MbtilesEnabled true" line in the Apache configs and write (in this case)

    MbtilesAdd sve01 /var/www/html/vector/sve01/tilemaker_sve01.mbtiles

after it.  The scripts in "[SomeoneElse-vector-web-display](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display)" can then create a simple website using those tiles.

Finally, to remove a set of .mbtiles from the Apache configurations there is

    sudo ./sve_delete.sh sve01 /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf

