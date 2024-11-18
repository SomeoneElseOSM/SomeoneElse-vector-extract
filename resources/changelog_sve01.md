# Changes made to the [SVE01 schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md).  
See also the [changelog](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/changelog.md) for the scripts here.

## As yet unreleased
Set minzoom for "natural=water" to 5-8 based on way_area.
Set minzoom for "leisure=nature_reserve" to 6-9 based on way_area.
If something is both a "natural=peak" and a "man_made=survey_point", display as the former.
Moved the extraction from "tourism=zoo" from zoom 9 to 14.

## 17/11/2024
Added "aeroway=aerodrome" in "land2" to the list of "larger landuse" that gets separate centroid object extracted with the name.
Extract the way_area for "natural=water" areas so that a map style can display the names of larger ones at lower zooms than smaller ones.

## 14/11/2024
Moved the extraction of natural=intermittentwater from land2 to land1, to ensure that name appears.  "natural=flood_prone" is still in land2; a name is extracted for it but will likely be ignored as often a land1 feature for the same object will exist.
For some larger landuse, show the name via one object at the centroid rather than distributed in each polygon tile.
Extract names on centroids of larger landuse only, to work around https://github.com/maplibre/maplibre-gl-js/issues/5042 .

## 10/11/2024
Initial release.
