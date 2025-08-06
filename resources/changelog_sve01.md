# Changes made to the [SVE01 schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md).  
See also the [changelog](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/changelog.md) for the scripts here.

## As yet unreleased
Ensure that bus stops that have also been tagged as platforms are correctly treated as bus stops.
Node bus platforms are all mistagged bus stops.
Changed "parking=e-scooter" to "parking=e_scooter" following a change to all the values in OSM.
Linear and area `highway=emergency_bay` are now both treated appropriately.

## 01/08/2025
Re-added `shop=amusement` as a synonym for `amusements`.
Treat `place=island` nodes as `place=locality`.

## 21/07/2025
Treat `natural=cliff`, `natural=ridge` and `natural=arch` nodes as a geographic place like `cape`, `peninsula` etc. - all treated like `place=locality`.
Treat linear `natural=strait` and `natural=mountain_range` as a linear `natural=valley`.
Treat linear `natural=gully` as a linear `natural=valley` - a linear name is shown.  Node and area `natural=gully` are treated as `place=locality`.
Treat linear `place=locality` as a linear `natural=valley` - a linear name is shown.  
Extract `tunnel` as a boolean on `natural=water` areas.
Treat area `highway=raceway` as area `leisure=track`.

## 13/07/2025
Treat `place=ocean` as `place=sea`.
Extract `place=sea` based on the size of the feature.
If a `place=sea` is a node but has `sqkm` set, use that to set minzoom.
Treat `natural=isthmus`, `natural=pass`, `natural=creek`, `natural=fishing_bank`, `natural=inlet`, `natural=land`, `natural=hillside` and `natural=cirque` as a geographic place like `cape`, `peninsula` etc. - all treated like `place=locality`.

## 12/07/2025
Treat `natural=moor`, `natural=strait`, `natural=mountain_range` and `natural=landform` as a geographic place like `cape`, `peninsula` etc. - all treated like `place=locality`.
Remove brands with semicolons in them as it's likely "brands sold here" not "brands of here".
Use `sqkm` on localities to generate a pseudo-way_area, as a proof of concept solution to problems such as https://community.openstreetmap.org/t/looking-for-the-pacific-ocean/128699 .
Treat `natural=shake_hole` et al as synonyms for `sinkhole`.
Treat `place=region` as `place=locality` if it's not some sort of boundary.

## 09/07/2025
Extract way and relation `place=locality` at the same zoom levels as `place=island`.  This includes things like large peninsulas.
Node `place=locality` are extracted at zoom 14 (one zoom level higher than e.g. `hamlet`).

## 06/07/2025
Extract cafes with `cuisine=bubble_tea` and `cuisine=indian` separately and e.g. `fish_and_chips` as restaurants.
Process various crossing tags to decide if a crossing should be extracted.
Removed `LPG=yes`.  No longer in the data.
Include galleries with artworks in former telephone box uses.
Extract noncommercial art galleries with a unique museum-like icon.
Handle more semicolon values.  Apart from some special cases, shops with semicolon values just use the first part.
Change squiggly brackets at the start of appended bridge refs to round brackets.
Detect Core Paths in Scotland which only have "Core Path..." set in the `ref`.

## 03/07/2025
Extract `wheelchair` info for `amenity=fast_food` with `cuisine=kebab`, `cuisine=mexican` and synonyms.
Extract `wheelchair` info for `amenity=restaurant` with `cuisine=british`, `cuisine=regional`, `cuisine=mexican`, `cuisine=seafood` and synonyms.

## 23/06/2025
Extract `wheelchair` info for `amenity=restaurant` with no `cuisine`, `cuisine=indian`, `cuisine=chinese`, `cuisine=italian`, `cuisine=fish_and_chips`, `cuisine=burger`, `cuisine=coffee_shop`, `cuisine=sandwich`, `cuisine=chicken`, `cuisine=kebab` and `cuisine=french` and synonyms.

