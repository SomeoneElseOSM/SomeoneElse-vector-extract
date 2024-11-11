# Installation

The following has been tested on Ubuntu 22.04 and Debian 12, and will likely work elsewhere.

For more detail "basic server setup" see [this OSM diary entry](https://www.openstreetmap.org/user/SomeoneElse/diary/404191), although we won't need all the software mentioned there.

As is normal for these things, use a regular non-root user for this.

    sudo apt update
    sudo apt upgrade

I'll assume that basic tools are installed as per that diary page, and that Apache with https support has been set up.

## Tilemaker and mod_mbtiles

Install some prerequisite software if not already present:

    sudo apt install gdal-bin apache2-dev libsqlite3-dev

Install mod_mbtiles

    cd
    mkdir src
    cd src
    git clone https://github.com/systemed/mod_mbtiles
    cd mod_mbtiles
    sudo apxs -lsqlite3 -i -a -c mod_mbtiles.c
    sudo systemctl restart apache2

Test that apache is still working.  Next, install Tilemaker:

    cd ~/src
    git clone https://github.com/systemed/tilemaker

Now we need to build tilemaker locally as described [here](https://github.com/systemed/tilemaker/blob/master/docs/INSTALL.md).

    sudo apt install build-essential libboost-dev libboost-filesystem-dev libboost-iostreams-dev libboost-program-options-dev libboost-system-dev liblua5.1-0-dev libshp-dev libsqlite3-dev rapidjson-dev zlib1g-dev
    cd ~/src/tilemaker
    make

and if that has successfully built a "tilemaker" executable:

    sudo make install

The lua version above will vary by OS; you may already have a later one.  Different lua versions can coexist.

    cd ~/src
    git clone https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract

    cd ~/src
    git clone https://github.com/SomeoneElseOSM/SomeoneElse-style

Next copy "shared_lua.lua" from "SomeoneElse-style" to somewhere that lua will include from, perhaps (depending on the lua version used) "/usr/local/share/lua/5.1/".  If it can't find it later it'll list where it is looking to make it easy to know where to move it to.

You'll also probably want to install an example web map style that uses this schema:

    cd ~/src
    git clone https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display

That contains a fully featured web map styles (called "svwd01") and a debug style ("svwd04").  See the [two](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/README.md) [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-web-display/blob/main/resources/README_svwd01.md) files there for more information.

Next, obtain coastline data:

    cd ~/src/tilemaker
    ./get-coastline.sh

    mkdir ~/data
    tilemaker --output ~/data/coastline.mbtiles --bbox -27.57,34.5,40.17,71.64 --process resources/process-coastline.lua --config resources/config-coastline.json

The bounding box above is for "Britain and Ireland and a bit more"; you'll likely want something else, but probably not (at least not initially) the whole world.

You're then ready to generate your ".mbtiles" file.  There is a helper script "update_vector.sh" which contains the following:

    local_filesystem_user=yournonrootusername
    sudo -u ${local_filesystem_user} /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/sve_extract.sh /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/config-sve01.json /home/${local_filesystem_user}/src/SomeoneElse-vector-extract/resources/process-sve01.lua /home/${local_filesystem_user}/data/tilemaker_sve01.mbtiles  -27.57,34.5,40.17,71.64 /home/${local_filesystem_user}/data/coastline.mbtiles   europe united-kingdom england  north-yorkshire

You'll likely want to do something similar, perhaps selecting a different Geofabrik region.  See the [readme](https://github.com/SomeoneElseOSM/SomeoneElse-vector-extract/blob/main/README.md) for more information.

## What can go wrong?

If Apache fails to restart:

    Job for apache2.service failed because the control process exited with error code.
    See "systemctl status apache2.service" and "journalctl -xeu apache2.service" for details.

Then it might be due to [this issue](https://github.com/systemed/mod_mbtiles/issues/3).  Edit the Apache config files of the form

    MbtilesAdd sve01 /var/www/html/vector/sve01/tilemaker_sve01.mbtiles

so that there are more or fewer of them and restart apache:

    sudo /etc/init.d/apache2 restart

Likely that will work.

