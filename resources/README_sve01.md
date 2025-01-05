# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

As with the parent style, releases are simply datestamped.  As written the most recent releases was "20241226"; this README corresponds with the latest version of the committed code (some time after that).

This only describes the schema and the data extraction that supports that schema.  See also the [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md) for an example display style, and also the main project [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md) for the top=level scripts.

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The main lua processing logic logic used here is actually shared with the equivalent [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua), and is also similar to that used for [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua) as well.

The keys and values present in the data at the time when it is written out to vector tiles will differ significantly from the original OSM keys.  As an example, "function wr_after_highway( passedt )", which writes highway information to vector tiles will be passed `highway` values such as `gallop`, which has been calculated based on the various OSM tags and values on the way.  The [taginfo](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags) entry for this project references actual OSM tags and values, but the tags and values listed below (e.g. `highway=gallop`) are after the initial lua processing.

The `name` values written to features to several layers may incorporate `operator` and `brand` as appropriate, and may be suppressed or written out in brackets if a feature has been tagged as being unsigned.


## "water"

This layer is for background sea map tiles.  See https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#creating-a-map-with-varying-detail .

### class

Set to "ocean".


## "place"

More important regular place nodes are written to lower numbered layers: country, state to all layers, capital at 3, city at 5, town at 8, suburb, village at 11, hamlet, locality, neighbourhood, isolated_dwelling, farm at 13.  Other values are ignored.  Only OSM nodes are processed for the "place" layer; there's too much randomness in OSM way and relation place data to use that.

Islands and islets are written as `place=island`, at a zoom level based on way_area. `way_area` is also written for islands, to allow higher zoom level display decisions to be made.

### class

Usually the `place` value (e.g. `city`). Set to `capital` (regardless of the place value) if it is a capital.

### name

The value of the OSM name tag.

### way_area

Written for islands only.

## "transportation"

This is for linear road, rail, air and water transport.

### class

Values are written as e.g. `motorway` without the OSM tag (here `highway`) as part of the key.  Many of these tag values are a result of previous lua processing (see note above).  For roads, this is derived from the OSM value for `highway` and the designation, so `highway=bridlewaysteps` will in OSM likely be a `highway=steps` with `designation=public_bridleway`.  Values after the initial lua processing wre written out to vector tiles as follows:

* motorway, trunk, primary, secondary, tertiary, unclassified and residential and links are handled as normal.
* service _without_ designation: "important" ones are handled as normal (`service`); "less important" (`parking_aisle`,`drive-through`,`driveway`) as `driveway`.
* service _with_ `designation` are handled as per the designation below.
* unpaved - these are unclassified roads that are unpaved; intended to be shown visually different from paved ones.
* ucrwide, ucrnarrow - unclassified country road intended to be shown visually between unpaved and BOAT.
* boatwide, boatnarrow - Byway Open to All Traffic; wide (>=2m) or narrow.
* rbywide, rbynarrow - Restricted Byway; wide or narrow.
* bridlewaywide, bridlewaynarrow - Public Bridleway; wide or narrow.
* bridlewaysteps - Public Bridleway; but steps.
* footwaywide, footwaynarrow - Public Footpath; wide (typically `service` or `track` in OSM) or narrow (typically `footway` or `path`).
* footwaysteps - Public Footpath; but steps.
* pathwide, pathnarrow - no designation; wide or narrow.
* steps - no designation; steps.

The MinZoom on each of these is broadly appropriate to the road type, varying from 3 for motorways to 12 to paths.

Genuine highway areas are handled via "land1", not here.  For some highway types that are closed ways, `area` needs to be checked to choose which layer something should be processed as:

* `highway=pedestrian` ways are assumed to be areas if closed unless `area=no` is set.
* `highway=leisuretrack` and `highway=gallop` (which is what `leisure=track` will be processed into based on `sport` tags) are assumed to be linear unless `area=no` is set.

Closed `barrier=hedge` are assumed to be linear if there is some other area tag on the object (e.g. `landuse=farmland`), otherwise areas.

