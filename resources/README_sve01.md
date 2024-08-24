# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The logic used here is actually very similar to that used for [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua) and [mkgrmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua).

## "transportation"

### class

This is derived from the OSM value for "highway" and the designation.  Values are:

* motorway, trunk, primary, secondary, tertiary, unclassified and residential are handled as normal.
* service without designation are handled as normal
* service with designation are handled as per the designation
* unpaved - unpaved unclassified roads, shown with a solid brown line
* ucrwide, ucrnarrow - unclassified country road; long brown dashes widely or narrowly spaced
* boatwide, boatnarrow - Byway Open to All Traffic; brown dashes widely or narrowly spaced
* rbywide, rbynarrow - Restricted Byway; blue dashes and dots widely or narrowly spaced
* bridlewaywide, bridlewaynarrow - Public Bridleway; blue dots widely or narrowly spaced
* bridlewaysteps - Public Bridleway; wide blue dashes
* footwaywide, footwaynarrow - Public Footpath; salmon dots widely or narrowly spaced
* footwaysteps - Public Footpath; wide salmon dashes
* pathwide, pathnarrow - no designation; black dots widely or narrowly spaced
* steps - no designation; wide black dashes

* edge - "sidewalk", "verge" or unset.  Influences the rendering on major road types.

## "waterway"

* class - the OSM value for "waterway"

## "building"

No fields

## "poi"

* class - stored as the OSM tag and value, such as "amenity_pub"
* name - the value of the OSM name tag.


This style is very much still a work in progress.

