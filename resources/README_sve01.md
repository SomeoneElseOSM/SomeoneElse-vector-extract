# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

As with the parent style, releases are simply datestamped.  As written this corresponds to release 20241110.

This only describes the schema and the data extraction that supports that schema.  See also the [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md) for an example display style, and also the main project [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md) for the top=level scripts.

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The logic used here is actually very similar to that used for [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua) and [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua).

## "water"

This layer is for background sea map tiles.  See https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#creating-a-map-with-varying-detail .

### class

Set to "ocean".


## "place"

More important places are written to lower numbered layers: country, state to all layers, capital at 3, city at 5, town at 8, suburb, village at 11, hamlet, locality, neighbourhood, isolated_dwelling, farm at 13, anything else at 14.

### class

Usually the place value (e.g. "city"). Set to "capital" (regardless of the place value) if it is a capital.

### name

The value of the OSM name tag.


## "transportation"

This is for linear road, rail, air and water transport.

### class

Values are written as e.g. "motorway" without the OSM tag (here "highway") as part of the key.

For roads, this is derived from the OSM value for "highway" and the designation.  Values from OSM are processed as follows:

* motorway, trunk, primary, secondary, tertiary, unclassified and residential are handled as normal.
* service _without_ designation: "important" ones are handled as normal ("service"), "less important" as "driveway".
* service _with_ designation are handled as per the designation below.
* unpaved - these are unclassified roads that are unpaved; intended to be shown visually different from paved ones.
* ucrwide, ucrnarrow - unclassified country road intended to be shown visually between unpaved and BOAT.
* boatwide, boatnarrow - Byway Open to All Traffic; wide (>=2m) or narrow.
* rbywide, rbynarrow - Restricted Byway; wide or narrow.
* bridlewaywide, bridlewaynarrow - Public Bridleway; wide or narrow.
* bridlewaysteps - Public Bridleway; but steps.
* footwaywide, footwaynarrow - Public Footpath; wide (typically "service" or "track" in OSM) or narrow (typically "footway" or "path").
* footwaysteps - Public Footpath; but steps.
* pathwide, pathnarrow - no designation; wide or narrow.
* steps - no designation; steps.

The MinZoom on each of these is broadly appropriate to the road type, varying from 3 for motorways to 12 to paths.

Genuine highway areas are handled via "land1", not here.  For some highway types that are closed ways, "area" needs to be checked to choose which layer something should be processed as:

* "highway=pedestrian" ways are assumed to be areas if closed unless "area=no" is set.
* "highway=leisuretrack" and "highway=gallop" (which is what "leisure=track" will be processed into based on "sport" tags") are assumed to be linear unless "area=no" is set.

Closed "barrier=hedge" are assumed to be linear if there is some other area tag on the object (e.g. "landuse=farmland"), otherwise areas.

Numerous other tags (e.g. "man_made=pier") may be linear or occur on areas; other than the exceptions noted above this is usually based on whether the way is closed or not.

### name

The value of the OSM name tag, after postprocessing to e.g. put in brackets if unsigned.

### ref

The value of the OSM ref tag, after postprocessing to e.g. put in brackets if unsigned.

### ref_len

The length of the OSM ref tag, designed to make choice of e.g. road shield backgrounds easier.

### edge

This will be "sidewalk", "verge", "ford" or unset.  Designed to influence the rendering on major road types.

### bridge

A boolean value set to true if a bridge.

### tunnel

A boolean value set to true if a tunnel.

"bridge" and "tunnel" tags can coexist and a map style consuming this schema needs to deal with that.

### access

Set to "no" if "access=no", "destination" if "access=destination", where "access" has been derived from "foot" if set and appropriate.  This schema tries to give a pedestrian-centric view of access-rights.

### oneway

The value of the OSM "oneway" tag - typically "yes" or "-1".


## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas and points go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

For area, polygons for features are written at an appropriate zoom level, which depending on the feature (e.g. "natural=water", "leisure=ature_reserve") and may vary based on way_area.

Those "landuse, leisure, etc." features that are often large will be written out twice - once as a polygon without a name, and once as a centroid with a name (if one exists).  Things considered "large" and written out in this way include:

* zoom 5+ to 8+ "natural=water"
* all zoom 14 "historic=" tags ("battlefield" etc. - here the area is written out as "landuse=historic" and the centroid as e.g. "historic=battlefield")
* all zoom 10 "landuse=" tags ("forest", "farmland", etc.)
* all zoom 13 "leisure=" tags ("nature_reserve", "park", etc.)
* zoom 14 university, school, etc.

Just the centroid is wrtten for:

* "leisure=leisurenonspecific" at zoom 14

### class

This is based on the OSM tag, processed to create some derived values such as "landuse=farmgrass" for both agricultural meadows and farmland that is pasture, paddock, etc.

Values are written as e.g. "landuse_farmland" with the OSM tag as part of the key.

### name

The value of the OSM `name` tag, after any name processing logic to (perhaps) append operator etc.

### access

The value of the OSM `access` tag is included for `amenity=bicycle_rental`, `amenity=scooter_rental`, `amenity=bicycle_parking`, `amenity=motorcycle_parking` and the `_pay` versions of the latter two.

### ele

Either the value of the OSM ele tag, or for some features used to pass a "more detailed name" to the display map style.  This allows (for example) "headline information" to be displayed for a signpost at lower zoom levels but detailed directions at higher ones.

### way_area

Set to the results of "Area()" for certain types of closed polygons (currently "natural=water").  Values here are roughly 2.9 times the equivalent raster way_area values.

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

"bridge" and "tunnel" tags can coexist and a map style consuming this schema needs to deal with that.


## "linearbarrier"

All features here are linear.  Point or polygon features will go in "land1" or "land2".  Most features here are barriers, but things like power lines are also included.

### class

Generally speaking, the OSM value for "barrier".

### name

The value of the OSM name tag


## "building"

### class

Stored as the processed OSM tag and value, such as "building_roof"

### name

the value of the OSM "name" tag, after any postprocessing e.g. for "operator".

### housenumber

the value of the OSM "addr:housenumber" tag, after postprocessing.

### housename

the value of the OSM "addr:housename" tag, after postprocessing.


## "poi"

Not written by default - this is an optional catch-all that can output everything not handled by "land1" processing.  Uncomment out "generic_after_poi( passedt )" to produce this layer, which contains all unhandled "amenity", "shop" and "tourism" features.

### class

Stored as the OSM tag and value, such as "amenity_wibble", where "wibble" is not an amenity value already expected by the "land1" layer.

### name

the value of the OSM name tag, after any postprocessing e.g. for "operator".


For individual source tag values used see [here](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags)