## 19/06/2025
Fix bug where `frozen_yogurt` was assigned incorrectly to both `dessert` and `ice_cream`.
Trim cuisine values before the first semicolon, so that more semicolon combination combinations are handled.
Extract `wheelchair` info for `amenity=fast_food` with no `cuisine` and `cuisine=fish_and_chips`, `chinese`, `pizza`, `sandwich`, `burger`, `chicken`, `indian`.
Removed `barrier=hand_rail_fence`.  No longer in the data.

## 09/06/2025
Fix a bug in the way that the "munro" tag was handled in Scotland (to assume prominence where none is given in the data).

## 08/06/2025
Extract ice cream restaurants as a separate `amenity` so that a unique icon can be used.
Extract Caribbean, Lebanese, dessert, Spanish and African fast food and restaurants as a separate `amenity` so that a unique icon can be used.
Extract donut fast food places as a separate `amenity` so that a unique icon can be used.

## 07/06/2025
Extract British fast food and Regional, Mexican, Greek, French and seafood fast food and restaurants as a separate `amenity` so that a unique icon can be used.
Extract `accomodation` (a misspelling of `accommodation`).
Ensure that all restaurants with a non-no `accommodation` values are treated as having accommodation.

## 04/06/2025
Extract Indian, Chinese, Italian, Fish and Chips, Burger, Coffee Shop, Sandwich, Chicken, Kebab and British resturants as a separate `amenity` so that a unique icon can be used.

## 01/06/2025
Extract Indian resturants as a separate `amenity` so that a unique icon can be used.

## 31/05/2025
Use the `restaurant` tag on a pub to tell that it serves food.

## 27/05/2025
Use a characteristic icon for `golf=pin` rather than  generic leisure one.

## 26/05/2025
Removed `shop=clothing`.  No longer in the data
Handle `military=range_marker` as something that can be displayed as military-coloured marker posts.
Handle military information boards as military signs.
Round `ele` values on the features where it is shown (peaks, cairns, etc.).
Use the `diameter_crown` value to write a `crown` attribute for large trees of "10m", "20m", "30m".
Treat `information=information_office` as `information=office`.
Treat various other `information` values as either new (stele, artwork) or existing.

## 25/05/2025
Revisit `basin` values to decide which are wet all the time and which merely `flood_prone`.  `intermittent` is still considered.

## 23/05/2025
Treat `amenity=fast_food; cuisine==frozen_yogurt` as `cuisine=ice_cream`.
Treat `amenity=fast_food; cuisine==filipino` as `cuisine=chinese`.
Treat `amenity=fast_food; cuisine==friture` as `cuisine=fish_and_chips`.
Extract linear rivers at vector zoom 10.

## 11/05/2025
Treat `access=emergency` and `services=emergency_access` as "no access".
Fix bug where memorial benches were not shown as such.
Removed `shop=e-cigarette;confectionery;cbd`.  No longer in the data.
Fix bug where `display` was never obtained so sundials were never detected.

## 09/05/2025
Removed `power=sub_station` and `amenity=escape_game`.  No longer in the data.
Extract PROW fingerposts as a different value.

## 02/05/2025
Add `disused:amenity` to the list of generic keys so that unnamed former pubs are shown as such.
Add more "nature reserve designations".
Fix bug whereby some "nature reserve designations" were not shown correctly on vector.

## 30/04/2025
Handle shooting grounds better - show both the danger hatching and the pitch.

## 26/04/2025
If something is both a road and tram, show both.

## 22/04/2025
Make displayed name of a Teesdale Way alt route more sensible.
Check `railway` before processing `railway:preserved=yes` so that only preserved rails are handled as such.

## 20/04/2025
Show more "not quite buildings" as such, including `construction`.
Don't show "not buildings" as such, including `demolished`.
Don't show underground buildings as buildings.
Close loophole that allowed some closed linear hedges to incorrectly appear as areas.

