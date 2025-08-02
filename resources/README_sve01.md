# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

As with the parent style, releases are simply datestamped.  At the time of updating this README, the most recent release was "20250706".  Roughly one "release" per month is made; this README corresponds with the latest version of the committed code at that time.

This only describes the schema and the data extraction that supports that schema.  See also the [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md) for an example display style, and also the main project [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md) for the top=level scripts.

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The main lua processing logic logic used here is actually shared with the equivalent [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua), and is also similar to that used for [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua) as well.

Note that the "config-sve01.json" has the "high_resolution" parameter set to "true", so that parameter must also be in any "config-coastline.json" if generated tiles are merged with coastline tiles, otherwise there will be patches of grey in the sea.

The keys and values present in the data at the time when it is written out to vector tiles will differ significantly from the original OSM keys.  As an example, "function wr_after_highway( passedt )", which writes highway information to vector tiles will be passed `highway` values such as `gallop`, which has been calculated based on the various OSM tags and values on the way.  The [taginfo](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags) entry for this project references actual OSM tags and values, but the tags and values listed below (e.g. `highway=gallop`) are after the initial lua processing.

The `name` values written to features to several layers may incorporate `operator` and `brand` as appropriate, and may be suppressed or written out in brackets if a feature has been tagged as being unsigned.


## "water"

This layer is for background sea map tiles.  See https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#creating-a-map-with-varying-detail .

### class

Set to "ocean".


## "place"

More important regular place nodes are written to lower numbered layers: `country`, `state` to all layers, `capital` at 3, `city` at 5, `town` at 8, `suburb`, `village` at 11, `hamlet`, `neighbourhood`, `isolated_dwelling`, `farm` at 13.  Only OSM nodes are processed for these place as there is too much randomness and duplication in OSM way and relation place data to use ways or relations.

Area islands and islets are written as `place=island`, at a zoom level based on `way_area`. The `way_area` is also written out to allow zoom level display decisions to be made beyond zoom level 15.  Point islands and islets are written as `place=locality`, handled as described below.

Some named point and area `natural` features are also written out as localities - `arch`, `cliff`, `gully`, `mountain_range`, `ridge`, and `strait`.

Point and area 'locality' values are also written; at a zoom level that depends on size.  Size is determined either by the `way_area` of the area, or the size as defined by `sqkm` of a node.

`place=sea` is written to `land1` (see below).  Other `place` values are ignored.

### class

This is usually the `place` value (e.g. `city`). It is set to `capital` (regardless of the `place` value) if it is a capital.

### name

The value of the OSM name tag.

### way_area

Written for `locality` and 'island` only.  This is either an actual `way_area` value or a pretend one based on `sqkm` for nodes.

## "transportation"

This is for linear road, rail, air and water transport.

### class

Various linear transportation objects are written here.  This includes these highways:

* `highway=motorway` and `motorway_link` at vector zoom 3.
* `highway=trunk` and `trunk_link` at vector zoom 6.
* `highway=primary` and `primary_link` at vector zoom 7.
* `highway=secondary` and `secondary_link` at vector zoom 8.
* `highway=tertiary` and `tertiary_link`, `highway=unclassified` and `unclassified_link`, `highway=residential` and `residential_link` and `highway=living_street` and `living_street_link` at vector zoom 9.

Other `highway` values are calculated from a combination of OSM tags, such as `highway`, `surface`, `designation` (a number of UK legal classifications), `width` among others.  These are all written out at vector zoom 12:

