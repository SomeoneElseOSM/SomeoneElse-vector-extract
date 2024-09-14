# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The logic used here is actually very similar to that used for [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua) and [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua).

## "place"

More important places are written to lower numbered layers: country, state, city at 5, town at 8, suburb, village at 11, hamlet, locality, neighbourhood, isolated_dwelling, farm at 13, anything else at 14.

## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

### name

The value of the OSM name tag

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

### name

The value of the OSM name tag, after postprocessing to e.g. put in brackets if not signed.

### edge

This will be "sidewalk", "verge" or unset.  Influences the rendering on major road types.

## "waterway"

### class

The OSM value for "waterway"

## "building"

No fields yet

## "poi"

### class

Stored as the OSM tag and value, such as "amenity_pub"

### name

the value of the OSM name tag, after any postprocessing e.g. for "operator".


This style is very much still a work in progress.