## 17/04/2025
Check `shoulder:both`, `shoulder:left`, and `shoulder:right` along with `shoulder`.
Check `expressway` and `motorroad` along with `shoulder` etc.

## 14/04/2025
Changed the pub floor logic to only look at the first entry in semicolon-separated list.  Added "glued gravel" as a noncarpeted floor material.
The first pre-semicolon value for "sport" is now used, which has a minor impact on combinations such as "multi;soccer;basketball" which previously used the first non-multi value.
If a `wetland` is mapped without `natural`, and without any other obvious key, assume `natural=wetland`.

## 12/04/2025
Expand "silly name processing" to also handle silly names on relations that a node is part of, which are available for display with the node as e.g. "nwnrelationlist".

## 11/04/2025
Removed `sport=baseball;american_football;ice_hockey;basketball`.  No longer in the data.

## 30/03/2025
Removed `information=leaflet_board`.  No longer in the data.

## 28/03/2025
Consolidate more RWN section names.
Removed `gate=kissing`.  No longer in the data.
Append "£" to toll roads and paths as if it was an official ref.
Extract the `website` along with the `name` on `amenity=charging_station`.

## 26/03/2025
Suppress `substance=gas_topology`.  Not really a pipeline.
Extract `highway=toll_gantry` as `barrier=toll_gantry`.

## 23/03/2025
Extract `highway=elevator` nodes and ways, with a name if present.

## 22/03/2025
Removed `landmark=obelisk`.  No longer in the data.
Use `animal=yes` to detect `farmgrass`.

## 17/03/2025
More National Trail name consolidation and shields, including South West Coast Path.
Also consolidate some some RWN section names.

## 16/03/2025
Shorten some brand names, usually if another name exists.
Suppress overly long (> 40 characters) brands and operators.
Shorten some names, where a rare longer version is used in place of a common shorter one.
Consolidate some National Trail names so that "names" like "King Charles III England Coast Path: East: Shotley Gate to Felixstowe Ferry" are shown instead as just "England Coast Path".

## 13/03/2025
Mud, scree, heath, scrub etc. are now extracted at a wider range of zoom levels,
Removed `shop=loan_shark`.  No longer in the data.
Removed `crossing=light_controlled`.  No longer in the data.
Removed `landmark=windsock`.  No longer in the data.
Added `shop=e-cigarette;convenience` as a synonym for `e-cigarette`, and various other similar synonyms.

## 09/03/2025
Parks etc. are now extracted at a range of zoom levels also based on way_area.
Lots of power infrastructure is now extracted at a range of zoom levels also based on way_area.

## 09/03/2025 AM
Historic now extracted at a range of zoom levels also based on way_area.
Education and hospitals in the `land1` layer are now extracted at a range of zoom levels between 8 and 14, with names extracted between 10 and 14.  Also retail, construction, brownfield, landfill, orchard, vineyard.

## 08/03/2025
Farmland, farmgrass, farmyard, forest, grass, meadow and residential in the `land1` layer (which is most of it) is now extracted at a range of zoom levels between 8 and 14, with names extracted between 10 and 14.
Reduced the threshold for military extraction at zoom 9.

## 07/03/2025
Moved "water area size extract at zoom" logic from "svwd01" style to the "sve01" extract code and adjusted zoom levels to make zoom 8 and 9 tiles smaller.  Also `industrial`, `commercial` and `railway` `landuse`, and various sand.
Small military areas are no longer all extracted at vector zoom 6 with names shown from 11+.  The range is now 7-14 for both.
Woodland in the `land1` layer (which is most of it) is now extracted at a range of zoom levels between 8 and 14, with names extracted between 10 and 14.

## 06/03/2025
Moved "island size extract at zoom" logic from "svwd01" style to the "sve01" extract code for zooms between 6 and 13.  Higher zoom levels are extracted at zoom level 14, and the decision to display is in the style .json.
Also similarly handled the extract for `landuse=recreation_ground`, `landuse=conservation`, `landuse=village_grean` and `leisure=nature_reseerve`.

