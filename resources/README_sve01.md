# Schema for use with Tilemaker "sve01"

"sve01" is a schema for use with [Tilemaker](https://github.com/systemed/tilemaker) that is used to create 
mbtiles that can be displayed with the svwd01 style [here](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md).

As with the parent style, releases are simply datestamped.  At the time of updating this README, the most recent release was "20250706".  Roughly one "release" per month is made; it corresponds with the latest version of the committed code at that time.

This only describes the schema and the data extraction that supports that schema.  See also the [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md) for an example display style, and also the main project [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md) for the top=level scripts.  Note that in order to keep vector tile sizes small, below vector zoom 14 decisions to exclude something fro a layer tend to be made in here rather than the example display style.

There are two files:

* config-sve01.json - defines what is stored in the .mbtiles file
* process-sve01.lua - actually puts OSM data into the right field

The main lua processing logic logic used here is actually shared with the equivalent [raster maps](https://github.com/SomeoneElseOSM/SomeoneElse-style/blob/master/style.lua), and is similar to that also used for [mkgmap maps](https://github.com/SomeoneElseOSM/mkgmap_style_ajt/blob/master/transform_03.lua) as well.

Note that the "config-sve01.json" has the "high_resolution" parameter set to "true", so that parameter must also be in any "config-coastline.json" if generated tiles are merged with coastline tiles, otherwise there will be patches of grey in the sea.  See [here](https://github.com/systemed/tilemaker/pull/384) for how that works.

The keys and values present in the data at the time when it is written out to vector tiles will differ significantly from the original OSM keys.  As an example, "function wr_after_highway( passedt )", which writes highway information to vector tiles will be passed `highway` values such as `gallop`, which has been computed based on the various OSM tags and values on the way.  The [taginfo](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags) entry for this project references the raw OSM tags and values in OSM data, but the tags and values listed below (e.g. `highway=gallop`) are after the initial lua processing.  Generally speaking the raw OSM tags used to compute these "schema" values is mentioned in each section below.

The `name` values written to features to several layers may incorporate `operator` and `brand` as appropriate, and may be suppressed or written out in brackets if a feature has been tagged as being unsigned (see the discussion of the `land2` layer below).


## "water"

This layer is for background sea map tiles.  See https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#creating-a-map-with-varying-detail .

### class

Set to "ocean".


## "place"

More important regular place nodes are written to lower numbered layers: `country`, `state` to all layers, `capital` at 3, `city` at 5, `town` at 8, `suburb`, `village` at 11, `hamlet`, `neighbourhood`, `isolated_dwelling`, `farm` at 13.  Only OSM nodes are processed for these place as there is too much randomness and duplication in most OSM way and relation `place` data to use ways or relations, apart from the exceptions listed immediately below.

Area islands and islets are written as `place=island`, at a zoom level based on `way_area`. The `way_area` is also written out to allow zoom level display decisions to be made beyond zoom level 15.  Point islands and islets are written as `place=locality`, handled as described below.

Note that vector `way_area` values are roughly 2.9 times the equivalent raster way_area values.

Some named point and area `natural` features are also written out as localities - `arch`, `cliff`, `gully`, `mountain_range`, `ridge`, and `strait`.

Point and area `locality` values are also written; at a zoom level that depends on size.  Size is determined either by the `way_area` of the area, or the size as defined by `sqkm` of a node.

`place=sea` is written to `land1` (see below).  Other `place` values are ignored.

### class

This is usually the `place` value (e.g. `city`). It is set to `capital` (regardless of the `place` value) if it is a capital.

### name

The value of the OSM name tag.

### way_area

Written for `locality` and `island` only.  This is either an actual `way_area` value or a pretend one based on `sqkm` for nodes.

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

* `unpaved`.  Used for `unclassified` highways with an unpaved `surface` (values such as `gravel`).
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

For the full list of `designation` values handled see [taginfo](https://taginfo.openstreetmap.org/keys/designation#projects).  Values in use in [England and Wales, Scotland](https://taginfo.geofabrik.de/europe:great-britain/keys/designation#values), and [Northern Ireland](https://taginfo.geofabrik.de/europe:ireland-and-northern-ireland/keys/designation#values) are included, as are semicolon-separated values.  Access modifiers are also processed, so a `motor_vehicle=no` (perhaps as a result of a TRO) on a `designation=byway_open_to_all_traffic` will result in it being seen as a `restricted_byway`.

A `highway=tertiary`, `highway=unclassified` or `highway=residential` with `designation=quiet_lane` (and some semicolon derivatives) is handled as `highway=living_street`.

`highway=tertiary` with a `width` <= 3 are treated as `highway=unclassified`.

Various other tags are used to complement `trail_visibility` so that consumers can classify paths into "obvious", "less obvious" and "not obvious at all":

* `visibility` is used to set `trail_visibility` if that is not already set.
* `overgrown=yes` is used to set `trail_visibility=intermediate`.
* `obstacle=vegetation` is used to set `trail_visibility=intermediate`.
* `foot:physical=no` is used to set `trail_visibility=bad`.
* a `bridge` on an otherwise `trail_visibility=bad` is handled as `intermediate`.
* a `designation` on an otherwise `trail_visibility=bad` highway is handled as `intermediate`.
* a `sac_scale` of `demanding_alpine_hiking` or `difficult_alpine_hiking` is handled as `bad`.

The resulting `trail_visibility` is used to change an object from e.g. `pathwide` to `intpathwide` or `badpathwide`.

Other things that can get included in the list above can include:

* Ground-level `highway=corridor`, which will be classified based on other tags,
* `golf=track` and `golf=cartpath`, which in the absence of `width` are assumed to be >= 2m wide.
* `golf=path`, which in the absence of `width` are assumed to be < 2m wide.
* `highway=scramble`, which will be classified based on other tags.  If `sac_scale` is unsert `demanding_alpine_hiking` is assumed.
* `ladder=yes` in the absence of a `highway` value.
* `highway=escape` is treated as `highway=service` with `access=destination`.
* `surface=grass` on an `aeroway=taxiway` causes it be be set as `highway=pathwide`

Various sorts of long distance paths are also written out at vector zoom 12.  These include:

* `ldpnwn`.  Used for signed `iwn`, `nwn`, `rwn` and `lwn` networks
* `ldpnhn`.  Used for signed `nhn` and `rhn` networks.  Also includes some semicolon-value networks incorporating '*hn'.
* `ldpncn`.  Used for signed `ncn`, `rcn` and selected `lcn` networks
* `ldpmtb`.  Used for MTB routes that are not `ncn`, `rcn` or `lcn`.

Linear highway platforms are written out at vector zoom 14.  

Highways are also checked to see if they are also `railway=tram`.  If that is also present it is written out at vector zoom 6.

See below for attributes of highways also written out if set include:

As well as highways, the value of `railway` is wrtten out for non-area `railway` objects from vector zoom 6.  Non-linear `railway` objects are written to `land1` not here.  Some other changes are made:

* `highway=bus_guideway` and `highway=busway` are handled as `railway=bus_guideway`.  
* `historic=inclined_plane` and `historic=tramway` are handled as `railway=abandoned`.
* `railway=razed` is handled as `railway=dismantled`.  
* `railway=proposed` is handled as `railway=construction`.  
* if `railway:preserved=yes` and `railway=rail` are set together, `railway=preserved` is set.
* if `railway=preserved` and `tunnel=yes` are set together, `railway=rail` is set.
* if `railway=miniature` or `railway=narrow_gauge` and `tunnel=yes` are set together, `railway=light_rail` is set.
* `man_made=goods_conveyor` is handled as `railway=miniature`.  
* if `railway=platform` and either `location=underground` or `underground=yes` are set together, `railway` is unset.

Of the attributes listed below, `bridge` and `tunnel` will be written for railway.

The `name` on railway platforms can be set from `ref` if no name is previously set.

`route=ferry` is written out from vector zoom 6.

The following linear `aeroway` values are written out from vector zoom 10:

* `runway`
* `grass_runway`
* `taxiway`.  Non-area ones only written.

These other values are taken into account:

* `disused=yes` on an `aeroway=runway` or `aeroway=taxiway` causes it be be set as `disused:aeroway` (which isn't written out)
* `surface=grass` on an `aeroway=runway` causes it be be set as `aeroway=grass_runway`

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

Genuine highway areas are handled via `land1`, not here.  For some highway types that are closed ways, `area` needs to be checked to choose which layer something should be processed as:

* `highway=pedestrian` ways are assumed to be areas if closed unless `area=no` or `oneway` is set.
* `highway=leisuretrack` and `highway=gallop` (which is what `leisure=track` will be processed into based on `sport` tags) are assumed to be linear unless `area=no` is set.

### name

The value of the OSM `name` tag, after postprocessing to e.g. put in brackets if unsigned.

For long distance paths, there is some consolidation of `name` values based on partial name and operator.

### ref

The value of the OSM ref tag, after postprocessing to e.g. put in brackets if unsigned.

For long distance paths, there is some consolidation of `ref` values based on partial name (in either English or Welsh) and operator.

### ref_len

The length of the OSM ref tag, designed to make choice of e.g. road shield backgrounds easier.  Values for `ref` tend to be short (e.g. "A1") or long (e.g. "A627(M)"); generally speaking a split at "less than 6 characters" works well visually.

### edge

This will be `sidewalk`, `verge`, ford` or unset.  Designed to be used to influence the rendering on major road types.  `sidewalk` is set if one of many "sidewalk-indicating" tags such as `sidewalk:left=yes` is set; similarly `verge` and `ford` (for long fords on roads).

### bridge

Set to the value of the bridge on the highway or railway, which will be "levee" for embankments, "yes" for all genuine bridges and blank for ones that are neither.

### tunnel

A boolean value set to true if a tunnel.

The `bridge` and `tunnel` tags can coexist and a map style consuming this schema needs to deal with that.

### access

Set to `no` if `access=private` or `access=no`, `destination` if `access=destination`, where `access` has been derived from `foot` if set and appropriate.  This schema tries to give a pedestrian-centric view of access-rights.  Note that the access logic here differs from that used for parking features (for cars, bicycles and motorcycles) in `land1`.  See the `land1` layer below for that.

### oneway

The value of any OSM `oneway` tag - typically `yes` or `-1`.

### operator

The value of `operator` is written out for LDPs.

## "waterway"

This is for linear waterways.

### class

The OSM value for "waterway" after processing based on "intermittent" etc.

* zoom 10 `waterway=river`
* zoom 11 `waterway=canal`, `waterway=derelict_canal`.
* zoom 12 `waterway=stream`, `waterway=drain`, `waterway=intriver`., `waterway=intstream`.
* zoom 13 `waterway=ditch`
* zoom 14 `waterway=pipeline`

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

### class

Stored as the processed OSM tag and value, such as `building_roof`

### name

the value of the OSM `name` tag, after any postprocessing e.g. for `operator`.

### housenumber

the value of the OSM `addr:housenumber` tag, after postprocessing.

### housename

the value of the OSM `addr:housename` tag, after postprocessing.

## `land1` and `land2`

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas and points go.  Most go into `land1`, except in the case of some overlays (e.g. military red hatching) which goes into `land2`.  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into `land2`.

Features are written from an appropriate zoom level, which depending on the feature (e.g. "natural=water", "leisure=nature_reserve") and that zoom level in many cases will vary based on `way_area` or a proxy for that (`sqkm`).

Most area "`landuse`, `leisure`, etc." features that may be either large or small will be written out twice - once as a polygon without a name, so that a rendering style can show an appropriate fill and outline, and once as a centroid with a name (if one exists), together with the way_area of the polygon.  This allows the fill and/or outline for these features to be shown at one (lower) zoom level, and the `name` at a higher one, and the rendering style may choose to display larger feature names earlier than smaller ones.

Tags and values are checked in order so the last thing that might cause a feature to be written to these layers (address information) won't be written as a separate feature if something more important has been earlier.

### `natural` and `place` water features in `land1`.

This includes `natural=water`, `natural=intermittentwater`, `natural=glacier`, `natural=bay` and `place=sea`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 20000000000) the "fill minzoom" and "name minzoom" are both vector zoom 2.  The catch-all for the smallest ones is 14 for both, which is the highest vector zoom level created by this schema, although map styles can choose to display features or names whenever they like after that.

With the area feature, as well as `class`, `tunnel` is written as a boolean attribute.

With the point feature, as well as `class`, `way_area` and `name` are written.

### `amenity` parking features in `land1`.

This includes `amenity=parking`, `amenity=parking_pay`, `amenity=parking_freedisabled`, `amenity=parking_paydisabled`, 

These are written as a area feature at vector zoom 9 and an also as a point feature, also at vector zoom 9.  It includes both regular `amenity=parking` and also `amenity=parking_space` and highway=emergency_bay`

Other tags that will change `amenity=parking` to e.g. `amenity=parking_pay` include:

* `fee`.  If set to a non-free value `parking_space=parking_pay` is set as an attribute.
* `parking_space=disabled`

An additional attribute `access` is also set - this is the regular `access` tag from OSM.

### `amenity` education and hospital features in `land1`.

This includes `amenity=university`, `amenity=college`, `amenity=school`, `amenity=hospital` and `amenity=kindergarten`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 800000) the "fill minzoom" is 9 and the "name minzoom" is vector zoom 11.  The catch-all for the smallest ones is 13 for fill and 14 for name.

In addition to the normal OSM tags, `amenity=hospital` can be set based on `healthcare=hospital`.

### `amenity` `holy_spring`, `holy_well` and `watering_place` features in `land1`.

These are written as a point feature at vector zoom 13.

In addition to the regular OSM tags, `holy_spring` can be set based on `place_of_worship=holy_well` on a `natural=spring`.

### `amenity=ferry_terminal` in `land1`.

These are written as a point feature at vector zoom 14.

### Other zoom 14 amenities in `land1`.

This includes:

`shelter`, `atm`, `bank`, `bank_l`, `bank_n`, `bank_y`, `bar`, `bar_ddd`, `bar_dld`, `bar_dnd`, `bar_dyd`, `bar_ydd`, `bar_yld`, `bar_ynd`, `bar_yyd`, `bar_ddy`, `bar_dly`, `bar_dny`, `bar_dyy`, `bar_ydy`, `bar_yly`, `bar_yny`, `bar_yyy`, `nightclub`, `concert_hall`, `car_sharing`, `taxi`, `taxi_office`, `bus_station`, `entrancemain`, `bubble_tea`, `cafe_indian`, `cafe_ddd`, `cafe_dld`, `cafe_dnd`, `cafe_dyd`, `cafe_ydd`, `cafe_yld`, `cafe_ynd`, `cafe_yyd`, `cafe_ddy`, `cafe_dly`, `cafe_dny`, `cafe_dyy`, `cafe_ydy`, `cafe_yly`, `cafe_yny`, `cafe_yyy`, `cinema`, `fire_station`, `lifeboat`, `fuel`, `fuel_e`, `fuel_h`, `fuel_l`, `fuel_w`, `charging_station`, `embassy`, `library`, `courthouse`, `monastery`, `zooaviary`, `zooenclosure`, `vending_machine`, `vending_excrement`, `bottle_return`, `waste_basket`, `waste_disposal`, `grit_bin`, `left_luggage`, `parcel_locker`, `bench`, `playground_swing`, `playground_structure`, `playground_climbingframe`, `playground_slide`, `playground_springy`, `playground_zipwire`, `playground_seesaw`, `playground_roundabout`, `pitch_tabletennis`, `pitch_soccer`, `pitch_basketball`, `pitch_cricket`, `pitch_skateboard`, `pitch_climbing`, `pitch_rugby`, `pitch_chess`, `pitch_tennis`, `pitch_athletics`, `pitch_boules`, `pitch_bowls`, `pitch_croquet`, `pitch_cycling`, `pitch_equestrian`, `pitch_gaa`, `pitch_hockey`, `pitch_multi`, `pitch_netball`, `pitch_polo`, `pitch_shooting`, `pitch_baseball`, `doctors`, `dentist`, `pharmacy`, `pharmacy_l`, `pharmacy_n`, `pharmacy_y`, `ambulance_station`, `mountain_rescue`, `mountain_rescue_box`, `place_of_worship_christian`, `place_of_worship_muslim`, `place_of_worship_sikh`, `place_of_worship_jewish`, `place_of_worship_hindu`, `place_of_worship_buddhist`, `place_of_worship_shinto`, `place_of_worship_taoist`, `place_of_worship_other`, `police`, `post_box`, `post_office`, `biergarten`, `boatyard`, `tourismstation`, `recycling`, `recyclingcentre`, `restaurant_y`, `restaurant_l`, `restaurant_n`, `restaurant_d`, `restaccomm`, `restaurant_indian_y`, `restaurant_indian_l`, `restaurant_indian_n`, `restaurant_indian_d`, `restaurant_chinese_y`, `restaurant_chinese_l`, `restaurant_chinese_n`, `restaurant_chinese_d`, `restaurant_italian_y`, `restaurant_italian_l`, `restaurant_italian_n`, `restaurant_italian_d`, `restaurant_fish_and_chips_y`, `restaurant_fish_and_chips_l`, `restaurant_fish_and_chips_n`, `restaurant_fish_and_chips_d`, `restaurant_burger_y`, `restaurant_burger_l`, `restaurant_burger_n`, `restaurant_burger_d`, `restaurant_coffee_y`, `restaurant_coffee_l`, `restaurant_coffee_n`, `restaurant_coffee_d`, `restaurant_sandwich_y`, `restaurant_sandwich_l`, `restaurant_sandwich_n`, `restaurant_sandwich_d`, `restaurant_chicken_y`, `restaurant_chicken_l`, `restaurant_chicken_n`, `restaurant_chicken_d`, `restaurant_kebab_y`, `restaurant_kebab_l`, `restaurant_kebab_n`, `restaurant_kebab_d`, `restaurant_british_y`, `restaurant_british_l`, `restaurant_british_n`, `restaurant_british_d`, `restaurant_regional_y`, `restaurant_regional_l`, `restaurant_regional_n`, `restaurant_regional_d`, `restaurant_mexican_y`, `restaurant_mexican_l`, `restaurant_mexican_n`, `restaurant_mexican_d`, `restaurant_greek`, `restaurant_french_y`, `restaurant_french_l`, `restaurant_french_n`, `restaurant_french_d`, `restaurant_seafood_y`, `restaurant_seafood_l`, `restaurant_seafood_n`, `restaurant_seafood_d`, `restaurant_ice_cream`, `restaurant_caribbean`, `restaurant_lebanese`, `restaurant_dessert`, `restaurant_spanish`, `restaurant_african`, `fast_food_y`, `fast_food_l`, `fast_food_n`, `fast_food_d`, `fast_food_burger_y`, `fast_food_burger_l`, `fast_food_burger_n`, `fast_food_burger_d`, `fast_food_chicken_y`, `fast_food_chicken_l`, `fast_food_chicken_n`, `fast_food_chicken_d`, `fast_food_chinese_y`, `fast_food_chinese_l`, `fast_food_chinese_n`, `fast_food_chinese_d`, `fast_food_coffee`, `fast_food_fish_and_chips_y`, `fast_food_fish_and_chips_l`, `fast_food_fish_and_chips_n`, `fast_food_fish_and_chips_d`, `fast_food_ice_cream`, `fast_food_indian_y`, `fast_food_indian_l`, `fast_food_indian_n`, `fast_food_indian_d`, `fast_food_kebab_y`, `fast_food_kebab_l`, `fast_food_kebab_n`, `fast_food_kebab_d`, `fast_food_pie`, `fast_food_pizza_y`, `fast_food_pizza_l`, `fast_food_pizza_n`, `fast_food_pizza_d`, `fast_food_sandwich_y`, `fast_food_sandwich_l`, `fast_food_sandwich_n`, `fast_food_sandwich_d`, `fast_food_british`, `fast_food_regional`, `fast_food_mexican_y`, `fast_food_mexican_l`, `fast_food_mexican_n`, `fast_food_mexican_d`, `fast_food_greek`, `fast_food_french`, `fast_food_seafood`, `fast_food_caribbean`, `fast_food_lebanese`, `fast_food_dessert`, `fast_food_spanish`, `fast_food_donut`, `fast_food_african`, `telephone`, `boothtelephonered`, `boothtelephoneblack`, `boothtelephonewhite`, `boothtelephoneblue`, `boothtelephonegreen`, `boothtelephonegrey`, `boothtelephonegold`, `boothdefibrillator`, `boothlibrary`, `boothbicyclerepairstation`, `boothatm`, `boothinformation`, `boothartwork`, `boothmuseum`, `boothdisused`, `public_bookcase`, `bicycle_repair_station`, `sundial`, `shopmobility`, `emergency_phone`, `emergency_access_point`, `theatre`, `toilets`, `toilets_free_m`, `toilets_free_w`, `toilets_pay`, `toilets_pay_m`, `toilets_pay_w`, `shower`, `shower_free_m`, `shower_free_w`, `shower_pay`, `shower_pay_m`, `shower_pay_w`, `musical_instrument`, `drinking_water`, `nondrinking_water`, `fountain`, `prison`, `veterinary`, `animal_boarding`, `animal_shelter`, `car_wash`, `car_rental`, `compressed_air`, `defibrillator`, `life_ring`, `fire_extinguisher`, `fire_hydrant`, `bbq`, `waterway_access_point` and all `pub` derivates.

Where there are variations from regular OSM keys, these are based on other OSM tags.  Appended characters include:

* `bank`, `pharmacy` and non-cuisine restaurants and fast food: a flag for `wheelchair=limited`, `no` or `yes`
* restaurants and fast food with a `cuisine`: a name for the cuisine and then a flag for `wheelchair=limited`, `no` or `yes`
* `bar` and `cafe`: flags for `accommodation` ("don't know" or `yes`), `wheelchair` ("don't know", `no`, `limited`, `yes`), `outdoor_seating` ("don't know", `yes`)
* `fuel`: "e" for electricity, "h" for hydrogen, "l" for LPG, "w" for waterway fuel, 
* `toilets` and `shower`: `free` or `pay`, then "m" for men and "w" for women.

For pubs, a series of up to 9 flags is appended.  For each flag, "d" means "don't know", "y" means "yes" and "n" no. These flags and any other values are:

* live or dead pub?  y or n, or c (closed due to covid)
* real ale  y, n or d (don't know)
* food  y or d
* noncarpeted floor  y or d, based on a non-blank `description:floor` or certain `floor:material` such as `lino`
* microbrewery  y, n or d
* micropub  y, n or d
* accommodaton  y, n or d
* wheelchair: y, l, n or d
* beer garden: g (beer garden), o (outside seating), d (don't know)

Other computed values include 

* `playground_swing` etc. based on `playground=swing` and a consolidation of similar values.
* `place_of_worship_shinto` etc. based on the `religion` of an `amenity=place_of_worship`
* `boothtelephonered` and `boothmuseum` etc.: Usage of current and former telephone boxes, based on other tags.
* `drinking_water` and `nondrinking_water`.  Various "water available" amenities are included in these, and tags such as `drinking_water` decide between which.

For these amenities one area feature is written at vector zoom 14 with `name` and `ele` also written out as attributes.

### Zoom 14 amenities with access values in `land1`.

This includes 
`bicycle_rental`, `scooter_rental`, `bicycle_parking`, `bicycle_parking_pay`, `motorcycle_parking`, and `motorcycle_parking_pay`

For these amenities one area feature is written at vector zoom 14 with `name` and `ele` also written out as attributes.

Other tags that will change `amenity=bicycle_parking` to e.g. `amenity=bicycle_parking_pay` are as expected:

* `fee`

An additional attribute `access` is also set - this is the regular `access` tag from OSM.

### Zoom 14 shops in `land1`.

These are written as a area feature at vector zoom 14 and also as a point feature at vector zoom 14

These include:

`supermarket`, `department_store`, `ecosupermarket`, `alcohol`, `antiques`, `art`, `bakery`, `beauty`, `bicycle`, `bookmaker`, `books`, `butcher`, `car`, `car_parts`, `car_repair`, `catalogue`, `charity`, `clothes`, `coffee`, `computer`, `confectionery`, `convenience`, `copyshop`, `deli`, `discount`, `doityourself`, `e-cigarette`, `ecoconv`, `ecogreengrocer`, `ecohealth_food`, `electrical`, `electronics`, `estate_agent`, `farm`, `florist`, `funeral_directors`, `furniture`, `garden_centre`, `gift`, `greengrocer`, `hairdresser`, `health_food`, `healthnonspecific`, `homeware`, `jewellery`, `laundry`, `locksmith`, `mobile_phone`, `motorcycle`, `music`, `musical_instrument`, `optician`, `outdoor`, `pawnbroker`, `pet`, `pet_food`, `pet_grooming`, `photo`, `seafood`, `shoe_repair_etc`, `shoes`, `shopnonspecific`, `sports`, `stationery`, `storage_rental`, `tattoo`, `toys` and `travel_agent`.

There is considerable consolidation of raw OSM tags into these values.  In addition, other tags such as `zero_waste` and `bulk_purchase` can be used to change e.g. `greengrocer` into `ecogreengrocer`.  A very large number of less common shop values are written through as `shopnonspecific`.

`shop=vacant` is written as a area feature at vector zoom 14.  `ref` is written with a name containing "vacant:".

### Zoom 11 `man_made` in `land1`.

`bigmast`, `pier`, `breakwater` and `groyne` point and area values are written out at vector zoom 11 as area features.

`mast` and `bigmast` are derived from a selection of `man_made` features such as `phone_mast`, 'radio_mast`, `communications_mast`, `tower`, `communications_tower`, `transmitter`, `antenna`, `mast`, with `bigmast` being set if the `height` is > 300.

Previously many sorts of `tower` will have been split off into a selection of towers, `bigchimney` and `chimney` (see below).

### Zoom 12 `man_made` in `land1`.

`bigchimney` point and area values are written out at vector zoom 12 as area features.

`bigchimney` is set instead of `chimney` if the `height` is > 50.

### Zoom 13 `man_made` in `land1`.

`bigobservationtower` point and area values are written out at vector zoom 13 as area features.

`observationtower` is set if `man_made` is `tower` and `tower:type` is`observation`.  `bigobservationtower` is set instead of `observationtower` if the `height` is > 100.

### Variable zoom `man_made` derived from `power` in `land1`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 1500000) the "fill minzoom" is 9 and the "name minzoom" is vector zoom 11.  The catch-all for the smallest ones is 14 for fill and name.

`man_made=power`, `power_water` and `power_wind` are written out this way.  Those in turn may be derived from several OSM tags (5 for `wind`, 4 for `water`).

### Zoom 14 `man_made` in `land1`.

Numerous other `man_made` values are written as area features at vector zoom 14.  These include `chimney`, `lighthouse`, `mast`, `ventilation`, `water`, `windsock`, `crane`, `cross`, `flagpole`, `maypole`, `aircraftcontroltower`, `churchspire`, `churchtower`, `clockpedestal`, `clocktower`, `defensivetower`, `footwear`, `illuminationtower`, `militarybunker`, `mineshaft`, `monitoringearthquake`, `monitoringrainfall`, `monitoringky`, `monitoringwater`, `monitoringweather`, `mounting`, `observationtower`, `radartower`, `squaretower`, `watermill`, `windmill`, `survey`, `water`, `cairn`, `flagpole`, `boundary`, `golfballwasher`, `golfpin`, `outfall` and `markermilitary`.  Each of these is typically sent based on several other tags (such as `monitoringwater`, based on `man_made=monitoring_station` and various other tags such as `monitoring:water_velocity`).

If set, `ele` is also written through here; it sometimes carries an inscription for a stone.

### Zoom 14 `man_made` with `ref` and relation lists in `land1`.

`man_made=markeraerial` and `lcn_ref` have the `ref` written through as a `name` attribute, and also an `ncnrelationlist` written through if set.  The `ncnrelationlist` value is made up of all the appropriate relation `ref` or `name` values concatenated together. 

### Zoom 14 `office` values in `land1`.

Most `office` values are written through as area features at vector zoom 14 as `nonspecific`; the exceptions are `craftbrewery` and `craftcider` (based on appropriate `craft` and `product` values.

### Zoom 12 `highway` values in `land1`.

Only point and area features are included here; linear features are in `transportation`.

`highway=pedestrian` and are only written to land1 if they're closed areas.  All closed 1highway=pedestrian` and `highway=platform` are assumed to be areas regardless of any `area` tag.  Closed `highway=pathnarrow` and `highway=service` are assumed to be areas only if `area=yes` is set.

### Zoom 14 `highway` values in `land1`.

`highway=ford` only (typically a point only).

Note that linear fords are handled as an `edge=ford` attribute on roads in `transportation`.

### Zoom 14 `highway` values with website processing in `land1`.

`board_realtime`, `bus_stop_nothing`, `bus_stop_pole`, `bus_stop_disused_pole`, `bus_stop_timetable`, `bus_stop_realtime`, `bus_stop_speech_timetable`, `bus_stop_speech_realtime`, `elevator`, `traffic_signals`, `streetlamp_electric`, `streetlamp_gas`, `crossing`, `milestone` and `mini_roundabout` are also written out as area features at vector zoom 14.

`ele` (which will often include an expanded `name` to include `website`) is also written.

### Zoom 10 `highway=motorway_junction` in `land1`.

This is written out as a named area feature at vector zoom 10.  `ref` and `ref_len` are added as attributes.

### Zoom 14 `highway=platform` in `land1`.

Note that linear ones are handled in `transportation`.

### Zoom 12 `highway=turning_circle` in `land1`.

These include `passing_place` and are written out as area features at vector zoom 14.

### Zoom 11 `railway` in `land1`.

`railway=station` is written as an area feature.

### Zoom 12 `railway` in `land1`.

`railway=halt` and `railway=tram_stop`  are written as area features

### Zoom 14 railway platforms in `land1`.

Point and area `railway=platform` only.   Linear ones are handled in `transportation`.

### Zoom 14 railway turntables in `land1`.

`railway=turntable` is assumed to be an area feature.

### Zoom 12 `aerialway` in `land1`.

`aerialway=station` is written as an area feature.

### Variable zoom `historic` in `land1`.

These are written as a area feature at a based-on-area "minzoom" and an also as a point feature at the same "minzoom".  

For the largest of these features (way_area > 800000) the "minzoom" is 9.  The catch-all for the smallest ones is 13.

The fill that is written is `landus=historic`.  The `historic` feature written out will be one of `archaeological_site`, `battlefield`, `historicarchcastle`, `historicarchmotte`, `historiccrannog`, `historicfortification`, `historichillfort`, `historicpromontoryfort`, `historicringfort`, `historictumulus`, `manor`, `monastery`, `palaeontological_site`, `castle`, `church`, `city_gate`, `dovecote`, `folly`, `historicchurchtower`, `historicdefensivetower`, `historicmegalithtomb`, `historicobservationtower`, `historicroundtower`, `historicsquaretower`, `historicstandingstone`, `historicstone`, `historicstonecircle`, `historicstonerow`, `martello_tower`, `massrock`, `naturalstone`, `oghamstone`, `pinfold`, `runestone`, `aircraft`, `aircraft_wreck`, `bunker`, `cannon`, `cross`, `ice_house`, `kiln`, `memorial`, `memorialbench`, `memorialcross`, `memorialgrave`, `memorialobelisk`, `memorialpavementplaque`, `memorialplaque`, `memorialplate`, `memorialsculpture`, `memorialstatue`, `memorialstone`, `milk_churn_stand`, `mill`, `monument`, `ship`, `stocks`, `tank`, `tomb`, `warmemorial`, `water_crane`, `water_pump`, `watermill`, `well`, `windmill`, `wreck`, `mineshaft` or `nonspecific`.

These values are computed from numerous other OSM tags.  In many cases a `historic` tag exists in the raw OSM data alongside other tags defining a feature (for example various tower tags can define a "square tower") and `historic` is simply used to move that into an equivalent set of historic features that data consumers can either handle separately or ignore.

### Variable zoom forest and farmland `landuse` in `land1`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 16000000) the "fill minzoom" is 7 and the "name minzoom" is 9.  The catch-all for the smallest ones is 14 for fill and name.

`landuse=forest` and `landuse=farmland` are handled like this.

### Variable zoom other land-based `landuse` in `land1`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 800000) the "fill minzoom" is 9 and the "name minzoom" is 11.  The catch-all for the smallest ones is 13 for fill and 14 for name.

industrial`, `railway`, `commercial`, `residential`, `retail`, `construction`, `brownfield`, `landfill`, `historic`, `meadow`, `meadowtransitional`, `meadowwildflower`, `wetmeadow`, `meadowperpetual`, `farmyard`, `farmgrass`, `grass`, `christiancemetery`, `jewishcemetery`, `othercemetery`, `orchard`, `vineyard`, and `allotments` are all handled like this.

Those tags are often computed from other raw OSM tags - synonyms, subtags and others such as religion.

### Variable zoom other mostly coastal `landuse` in `land1`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 141284) the "fill minzoom" is 9 and the "name minzoom" is 12.  The catch-all for the smallest ones is 9 for fill and 14 for name.

`greenfield`, `saltmarsh` and `reedbed` are handled like this.

### Variable zoom other large green `landuse` in `land1`.

These are written as a area feature at a based-on-area "minzoom" and an also as a point feature at the same "minzoom".  

For the largest of these features (way_area > 4000000000) the "minzoom" is 6.  The catch-all for the smallest ones is 14.

`recreation_ground`, `conservation`, `village_green` are handled like this.

### Zoom 10 quarries in `land1`.

`landuse=quarry` and `landuse=historicquarry` are written out as unnamed area and named point features.  The second of these values in particular is computed from other raw OSM tags such as `disused`.

### Zoom 11 `garages` in `land1`.

`landuse=garages` is written out as a named area feature.

### Zoom 14 `industrialbuilding` in `land1`.

`landuse=industrialbuilding` is written out as an unnamed area and a named point feature.  This value is computed from other raw OSM tags.

### Variable zoom nature reserves in `land1`.

These are written as a area feature at a based-on-area "minzoom" and an also as a point feature at the same "minzoom".  

For the largest of these features (way_area > 4000000000) the "minzoom" is 6.  The catch-all for the smallest ones is 14.

`nature_reserve` is handled like this.  The value is computed from other OSM tags.  The very largest values are marine conservation areas.

### Variable zoom large green `leisure` in `land1`.

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 1600000) the "fill minzoom" is 8 and the "name minzoom" is 10.  The catch-all for the smallest ones is 13 for fill and 14 for name.

`park`, `common`, `garden`, `golfgreen` are handled like this.

### Variable zoom other green `leisure` in `land1`.

These are written as a area feature at a based-on-area "minzoom" and an also as a point feature at the same "minzoom".  

For the largest of these features (way_area > 141284) the "minzoom" is 9.  The catch-all for the smallest ones is 13.

`dog_park`, `recreation_ground`, `golf_course`, `sports_centre`, `stadium`, `pitch`, `track` are handled like this.

Note that `track` may be an area (processed here) or a closed linear (processed in `transportation`) feature depending on the `area` tag.

### Zoom 12 `leisure=playground and `leisure=schoolyard` in `land1`. 

Written a an unnamed area feature and a named point at vector zoom 12.

### Zoom 13 `leisure=swimming_pool in `land1`. 

Written a an unnamed area feature and a named point feature at vector zoom 13.

### Zoom 14 `leisure=leisurenonspecific` and `leisure=hunting_stand` in `land1`. 

Written a an unnamed area feature and a named point feature at vector zoom 14.

`leisure=leisurenonspecific` is a catch-all for many other raw OSM `leisure` and other tags.

### Zoom 14 other `leisure` in `land1`. 

These are written a an unnamed area feature only at vector zoom 14.

`bandstand`, `bleachers`, `fitness_station`, `picnic_table`, `slipway`, `bird_hide`, `grouse_butt` are handled here.

### Zoom 9 `military=barracks` in `land1`. 

Written a an unnamed area feature and a named point feature at vector zoom 9.

### Zoom 7 `natural=desert` in `land1`. 

Written a an unnamed area feature and a named point feature at vector zoom 7.

### Zoom 8 `natural=bigprompeak` in `land1`. 

These are written a an named area feature only (with `ele`) at vector zoom 8.

The value `bigprompeak` is calculated from (`ele` > 914) and (`prominence` > 500).  If not tagged `prominence` is guessed based on other tags such as `munro`.

The value of `ele` is written as an attribute.

### Variable zoom `natural` woodland in `land1`

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 8000000) the "fill minzoom" is 8 and the "name minzoom" is 10.  The catch-all for the smallest ones is 14 for fill and name.

`wood`, `broadleaved`, `needleleaved`, and `mixedleaved` are handled like this.

### Variable zoom `natural` beaches and sand in `land1`

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 800000) the "fill minzoom" is 9 and the "name minzoom" is 11.  The catch-all for the smallest ones is 13 for fill and 14 for name.

`beach`, `tidal_beach`, `sand` and `tidal_sand` are handled like this.  These are computed values based on the raw OSM tags for `natural` and `tidal`.
 
### Variable zoom `natural` mud and rock in `land1`

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 16000000) the "fill minzoom" is 7 and the "name minzoom" is 9.  The catch-all for the smallest ones is 14 for fill and name.

`mud`, `tidal_mud`, `bare_rock`, `tidal_rock`, `scree`, `tidal_scree`, `shingle`, `tidal_shingle`, `heath`, `grassland`, and `scrub` are handled like this.

### Zoom 9 `natural=bigpeak` in `land1`. 

These are written a an named area feature only (with `ele`) at vector zoom 9.

The value `bigpeak` is calculated from (`ele` > 914) and (`prominence` <= 500).  If not tagged `prominence` is guessed based on other tags such as `munro`.

The value of `ele` is written as an attribute.

### Zoom 10 `natural` other peak and similar features in `land1`. 

These are written a an named area feature only (with `ele`) at vector zoom 10.

The value `peak` is calculated from (`ele` <= 914).

`peak`, `saddle` and `volcano` are handled like this.

The value of `ele` is written as an attribute.

### Zoom 12 `natural` wetland features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 12.

`wetland`, `intermittentwetland`, `swamp`, `bog`, `string_bog`, `reef` and `reefsand` are handled like this.  These tags are computed from other tags such as `wetland`, `intermittent`, `surface` etc.

### Zoom 12 `natural=hill` in `land1`. 

These are written a an named area feature only (with `ele`) at vector zoom 12.  `hill` is derived from a couple of tag combinations (`natural=hill` and `peak=hill`).

The value of `ele` is written as an attribute.

### Zoom 13 `natural=spring` in `land1`. 

These are written as a named area feature only at vector zoom 13.  

Regular springs are handled here.  See also `holy_spring` elsewhere.

### Zoom 14 `natural` features in `land1`. 

These are written as a named area feature only at vector zoom 14.  

`cave_entrance`, `sinkhole`, `climbing`, `rock`, `tree`, `tree_10m`, `tree_20m`, `tree_30m` and `shrub` are handled like this.  The `tree` tags are computed from the value of `diameter_crown`.

### Zoom 14 point and area `barrier` features in `land1`. 

These are written as a named area feature only at vector zoom 14.  

`cattle_grid`, `cycle_barrier`, `gate`, `gate_locked`, `horse_stile`, `kissing_gate`, `dog_gate_stile`, `stepping_stones`, `stile`, `block`, `bollard`, `lift_gate`, `toll_booth`, `toll_gantry`, `door` and `hedge` are handled like this.

Note that linear versions of many of these are also processed, but to `linearbarrier` not `land1`.

### Zoom 10 `waterway=damarea` in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 10.

`waterway=damarea` is a tag computed based on closed way `waterway=dam` that are not buildings.

### Zoom 14 `waterway` point and area features in `land1`. 

These are written as an named area only at vector zoom 14.

`lock_gate`, `sluice_gate`, `waterfall`, `weir` and `floating_barrier` are handled like this.

### Zoom 9 `power` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 9.

`station` and `generator` are handled like this.

Also see e.g. `power_water` et al elsewhere.

### Zoom 12 `power` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 12.

`substation` is handled like this.

Also see e.g. `power_water` et al elsewhere.

### Zoom 14 `power` point and area features in `land1`. 

These are written as an named area only at vector zoom 14.

`tower` and `pole` are handled like this.

Also see e.g. `power_water` et al elsewhere.

### Zoom 9 `tourism=attraction` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 9.

Note that where `tourism=attraction` occurs in combination with other tags, almost always the other tags will be used and the `tourism=attraction` tag removed.

### Zoom 12 `tourism` point and area features without centroid in `land1`. 

These are written as an named area only at vector zoom 12.

`picnic_site` and `alpine_hut` are handled like this.

### Zoom 12 `tourism` point and area features with centroid in `land1`. 

These are written as an unnamed area and named centroid at vector zoom 12.

`camp_site`, `caravan_site` and `theme_park` are handled like this.

### Zoom 14 `tourism` point and area features without centroid in `land1`. 

These are written as an named area only at vector zoom 14.

`viewpoint`, `information`, `informationncndudgeon`, `informationncnmccoll`, `informationncnmills`, `informationncnrowe`, `informationncnunknown`, `informationpnfs`, `informationoffice`, `informationboard`, `informationear`, `informationplaque`, `informationpublictransport`, `informationroutemarker`, `informationsign`, `informationmarker`, `informationprowmarker`, `informationstele`, `informationartwork`, `militarysign`, `advertising_column`, `artwork`, `singlechalet`, `hostel`, `bed_and_breakfast`, `guest_house`, `tourism_guest_dynd`, `tourism_guest_nydn`, `tourism_guest_nynn`, `tourism_guest_yddd`, `tourism_guest_ynnn`, `tourism_guest_ynyn`, `tourism_guest_yynd`, `tourism_guest_yyyn`, `tourism_guest_yyyy` and `camp_pitch` are handled like this.

Many of those values are computed from a selection of OSM tags - for example, the value of `ncn_milepost` is used when setting values for the various NCN route markers.  The `tourism_guest_` values are used for various sorts of guest accommodation.  The flags mean "self catering", "multiple occupancy", "urban setting" and "cheap" (like a hostel).

The value of `ele` and `ref` are written as attributes.

A `nwnrelationlist` value is also written out if set, made up of all the appropriate relation `ref` or `name` values concatenated together.  `nhnrelation_in_list` is written as an attrinbte if one of the relations is an NHN (horse) relation. A `ncnrelationlist` value is also written out if set.

### Zoom 14 `tourism` point and area features with centroid in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 14.

`motel`, `hotel`, `chalet`, `museum`, `gallery`, `aquarium`, `zoo` are handled like this.

### Zoom 10 `aeroway` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 10.

Point and area `runway` and `grass_runway` are handled like this.  `grass_runway` is computed based on the `surface` tag of the runway.  An closed runway way is assumed to be an area (since circular runways are not a thing).  Linear runways are written to `transportation`; see above.

### Zoom 12 `aeroway` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 12.

Point and area `apron` and `taxiway` are handled like this.  Unless `area=yes` is explicitly set we assume that a taxiway is linear, because there are circular ones.

### Zoom 14 `aeroway` point and area features in `land1`. 

These are written as an unnamed area and a named centroid at vector zoom 14.

Point and area `helipad` and `gate` are handled like this.  The `way_area` is written against the centroid, as is `ref`.

### Zoom 11 address point and area features in `land1`. 

If nothing else has caused a feature to be written to `land1`, a non-nil, non-blank `addr:housenumber` on a non-building will result in a `housenumber` object being writte as an area feaure at vector zoom 11.

### Zoom 9 `natural=flood_prone` point and area features in `land2`. 

These are written as an named area only at vector zoom 9.

`natural=flood_prone` is handled like this.  This tag is computed from various other raw tags, including `basin` values that would not normally have water in them.

### Zoom 8 `natural` forest and farmland point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 8.

`natural=unnamed_forest` and `natural=unnamedfarmland` are handled like this.  These tags are set when other more important tags should be used for the name, but we still want `forest` or `farmland` fill.

### Variable zoom `natural` point and area features in `land2`. 

These are written as an unnamed area feature only at a based-on-area "minzoom".

For the largest of these features (way_area > 800000) the "minzoom" is 9.  The catch-all for the smallest ones is 13.

`unnamedgrass`, `unnamedresidential`, `unnamedmeadow`, `unnamedwetmeadow`, `unnamedfarmyard`, `unnamedfarmgrass`, `unnamedindustrial`, `unnamedcommercial`, `unnamedconstruction`, `unnamedlandfill`, `unnamedorchard`, `unnamedmeadowtransitional`, `unnamedmeadowwildflower`, `unnamedmeadowperpetual`, `unnamedsaltmarsh`, `unnamedallotments`, `unnamedchristiancemetery`, `unnamedjewishcemetery` and `unnamedothercemetery` are handled like this.  Again, these tags are set when other more important tags should be used for the name, but we still want a fill from another feature.  As with the named versions of these tags, these computed from other raw OSM tags - synonyms, subtags and others such as religion.

### Variable zoom `landuse=miltary` point and area features in `land2`. 

These are written as a area feature at a based-on-area "fill minzoom" and an also as a point feature at a based-on-area "name minzoom".  

For the largest of these features (way_area > 150000000) the "fill minzoom" and the "name minzoom" are both 7.  The catch-all for the smallest ones is 14 for fill and name.

After writing out a `landuse=military` feature an additional `leisure` feature may also be written - see `leisure=unnamedpitch` below.  This is an exception to the way that processing is done in almost all other cases.

### Zoom 10 `landuse` quarry point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 10.

`landuse=unnamedquarry` and `landuse=unnamedhistoricquarry` are written out as unnamed area features.  The second of these values in particular is computed from other raw OSM tags such as `disused`.

### Zoom 13 `landuse=harbour` point and area features in `land2`. 

These are written as an unnamed area and named centroid at vector zoom 13.

### Zoom 9 `leisure=unnamedpitch` point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 9.

### Zoom 13 `leisure=marina` point and area features in `land2`. 

These are written as an unnamed area and a named centroid at vector zoom 13.

### Zoom 8 `landuse` woodland point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 8.

`unnamedwood`, `unnamedbroadleaved`, `unnamedneedleleaved`, `unnamedmixedleaved` are handled like this.

### Zoom 9 `landuse` point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 9.

`unnamedheath`, `unnamedscrub`, `unnamedmud`, `unnamedtidal_mud`, `unnamedbare_rock`, `unnamedbeach`, `unnamedsand`, `unnamedtidal_sand` and `unnamedgrassland` are handled like this.

### Zoom 12 `landuse` point and area features in `land2`. 

These are written as an unnamed area only at vector zoom 12.

`unnamedwetland`, `unnamedswamp`, `unnamedbog` and `unnamedstring_bog` are handled like this.

### Zoom 12 `aeroway` point and area features in `land2`. 

These are written as an unnamed area and a named centroid at vector zoom 12.

`aerodrome` and `large_aerodrome`, are handled like this.

A "large" aerodrome is one that has an `iata` value that is non-miltary.

### Variable zoom `boundary=administrative` point and area features in `land2`. 

These are written as an unnamed area feature only at a based-on-admin_level "minzoom".  

For countries (`admin_level=2`) the `minzoom` value is 0, for `admin_level=11`, it is 12.

Alongside `boundary=administrative` written to `class`, `boundary_X` (where X is the `admin_level`) is written to `admin_level`, as an area feature, and also as a centroid with `way_area` and `name`.

### Zoom 6 `boundary` national parks etc. point and area features in `land2`. 

These are written as an unnamed area and a named centroid at vector zoom 6.

`national_park` and `access_land` are handled like this.

## "poi"

Not written by default - this is an optional catch-all that can output everything not handled by "land1" processing.  Uncomment out the call to `generic_after_poi( passedt )` to produce this layer, which contains all unhandled `amenity`, `shop` and `tourism` features.

### class

Stored as the OSM tag and value, such as `amenity_wibble`, where `wibble` is not an amenity value already expected by the "land1" layer.

### name

the value of the OSM name tag, after any postprocessing e.g. for `operator`.


For individual source tag values used see [here](https://taginfo.openstreetmap.org/projects/someoneelse_vector_sve01#tags
).


