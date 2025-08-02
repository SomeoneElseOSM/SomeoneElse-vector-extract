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

As well as highways, the value of `railway` is wrtten out for non-area `railway` objects from vector zoom 6.  Non-linear `railway` objects are written to `land` not here.  Some other changes are made:

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

Genuine highway areas are handled via "land1", not here.  For some highway types that are closed ways, `area` needs to be checked to choose which layer something should be processed as:

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


## "land1" and "land2"

There are two "landuse / landcover" layers into which all sorts of landuse, leisure, natural etc. areas and points go.  Most go into "land1", except in the case of some overlays (e.g. military red hatching) which goes into "land2".  The same name collision avoidance logic is used as in the [equivalent raster map code](https://github.com/SomeoneElseOSM/SomeoneElse-style); the resulting "unnamed" area features also go into "land2".

Features are written from an appropriate zoom level, which depending on the feature (e.g. "natural=water", "leisure=nature_reserve") and that zoom level in many cases will vary based on `way_area` or a proxy for that (`sqkm`).

Most area "`landuse`, `leisure`, etc." features that may be either large or small will be written out twice - once as a polygon without a name, so that a rendering style can show an appropriate fill and outline, and once as a centroid with a name (if one exists), together with the way_area of the polygon.  This allows the fill and/or outline for these features to be shown at one (lower) zoom level, and the `name` at a higher one, and the rendering style may choose to display larger feature names earlier than smaller ones.

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

For pubs, a series of up to 8 flags is appended.  For each flag, "d" means "don't know", "y" means "yes" and "n" no. These flags and any other values are:

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
* `place_of_worship_shinto` based on the `religion` of an `amenity=place_of_worship`
* `boothtelephonered` and `boothmuseum`: Usage of current and former telephone boxes, based on other tags.
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

(older notes)

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