## 02/03/2025
Extract linear `man_made=crane` as `railway=miniature`.
Treat `greenfield` as `farmgrass` rather than `construction`.

## 24/02/2025
Extract `place=sea` at zoom level 8.
Extract node and polygon `man_made=crane`.
Removed `information=noticeboard`, no longer in the data.

## 16/02/2025
Fixed bugs that were suppressing the display of palaeolontological sites.
Fixed bugs that were suppressing the display of eco health food shops.
`ford=Tidal_Causeway` has been renamed to the more normal `ford=tidal_causeway`.
Handle `police=checkpoint` as other checkpoints.  Added `police=offices` as other government offices.  Also `police=car_pound`, `police=detention`, `police=range`, `police=training_area`, `police=traffic_police`, `police=storage`, `police=dog_unit`, `police=horse`.

## 05/02/2025
Added `amenity=lost_property` and `amenity=lost_property_office` as offices.
Extract `ref` along with various `tourism` tags including `informationpnfs`.
Extract `highway=busway` as `highway=bus_guideway` rather than `service`.

## 02/02/2025
Extract `wetland=swamp`, `wetland=bog` and `wetland=string_bog` to be passed through as individual `natural` values.
Added some more values (e.g. `swamp`) to the unnamed extract code.

## 28/01/2025
Extract housenumbers not attached to buildings.
Extract address interpolation lines.

## 23/01/2025
Added `whitewater=put_in_out` as a variety of waterway access point.
Extract `emergency=access_point` and `highway=emergency_access_point` as `amenity=emergency_access_point` with `name` as `ref`.

## 18/01/2025
Show more `unclassified` `surface` values as `unpaved`.
Don't show `bridge=low_water_crossing` on a `waterway` as a `bridge`.
If a `waterway` is allegedly both a `bridge` and a `tunnel`, assume it is not really a bridge.
Also extract the `operator` value for LDPs.
Where a NWN does have a known operator and doesn't have a ref, have a go at constructing a ref.

## 16/01/2025
The `bridge` value is now a string not a boolean, containing `yes`, `levee` or blank.

## 14/01/2025
Fixed a bug in the tertiary / passing place logic

## 12/01/2025
Removed `natural=col` from taginfo and shared code, no longer in the data.
Added `"high_resolution": true` it increase resolution of z14 tiles, as suggested by https://github.com/systemed/tilemaker/discussions/792#discussioncomment-11773710
Extract `highway=turning_circle` from zoom 12.
If a tertiary road has `passing_places` and isn't oneway, junction, doesn't have "lanes" or any width set, assume that it's narrow.

## 05/01/2025
Handle `industrialbuilding` as per `industrial`; write out name and way_area at centroid.
Handle route relation membership for other node tags, including artworks and NCN mileposts.
Special-case some "sensibly named and important" LCNs, both for relation display and relation membershop display.  Unfortunately many LCNs are just wishlists and can't be included more generally.
Use `ref` on IWNs when appending to a relation list.
Use `name` on LCNs when appending to a relation list.
Exclude empty names/refs when creating a list of relations.
Also extract `parking_space`, because the vector code now interprets that directly.

## 04/01/2025
Also create `ncnrelationlist`, containing the refs of all cycling relations that node is a member of.

## 03/01/2025
(via shared lua) Extract an `orchard` landuse for plant nurseries, so that an orchard fill can be displayed.
For `informationmarker` and `informationroutemarker`, where a guidepost is a marker of a walking or horse route relation, create an `nwnrelationlist` containing the names all relations that the node is a member of.  Also set a `nhnrelatation_in_list` flag if one of the relations is a horse relation.

## 01/01/2025
Extract `place=island` from zoom 4 upwards, based on the way_area, up to 14.

