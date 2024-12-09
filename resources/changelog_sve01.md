# Changes made to the [SVE01 schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md).  
See also the [changelog](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/changelog.md) for the scripts here.

## As yet unreleased
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