Numerous other tags (e.g. `man_made=pier`) may be linear or occur on areas; other than the exceptions noted above this is usually based on whether the way is closed or not.

### name

The value of the OSM name tag, after the postprocessing described above to e.g. put in brackets if unsigned.

### ref

The value of the OSM ref tag, after postprocessing to e.g. put in brackets if unsigned.

### ref_len

The length of the OSM ref tag, designed to make choice of e.g. road shield backgrounds easier.  Values for `ref` tend to be short (e.g. "A1") or long (e.g. "A627(M)"); generally speaking a split at "less than 6 characters" works well visually.

### edge

This will be `sidewalk`, `verge`, ford` or unset.  Designed to be used to influence the rendering on major road types.

### bridge

A boolean value set to true if a bridge.

### tunnel

A boolean value set to true if a tunnel.

The `bridge` and `tunnel` tags can coexist and a map style consuming this schema needs to deal with that.

### access

Set to `no` if `access=no`, `destination` if `access=destination`, where `access` has been derived from `foot` if set and appropriate.  This schema tries to give a pedestrian-centric view of access-rights.  Note that the access logic here differs from that used for parking features (for cars, bicycles and motorcycles) in "land1".  See the "land1" layer below for that.

### oneway

The value of any OSM `oneway` tag - typically `yes` or `-1`.


## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas and points go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

Features are written at an appropriate zoom level, which depending on the feature (e.g. "natural=water", "leisure=nature_reserve") and that zoom level may vary based on way_area.

A number of "`landuse`, `leisure`, etc." features that may be either large or small will be written out twice - once as a polygon without a name, so that a rendering style can show an appropriate fill and outline, and once as a centroid with a name (if one exists), together with the way_area of the polygon.  This allows the fill and/or outline for these features to be shown at one (lower) zoom level, and the `name` at a higher one, and the rendering style may choose to display larger feature names earlier than smaller ones.

.  Things considered "large" and written out in this way include (from "land1"):

* zoom 5+ to 8+ `natural=water`, `natural=intermittentwater`, `natural=glacier`, `natural=bay`.
* zoom 6-9 `leisure=nature_reserve`.
* zoom 7 `natural=desert`
* zoom 8 `landuse` tags `forest`, `farmland`.
* zoom 8 `natural` tags `wood`, `broadleaved`, `needleleaved`, `mixedleaved`.
* zoom 8 Various power features extracted as `man_made=power`, `man_made=power_water` and `man_made=power_wind`.
* zoom 9 various parking `amenity` tags (`parking`, `parking_pay`, `parking_freedisabled`, `parking_paydisabled`)
* zoom 9 `amenity` tags `university`, `college`, `school`, `hospital`, `kindergarten`.
* zoom 9 `tourism` tag `attraction`.  Consumers need to take care with this because in "land1" this shouldn't be allowed to obliterate smaller "land1" objects mapped.  Rendering a fill with a low maxzoom is one option.
* zoom 9-13 various `landuse` tags: `grass`, `residential`, `meadow`, `wetmeadow`, `farmyard`, `farmgrass`, `recreation_ground`, `retail`, `industrial`, `railway`, `commercial`, `brownfield`, `greenfield`, `construction`, `landfill`, `historic`, `orchard`, `meadowtransitional`, `meadowwildflower`, `meadowperpetual`, `saltmarsh`, `reedbed`, `allotments`, `christiancemetery`, `jewishcemetery`, `othercemetery`.
* zoom 9-13 various `leisure` tags `common`, `dog_park`, `park`, `recreation_ground`, `garden`, `golfgreen`, `golf_course`, `sports_centre`, `stadium`, `pitch`, and closed examples of `track`.
* zoom 9-13 various `natural` tags `beach`, `tidal_beach`, `mud`, `tidal_mud`, `bare_rock`, `tidal_rock`, `sand`, `tidal_sand`, `scree`, `tidal_scree`, `shingle`, `tidal_shingle`, `heath`, `grassland`, `scrub`.
* zoom 10 `landuse` tags `village_green`, `quarry`, `historicquarry`.
* zoom 10 point and area `aeroway` tags `runway` and `grass_runway`.
* zoom 10 `waterway=damarea`
* zoom 12 `natural` tags `wetland`, `reef`, `reefsand`.
* zoom 12 point and area `aeroway` tags `apron` and `taxiway`.
* zoom 12 `tourism` tags `camp_site`, `caravan_site` and `theme_park`.
* all zoom 14 `historic=` tags (`battlefield` etc. - here the area is written out as `landuse=historic` and the centroid as e.g. `historic=battlefield`)
* zoom 14 point and area `aeroway` tags `helipad` and `gate`.
* zoom 14 `tourism` tags `hotel`, `motel`, `museum`, `chalet`.
* zoom 14 `amenity` tag `ferry_terminal`.
* zoom 14 `landuse` tag `industrialbuilding`.
* zoom 14 `leisure` tag `leisurenonspecific`.
* zoom 14 many `shop` tags (the vast majority with a usage of at least tens in UK/IE, and some others).

from "land2:

* zoom 0-12 `boundary=administrative` (zoom based on admin level: 2->0, 3,4->7, 5,6,7->8, 8,9,10->10, 11->12).
* zoom 6 `landuse=military`
* zoom 6 `boundary=national_park`, `boundary=access_land`.
* zoom 12 `aeroway=aerodrome` and `aeroway=large_aerodrome`.
* zoom 13 `leisure=harbour`.
* zoom 13 `leisure=marina`.

Features written out just once, as a point or polygon, with a name if one exists, include:

* zoom 8 `natural-bigprompeak`.
* zoom 9 `military=barracks`
* zoom 9 `natural=bigpeak`
* zoom 10 `natural=peak`, `natural=saddle`, `natural=volcano`.
* zoom 11 closed `man_made=pier` areas.
* zoom 11 `railway=station`
* zoom 11 `landuse=garages`
* zoom 12 `railway=halt`, railway=tram_stop` and `aerialway=station`.
* zoom 12 `man_made=bigchimney`
* zoom 12 some `highway` street areas, usually after explicit checks on `is_closed` and the `area` tag.
* zoom 12 `landuse=vineyard`
* zoom 12 `natural=hill`
* zoom 12 `tourism=theme_park`
* zoom 12 `leisure` tags `playground`, `schoolyard`.
* zoom 13 `amenity` tags `holy_spring`, `holy_well`, `watering_place`.
* zoom 13 `man_made=bigobservationtower`
* zoom 13 `natural=spring`
* zoom 13 `leisure` tag `swimming_pool`.
* zoom 14 many `amenity` tags such as the various tags for bars, cafes, pitches, pubs and many more.
* zoom 14 most remaining `man_made` features such as `chimney` etc.
* zoom 14 `office` tags `craftbrewery`, `craftcider` and `nonspecific`.
* zoom 14 many `highway` tags such as the various bus stop tags etc.
* zoom 14 `highway` and `railway` platform areas, usually after explicit checks on `is_closed` and the `area` tag.  Also railway turntables.
* zoom 14 `leisure` tags `bandstand`, `bleachers`, `fitness_station`, `picnic_table`, `slipway`, `bird_hide`, `hunting_stand` and `grouse_butt`.
* zoom 14 `natural` tags `cave_entrance`, `sinkhole`, `climbing`, `rock`, `tree`, `shrub`.
* zoom 14 point and (multi)polygon `waterway=lock_gate`, `waterway=sluice_gate`, `waterway=waterfall`, `waterway=weir`, `waterway=floating_barrier`.