## 30/12/2024
After moving the sluice gate / waterfall / weir / floating barrier consolidation from the shared lua to the raster-only code, the vector code was modified to extract linear `waterway=lock_gate`, `waterway=sluice_gate`, `waterway=waterfall`, `waterway=weir`, and `waterway=floating_barrier` to `linearbarrier` and point and (multi)polygon ones to `land1`.
Extract `natural=intermittentwetland` for intermittent wetland areas.

## 29/12/2024
Extract both the name (on a centroid) and area for more wood features.
Extract both the name (on a centroid) and area for deserts.
Extract both the name (on a centroid) and area for military barracks.
Support a couple more synynyms for civilian shooting ranges.
Extract both the name (on a centroid) and area for `leisure=hunting_stand` (sometimes used on shooting grounds in error).
Extract linear slipways into `transportation` as `leisure=slipway`.
Extract both the name (on a centroid) and area for orchards, vineyards and pedestrian areas.
Extract both the name (on a centroid) and area for breweries and nonspecific offices.
Handle breakwaters as per groynes.

## 28/12/2024
Fixed bug whereby some area aeroways were also handled as circular linear ones.
Extract both the name (on a centroid) and area for various area aeroway features.
Extract both the name (on a centroid) and area for more tourism features.
Extract both the name (on a centroid) and area for more `amenity=ferry_terminal`.
If a barrier is a closed way, suppress the name - the name probably belongs to an area that the barrier shares nodes with.
Extract both the name (on a centroid) and area for various power features.
Detect marine water-based power stations (wave power etc.) and exclude from regular "industrial" power stations.
Handle differently-sized `natural=bay` in the same way as `natural=water`.

## 27/12/2024
Ensure that tourist accommodation in historic watermills and windmills is correctly shown as tourist accommodation.
If a watermill or windmill is a museum or a historic building, assume that it is also a historic mill.
Use `tower` in addition to `tower:type` to classify various towers.
Moved `tourism=theme_park` to the list of objects for which object names are written separately for the centroid.
Updated README to improve formatting only.
Added `outlet` to the list of keys that are processed.
Extract buildings from vector zoom 11, which matches raster zoom 12.
Only write polygons for historic features that are actually polygons.
Extract closed areas of access land as `boundary=access_land` from zoom 6.
Fixed a bug whereby unsigned relations could escape into the vector tiles.
Extract names of marinas and harbours at centroid only.
Don't create buildings for more `building` objects where the value implies "not a building" (such as "no").
Extract names of most shops at centroid only.

## 26/12/2024
Tidy access values for various parking objects in lua to either "yes" or "no".
Consolidated centroid processing (no functional change).
Added more detail to README.
Use `driveway` (designed to be less prominent than a regular service road) for `parking_aisle` and `drive-though` as well as `driveway`.
Export `boundary=administative` together with the `name` and `admin_level`.
Changed the `place` layer export to use nodes only.
Fixed a bug whereby some electricity-only `amenity=fuel` were being extracted as fuel rather than chargng stations.

## 23/12/2024
Some amenities (`bicycle_rental` etc.) are extracted with an access value as well.
Detect `tower:type=ventilation` as a ventilation shaft.
Extract names of some features (parking areas etc.) at centroid only.

## 20/12/2024
Added "disused:amenity" and "was:amenity" to node keys so that these are processed into e.g. closed pubs.
Most generic lua processing is now shared between raster and vector.
Send `man_made=bridge` through to the rendering code as `building=bridge_area` to allow the vector code to display it better (no display change in raster).

## 19/12/2024
If an `aeroway=taxiway` has not been explicitly declared as an area, assume it is linear.
Handle intermittent drains and ditches, sending them through as `intdrain` and `intditch` respectively.

## 18/12/2024
Extract `highway=ford` for point fords.
Changed the minzoom on `highway=motorway_junction` extraction to 10.

## 16/12/2024
Extract dam area features as explicit area features (`waterway=damarea`) with a name at the centroid, which also has the feature way_area.

## 15/12/2024
Extract way_area for nature_reserves etc.
Check that national parks are closed before extracting them into `land2`.

