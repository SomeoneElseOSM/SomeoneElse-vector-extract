# Changes made to the [SVE01 schema](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/README_sve01.md).  
See also the [changelog](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/changelog.md) for the scripts here.

## As yet unreleased
Moved the extraction of natural=intermittentwater from land2 to land1, to ensure that name appears.  "natural=flood_prone" is still in land2; a name is extracted for it but will likely be ignored as often a land1 feature for the same object will exist.
For some larger landuse, show the name via one object at the centroid rather than distributed in each polygon tile.

## 10/11/2024
Initial release.