* `unpaved`.  Used for `unclassified` highways with an unpaved `surface` values such as `gravel`.
* `ucrwide`.  Used for service roads, tracks or paths >= 2m wide with a designation of "unclassified county roads" or similar.
* `ucrnarrow`.  Used for service roads, tracks or paths < 2m wide with a designation of "unclassified county roads" or similar.
* `boatwide`.  Used for service roads, tracks or paths >= 2m wide with a designation of "byway open to all traffic" or similar.
* `boatnarrow`.  Used for service roads, tracks or paths < 2m wide with a designation of "byway open to all traffic" or similar.
* `rbywide`.  Used for service roads, tracks or paths >= 2m wide with a designation of "restricted byway" or similar.
* `rbynarrow`.  Used for service roads, tracks or paths < 2m wide with a designation of "restricted byway" or similar.
* `bridlewaywide`.  Used for service roads, tracks or paths >= 2m wide with a designation of "public bridleway" or similar.
* `bridlewaynarrow`.  Used for service roads, tracks or paths < 2m wide with a designation of "public bridleway" or similar.
* `bridlewaysteps`.  Used steps with a designation of "public bridleway" or similar.  It's legal but not always practical to ride a horse or a bicycle here.
* `intbridlewaywide`.  Like `bridlewaywide`, but with `intermediate` or `bad` `trail_visibility`.
* `intbridlewaynarrow`.  Like `bridlewaynarrow`, but with `intermediate` or `bad` `trail_visibility`.
* `footwaywide`.  Used for service roads, tracks or paths >= 2m wide with a designation of "public footpath" or similar.
* `footwaynarrow`.  Used for service roads, tracks or paths < 2m wide with a designation of "public footpath" or similar.
* `footwaysteps`.  Used steps with a designation of "public footpath" or similar.  
* `intfootwaywide`.  Like `footwaywide`, but with `intermediate` or `bad` `trail_visibility`.
* `intfootwaynarrow`.  Like `footwaynarrow`, but with `intermediate` or `bad` `trail_visibility`.
* `service`.  Used for "important" service roads without a designation
* `driveway`.  Used for "less important" service roads without a designation and with `service=driveway`, `parking_aisle`, or `drive_through`.
* `steps`.  Used for `steps` without a designation
* `road`.  Used for `highway=road`.
* `pathwide`.  Used for tracks or paths >= 2m wide without a designation.
* `pathnarrow`.  Used for tracks or paths < 2m wide without a designation.
* `intpathwide`.  Like `pathwide`, but with `intermediate` `trail_visibility`.
* `intpathnarrow`.  Like `pathnarrow`, but with `intermediate` `trail_visibility`.
* `badpathwide`.  Like `pathwide`, but with `bad` `trail_visibility`.
* `badpathnarrow`.  Like `pathnarrow`, but with `bad` `trail_visibility`.
* `construction`.  Used for `highway=construction`.
* `pedestrian`.  Used for `highway=pedestrian` which are open or closed linear ways (not areas).
* `raceway`.  Used for `highway=raceway` and open or closed linear `leisure=track` with a motor `sport`.
* `gallop`.  Used open or closed linear `leisure=track` with a horse `sport`.
* `leisuretrack`.  Used open or closed linear `leisure=track` with a non-motor, non-horse or no `sport`.

Various sorts of long distance paths are also written out at vector zoom 12.  These include:

* `ldpnwn`.  Used for signed `iwn`, `nwn`, `rwn` and `lwn` networks
* `ldpnhn`.  Used for signed `nhn` and `rhn` networks.  Also includes some semicolon-value networks incorporating '*hn'.
* `ldpncn`.  Used for signed `ncn`, `rcn` and selected `lcn` networks
* `ldpmtb`.  Used for MTB routes that are not `ncn`, `rcn` or `lcn`.

Linear highway platforms are written out at vector zoom 14.  

Highways are also checked to see if they are also `railway=tram`.  If that is also present it is written out at vector zoom 6.

Attributes of highways also written out if set include:

* `name`
* `ref`, and `ref_len` (the length of the `ref` can used to decide how long a "shield" to display a ref on top of).
* `edge=sidewalk`.  Set if one of many "sidewalk-indicating" tags such as `sidewalk:left=yes` is set.
* `edge=verge`.  Set if one of several "verge-indicating" tags is set.
* `edge=ford`.  Set if `ford=yes`.
* `bridge`. Set if `bridge` is set to a `bridge` value that indicates a bridge.
* `tunnel` (boolean) Set if `tunnel=yes`; in turn set as a result of many common `tunnel` values.
* `access`.  Set to `no` or `destination` if appropriate.
* `oneway`. Set if `oneway` is set to non-nil value.