## 14/12/2024
Extract railways from zoom 6.
Extract `railway=phone` as `emergency=phone`.
Extract `railway=wash` as a roof if not a building already.
Extract `railway=water_crane` as `historic=water_crane`.
Extract `railway=crane` (which are all linear) as miniature railways in their own right.
Extract a couple more historic railway features as "nonspecific".
Extract railway turntables as circular polygons  with a name.

## 13/12/2024
Extract some natural feature names as centroids.
Extract way_area for `tourism=attraction`.

## 11/12/2024
Extract dog parks into land1 so that they can be displayed separately (some are unnamed).
Extract `highway=motorway_junction` into `land1` with `name` and `ref` at zoom 14.
Extract university, school names etc. at the centroid.
Don't extract `barrier=ford` on ways with `highway` set - they will be extracted as highways.
Some ventilation shafts with unusual tagging were missing; these have now been included.
Extract `landuse=military` names at the centroid, along with the polygon `way_area`.

## 09/12/2024
Removed `surface=mud, sand` and `surface=sand, mud`, no longer in the data.

## 01/12/2024
Fix bug where the names of some regional cycleways were missing.
Treat `government=customs` as a government office.
If a `tourism=attraction` is also a `highway`, show as `highway`.
Write out boundary relations and call lua processing in the same way as routes.
Write out national park names at the centroid only

## 24/11/2024
Extract locked linear gates in a similar way to unlocked ones.
Extract linear lift gates in the same way.
Fixed bug where some former amenities were missing from former pub logic.
Added extract of pipelines at vector zoom 14.
Show more utility aerial pipeline markers.
Added `office=office` to the list of "nonspecific offices" that are handled.
Use more verge tags to detect verges.
Use `theatre:type` to detect concert halls.
Use `sport` to detect bowling alleys and places for skiing that are not tagged as that but are not tagged as anything else.
Added `shop=window_construction` as a synonym for `craft=window_construction`.
Added `shop=veterinary` as a synonym for `amenity=veterinary`.
Added `shop=key_cutter` as a synonym for `craft=key_cutter`.
Added `shop=financial_advice` as a synonym for `amenity=financial_advice`.
Added `shop=financial_advisor` as a synonym for `office=financial_advisor`.
Added `shop=carpenter` as a synonym for `craft=carpenter`.
Added `shop=dressmaker` as a synonym for `craft=dressmaker`.

## 22/11/2024
Extract the way_area for various park and garden features so that a map style can display the names of larger ones at lower zooms than smaller ones.
Extract [man_made=milk_churn_stand](https://taginfo.openstreetmap.org/tags/man_made=milk_churn_stand#overview) objects.

## 18/11/2024
Set minzoom for "natural=water" to 5-8 based on way_area.
Set minzoom for "leisure=nature_reserve" to 6-9 based on way_area.
If something is both a "natural=peak" and a "man_made=survey_point", display as the former.
Moved the extraction from "tourism=zoo" from zoom 9 to 14.
Extract the way_area for lots of "landuse" areas so that a map style can display the names of larger ones at lower zooms than smaller ones.
Extract the way_area for various beach and sand features so that a map style can display the names of larger ones at lower zooms than smaller ones.

## 17/11/2024
Added "aeroway=aerodrome" in "land2" to the list of "larger landuse" that gets separate centroid object extracted with the name.
Extract the way_area for "natural=water" areas so that a map style can display the names of larger ones at lower zooms than smaller ones.

## 14/11/2024
Moved the extraction of natural=intermittentwater from land2 to land1, to ensure that name appears.  "natural=flood_prone" is still in land2; a name is extracted for it but will likely be ignored as often a land1 feature for the same object will exist.
For some larger landuse, show the name via one object at the centroid rather than distributed in each polygon tile.
Extract names on centroids of larger landuse only, to work around https://github.com/maplibre/maplibre-gl-js/issues/5042 .

## 10/11/2024
Initial release.