### class

This is based on the OSM tag, processed to create some derived values such as `landuse=farmgrass` for both agricultural meadows and farmland that is pasture, paddock, etc.

Values are written as e.g. `landuse_farmland` with the OSM tag as part of the key.

### name

The value of the OSM `name` tag, after any name processing logic to (perhaps) append operator etc.

### access

The value of the OSM `access` tag is included for `amenity=bicycle_rental`, `amenity=scooter_rental`, `amenity=bicycle_parking`, `amenity=motorcycle_parking` and also the `_pay` versions of the latter two.

### admin_level

Written out for `boundary=administrative` only.

### ele

Either the value of the OSM ele tag, or for some features used to pass a "more detailed name" to the display map style.  This allows (for example) "headline information" to be displayed for a signpost at lower zoom levels but detailed directions at higher ones.

### way_area

Set to the results of "Area()" for certain types of closed polygons as described above.  Values here are roughly 2.9 times the equivalent raster way_area values.


## "waterway"

This is for linear waterways.

### class

The OSM value for "waterway" after processing based on "intermittent" etc.

* zoom 11 `waterway=river`, `waterway=canal`, `waterway=derelict_canal`.
* zoom 12 `waterway=stream`, `waterway=drain`, `waterway=intriver`., `waterway=intstream`.
* zoom 13 `waterway=ditch`
* zoom 14 `waterway=weir`, `waterway=pipeline`

