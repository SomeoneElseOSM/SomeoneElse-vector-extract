# Changes made to the scripts at the top level of [this repository](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md).  
See also the [changelog](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/resources/changelog_sve01.md) for the schema.

## 26/04/2025
Both "update_vector" scripts now use "nice -n 15" to inhibit e.g. raster tile serving less.

## 06/02/2025
The `update_vector2.sh` script now applies the same language rules as equivalent vector maps, so Welsh names are used in predominantly Welsh-speaking parts of Wales, Scots Gaelic in equivalent places in Scotland, and English in the rest of England, Scotland and Wales.

## 26/11/2025
The `update_vector.sh` and `update_vector_ia.sh` helper scripts now update the Android Native style swd06 based on the web one swd01 and installs that too.

## 22/11/2024
Added default attribution to config file.

## 11/11/2024
Added "resources/INSTALL_sve01.md" to summarise schema installation instructions.

## 10/11/2024
Initial release.
