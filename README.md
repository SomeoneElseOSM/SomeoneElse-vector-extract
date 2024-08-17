# SomeoneElse-vector-extract

This is intended to become a set of Tilemaker data extraction rules (see e.g. https://github.com/systemed/tilemaker/blob/master/resources/config-example.json and https://github.com/systemed/tilemaker/blob/master/resources/process-example.lua ) that offer similar data extraction capabilities to https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua (for raster web maps) or https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua (for mkgmap-built maps for Garmin devices).

Currently it just creates a set of .mbtiles with a very small set of example features in them, for testing the scripts etc. in "SomeoneElse-vector-web-display".

Not yet functional - still very much a work in progress.

## Running the scripts

Prerequisites - you're running this from ~/src/SomeoneElse-vector-extract and there's an existing ~/data directory.  You have a "standard" Ubuntu or Debian system with an Apache web server.

As a simple example:

    ./sve_extract.sh ~/src/SomeoneElse-vector-extract/resources/config-sve01.json ~/src/SomeoneElse-vector-extract/resources/process-sve01.lua ~/data/tilemaker_sve01.mbtiles   -27.57,34.5,40.17,71.64 europe united-kingdom england north-yorkshire

Note that this uses a [lua script](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/shared_lua.lua) shared with the "[raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style)" code.  See [the script itself](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/sve_extract.sh#L31) for more details.  After a successful run, you should see:

    Filled the tileset with good things at /home/username/data/tilemaker_sve01.mbtiles

The "config" and "process" files in the example above are for a [simple schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md), but you can use it with other schemas too, for example "[shortbread tilemaker](https://shortbread-tiles.org/make-vectortiles/)":

    ./sve_extract.sh ~/src/shortbread-tilemaker/config.json ~/src/shortbread-tilemaker/process.lua ~/data/tilemaker_sve03.mbtiles   -27.57,34.5,40.17,71.64 europe britain-and-ireland

The parameters after the bounding box are the path to select at http://download.geofabrik.de/ to locate the initial file to download.  Downloads are cached in the ~/data directory.

Once the .mbtiles file has been created, it can be installed below Apache using something like this

    sudo /home/username/src/SomeoneElse-vector-extract/sve_into_apache.sh sve01 sve01 /home/username/data/tilemaker_sve01.mbtiles   http://localipaddress /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf

That script will look for a "MbtilesEnabled true" line in the Apache config and write (in this case)

    MbtilesAdd sve01 /var/www/html/vector/sve01/tilemaker_sve01.mbtiles

after it.  The scripts in "[SomeoneElse-vector-web-display](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display)" can then create a simple website using those tiles.

Finally, to remove a set of .mbtiles from the Apache configurations there is

    sudo ./sve_delete.sh sve01 /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf



