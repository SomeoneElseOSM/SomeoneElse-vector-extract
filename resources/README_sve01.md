# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The logic used here is actually very similar to that used for [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua) and [mkgrmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua).

## "transportation"

* class - the OSM value for "highway"
* edge - "sidewalk", "verge" or unset.

## "waterway"

* class - the OSM value for "waterway"

## "building"

No fields

This style is Not yet fully functional - it is still very much a work in progress.

