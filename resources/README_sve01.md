# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The logic used here is actually very similar to that used for [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua) and [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua).

## "place"

More important places are written to lower numbered layers: country, state to all layers, capital at 3, city at 5, town at 8, suburb, village at 11, hamlet, locality, neighbourhood, isolated_dwelling, farm at 13, anything else at 14.

### class

Usually the place value (e.g. "city") or "capital" (regardless of the place value) if it is a capital.

### name

The value of the OSM name tag

## "linearbarrier"

### class

Generally speaking, the OSM value for "barrier".

### name

The value of the OSM name tag

## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

Values are written as e.g. "landuse_farmland" with the OSM tag as part of the key.

### name

The value of the OSM name tag

### ref

Either the value of the OSM ref tag, or used to pass a "more detailed name" to the display map style.

## "transportation"

This is for linear highways etc.

### class

This is derived from the OSM value for "highway" and the designation.  Values are:

* motorway, trunk, primary, secondary, tertiary, unclassified and residential are handled as normal.
* service without designation: "important" ones are handled as normal, "less important" as driveway.
* service with designation are handled as per the designation
* unpaved - unpaved unclassified roads, intended to be shown visually different from paved ones
* ucrwide, ucrnarrow - unclassified country road intended to be shown visually between unpaved and BOAT
* boatwide, boatnarrow - Byway Open to All Traffic; wide or narrow
* rbywide, rbynarrow - Restricted Byway; wide or narrow
* bridlewaywide, bridlewaynarrow - Public Bridleway; wide or narrow
* bridlewaysteps - Public Bridleway; but steps
* footwaywide, footwaynarrow - Public Footpath; wide or narrow
* footwaysteps - Public Footpath; but steps
* pathwide, pathnarrow - no designation; wide or narrow
* steps - no designation; steps

The MinZoom on each of these is broadly appropriate to the road type, varying from 3 for motorways to 12 to paths.

Genuine highway areas are handled via "land1", not here.  For some highway types that are closed ways, "area" needs to be checked to choose which layer something should be processed as.

### name

The value of the OSM name tag, after postprocessing to e.g. put in brackets if not signed.

### edge

This will be "sidewalk", "verge", "ford" or unset.  Designed to influence the rendering on major road types.

### bridge

A boolean value set to true if a bridge.

### tunnel

A boolean value set to true if a tunnel.

### access

Set to "no" if access=no.

## "waterway"

This is for linear waterways.

### class

The OSM value for "waterway" after processing based on "intermittent" etc.

### name

the value of the OSM name tag, after any postprocessing e.g. for "operator".

### bridge

A boolean value set to true if a bridge.

### tunnel

A boolean value set to true if a tunnel.

## "building"

### class

Stored as the processed OSM tag and value, such as "building_roof"

### name

the value of the OSM name tag, after any postprocessing e.g. for "operator".

## "poi"

### class

Stored as the OSM tag and value, such as "amenity_pub".  This is a temporary catch-all; things that exist in "land1" won't also be written here - the display style must source name and class (for icon) from "land1".

### name

the value of the OSM name tag, after any postprocessing e.g. for "operator".


For individual source tag values used see [here](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags)

This style is very much still a work in progress.