As well as highways, the value of `railway` is wrtten out for non-area `railway` objects from vector zoom 6.  The following attributes are also added:

* `bridge`. Set if `bridge` is set to a `bridge` value that indicates a bridge.
* `tunnel` (boolean) Set if `tunnel=yes`; in turn set as a result of many common `tunnel` values.

`route=ferry` is written out from vector zoom 6.

The following `aeroway` values are written out from vector zoom 10::

* `runway`
* `grass_runway`
* `taxiway`.  Non-area ones only written.

The following `aerialway` values are written from vector zoom 11:

* `cable_car`
* `gondola`
* `goods`
* `chair_lift`
* `drag_lift`
* `t-bar`
* `j-bar`
* `platter`
* `rope_tow`

`leisure=slipway` is written out as from vector zoom 13.

Genuine highway areas are handled via "land1", not here.  For some highway types that are closed ways, `area` needs to be checked to choose which layer something should be processed as:

* `highway=pedestrian` ways are assumed to be areas if closed unless `area=no` or `oneway` is set.
* `highway=leisuretrack` and `highway=gallop` (which is what `leisure=track` will be processed into based on `sport` tags) are assumed to be linear unless `area=no` is set.

### name

The value of the OSM name tag, after postprocessing to e.g. put in brackets if unsigned.

### ref

The value of the OSM ref tag, after postprocessing to e.g. put in brackets if unsigned.

### ref_len

The length of the OSM ref tag, designed to make choice of e.g. road shield backgrounds easier.  Values for `ref` tend to be short (e.g. "A1") or long (e.g. "A627(M)"); generally speaking a split at "less than 6 characters" works well visually.

### edge

This will be `sidewalk`, `verge`, ford` or unset.  Designed to be used to influence the rendering on major road types.

### bridge

Set to the value of the bridge on the highway or railway, which will be "levee" for embankments, "yes" for all genuine bridges and blank for ones that are neither.

### tunnel

A boolean value set to true if a tunnel.

The `bridge` and `tunnel` tags can coexist and a map style consuming this schema needs to deal with that.

### access

Set to `no` if `access=no`, `destination` if `access=destination`, where `access` has been derived from `foot` if set and appropriate.  This schema tries to give a pedestrian-centric view of access-rights.  Note that the access logic here differs from that used for parking features (for cars, bicycles and motorcycles) in "land1".  See the "land1" layer below for that.

### oneway

The value of any OSM `oneway` tag - typically `yes` or `-1`.

### operator

The value of `operator` is written out for LDPs.

## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas and points go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

Features are written at an appropriate zoom level, which depending on the feature (e.g. "natural=water", "leisure=nature_reserve") and that zoom level may vary based on way_area.

A number of "`landuse`, `leisure`, etc." features that may be either large or small will be written out twice - once as a polygon without a name, so that a rendering style can show an appropriate fill and outline, and once as a centroid with a name (if one exists), together with the way_area of the polygon.  This allows the fill and/or outline for these features to be shown at one (lower) zoom level, and the `name` at a higher one, and the rendering style may choose to display larger feature names earlier than smaller ones.

`place=sea` is extracted at zoom level 5.

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
* zoom 11 `addr:housenumber` tags not attached to buildings (as `housenumber`)
* zoom 12 `natural` tags `wetland`, `reef`, `reefsand`, `swamp`, `bog`, `string_bog`.
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
* zoom 12 `highway=turning_circle`
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

Set to the value of the bridge on the waterway, which will be "levee" for embankments, "yes" for all genuine bridges and blank for ones that are neither.

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

Numerous other tags (e.g. `man_made=pier`) may be linear or occur on areas; other than the exceptions noted elsewhere this is usually based on whether the way is closed or not.

Closed `barrier=hedge` are assumed to be linear if there is some other area tag on the object (e.g. `landuse=farmland`), otherwise areas.

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