### name

the value of the OSM name tag.

### bridge

A boolean value set to true if a bridge.

### tunnel

A boolean value set to true if a tunnel.

`bridge` and `tunnel` tags can coexist and a map style consuming this schema needs to deal with that.


## "linearbarrier"

All features here are linear.  Point or polygon features will go in "land1" or "land2".  Most features here are barriers, but things like power lines are also included.

### class

Generally speaking, this will be the OSM value for `barrier`.  Exceptions include various rarer tags mapped through to e.g. `gate`.

* zoom 10 `natural=valley`.
* zoom 11 `man_made=breakwater`, `man_made=groyne`, `man_made=pier`.
* zoom 12 `natural=cliff`.
* zoom 12 `waterway=dam`.
* zoom 13 `barrier=wall`, `barrier=hedge` (non-closed only), `barrier=hedgeline`, `barrier=fence`, `barrier=kerb`, `barrier=pitchline`, `barrier=gate`, `barrier=gate_locked`, `barrier=lift_gate`, `barrier=stile`, `barrier=cattle_grid`, `barrier=ford` (if not associated with a `highway`), `barrier=tree_row`.
* zoom 13 `man_made=cutline`, `man_made=levee`.
* zoom 13 `historic=citywalls`, `historic=castle_walls`.
* zoom 14 `man_made=embankment`.
* zoom 14 `power=line`, `power=minor_line`.
* zoom 14 linear `waterway=lock_gate`, `waterway=sluice_gate`, `waterway=waterfall`, `waterway=weir`, `waterway=floating_barrier`.

### name

The value of the OSM name tag; appended for most features.


## "building"

All nodes, ways and relations with `building` tags that imply "is actually a building" will be written out here from zoom 11.  Many "not quite a building" values will have been consolidated into `roof`; `man_made=bridge` will be in `bridge_area`.  Data consumers can special-case `roof` and `bridge_area`, and may also want to show e.g. `building=church` differently; they'll then need to use a catch-all for `building` values that excludes what they have special-cased.

non-nil and non-blank 

### class

Stored as the processed OSM tag and value, such as `building_roof`

### name

the value of the OSM `name` tag, after any postprocessing e.g. for `operator`.

### housenumber

the value of the OSM `addr:housenumber` tag, after postprocessing.

### housename

the value of the OSM `addr:housename` tag, after postprocessing.


## "poi"

Not written by default - this is an optional catch-all that can output everything not handled by "land1" processing.  Uncomment out the call to `generic_after_poi( passedt )` to produce this layer, which contains all unhandled `amenity`, `shop` and `tourism` features.

### class

Stored as the OSM tag and value, such as `amenity_wibble`, where `wibble` is not an amenity value already expected by the "land1" layer.

### name

the value of the OSM name tag, after any postprocessing e.g. for `operator`.


For individual source tag values used see [here](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags)


