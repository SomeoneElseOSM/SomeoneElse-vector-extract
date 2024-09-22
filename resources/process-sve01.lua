-- ----------------------------------------------------------------------------
-- process-sve01.lua
--
-- Copyright (C) 2024  Andy Townsend
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
-- ----------------------------------------------------------------------------
-- Code common to several projects is in "shared_lua.lua".
-- That file is in the "SomeoneElse-style" repository, but needs to be 
-- available on the standard lua path when this script is invoked.  An easy way
-- to do that is to copy it to a local shared area on that path:
-- cp /home/${local_filesystem_user}/src/SomeoneElse-style/shared_lua.lua -
--      /usr/local/share/lua/5.3/
-- ----------------------------------------------------------------------------
require "shared_lua"

-- Nodes will only be processed if one of these keys is present
node_keys = { "amenity", "natural", "place", "shop", "tourism" }

-- Initialize Lua logic

function init_function()
end

-- Finalize Lua logic()
function exit_function()
end


-- ------------------------------------------------------------------------------
-- Main entry point for processing nodes
--
-- The parameter here is an object that describes one node.  See:
-- https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md#principal-lua-functions
-- Note that "node" is an object with specific methods, unlike the array that is 
-- passed to similar code in osm2pgsql's pgsql lua calls.
--
-- "generic_before_function" handles things like "unusual" tags that we want to 
-- replace across the board.
-- Then any processing that only applies to nodes is done.
-- Finally "generic_after_function" handles everything else, including most of
-- the "move OSM tags to vector layers"
-- ------------------------------------------------------------------------------
function node_function()
    local nodet = {}
    nodet.amenity = Find("amenity")
    nodet.place = Find("place")
    nodet.shop = Find("shop")
    nodet.wasCshop = Find("was:shop")
    nodet.closedCshop = Find("closed:shop")
    nodet.disusedCshop = Find("disused:shop")
    nodet.tourism = Find("tourism")
    nodet.layer = Find("layer")
    nodet.bridge = Find("bridge")
    nodet.tunnel = Find("tunnel")
    nodet.embankment = Find("embankment")
    nodet.highway = Find("highway")
    nodet.level = Find("level")
    nodet.golf = Find("golf")
    nodet.sidewalk = Find("sidewalk")
    nodet.sidewalkCleft = Find("sidewalk:left")
    nodet.sidewalkCright = Find("sidewalk:right")
    nodet.sidewalkCboth = Find("sidewalk:both")
    nodet.footway = Find("footway")
    nodet.shoulder = Find("shoulder")
    nodet.hard_shoulder = Find("hard_shoulder")
    nodet.cycleway = Find("cycleway")
    nodet.segregated = Find("segregated")
    nodet.verge = Find("verge")
    nodet.waterway = Find("waterway")
    nodet.building = Find("building")
    nodet.natural = Find("natural")
    nodet.wasCamenity = Find("was:amenity")
    nodet.closedCamenity = Find("closed:amenity")
    nodet.disusedCamenity = Find("disused:amenity")
    nodet.wasCwaterway = Find("was:waterway")
    nodet.disusedCwaterway = Find("disused:waterway")
    nodet.wasCrailway = Find("was:railway")
    nodet.disusedCrailway = Find("disused:railway")
    nodet.aeroway = Find("aeroway")
    nodet.wasCaeroway = Find("was:aeroway")
    nodet.disusedCaeroway = Find("disused:aeroway")
    nodet.landuse = Find("landuse")
    nodet.wasClanduse = Find("was:landuse")
    nodet.disusedClanduse = Find("disused:landuse")
    nodet.status = Find("status")
    nodet.disused = Find("disused")
    nodet.name = Find("name")
    nodet.nameCleft = Find("name:left")
    nodet.nameCright = Find("name:right")
    nodet.nameCen = Find("name:en")
    nodet.nameCsigned = Find("name:signed")
    nodet.nameCabsent = Find("name:absent")
    nodet.old_name = Find("old_name")
    nodet.official_ref = Find("official_ref")
    nodet.highway_authority_ref = Find("highway_authority_ref")
    nodet.highway_ref = Find("highway_ref")
    nodet.admin_ref = Find("admin_ref")
    nodet.adminCref = Find("admin:ref")
    nodet.loc_ref = Find("loc_ref")
    nodet.ref = Find("ref")
    nodet.refCsigned = Find("ref:signed")
    nodet.unsigned = Find("unsigned")
    nodet.surface = Find("surface")
    nodet.visibility = Find("visibility")
    nodet.trail_visibility = Find("trail_visibility")
    nodet.footCphysical = Find("foot:physical")
    nodet.overgrown = Find("overgrown")
    nodet.obstacle = Find("obstacle")
    nodet.informal = Find("informal")
    nodet.width = Find("width")
    nodet.est_width = Find("est_width")
    nodet.maxwidth = Find("maxwidth")
    nodet.designation = Find("designation")
    nodet.prow_ref = Find("prow_ref")
    nodet.sac_scale = Find("sac_scale")
    nodet.scramble = Find("scramble")
    nodet.ladder = Find("ladder")
    nodet.access = Find("access")
    nodet.accessCfoot = Find("access:foot")
    nodet.accessCbicycle = Find("access:bicycle")
    nodet.accessChorse = Find("access:horse")
    nodet.foot = Find("foot")
    nodet.bicycle = Find("bicycle")
    nodet.horse = Find("horse")
    nodet.service = Find("service")
    nodet.motor_vehicle = Find("motor_vehicle")
    nodet.boundary = Find("boundary")
    nodet.protect_class = Find("protect_class")
    nodet.protection_title = Find("protection_title")
    nodet.leisure = Find("leisure")
    nodet.landcover = Find("landcover")
    nodet.barrier = Find("barrier")
    nodet.ford = Find("ford")
    nodet.oneway = Find("oneway")
    nodet.junction = Find("junction")
    nodet.farmland = Find("farmland")
    nodet.animal = Find("animal")
    nodet.meadow = Find("meadow")
    nodet.produce = Find("produce")
    nodet.historic = Find("historic")
    nodet.ruins = Find("ruins")
    nodet.ruinsCman_made = Find("ruins:man_made")
    nodet.towerCtype = Find("tower:type")
    nodet.aircraftCmodel = Find("aircraft:model")
    nodet.inscription = Find("inscription")
    nodet.tomb = Find("tomb")
    nodet.archaeological_site = Find("archaeological_site")
    nodet.geological = Find("geological")
    nodet.attraction = Find("attraction")
    nodet.reef = Find("reef")
    nodet.wetland = Find("wetland")
    nodet.tidal = Find("tidal")
    nodet.playground = Find("playground")
    nodet.sport = Find("sport")
    nodet.military = Find("military")
    nodet.hazard = Find("hazard")
    nodet.operator = Find("operator")
    nodet.leaf_type = Find("leaf_type")
    nodet.power = Find("power")
    nodet.zoo = Find("zoo")
    nodet.industrial = Find("industrial")
    nodet.seamarkCtype = Find("seamark:type")
    nodet.religion = Find("religion")
    nodet.denomination = Find("denomination")
    nodet.iata = Find("iata")
    nodet.icao = Find("icao")
    nodet.aerodromeCtype = Find("aerodrome:type")
    nodet.small_electric_vehicle = Find("small_electric_vehicle")
    nodet.network = Find("network")
    nodet.fee = Find("fee")
    nodet.male = Find("male")
    nodet.female = Find("female")
    nodet.area = Find("area")
    nodet.man_made = Find("man_made")
    nodet.landmark = Find("landmark")
    nodet.airmark = Find("airmark")
    nodet.abandonedCrailway = Find("abandoned:railway")
    nodet.historicCrailway = Find("historic:railway")
    nodet.wall = Find("wall")
    nodet.memorial = Find("memorial")
    nodet.memorialCtype = Find("memorial:type")
    nodet.marker = Find("marker")
    nodet.historicCcivilisation = Find("historic:civilisation")
    nodet.site_type = Find("site_type")
    nodet.fortification_type = Find("fortification_type")
    nodet.megalith_type = Find("megalith_type")
    nodet.place_of_worship = Find("place_of_worship")
    nodet.climbing = Find("climbing")
    nodet.disusedCman_made = Find("disused:man_made")
    nodet.castle_type = Find("castle_type")
    nodet.pipeline = Find("pipeline")
    nodet.intermittent = Find("intermittent")

    generic_before_function( nodet )

-- No node-specific code yet

    generic_after_function( nodet )
end -- node_function()

-- ------------------------------------------------------------------------------
-- Main entry point for processing ways
-- The parameter here is an object that describes one way.  See:
-- https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md#principal-lua-functions
-- Note that "node" is an object with specific methods, unlike the array that is 
-- passed to similar code in osm2pgsql's pgsql lua calls.
--
-- "generic_before_function" handles things like "unusual" tags that we want to 
-- replace across the board.
-- Then any processing that only applies to ways is done.
-- Finally "generic_after_function" handles everything else, including most of
-- the "move OSM tags to vector layers"
-- ------------------------------------------------------------------------------
function way_function()
    local wayt = {}
    wayt.amenity = Find("amenity")
    wayt.place = Find("place")
    wayt.shop = Find("shop")
    wayt.wasCshop = Find("was:shop")
    wayt.closedCshop = Find("closed:shop")
    wayt.disusedCshop = Find("disused:shop")
    wayt.tourism = Find("tourism")
    wayt.layer = Find("layer")
    wayt.bridge = Find("bridge")
    wayt.tunnel = Find("tunnel")
    wayt.embankment = Find("embankment")
    wayt.highway = Find("highway")
    wayt.level = Find("level")
    wayt.golf = Find("golf")
    wayt.sidewalk = Find("sidewalk")
    wayt.sidewalkCleft = Find("sidewalk:left")
    wayt.sidewalkCright = Find("sidewalk:right")
    wayt.sidewalkCboth = Find("sidewalk:both")
    wayt.footway = Find("footway")
    wayt.shoulder = Find("shoulder")
    wayt.hard_shoulder = Find("hard_shoulder")
    wayt.cycleway = Find("cycleway")
    wayt.segregated = Find("segregated")
    wayt.verge = Find("verge")
    wayt.waterway = Find("waterway")
    wayt.building = Find("building")
    wayt.natural = Find("natural")
    wayt.wasCamenity = Find("was:amenity")
    wayt.closedCamenity = Find("closed:amenity")
    wayt.disusedCamenity = Find("disused:amenity")
    wayt.wasCwaterway = Find("was:waterway")
    wayt.disusedCwaterway = Find("disused:waterway")
    wayt.wasCrailway = Find("was:railway")
    wayt.disusedCrailway = Find("disused:railway")
    wayt.aeroway = Find("aeroway")
    wayt.wasCaeroway = Find("was:aeroway")
    wayt.disusedCaeroway = Find("disused:aeroway")
    wayt.landuse = Find("landuse")
    wayt.wasClanduse = Find("was:landuse")
    wayt.disusedClanduse = Find("disused:landuse")
    wayt.status = Find("status")
    wayt.disused = Find("disused")
    wayt.name = Find("name")
    wayt.nameCleft = Find("name:left")
    wayt.nameCright = Find("name:right")
    wayt.nameCen = Find("name:en")
    wayt.nameCsigned = Find("name:signed")
    wayt.nameCabsent = Find("name:absent")
    wayt.old_name = Find("old_name")
    wayt.official_ref = Find("official_ref")
    wayt.highway_authority_ref = Find("highway_authority_ref")
    wayt.highway_ref = Find("highway_ref")
    wayt.admin_ref = Find("admin_ref")
    wayt.adminCref = Find("admin:ref")
    wayt.loc_ref = Find("loc_ref")
    wayt.ref = Find("ref")
    wayt.refCsigned = Find("ref:signed")
    wayt.unsigned = Find("unsigned")
    wayt.surface = Find("surface")
    wayt.visibility = Find("visibility")
    wayt.trail_visibility = Find("trail_visibility")
    wayt.footCphysical = Find("foot:physical")
    wayt.overgrown = Find("overgrown")
    wayt.obstacle = Find("obstacle")
    wayt.informal = Find("informal")
    wayt.width = Find("width")
    wayt.est_width = Find("est_width")
    wayt.maxwidth = Find("maxwidth")
    wayt.designation = Find("designation")
    wayt.prow_ref = Find("prow_ref")
    wayt.sac_scale = Find("sac_scale")
    wayt.scramble = Find("scramble")
    wayt.ladder = Find("ladder")
    wayt.access = Find("access")
    wayt.accessCfoot = Find("access:foot")
    wayt.accessCbicycle = Find("access:bicycle")
    wayt.accessChorse = Find("access:horse")
    wayt.foot = Find("foot")
    wayt.bicycle = Find("bicycle")
    wayt.horse = Find("horse")
    wayt.service = Find("service")
    wayt.motor_vehicle = Find("motor_vehicle")
    wayt.boundary = Find("boundary")
    wayt.protect_class = Find("protect_class")
    wayt.protection_title = Find("protection_title")
    wayt.leisure = Find("leisure")
    wayt.landcover = Find("landcover")
    wayt.barrier = Find("barrier")
    wayt.ford = Find("ford")
    wayt.oneway = Find("oneway")
    wayt.junction = Find("junction")
    wayt.farmland = Find("farmland")
    wayt.animal = Find("animal")
    wayt.meadow = Find("meadow")
    wayt.produce = Find("produce")
    wayt.historic = Find("historic")
    wayt.ruins = Find("ruins")
    wayt.ruinsCman_made = Find("ruins:man_made")
    wayt.towerCtype = Find("tower:type")
    wayt.aircraftCmodel = Find("aircraft:model")
    wayt.inscription = Find("inscription")
    wayt.tomb = Find("tomb")
    wayt.archaeological_site = Find("archaeological_site")
    wayt.geological = Find("geological")
    wayt.attraction = Find("attraction")
    wayt.reef = Find("reef")
    wayt.wetland = Find("wetland")
    wayt.tidal = Find("tidal")
    wayt.playground = Find("playground")
    wayt.sport = Find("sport")
    wayt.military = Find("military")
    wayt.hazard = Find("hazard")
    wayt.operator = Find("operator")
    wayt.leaf_type = Find("leaf_type")
    wayt.power = Find("power")
    wayt.zoo = Find("zoo")
    wayt.industrial = Find("industrial")
    wayt.seamarkCtype = Find("seamark:type")
    wayt.religion = Find("religion")
    wayt.denomination = Find("denomination")
    wayt.iata = Find("iata")
    wayt.icao = Find("icao")
    wayt.aerodromeCtype = Find("aerodrome:type")
    wayt.small_electric_vehicle = Find("small_electric_vehicle")
    wayt.network = Find("network")
    wayt.fee = Find("fee")
    wayt.male = Find("male")
    wayt.female = Find("female")
    wayt.area = Find("area")
    wayt.man_made = Find("man_made")
    wayt.landmark = Find("landmark")
    wayt.airmark = Find("airmark")
    wayt.abandonedCrailway = Find("abandoned:railway")
    wayt.historicCrailway = Find("historic:railway")
    wayt.wall = Find("wall")
    wayt.memorial = Find("memorial")
    wayt.memorialCtype = Find("memorial:type")
    wayt.marker = Find("marker")
    wayt.historicCcivilisation = Find("historic:civilisation")
    wayt.site_type = Find("site_type")
    wayt.fortification_type = Find("fortification_type")
    wayt.megalith_type = Find("megalith_type")
    wayt.place_of_worship = Find("place_of_worship")
    wayt.climbing = Find("climbing")
    wayt.disusedCman_made = Find("disused:man_made")
    wayt.castle_type = Find("castle_type")
    wayt.pipeline = Find("pipeline")
    wayt.intermittent = Find("intermittent")

    generic_before_function( wayt )

-- ----------------------------------------------------------------------------
-- A "leisure=track" can be either a linear or an area feature
-- https://wiki.openstreetmap.org/wiki/Tag%3Aleisure%3Dtrack
-- Assign a highway tag (gallop or leisuretrack) so that linear features can
-- be explicitly rendered.
-- "sport" is often (but not always) used to separate different types of
-- leisure tracks.
--
-- If on an area, the way will go into planet_osm_polygon and the highway
-- feature won't be rendered (because both leisuretrack and gallop are only 
-- processed as linear features) but the leisure=track will be (as an area).
--
-- Additionally force anything that is "oneway" to not be an area feature
-- ----------------------------------------------------------------------------
   if ( wayt.leisure  == "track" ) then
      if (( wayt.sport    == "equestrian"   )  or
          ( wayt.sport    == "horse_racing" )) then
         wayt.highway = "gallop"
      else
         if ((( wayt.sport    == "motor"         )  or
              ( wayt.sport    == "karting"       )  or
              ( wayt.sport    == "motor;karting" )) and
             (( wayt.area     == nil              )  or
              ( wayt.area     == ""               )  or
              ( wayt.area     == "no"             ))) then
            wayt.highway = "raceway"
         else
            wayt.highway = "leisuretrack"
         end
      end

      if ( wayt.oneway == "yes" ) then
         wayt.area = "no"
      end
   end

-- ----------------------------------------------------------------------------
-- highway=turning_loop on ways to service road
-- "turning_loop" is mostly used on nodes, with one way in UK/IE data.
-- ----------------------------------------------------------------------------
   if ( wayt.highway == "turning_loop" ) then
      wayt.highway = "service"
      wayt.service = "driveway"
   end

-- ----------------------------------------------------------------------------
-- natural=rock on ways to natural=bare_rock
-- ----------------------------------------------------------------------------
   if ( wayt.natural == "rock" ) then
      wayt.natural = "bare_rock"
   end

-- ----------------------------------------------------------------------------
-- Where amenity=watering_place has been used on a way and there's no
-- "natural" tag already, apply "natural=water".
-- ----------------------------------------------------------------------------
   if ((  wayt.amenity == "watering_place"  ) and
       (( wayt.natural == nil              )  or
        ( wayt.natural == ""               ))) then
      wayt.amenity = nil
      wayt.natural = "water"
   end

-- ----------------------------------------------------------------------------
-- Before processing footways, turn certain corridors into footways
--
-- Note that https://wiki.openstreetmap.org/wiki/Key:indoor defines
-- indoor=corridor as a closed way.  highway=corridor is not documented there
-- but is used for corridors.  We'll only process layer or level 0 (or nil)
--
-- The assignment of local variables is done by the example code, I'm guessing
-- for reasons of speed.
-- ----------------------------------------------------------------------------
    wayt.highway = fix_corridors( wayt.highway, wayt.layer, wayt.level )

-- ----------------------------------------------------------------------------
-- Consolidate some rare highway types into ones we can display.
-- ----------------------------------------------------------------------------
    wayt.highway = process_golf_tracks( wayt.highway, wayt.golf )

-- ----------------------------------------------------------------------------
-- highway processing
-- ----------------------------------------------------------------------------
    if (( wayt.highway ~= nil )   and
        ( wayt.highway ~= ""  ))  then
        Layer("transportation", false)
        Attribute( "class", wayt.highway )
	Attribute( "name", wayt.name )

-- ----------------------------------------------------------------------------
-- If there is a sidewalk, set "edge" to "sidewalk"
-- ----------------------------------------------------------------------------
        if (( wayt.sidewalk == "both"            ) or 
            ( wayt.sidewalk == "left"            ) or 
            ( wayt.sidewalk == "mapped"          ) or 
            ( wayt.sidewalk == "separate"        ) or 
            ( wayt.sidewalk == "right"           ) or 
            ( wayt.sidewalk == "shared"          ) or 
            ( wayt.sidewalk == "yes"             ) or
            ( wayt.sidewalkCboth == "separate"   ) or 
            ( wayt.sidewalkCboth == "yes"        ) or
            ( wayt.sidewalkCleft == "segregated" ) or
            ( wayt.sidewalkCleft == "separate"   ) or 
            ( wayt.sidewalkCleft == "yes"        ) or
            ( wayt.sidewalkCright == "segregated" ) or 
            ( wayt.sidewalkCright == "separate"  ) or 
            ( wayt.sidewalkCright == "yes"       ) or
            ( wayt.footway  == "separate"        ) or 
            ( wayt.footway  == "yes"             ) or
            ( wayt.shoulder == "both"            ) or
            ( wayt.shoulder == "left"            ) or 
            ( wayt.shoulder == "right"           ) or 
            ( wayt.shoulder == "yes"             ) or
            ( wayt.hard_shoulder == "yes"        ) or
            ( wayt.cycleway == "track"           ) or
            ( wayt.cycleway == "opposite_track"  ) or
            ( wayt.cycleway == "yes"             ) or
            ( wayt.cycleway == "separate"        ) or
            ( wayt.cycleway == "sidewalk"        ) or
            ( wayt.cycleway == "sidepath"        ) or
            ( wayt.cycleway == "segregated"      ) or
            ( wayt.segregated == "yes"           ) or
            ( wayt.segregated == "right"         )) then
            Attribute("edge", "sidewalk")
        else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk but there is a verge, set "edge" to "verge"
-- ----------------------------------------------------------------------------
            if (( wayt.verge == "both"     ) or
                ( wayt.verge == "left"     ) or
                ( wayt.verge == "separate" ) or
                ( wayt.verge == "right"    ) or
                ( wayt.verge == "yes"      )) then
                Attribute("edge", "verge")
            else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk or verge but it is a long ford, set "edge" to "ford"
-- ----------------------------------------------------------------------------
                if ( wayt.ford == "yes" ) then
                    Attribute("edge", "ford")
                end  -- ford
            end -- verge
        end -- sidewalk

        AttributeBoolean( "bridge", ( wayt.bridge == "yes" ) )
        AttributeBoolean( "tunnel", ( wayt.tunnel == "yes" ) )
    end -- linear highways

-- ----------------------------------------------------------------------------
-- waterway processing
-- ----------------------------------------------------------------------------
    if (( wayt.waterway ~= nil ) and
        ( wayt.waterway ~= ""  )) then
        Layer("waterway", false)
        Attribute("class", wayt.waterway)
        Attribute( "name", Find( "name" ) )

        if (( wayt.waterway == "river"          ) or
            ( wayt.waterway == "canal"          ) or
            ( wayt.waterway == "derelict_canal" )) then
            MinZoom( 11 )
        else
            if (( wayt.waterway == "stream"   ) or
                ( wayt.waterway == "drain"    ) or
                ( wayt.waterway == "intriver" ) or
                ( wayt.waterway == "intstream" )) then
                MinZoom( 12 )
            else
                if ( wayt.waterway == "ditch" ) then
                    MinZoom( 13 )
                else
                    if ( wayt.waterway == "weir" ) then
                        MinZoom( 14 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
                    end -- weir
                end  -- ditch
            end -- stream etc.
        end -- river etc.
    end -- linear waterways

-- ----------------------------------------------------------------------------
-- Most other "adding to mbtiles" processing is shared for points and polygons
-- and is called from here:
-- ----------------------------------------------------------------------------
    generic_after_function( wayt )
end -- way_function()


-- ------------------------------------------------------------------------------
-- Generic code called for both nodes and ways.
-- "_before_" is called before any node or way specific code, "_after_" after.
-- For methods available, see
-- https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md#principal-lua-functions
-- ------------------------------------------------------------------------------
function generic_before_function( passedt )
-- ----------------------------------------------------------------------------
-- Invalid layer values - change them to something plausible.
-- ----------------------------------------------------------------------------
    passedt.layer = fix_invalid_layer_values( passedt.layer, passedt.bridge, passedt.embankment )

-- ----------------------------------------------------------------------------
-- Treat "was:" as "disused:"
-- ----------------------------------------------------------------------------
   if (( passedt.wasCamenity     ~= nil ) and
       ( passedt.disusedCamenity == nil )) then
      passedt.disusedCamenity = passedt.wasCamenity
   end

   if (( passedt.wasCwaterway     ~= nil ) and
       ( passedt.disusedCwaterway == nil )) then
      passedt.disusedCwaterway = passedt.wasCwaterway
   end

   if (( passedt.wasCrailway     ~= nil ) and
       ( passedt.disusedCrailway == nil )) then
      passedt.disusedCrailway = passedt.wasCrailway
   end

   if (( passedt.wasCaeroway     ~= nil ) and
       ( passedt.disusedCaeroway == nil )) then
      passedt.disusedCaeroway = passedt.wasCaeroway
   end

   if (( passedt.wasClanduse     ~= nil ) and
       ( passedt.disusedClanduse == nil )) then
      passedt.disusedClanduse = passedt.wasClanduse
   end

   if (( passedt.wasCshop     ~= nil ) and
       ( passedt.disusedCshop == nil )) then
      passedt.disusedCshop = passedt.wasCshop
   end

-- ----------------------------------------------------------------------------
-- Treat "closed:" as "disused:" in some cases too.
-- ----------------------------------------------------------------------------
   if (( passedt.closedCamenity  ~= nil ) and
       ( passedt.disusedCamenity == nil )) then
      passedt.disusedCamenity = passedt.closedCamenity
   end

   if (( passedt.closedCshop  ~= nil ) and
       ( passedt.disusedCshop == nil )) then
      passedt.disusedCshop = passedt.closedCshop
   end

-- ----------------------------------------------------------------------------
-- Treat "status=abandoned" as "disused=yes"
-- ----------------------------------------------------------------------------
   if ( passedt.status == "abandoned" ) then
      passedt.disused = "yes"
   end

-- ----------------------------------------------------------------------------
-- Before processing footways, turn certain corridors into footways
--
-- Note that https://wiki.openstreetmap.org/wiki/Key:indoor defines
-- indoor=corridor as a closed way.  highway=corridor is not documented there
-- but is used for corridors.  We'll only process layer or level 0 (or nil)
-- ----------------------------------------------------------------------------
   passedt.highway = fix_corridors( passedt.highway, passedt.layer, passedt.level )

-- ----------------------------------------------------------------------------
-- If there are different names on each side of the street, we create one name
-- containing both.
-- If "name" does not exist but "name:en" does, use that.
-- ----------------------------------------------------------------------------
   passedt.name = set_name_left_right_en( passedt.name, passedt.nameCleft, passedt.nameCright, passedt.nameCen )

-- ----------------------------------------------------------------------------
-- Move refs to consider as "official" to official_ref
-- ----------------------------------------------------------------------------
   passedt.official_ref = set_official_ref( passedt.official_ref, passedt.highway_authority_ref, passedt.highway_ref, passedt.admin_ref, passedt.adminCref, passedt.loc_ref, passedt.ref )

-- ----------------------------------------------------------------------------
-- "Sabristas" sometimes add dubious names to motorway junctions.  Don't show
-- them if they're not signed.
-- ----------------------------------------------------------------------------
   passedt.name = suppress_unsigned_motorway_junctions( passedt.name, passedt.highway, passedt.nameCsigned, passedt.nameCabsent, passedt.unsigned )

-- ----------------------------------------------------------------------------
-- Move unsigned road refs to the name, in brackets.
-- ----------------------------------------------------------------------------
   t = { passedt.name, passedt.highway, passedt.nameCsigned, passedt.nameCabsent, passedt.official_ref, passedt.ref, passedt.refCsigned, passedt.unsigned }
   suppress_unsigned_road_refs( t )

   if ( t[1] ~= nil ) then
      passedt.name = t[1]
   end

   if ( t[2] ~= nil ) then
      passedt.highway = t[2]
   end

   if ( t[3] ~= nil ) then
      passedt.nameCsigned = t[3]
   end

   if ( t[4] ~= nil ) then
      passedt.nameCabsent = t[4]
   end

   if ( t[5] ~= nil ) then
      passedt.official_ref = t[5]
   end

   if ( t[6] ~= nil ) then
      passedt.ref = t[6]
   end

   if ( t[7] ~= nil ) then
      passedt.refCsigned = t[7]
   end

   if ( t[8] ~= nil ) then
      passedt.unsigned = t[8]
   end

-- ----------------------------------------------------------------------------
-- Show natural=bracken as scrub
-- ----------------------------------------------------------------------------
   if ( passedt.natural  == "bracken" ) then
      passedt.natural = "scrub"
   end

-- ----------------------------------------------------------------------------
-- Show natural=col as natural=saddle
-- ----------------------------------------------------------------------------
   if ( passedt.natural  == "col" ) then
      passedt.natural = "saddle"
   end
 
-- ----------------------------------------------------------------------------
-- Render old names on farmland etc.
-- ----------------------------------------------------------------------------
   if ((( passedt.landuse  == "farmland"       )  or
        ( passedt.natural  == "grassland"      )  or
        ( passedt.natural  == "scrub"          )) and
       (  passedt.name     == nil               ) and
       (  passedt.old_name ~= nil               )) then
      passedt.name = "(" .. passedt.old_name .. ")"
      passedt.old_name = nil
   end

-- ----------------------------------------------------------------------------
-- If "visibility" is set but "trail_visibility" is not, use "visibility".
-- ----------------------------------------------------------------------------
   if (( passedt.visibility       ~= nil ) and
       ( passedt.trail_visibility == nil )) then
      passedt.trail_visibility = passedt.visibility
   end

-- ----------------------------------------------------------------------------
-- Rationalise the various trail_visibility values into 3 sets
-- (no value)    Implied good trail visibility.
--               
-- intermediate  Less trail visibility.  Shown with wider gaps in dotted line
-- bad           Even less trail visibility.  Shown with wider gaps or not shown
--               (depending on designation).
--
-- "trail_visibility=unknown" is treated as "good" since it's been mapped 
-- from aerial imagery.  It's not explicitly referenced below.
--
-- "trail_visibility=low" is treated as "intermediate" based on looking at 
-- the use in OSM.
--
-- Also treat "overgrown=yes" as "intermediate".  A discussion on talk-gb was
-- largely inconclusive, but "overgrown" is the "most renderable" way to deal
-- with things like this.  A later suggestion "foot:physical=no" is also 
-- included.
--
-- "informal=yes" was less common in the UK (but is becoming more so).
-- ----------------------------------------------------------------------------
   if (( passedt.trail_visibility == "no"         )  or
       ( passedt.trail_visibility == "none"       )  or
       ( passedt.trail_visibility == "nil"        )  or
       ( passedt.trail_visibility == "horrible"   )  or
       ( passedt.trail_visibility == "very_bad"   )  or
       ( passedt.trail_visibility == "bad"        )  or
       ( passedt.trail_visibility == "poor"       )  or
       ( passedt.footCphysical    == "no"         )) then
      passedt.trail_visibility = "bad"
   end

   if ((   passedt.trail_visibility == "intermediate"  )  or
       (   passedt.trail_visibility == "intermittent"  )  or
       (   passedt.trail_visibility == "indistinct"    )  or
       (   passedt.trail_visibility == "medium"        )  or
       (   passedt.trail_visibility == "low"           )  or
       (   passedt.overgrown        == "yes"           )  or
       (   passedt.obstacle         == "vegetation"    )  or
       ((( passedt.trail_visibility == nil           )    or
         ( passedt.trail_visibility == ""            ))   and
        (  passedt.informal         == "yes"          ))) then
      passedt.trail_visibility = "intermediate"
   end

-- ----------------------------------------------------------------------------
-- If we have an est_width but no width, use the est_width
-- ----------------------------------------------------------------------------
   if (( passedt.width     == nil  ) and
       ( passedt.est_width ~= nil  )) then
      passedt.width = passedt.est_width
   end

-- ----------------------------------------------------------------------------
-- highway=scramble is used very occasionally
--
-- If sac_scale is unset, set it to "demanding_alpine_hiking" here so that
-- e.g. "badpathnarrow" is set lower down.  
-- If it is already set, use the already-set value.
--
-- Somewhat related, if "scramble=yes" is set and "trail_visibility" isn't,
-- set "trail_visibility==intermediate" so that e.g. "badpathnarrow" is set.
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "scramble"  ) then
      passedt.highway = "path"

      if ( passedt.sac_scale == nil  ) then
         passedt.sac_scale = "demanding_alpine_hiking"
      end
   end

   if (( passedt.highway          ~= nil   ) and
       ( passedt.scramble         == "yes" ) and
       ( passedt.sac_scale        == nil   ) and
       ( passedt.trail_visibility == nil   )) then
      passedt.trail_visibility = "intermediate"
   end

-- ----------------------------------------------------------------------------
-- Suppress non-designated very low-visibility paths
-- Various low-visibility trail_visibility values have been set to "bad" above
-- to suppress from normal display.
-- The "bridge" check (on trail_visibility, not sac_scale) is because if 
-- there's really a bridge there, surely you can see it?
-- ----------------------------------------------------------------------------
   if (( passedt.highway          ~= nil   ) and
       ( passedt.designation      == nil   ) and
       ( passedt.trail_visibility == "bad" )) then
      if ((( tonumber(passedt.width) or 0 ) >=  2 ) or
          ( passedt.width == "2 m"                ) or
          ( passedt.width == "2.5 m"              ) or
          ( passedt.width == "3 m"                ) or
          ( passedt.width == "4 m"                )) then
         if ( passedt.bridge == nil ) then
            passedt.highway = "badpathwide"
         else
            passedt.highway = "intpathwide"
         end
      else
         if ( passedt.bridge == nil ) then
            passedt.highway = "badpathnarrow"
         else
            passedt.highway = "intpathnarrow"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Various low-visibility trail_visibility values have been set to "bad" above.
-- ----------------------------------------------------------------------------
   if (( passedt.highway ~= nil   ) and
       ( passedt.ladder  == "yes" )) then
      passedt.highway = "steps"
      passedt.ladder  = nil
   end

-- ----------------------------------------------------------------------------
-- Where a wide width is specified on a normally narrow path, render as wider
--
-- Note that "steps" and "footwaysteps" are unchanged by the 
-- pathwide / path choice below:
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "footway"   ) or 
       ( passedt.highway == "bridleway" ) or 
       ( passedt.highway == "cycleway"  ) or
       ( passedt.highway == "path"      )) then
      if ((( tonumber(passedt.width) or 0 ) >=  2 ) or
          ( passedt.width == "2 m"                ) or
          ( passedt.width == "2.5 m"              ) or
          ( passedt.width == "3 m"                ) or
          ( passedt.width == "4 m"                )) then
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intpathwide"
         else
            passedt.highway = "pathwide"
         end
      else
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intpathnarrow"
         else
            passedt.highway = "pathnarrow"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Where a narrow width is specified on a normally wide track, render as
-- narrower
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "track" ) then
      if (( passedt.width == nil ) or
          ( passedt.width == ""  )) then
         passedt.width = "2"
      end

      if ((( tonumber(passedt.width) or 0 ) >= 2 ) or
          (  passedt.width == "2 m"              ) or
          (  passedt.width == "2.5 m"            ) or
          (  passedt.width == "2.5m"             ) or
          (  passedt.width == "3 m"              ) or
          (  passedt.width == "3 metres"         ) or
          (  passedt.width == "3.5 m"            ) or
          (  passedt.width == "4 m"              ) or
          (  passedt.width == "5m"               )) then
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intpathwide"
         else
            passedt.highway = "pathwide"
         end
      else
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intpathnarrow"
         else
            passedt.highway = "pathnarrow"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Suppress some "demanding" paths.  UK examples with sac_scale:
-- alpine_hiking:
-- http://www.openstreetmap.org/way/168426583   Crib Goch, Snowdon
-- demanding_mountain_hiking:
-- http://www.openstreetmap.org/way/114871124   Near Tryfan
-- difficult_alpine_hiking:
-- http://www.openstreetmap.org/way/334306672   Jack's Rake, Pavey Ark
-- ----------------------------------------------------------------------------
   if ((  passedt.designation == nil                        ) and
       (( passedt.sac_scale   == "demanding_alpine_hiking" )  or
        ( passedt.sac_scale   == "difficult_alpine_hiking" ))) then
      if ((( tonumber(passedt.width) or 0 ) >=  2 ) or
          ( passedt.width == "2 m"                ) or
          ( passedt.width == "2.5 m"              ) or
          ( passedt.width == "3 m"                ) or
          ( passedt.width == "4 m"                )) then
         passedt.highway = "badpathwide"
      else
         passedt.highway = "badpathnarrow"
      end
   end

-- ----------------------------------------------------------------------------
-- Consolidate some access values to make later processing easier.
--
-- First - lose "access=designated", which is meaningless.
-- ----------------------------------------------------------------------------
   if ( passedt.access == "designated" ) then
      passedt.access = nil
   end

   if ( passedt.foot == "designated" ) then
      passedt.foot = "yes"
   end

   if ( passedt.bicycle == "designated" ) then
      passedt.bicycle = "yes"
   end

   if ( passedt.horse == "designated" ) then
      passedt.horse = "yes"
   end

-- ----------------------------------------------------------------------------
-- Handle dodgy access tags.  Note that this doesn't affect my "designation"
-- processing, but may be used by the main style, as "foot", "bicycle" and 
-- "horse" are all in as columns.
-- ----------------------------------------------------------------------------
   if (passedt.accessCfoot == "yes") then
      passedt.accessCfoot = nil
      passedt.foot = "yes"
   end

   if (passedt.accessCbicycle == "yes") then
      passedt.accessCbicycle = nil
      passedt.bicycle = "yes"
   end

   if (passedt.accessChorse == "yes") then
      passedt.accessChorse = nil
      passedt.horse = "yes"
   end

-- ----------------------------------------------------------------------------
-- On footpaths, if foot=no set access=no
--
-- Tracks etc. that aren't narrow won't be "pathnarrow" at this stage, and we
-- shouldn't set "access" based on "foot"
--
-- Things that are narrow but have a designation will either not be private to
-- foot traffic or should be picked up by the TRO etc. handling below.
-- ----------------------------------------------------------------------------
   if ((  passedt.highway == "pathnarrow" ) and
       (( passedt.foot    == "private"   )  or
        ( passedt.foot    == "no"        )) and
       (( passedt.bicycle == nil         )  or
        ( passedt.bicycle == "private"   )  or
        ( passedt.bicycle == "no"        )) and
       (( passedt.horse   == nil         )  or
        ( passedt.horse   == "private"   )  or
        ( passedt.horse   == "no"        ))) then
      passedt.access = "no"
   end

-- ----------------------------------------------------------------------------
-- When handling TROs etc. we test for "no", not private, hence this change:
-- ----------------------------------------------------------------------------
   if ( passedt.access == "private" ) then
      passedt.access = "no"
   end

   if ( passedt.foot == "private" ) then
      passedt.foot = "no"
   end

   if ( passedt.bicycle == "private" ) then
      passedt.bicycle = "no"
   end

   if ( passedt.horse == "private" ) then
      passedt.horse = "no"
   end

-- ----------------------------------------------------------------------------
-- Here we apply the track grade rendering to road designations:
--   unpaved roads                      unpaved
--   narrow unclassigned_county_road    ucrnarrow
--   wide unclassigned_county_road      ucrwide
--   narrow BOAT			boatnarrow
--   wide BOAT				boatwide
--   narrow restricted byway		rbynarrow
--   wide restricted byway		rbywide
--
-- prow_ref is appended in brackets if present.
-- ----------------------------------------------------------------------------
   if ((  passedt.highway == "unclassified"  ) and
       (( passedt.surface == "unpaved"      )  or 
        ( passedt.surface == "gravel"       ))) then
      passedt.highway = "unpaved"
   end

   if ((( passedt.highway == "residential"  )  or
        ( passedt.highway == "service"      )) and
       (( passedt.surface == "unpaved"      )  or 
        ( passedt.surface == "gravel"       ))) then
      passedt.highway = "track"
   end

   if (( passedt.designation == "unclassified_county_road"                       ) or
       ( passedt.designation == "unclassified_country_road"                      ) or
       ( passedt.designation == "unclassified_highway"                           ) or
       ( passedt.designation == "unclassified_road"                              ) or
       ( passedt.designation == "unmade_road"                                    ) or
       ( passedt.designation == "public_highway"                                 ) or 
       ( passedt.designation == "unclassified_highway;public_footpath"           ) or 
       ( passedt.designation == "unmade_road"                                    ) or 
       ( passedt.designation == "adopted"                                        ) or 
       ( passedt.designation == "unclassified_highway;public_bridleway"          ) or 
       ( passedt.designation == "adopted highway"                                ) or 
       ( passedt.designation == "adopted_highway"                                ) or 
       ( passedt.designation == "unclassified_highway;byway_open_to_all_traffic" ) or 
       ( passedt.designation == "adopted_highway;public_footpath"                ) or 
       ( passedt.designation == "tertiary_highway"                               ) or 
       ( passedt.designation == "public_road"                                    ) or
       ( passedt.designation == "quiet_lane;unclassified_highway"                ) or
       ( passedt.designation == "unclassified_highway;quiet_lane"                )) then
      if (( passedt.highway == "steps"         ) or 
	  ( passedt.highway == "intpathnarrow" ) or
	  ( passedt.highway == "pathnarrow"    )) then
	  passedt.highway = "ucrnarrow"
      else
         if (( passedt.highway == "service"     ) or 
             ( passedt.highway == "road"        ) or
             ( passedt.highway == "track"       ) or
             ( passedt.highway == "intpathwide" ) or
             ( passedt.highway == "pathwide"    )) then
	     passedt.highway = "ucrwide"
         end
      end

      append_prow_ref( passedt )
   end

   if (( passedt.designation == "byway_open_to_all_traffic" ) or
       ( passedt.designation == "public_byway"              ) or 
       ( passedt.designation == "byway"                     ) or
       ( passedt.designation == "carriageway"               )) then
      if (( passedt.highway == "steps"         ) or 
	  ( passedt.highway == "intpathnarrow" ) or
	  ( passedt.highway == "pathnarrow"    )) then
	  passedt.highway = "boatnarrow"
	  passedt.designation = "byway_open_to_all_traffic"
      else
         if (( passedt.highway == "service"     ) or 
             ( passedt.highway == "road"        ) or
             ( passedt.highway == "track"       ) or
             ( passedt.highway == "intpathwide" ) or
             ( passedt.highway == "pathwide"    )) then
	     passedt.highway = "boatwide"
	     passedt.designation = "byway_open_to_all_traffic"
         end
      end

      append_prow_ref( passedt )
   end

-- ----------------------------------------------------------------------------
-- Note that a designated restricted_byway up some steps would be rendered
-- as a restricted_byway.  I've never seen one though.
-- There is special processing for "public footpath" and "public_bridleway"
-- steps (see below) and non-designated steps are rendered as is by the
-- stylesheet.
-- ----------------------------------------------------------------------------
   if (( passedt.designation == "restricted_byway"                        ) or
       ( passedt.designation == "public_right_of_way"                     ) or
       ( passedt.designation == "unclassified_highway;restricted_byway"   ) or 
       ( passedt.designation == "unknown_byway"                           ) or 
       ( passedt.designation == "public_way"                              ) or 
       ( passedt.designation == "tertiary_highway;restricted_byway"       ) or 
       ( passedt.designation == "orpa"                                    ) or
       ( passedt.designation == "restricted_byway;quiet_lane"             )) then
      if (( passedt.highway == "steps"         ) or 
	  ( passedt.highway == "intpathnarrow" ) or
	  ( passedt.highway == "pathnarrow"    )) then
         passedt.highway = "rbynarrow"
         passedt.designation = "restricted_byway"
      else
         if (( passedt.highway == "service"     ) or 
             ( passedt.highway == "road"        ) or
             ( passedt.highway == "track"       ) or
             ( passedt.highway == "intpathwide" ) or
             ( passedt.highway == "pathwide"    )) then
	    passedt.highway = "rbywide"
            passedt.designation = "restricted_byway"
         end
      end

      append_prow_ref( passedt )
   end

   if (( passedt.designation == "public_bridleway"                    ) or
       ( passedt.designation == "bridleway"                           ) or 
       ( passedt.designation == "tertiary_highway;public_bridleway"   ) or 
       ( passedt.designation == "public_bridleway;public_cycleway"    ) or 
       ( passedt.designation == "public_cycleway;public_bridleway"    ) or 
       ( passedt.designation == "public_bridleway;public_footpath"    )) then
      if (( passedt.highway == "intpathnarrow" ) or
	  ( passedt.highway == "pathnarrow"    )) then
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intbridlewaynarrow"
         else
            passedt.highway = "bridlewaynarrow"
         end
      else
         if (( passedt.highway == "steps"          ) or
             ( passedt.highway == "bridlewaysteps" )) then
            passedt.highway = "bridlewaysteps"
         else
            if (( passedt.highway == "service"     ) or 
                ( passedt.highway == "road"        ) or
                ( passedt.highway == "track"       ) or
                ( passedt.highway == "intpathwide" ) or
                ( passedt.highway == "pathwide"    )) then
               if (( passedt.trail_visibility == "bad"          )  or
                   ( passedt.trail_visibility == "intermediate" )) then
                  passedt.highway = "intbridlewaywide"
               else
                  passedt.highway = "bridlewaywide"
               end
            end
         end
      end

      append_prow_ref( passedt )
   end

-- ----------------------------------------------------------------------------
-- Rights of way for people on foot are designated as:
-- England and Wales: public_footpath
-- Scotland: core_path (ish - more general acess rights exist)
-- Northern Ireland: public_footpath or PROW (actually "footpath" in law)
-- ----------------------------------------------------------------------------
   if (( passedt.designation == "public_footpath"                        ) or
       ( passedt.designation == "core_path"                              ) or 
       ( passedt.designation == "footpath"                               ) or 
       ( passedt.designation == "public_footway"                         ) or 
       ( passedt.designation == "public_footpath;permissive_bridleway"   ) or 
       ( passedt.designation == "public_footpath;public_cycleway"        ) or
       ( passedt.designation == "PROW"                                   ) or
       ( passedt.designation == "access_land"                            )) then
      if (( passedt.highway == "intpathnarrow" ) or
          ( passedt.highway == "pathnarrow"    )) then
         if (( passedt.trail_visibility == "bad"          )  or
             ( passedt.trail_visibility == "intermediate" )) then
            passedt.highway = "intfootwaynarrow"
         else
            passedt.highway = "footwaynarrow"
         end
      else
         if (( passedt.highway == "steps"        ) or
             ( passedt.highway == "footwaysteps" )) then
            passedt.highway = "footwaysteps"
         else
            if (( passedt.highway == "service"     ) or 
                ( passedt.highway == "road"        ) or
                ( passedt.highway == "track"       ) or
                ( passedt.highway == "intpathwide" ) or
                ( passedt.highway == "pathwide"    )) then
               if (( passedt.trail_visibility == "bad"          )  or
                   ( passedt.trail_visibility == "intermediate" )) then
                  passedt.highway = "intfootwaywide"
               else
                  passedt.highway = "footwaywide"
               end
            end
         end
      end

      append_prow_ref( passedt )
   end

-- ----------------------------------------------------------------------------
-- If something is still "track" by this point change it to pathwide.
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "track" ) then
      if (( passedt.trail_visibility == "bad"          )  or
          ( passedt.trail_visibility == "intermediate" )) then
         passedt.highway = "intpathwide"
      else
         passedt.highway = "pathwide"
      end
   end

-- ----------------------------------------------------------------------------
-- Treat access=permit as access=no (which is what we have set "private" to 
-- above).
-- ----------------------------------------------------------------------------
   if (( passedt.access  == "permit"       ) or
       ( passedt.access  == "agricultural" ) or
       ( passedt.access  == "forestry"     ) or
       ( passedt.access  == "delivery"     ) or
       ( passedt.access  == "military"     )) then
      passedt.access = "no"
   end

   if ( passedt.access  == "customers" ) then
      passedt.access = "destination"
   end

-- ----------------------------------------------------------------------------
-- Don't make driveways with a designation disappear.
-- ----------------------------------------------------------------------------
   if ((    passedt.service     == "driveway"                     ) and
       ((   passedt.designation == "public_footpath"             )  or
        (   passedt.designation == "public_bridleway"            )  or
        (   passedt.designation == "restricted_byway"            )  or
        (   passedt.designation == "byway_open_to_all_traffic"   )  or
        (   passedt.designation == "unclassified_county_road"    )  or
        (   passedt.designation == "unclassified_country_road"   )  or
        (   passedt.designation == "unclassified_highway"        ))) then
      passedt.service = nil
   end

-- ----------------------------------------------------------------------------
-- If motor_vehicle=no is set on a BOAT, it's probably a TRO, so display as
-- an RBY instead
-- ----------------------------------------------------------------------------
   if (( passedt.highway       == "boatwide"    )  and
       ( passedt.motor_vehicle == "no"          )) then
      passedt.highway = "rbywide"
   end

   if (( passedt.highway       == "boatnarrow"  )  and
       ( passedt.motor_vehicle == "no"          )) then
      passedt.highway = "rbynarrow"
   end

-- ----------------------------------------------------------------------------
-- Try and detect genuinely closed public footpaths, bridleways (not just those
-- closed to motor traffic etc.).  Examples with "access=no/private" are
-- picked up below; we need to make sure that those that do not get an
-- access=private tag first.
-- ----------------------------------------------------------------------------
   if ((  passedt.access      == nil                          )  and
       (( passedt.designation == "public_footpath"           )   or
        ( passedt.designation == "public_bridleway"          )   or
        ( passedt.designation == "restricted_byway"          )   or
        ( passedt.designation == "byway_open_to_all_traffic" )   or
        ( passedt.designation == "unclassified_county_road"  )   or
        ( passedt.designation == "unclassified_country_road" )   or
        ( passedt.designation == "unclassified_highway"      ))  and
       (  passedt.foot        == "no"                         )) then
      passedt.access  = "no"
   end

-- ----------------------------------------------------------------------------
-- The extra information "and"ed with "public_footpath" below checks that
-- "It's access=private and designation=public_footpath, and ordinarily we'd
-- just remove the access=private tag as you ought to be able to walk there,
-- unless there isn't foot=yes/designated to say you can, or there is an 
-- explicit foot=no".
-- ----------------------------------------------------------------------------
   if (((   passedt.access      == "no"                          )  or
        (   passedt.access      == "destination"                 )) and
       (((( passedt.designation == "public_footpath"           )    or
          ( passedt.designation == "public_bridleway"          )    or
          ( passedt.designation == "restricted_byway"          )    or
          ( passedt.designation == "byway_open_to_all_traffic" )    or
          ( passedt.designation == "unclassified_county_road"  )    or
          ( passedt.designation == "unclassified_country_road" )    or
          ( passedt.designation == "unclassified_highway"      ))   and
         (  passedt.foot        ~= nil                          )   and
         (  passedt.foot        ~= "no"                         ))  or
        ((( passedt.highway     == "pathnarrow"                )    or
          ( passedt.highway     == "pathwide"                  )    or
          ( passedt.highway     == "intpathnarrow"             )    or
          ( passedt.highway     == "intpathwide"               )    or
          ( passedt.highway     == "service"                   ))   and
         (( passedt.foot        == "permissive"                )    or
          ( passedt.foot        == "yes"                       ))))) then
      passedt.access  = nil
   end

-- ----------------------------------------------------------------------------
-- Send driveways through to the vector rendering code as 
-- a specific highway type (raster does not do this)
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "service"  ) and
       ( passedt.service == "driveway" )) then
      passedt.highway  = "driveway"
   end

-- ----------------------------------------------------------------------------
-- Render national parks and AONBs as such no matter how they are tagged.
--
-- Any with "boundary=national_park" set already will be included and won't
-- be affected by this.  Most national parks and AONBs in UK have 
-- "protect_class=5", but also have one of the "designation" values below.
-- Many smaller nature reserves have other values for designation and are
-- ignored here.
--
-- Previously this section also had "protect_class=2" because IE ones had that 
-- and not "boundary"="national_park", but that situation seems to have changed.
-- ----------------------------------------------------------------------------
   if ((   passedt.boundary      == "protected_area"                      ) and
       ((  passedt.designation   == "national_park"                      )  or 
        (  passedt.designation   == "area_of_outstanding_natural_beauty" )  or
        (  passedt.designation   == "national_scenic_area"               ))) then
      passedt.boundary = "national_park"
      passedt.protect_class = nil
   end

-- ----------------------------------------------------------------------------
-- Access land is shown with a high-zoom yellow border (to contrast with the 
-- high-zoom green border of nature reserves) and with a low-opacity 
-- yellow fill at all zoom levels (to contrast with the low-opacity green fill
-- at low zoom levels of nature reserves).
-- ----------------------------------------------------------------------------
   if ((  passedt.designation   == "access_land"     )  and
       (( passedt.boundary      == nil              )   or
        ( passedt.boundary      == "protected_area" ))  and
       (  passedt.highway       == nil               )) then
      passedt.boundary = "access_land"
   end

-- ----------------------------------------------------------------------------
-- Render certain protect classes and designations of protected areas as 
-- nature_reserve:
-- protect_class==1   "... strictly set aside to protect ... " (all sorts)
-- protect_class==4   "Habitat/Species Management Area"
--
-- There are a few instances of "leisure" being set to something else already
-- ("common", "park", "golf_course", "dog_park").  We leave that if so.
--
-- This selection does not currently include:
-- protect_class==98  "intercontinental treaties..." (e.g. world heritage)
-- ----------------------------------------------------------------------------
   if (((  passedt.boundary      == "protected_area"            )   and
        (( passedt.protect_class == "1"                        )    or
         ( passedt.protect_class == "2"                        )    or
         ( passedt.protect_class == "4"                        )    or
         ( passedt.designation   == "national_nature_reserve"  )    or
         ( passedt.designation   == "local_nature_reserve"     )    or
         ( passedt.designation   == "Nature Reserve"           )    or
         ( passedt.designation   == "Marine Conservation Zone" ))) and
       (   passedt.leisure       == nil                          )) then
      passedt.leisure = "nature_reserve"
   end

-- ----------------------------------------------------------------------------
-- Show grass schoolyards as green
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "schoolyard" ) and
       ( passedt.surface == "grass"      )) then
      passedt.landuse = "grass"
      passedt.leisure = nil
      passedt.surface = nil
   end

-- ----------------------------------------------------------------------------
-- "Nature reserve" doesn't say anything about what's inside; but one UK OSMer 
-- changed "landuse" to "surface" (changeset 98859964).  This undoes that.
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "nature_reserve" ) and
       ( passedt.surface == "grass"          )) then
      passedt.landuse = "grass"
      passedt.surface = nil
   end

-- ----------------------------------------------------------------------------
-- Treat landcover=grass as landuse=grass
-- Also landuse=college_court, flowerbed
-- ----------------------------------------------------------------------------
   if (( passedt.landcover == "grass"         ) or
       ( passedt.landuse   == "college_court" ) or
       ( passedt.landuse   == "flowerbed"     )) then
      passedt.landcover = nil
      passedt.landuse = "grass"
   end

-- ----------------------------------------------------------------------------
-- Treat natural=grass as landuse=grass 
-- if there is no other more appropriate tag
-- ----------------------------------------------------------------------------
   if (( passedt.natural  == "grass"  ) and
       (( passedt.landuse == nil     )  and
        ( passedt.leisure == nil     )  and
        ( passedt.aeroway == nil     ))) then
      passedt.landuse = "grass"
   end

-- ----------------------------------------------------------------------------
-- Treat natural=garden and natural=plants as leisure=garden
-- if there is no other more appropriate tag.
-- The "barrier" check is to avoid linear barriers with this tag as well 
-- becoming area ones unexpectedly
-- ----------------------------------------------------------------------------
   if ((( passedt.natural == "garden"     )   or
        ( passedt.natural == "plants"     )   or
        ( passedt.natural == "flower_bed" ))  and
       (( passedt.landuse == nil          )   and
        ( passedt.leisure == nil          )   and
        ( passedt.barrier == nil          ))) then
      passedt.leisure = "garden"
   end

-- ----------------------------------------------------------------------------
-- Render various synonyms for leisure=common.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse          == "common"   ) or
       ( passedt.leisure          == "common"   ) or
       ( passedt.designation      == "common"   ) or
       ( passedt.amenity          == "common"   ) or
       ( passedt.protection_title == "common"   )) then
      passedt.leisure = "common"
      passedt.landuse = nil
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Render quiet lanes as living streets.
-- This is done because it's a difference I don't want to draw attention to -
-- they aren't "different enough to make them render differently".
-- ----------------------------------------------------------------------------
   if ((( passedt.highway     == "tertiary"                          )  or
        ( passedt.highway     == "unclassified"                      )  or
        ( passedt.highway     == "residential"                       )) and
       (( passedt.designation == "quiet_lane"                        )  or
        ( passedt.designation == "quiet_lane;unclassified_highway"   )  or
        ( passedt.designation == "unclassified_highway;quiet_lane"   ))) then
      passedt.highway = "living_street"
   end

-- ----------------------------------------------------------------------------
-- Here the raster code has "Use unclassified_sidewalk to indicate sidewalk"
-- We don't do that here because we write an "edge" value through.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Render narrow tertiary roads as unclassified
-- ----------------------------------------------------------------------------
   if ((  passedt.highway    == "tertiary"  )  and
       (( passedt.oneway     == nil        )   or
        ( passedt.oneway     == ""         ))  and
       (( passedt.junction   == nil        )   or
        ( passedt.junction   == ""         ))  and
       ((( tonumber(passedt.width)    or 4 ) <=  3 ) or
        (( tonumber(passedt.maxwidth) or 4 ) <=  3 ))) then
      passedt.highway = "unclassified"
   end

-- ----------------------------------------------------------------------------
-- Render bus-only service roads tagged as "highway=busway" as service roads.
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "busway" ) then
      passedt.highway = "service"
   end

-- ----------------------------------------------------------------------------
-- Bridge types - only some types (including "yes") are selected
-- ----------------------------------------------------------------------------
   if (( passedt.bridge == "aqueduct"           ) or
       ( passedt.bridge == "bailey"             ) or
       ( passedt.bridge == "boardwalk"          ) or
       ( passedt.bridge == "building_passage"   ) or
       ( passedt.bridge == "cantilever"         ) or
       ( passedt.bridge == "chain"              ) or
       ( passedt.bridge == "covered"            ) or
       ( passedt.bridge == "foot"               ) or
       ( passedt.bridge == "footbridge"         ) or
       ( passedt.bridge == "gangway"            ) or
       ( passedt.bridge == "low_water_crossing" ) or
       ( passedt.bridge == "movable"            ) or
       ( passedt.bridge == "pier"               ) or
       ( passedt.bridge == "plank"              ) or
       ( passedt.bridge == "plank_bridge"       ) or
       ( passedt.bridge == "pontoon"            ) or
       ( passedt.bridge == "rope"               ) or
       ( passedt.bridge == "swing"              ) or
       ( passedt.bridge == "trestle"            ) or
       ( passedt.bridge == "undefined"          ) or
       ( passedt.bridge == "viaduct"            )) then
      passedt.bridge = "yes"
   end

-- ----------------------------------------------------------------------------
-- Remove some combinations of bridge
-- ----------------------------------------------------------------------------
   if ((  passedt.bridge  == "yes"          ) and
       (( passedt.barrier == "cattle_grid" )  or
        ( passedt.barrier == "stile"       ))) then
      passedt.barrier = nil
   end

-- ----------------------------------------------------------------------------
-- Tunnel values - render as "yes" if appropriate.
-- ----------------------------------------------------------------------------
   if (( passedt.tunnel == "culvert"             ) or
       ( passedt.tunnel == "covered"             ) or
       ( passedt.tunnel == "avalanche_protector" ) or
       ( passedt.tunnel == "passage"             ) or
       ( passedt.tunnel == "1"                   ) or
       ( passedt.tunnel == "cave"                ) or
       ( passedt.tunnel == "flooded"             ) or
       ( passedt.tunnel == "building_passage"    )) then
      passedt.tunnel = "yes"
   end

-- ----------------------------------------------------------------------------
-- Covered values - render as "yes" if appropriate.
-- ----------------------------------------------------------------------------
   if (( passedt.covered == "arcade"           ) or
       ( passedt.covered == "covered"          ) or
       ( passedt.covered == "colonnade"        ) or
       ( passedt.covered == "building_passage" ) or
       ( passedt.covered == "building_arcade"  ) or
       ( passedt.covered == "roof"             ) or
       ( passedt.covered == "portico"          )) then
      passedt.covered = "yes"
   end

-- ----------------------------------------------------------------------------
-- Aviaries in UK / IE seem to be always within a zoo or larger attraction, 
-- and not "zoos" in their own right.
-- ----------------------------------------------------------------------------
   if ((  passedt.zoo     == "aviary"  )  and
       (( passedt.amenity == nil      )   or
        ( passedt.amenity == ""       ))) then
      passedt.amenity = "zooaviary"
      passedt.tourism = nil
      passedt.zoo = nil
   end

-- ----------------------------------------------------------------------------
-- Some zoos are mistagged with extra "animal=attraction" or "zoo=enclosure" 
-- tags, so remove those.
-- ----------------------------------------------------------------------------
   if ((( passedt.attraction == "animal"    )  or
        ( passedt.zoo        == "enclosure" )) and
       (  passedt.tourism == "zoo"           )) then
      passedt.attraction = nil
      passedt.zoo = nil
   end

-- ----------------------------------------------------------------------------
-- Retag any remaining animal attractions or zoo enclosures for rendering.
-- ----------------------------------------------------------------------------
   if ((( passedt.attraction == "animal"    )  or
        ( passedt.zoo        == "enclosure" )) and
       (( passedt.amenity    == nil         )  or
        ( passedt.amenity    == ""          ))) then
      passedt.amenity = "zooenclosure"
      passedt.attraction = nil
      passedt.zoo = nil
   end

-- ----------------------------------------------------------------------------
-- Handle spoil heaps as landfill
-- ----------------------------------------------------------------------------
   if ( passedt.man_made == "spoil_heap" ) then
      passedt.landuse = "landfill"
   end

-- ----------------------------------------------------------------------------
-- Handle place=islet as place=island
-- Handle place=quarter
-- Handle natural=cape etc. as place=locality if no other place tag.
-- ----------------------------------------------------------------------------
   passedt.place = consolidate_place( passedt.place, passedt.natural )

-- ----------------------------------------------------------------------------
-- Handle shoals, either as mud or reef
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "shoal" ) then
      if ( passedt.surface == "mud" ) then
         passedt.natural = "mud"
         passedt.surface = nil
      else
         passedt.natural = "reef"
      end
   end

-- ----------------------------------------------------------------------------
-- Show sandy reefs as more sandy than rocky reefs
-- ----------------------------------------------------------------------------
   if (( passedt.natural == "reef" ) and
       ( passedt.reef    == "sand" )) then
         passedt.natural = "reefsand"
   end

-- ----------------------------------------------------------------------------
-- Convert "natural=saltmarsh" into something we can handle below
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "saltmarsh" ) then
      if ( passedt.wetland == "tidalflat" ) then
         passedt.tidal = "yes"
      else
         passedt.tidal = "no"
      end

      passedt.natural = "wetland"
      passedt.wetland = "saltmarsh"
   end

-- ----------------------------------------------------------------------------
-- Detect wetland not tagged with "natural=wetland".
-- Other combinations include
-- natural=water, natural=scrub, landuse=meadow, leisure=nature_reserve,
-- leisure=park, and no natural, landuse or leisure tags.
-- In many cases we don't set natural=wetland, but in some we do.
-- ----------------------------------------------------------------------------
   if ((  passedt.wetland == "wet_meadow"  ) and
       (( passedt.natural == nil          )  or
        ( passedt.natural == ""           )  or
        ( passedt.natural == "grassland"  )) and
       (( passedt.leisure == nil          )  or
        ( passedt.leisure == ""           ))  and
       (( passedt.landuse == nil          )  or
        ( passedt.landuse == ""           )  or
        ( passedt.landuse == "meadow"     ))) then
      passedt.natural = "wetland"
   end

-- ----------------------------------------------------------------------------
-- Detect wetland also tagged with "surface" tags.
-- The wetland types that we're interested in below are:
-- (nil), tidalflat, mud, wet_meadow, saltmarsh, reedbed
-- Of these, for (nil) and tidalflat, the surface should take precedence.
-- For others, we fall through to 'if "natural" is still "wetland"' nelow, and
-- if "wetland" doesn't match one of those, it'll go through as 
-- "generic wetland", which is an overlay for whatever's underneath.
-- ----------------------------------------------------------------------------
   if ((  passedt.natural == "wetland"    ) and
       (( passedt.wetland == nil         ) or
        ( passedt.wetland == ""          ) or
        ( passedt.wetland == "tidalflat" ))) then
      if (( passedt.surface == "mud"       ) or
          ( passedt.surface == "mud, sand" )) then
         passedt.natural = "mud"
      end

      if (( passedt.surface == "sand"      ) or
          ( passedt.surface == "sand, mud" ) or
          ( passedt.surface == "dirt/sand" )) then
         passedt.natural = "sand"
      end

      if (( passedt.surface == "shingle"     ) or
          ( passedt.surface == "gravel"      ) or
          ( passedt.surface == "fine_gravel" ) or
          ( passedt.surface == "pebblestone" )) then
         passedt.natural = "shingle"
      end

      if (( passedt.surface == "rock"      ) or
          ( passedt.surface == "bare_rock" ) or
          ( passedt.surface == "concrete"  )) then
         passedt.natural = "bare_rock"
      end
   end

-- ----------------------------------------------------------------------------
-- Also, if "natural" is still "wetland", what "wetland" values should be 
-- handled as some other tag?
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "wetland" ) then
      if (( passedt.wetland == "tidalflat" ) or
          ( passedt.wetland == "mud"       )) then
         passedt.natural = "mud"
         passedt.tidal = "yes"
      end

      if ( passedt.wetland == "wet_meadow" ) then
         passedt.landuse = "wetmeadow"
         passedt.natural = nil
      end

      if ( passedt.wetland == "saltmarsh" ) then
         passedt.landuse = "saltmarsh"
         passedt.natural = nil
      end

      if ( passedt.wetland == "reedbed" ) then
         passedt.landuse = "reedbed"
         passedt.natural = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Render tidal mud with more blue
-- ----------------------------------------------------------------------------
   if ((  passedt.natural   == "mud"        ) and
       (( passedt.tidal     == "yes"       ) or
        ( passedt.wetland   == "tidalflat" ))) then
      passedt.natural = "tidal_mud"
   end

-- ----------------------------------------------------------------------------
-- Handle various sorts of milestones.
-- ----------------------------------------------------------------------------
   if (( passedt.highway  == "milestone" )  or
       ( passedt.historic == "milestone" )  or
       ( passedt.historic == "milepost"  )  or
       ( passedt.waterway == "milestone" )  or
       ( passedt.railway  == "milestone" )  or
       ( passedt.man_made == "mile_post" )) then
      passedt.highway = "milestone"

      append_inscription( passedt )
      append_directions( passedt )
   end

-- ----------------------------------------------------------------------------
-- Aerial markers for pipelines etc.
-- ----------------------------------------------------------------------------
   if (( passedt.marker   == "aerial"          ) or
       ( passedt.marker   == "pipeline"        ) or
       ( passedt.marker   == "post"            ) or
       ( passedt.man_made == "pipeline_marker" ) or
       ( passedt.man_made == "marker"          ) or
       ( passedt.pipeline == "marker"          )) then
      passedt.man_made = "markeraerial"
   end

-- ----------------------------------------------------------------------------
-- Boundary stones.  If they're already tagged as tourism=attraction, remove
-- that tag.
-- Note that "marker=stone" (for "non boundary stones") are handled elsewhere.
-- For March Stones see https://en.wikipedia.org/wiki/March_Stones_of_Aberdeen
-- ----------------------------------------------------------------------------
   if (( passedt.historic    == "boundary_stone"  )  or
       ( passedt.historic    == "boundary_marker" )  or
       ( passedt.man_made    == "boundary_marker" )  or
       ( passedt.marker      == "boundary_stone"  )  or
       ( passedt.boundary    == "marker"          )  or
       ( passedt.designation == "March Stone"     )) then
      passedt.man_made = "boundary_stone"
      passedt.tourism  = nil

      append_inscription( passedt )
   end

-- ----------------------------------------------------------------------------
-- Things that are both localities and peaks or hills 
-- should render as the latter.
-- Also, some other combinations (most amenities, some man_made, etc.)
-- Note that "hill" is handled by the rendering code as similar to "peak" but
-- only at higher zooms.  See 19/03/2023 in changelog.html .
-- ----------------------------------------------------------------------------
   if ((  passedt.place    == "locality"      ) and
       (( passedt.natural  == "peak"         )  or
        ( passedt.natural  == "hill"         )  or
        ( passedt.amenity  ~= nil            )  or
        ( passedt.man_made ~= nil            )  or
        ( passedt.historic ~= nil            ))) then
      passedt.place = nil
   end

-- ----------------------------------------------------------------------------
-- Things that are both viewpoints or attractions and monuments or memorials 
-- should render as the latter.  Some are handled further down too.
-- Also handle some other combinations.
-- ----------------------------------------------------------------------------
   if ((( passedt.tourism   == "viewpoint"                 )  or
        ( passedt.tourism   == "attraction"                )) and
       (( passedt.historic  == "abbey"                     )  or
        ( passedt.historic  == "aircraft"                  )  or
        ( passedt.historic  == "almshouse"                 )  or
        ( passedt.historic  == "anchor"                    )  or
        ( passedt.historic  == "archaeological_site"       )  or
        ( passedt.historic  == "bakery"                    )  or
        ( passedt.historic  == "barrow"                    )  or
        ( passedt.historic  == "baths"                     )  or
        ( passedt.historic  == "battlefield"               )  or
        ( passedt.historic  == "battery"                   )  or
        ( passedt.historic  == "bullaun_stone"             )  or
        ( passedt.historic  == "boundary_stone"            )  or
        ( passedt.historic  == "building"                  )  or
        ( passedt.historic  == "bridge_site"               )  or
        ( passedt.historic  == "bunker"                    )  or
        ( passedt.historic  == "camp"                      )  or
        ( passedt.historic  == "cannon"                    )  or
        ( passedt.historic  == "castle"                    )  or
        ( passedt.historic  == "chapel"                    )  or
        ( passedt.historic  == "church"                    )  or
        ( passedt.historic  == "city_gate"                 )  or
        ( passedt.historic  == "citywalls"                 )  or
        ( passedt.historic  == "chlochan"                  )  or
        ( passedt.historic  == "cross"                     )  or
        ( passedt.historic  == "deserted_medieval_village" )  or
        ( passedt.historic  == "drinking_fountain"         )  or
        ( passedt.historic  == "folly"                     )  or
        ( passedt.historic  == "fort"                      )  or
        ( passedt.historic  == "fortification"             )  or
        ( passedt.historic  == "gate"                      )  or
        ( passedt.historic  == "grinding_mill"             )  or
        ( passedt.historic  == "hall"                      )  or
        ( passedt.historic  == "high_cross"                )  or
        ( passedt.historic  == "house"                     )  or
        ( passedt.historic  == "ice_house"                 )  or
        ( passedt.historic  == "jail"                      )  or
        ( passedt.historic  == "locomotive"                )  or
        ( passedt.historic  == "locomotive"                )  or
        ( passedt.historic  == "martello_tower"            )  or
        ( passedt.historic  == "martello_tower;bunker"     )  or
        ( passedt.historic  == "maypole"                   )  or
        ( passedt.historic  == "memorial"                  )  or
        ( passedt.historic  == "mill"                      )  or
        ( passedt.historic  == "millstone"                 )  or
        ( passedt.historic  == "mine"                      )  or
        ( passedt.historic  == "monastery"                 )  or
        ( passedt.historic  == "monastic_grange"           )  or
        ( passedt.historic  == "monument"                  )  or
        ( passedt.historic  == "mound"                     )  or
	( passedt.historic  == "naval_mine"                )  or
        ( passedt.historic  == "oratory"                   )  or
        ( passedt.historic  == "pillory"                   )  or
        ( passedt.historic  == "place_of_worship"          )  or
        ( passedt.historic  == "police_call_box"           )  or
        ( passedt.historic  == "prison"                    )  or
        ( passedt.historic  == "residence"                 )  or
        ( passedt.historic  == "roundhouse"                )  or
        ( passedt.historic  == "ruins"                     )  or
        ( passedt.historic  == "sawmill"                   )  or
        ( passedt.historic  == "shelter"                   )  or
        ( passedt.historic  == "ship"                      )  or
        ( passedt.historic  == "smithy"                    )  or
        ( passedt.historic  == "sound_mirror"              )  or
        ( passedt.historic  == "standing_stone"            )  or
        ( passedt.historic  == "statue"                    )  or
        ( passedt.historic  == "stocks"                    )  or
        ( passedt.historic  == "stone"                     )  or
        ( passedt.historic  == "tank"                      )  or
        ( passedt.historic  == "theatre"                   )  or
        ( passedt.historic  == "tomb"                      )  or
        ( passedt.historic  == "tower"                     )  or
        ( passedt.historic  == "tower_house"               )  or
        ( passedt.historic  == "tumulus"                   )  or
        ( passedt.historic  == "village"                   )  or
        ( passedt.historic  == "village_pump"              )  or
        ( passedt.historic  == "water_pump"                )  or
        ( passedt.historic  == "wayside_cross"             )  or
        ( passedt.historic  == "wayside_shrine"            )  or
        ( passedt.historic  == "well"                      )  or
        ( passedt.historic  == "watermill"                 )  or
        ( passedt.historic  == "windmill"                  )  or
        ( passedt.historic  == "workhouse"                 )  or
        ( passedt.historic  == "wreck"                     )  or
        ( passedt.historic  == "yes"                       )  or
        ( passedt.natural   == "beach"                     )  or
        ( passedt.natural   == "cave_entrance"             )  or
        ( passedt.natural   == "cliff"                     )  or
        ( passedt.natural   == "grassland"                 )  or
        ( passedt.natural   == "heath"                     )  or
        ( passedt.natural   == "sand"                      )  or
        ( passedt.natural   == "scrub"                     )  or
        ( passedt.natural   == "spring"                    )  or
        ( passedt.natural   == "tree"                      )  or
        ( passedt.natural   == "water"                     )  or
        ( passedt.natural   == "wood"                      )  or
        ( passedt.leisure   == "garden"                    )  or
        ( passedt.leisure   == "nature_reserve"            )  or
        ( passedt.leisure   == "park"                      )  or
        ( passedt.leisure   == "sports_centre"             ))) then
      passedt.tourism = nil
   end

   if ((   passedt.tourism == "attraction"   ) and
       ((( passedt.shop    ~= nil          )   and
         ( passedt.shop    ~= ""           ))  or
        (( passedt.amenity ~= nil          )   and
         ( passedt.amenity ~= ""           ))  or
        (  passedt.leisure == "park"       ))) then
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- There's a bit of "tagging for the renderer" going on with some large museums
-- ----------------------------------------------------------------------------
   if ((  passedt.tourism == "museum"          ) and 
       (( passedt.leisure == "garden"         )  or
        ( passedt.leisure == "nature_reserve" )  or
        ( passedt.leisure == "park"           ))) then
      passedt.leisure = nil
   end

-- ----------------------------------------------------------------------------
-- Boatyards
-- ----------------------------------------------------------------------------
   if (( passedt.waterway   == "boatyard" ) or
       ( passedt.industrial == "boatyard" )) then
      passedt.amenity = "boatyard"
      passedt.waterway = nil
      passedt.industrial = nil
   end

-- ----------------------------------------------------------------------------
-- Beer gardens etc.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "beer_garden" ) or
       ( passedt.leisure == "beer_garden" )) then
      passedt.amenity = nil
      passedt.leisure = "garden"
      passedt.garden = "beer_garden"
   end

-- ----------------------------------------------------------------------------
-- Render biergartens as gardens, which is all they likely are.
-- Remove the symbol from unnamed ones - they're likely just pub beer gardens.
-- ----------------------------------------------------------------------------
   if (  passedt.amenity == "biergarten" ) then
      if (( passedt.name == nil           )   or
          ( passedt.name == "Beer Garden" )) then
         passedt.amenity = nil
      end

      passedt.leisure = "garden"
      passedt.garden  = "beer_garden"
   end

-- ----------------------------------------------------------------------------
-- Treat natural=meadow as a synonym for landuse=meadow, if no other landuse
-- ----------------------------------------------------------------------------
   if (( passedt.natural == "meadow" ) and
       ( passedt.landuse == nil      )) then
      passedt.landuse = "meadow"
   end

-- ----------------------------------------------------------------------------
-- highway=services is translated to commercial landuse - any overlaid parking
-- can then be seen.
--
-- highway=rest_area is translated lower down to amenity=parking.
-- ----------------------------------------------------------------------------
   if (  passedt.highway == "services" ) then
      passedt.highway = nil
      passedt.landuse = "commercial"
   end

-- ----------------------------------------------------------------------------
-- Things without icons - add "commercial" landuse to include a name 
-- (if one exists) too.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse      == "churchyard"               ) or
       ( passedt.landuse      == "religious"                ) or
       ( passedt.leisure      == "racetrack"                ) or
       ( passedt.landuse      == "aquaculture"              ) or
       ( passedt.landuse      == "fishfarm"                 ) or
       ( passedt.industrial   == "fish_farm"                ) or
       ( passedt.seamarkCtype == "marine_farm"              )) then
      passedt.landuse = "commercial"
   end

-- ----------------------------------------------------------------------------
-- Shop groups - just treat as retail landuse.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "mall"            ) or
       ( passedt.amenity == "marketplace"     ) or
       ( passedt.shop    == "market"          ) or
       ( passedt.amenity == "market"          ) or
       ( passedt.amenity == "food_court"      ) or
       ( passedt.shop    == "shopping_centre" )) then
      passedt.landuse = "retail"
   end

-- ----------------------------------------------------------------------------
-- Scout camps etc.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity   == "scout_camp"     ) or
       ( passedt.landuse   == "scout_camp"     ) or	
       ( passedt.leisure   == "fishing"        ) or
       ( passedt.leisure   == "outdoor_centre" )) then
      passedt.leisure = "park"
   end

-- ----------------------------------------------------------------------------
-- Some people tag beach resorts as beaches - remove "beach_resort" there.
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "beach_resort" ) and
       ( passedt.natural == "beach"        )) then
      passedt.leisure = nil
   end

-- ----------------------------------------------------------------------------
-- Remove tourism=attraction from rock features that are rendered as rock(s)
-- ----------------------------------------------------------------------------
   if ((  passedt.tourism   == "attraction"     ) and
       (( passedt.natural   == "bare_rock"     ) or
        ( passedt.natural   == "boulder"       ) or
        ( passedt.natural   == "rock"          ) or
        ( passedt.natural   == "rocks"         ) or
        ( passedt.natural   == "stone"         ) or
        ( passedt.natural   == "stones"        ) or
        ( passedt.climbing  == "boulder"       ))) then
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- There is at least one closed "natural=couloir" with "surface=scree".
-- ----------------------------------------------------------------------------
   if (( passedt.natural ~= nil     ) and
       ( passedt.surface == "scree" )) then
      passedt.natural = "scree"
   end

-- ----------------------------------------------------------------------------
-- Render tidal beaches with more blue
-- ----------------------------------------------------------------------------
   if ((  passedt.natural   == "beach"      ) and
       (( passedt.tidal     == "yes"       )  or
        ( passedt.wetland   == "tidalflat" ))) then
      passedt.natural = "tidal_beach"
   end

-- ----------------------------------------------------------------------------
-- Render tidal scree with more blue
-- ----------------------------------------------------------------------------
   if (( passedt.natural   == "scree" ) and
       ( passedt.tidal     == "yes"   )) then
      passedt.natural = "tidal_scree"
   end

-- ----------------------------------------------------------------------------
-- Render tidal shingle with more blue
-- ----------------------------------------------------------------------------
   if (( passedt.natural   == "shingle" ) and
       ( passedt.tidal     == "yes"     )) then
      passedt.natural = "tidal_shingle"
   end

-- ----------------------------------------------------------------------------
-- Change natural=rocks on non-nodes to natural=bare_rock
-- ----------------------------------------------------------------------------
   if (( passedt.natural   == "rocks"  ) or
       ( passedt.natural   == "stones" )) then
      passedt.natural = "bare_rock"
   end

-- ----------------------------------------------------------------------------
-- Render tidal rocks with more blue
-- ----------------------------------------------------------------------------
   if ((  passedt.natural   == "bare_rock"  ) and
       (( passedt.tidal     == "yes"       )  or
        ( passedt.wetland   == "tidalflat" ))) then
      passedt.natural = "tidal_rock"
   end

-- ----------------------------------------------------------------------------
-- landuse=field is rarely used.  I tried unsuccessfully to change the colour 
-- in the stylesheet so am mapping it here.
-- ----------------------------------------------------------------------------
   if (passedt.landuse   == "field") then
      passedt.landuse = "farmland"
   end

-- ----------------------------------------------------------------------------
-- Various tags for showgrounds
-- Other tags are suppressed to prevent them appearing ahead of "landuse"
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity    == "showground"       )  or
       (  passedt.leisure    == "showground"       )  or
       (  passedt.amenity    == "show_ground"      )  or
       (  passedt.amenity    == "show_grounds"     )  or
       (( passedt.tourism    == "attraction"      )   and
        ( passedt.attraction == "showground"      ))  or
       (  passedt.amenity    == "festival_grounds" )  or
       (  passedt.amenity    == "car_boot_sale"    )) then
      passedt.amenity = nil
      passedt.leisure = nil
      passedt.tourism = nil
      passedt.landuse = "meadow"
   end

-- ----------------------------------------------------------------------------
-- Some kinds of farmland and meadow should be changed to "landuse=farmgrass", 
-- which is rendered slightly greener than the normal farmland (and less green 
-- than landuse=meadow)
-- ----------------------------------------------------------------------------
   if ((  passedt.landuse  == "farmland"                    ) and
       (( passedt.farmland == "pasture"                    )  or
        ( passedt.farmland == "heath"                      )  or
        ( passedt.farmland == "paddock"                    )  or
        ( passedt.farmland == "meadow"                     )  or
        ( passedt.farmland == "pasture;heath"              )  or
        ( passedt.farmland == "turf_production"            )  or
        ( passedt.farmland == "grassland"                  )  or
        ( passedt.farmland == "wetland"                    )  or
        ( passedt.farmland == "marsh"                      )  or
        ( passedt.farmland == "turf"                       )  or
        ( passedt.farmland == "animal_keeping"             )  or
        ( passedt.farmland == "grass"                      )  or
        ( passedt.farmland == "crofts"                     )  or
        ( passedt.farmland == "scrub"                      )  or
        ( passedt.farmland == "pasture;wetland"            )  or
        ( passedt.farmland == "equestrian"                 )  or
        ( passedt.animal   == "cow"                        )  or
        ( passedt.animal   == "cattle"                     )  or
        ( passedt.animal   == "chicken"                    )  or
        ( passedt.animal   == "horse"                      )  or
        ( passedt.meadow   == "agricultural"               )  or
        ( passedt.meadow   == "paddock"                    )  or
        ( passedt.meadow   == "pasture"                    )  or
        ( passedt.produce  == "turf"                       )  or
        ( passedt.produce  == "grass"                      )  or
        ( passedt.produce  == "Silage"                     )  or
        ( passedt.produce  == "cow"                        )  or
        ( passedt.produce  == "cattle"                     )  or
        ( passedt.produce  == "milk"                       )  or
        ( passedt.produce  == "dairy"                      )  or
        ( passedt.produce  == "meat"                       )  or
        ( passedt.produce  == "horses"                     )  or
        ( passedt.produce  == "live_animal"                )  or
        ( passedt.produce  == "live_animal;cows"           )  or
        ( passedt.produce  == "live_animal;sheep"          )  or
        ( passedt.produce  == "live_animal;Cattle_&_Sheep" )  or
        ( passedt.produce  == "live_animals"               ))) then
      passedt.landuse = "farmgrass"
   end

   if ((  passedt.landuse  == "meadow"        ) and
       (( passedt.meadow   == "agricultural" )  or
        ( passedt.meadow   == "paddock"      )  or
        ( passedt.meadow   == "pasture"      )  or
        ( passedt.meadow   == "agriculture"  )  or
        ( passedt.meadow   == "hay"          )  or
        ( passedt.meadow   == "managed"      )  or
        ( passedt.meadow   == "cut"          )  or
        ( passedt.animal   == "pig"          )  or
        ( passedt.animal   == "sheep"        )  or
        ( passedt.animal   == "cow"          )  or
        ( passedt.animal   == "cattle"       )  or
        ( passedt.animal   == "chicken"      )  or
        ( passedt.animal   == "horse"        )  or
        ( passedt.farmland == "field"        )  or
        ( passedt.farmland == "pasture"      )  or
        ( passedt.farmland == "crofts"       ))) then
      passedt.landuse = "farmgrass"
   end

   if (( passedt.landuse == "paddock"        ) or
       ( passedt.landuse == "animal_keeping" )) then
      passedt.landuse = "farmgrass"
   end

-- ----------------------------------------------------------------------------
-- As well as agricultural meadows, we show a couple of other subtags of meadow
-- slightly differently.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse  == "meadow"       ) and
       ( passedt.meadow   == "transitional" )) then
      passedt.landuse = "meadowtransitional"
   end

   if (( passedt.landuse  == "meadow"       ) and
       ( passedt.meadow   == "wildflower" )) then
      passedt.landuse = "meadowwildflower"
   end

   if (( passedt.landuse  == "meadow"       ) and
       ( passedt.meadow   == "perpetual" )) then
      passedt.landuse = "meadowperpetual"
   end

-- ----------------------------------------------------------------------------
-- Change landuse=greenhouse_horticulture to farmyard.
-- ----------------------------------------------------------------------------
   if (passedt.landuse   == "greenhouse_horticulture") then
      passedt.landuse = "farmyard"
   end

-- ----------------------------------------------------------------------------
-- Attempt to do something sensible with trees
--
-- "boundary=forest" is the latest attempt to resolve the "landuse=forest is 
-- used for different things" issue.  Unfortunately, it can also be used with 
-- other landuse values.
--
-- There are a few 10s of natural=woodland and natural=forest; treat them the same
-- as other woodland.  If we have landuse=forest on its own without
-- leaf_type, then we don't change it - we'll handle that separately in the
-- mss file.
-- ----------------------------------------------------------------------------
  if ((  passedt.boundary == "forest"  ) and
      (( passedt.landuse  == nil      )  or
       ( passedt.landuse  == ""       ))) then
      passedt.landuse = "forest"
      passedt.boundary = nil
  end

  if ( passedt.landuse == "forestry" ) then
      passedt.landuse = "forest"
  end

  if ( passedt.natural == "woodland" ) then
      passedt.natural = "wood"
  end

-- ----------------------------------------------------------------------------
-- Use operator (but not brand) on various natural objects, always in brackets.
-- (compare with the similar check including "brand" for e.g. "atm" below)
-- This is done before we change tags based on leaf_type.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse == "forest" )  or
       ( passedt.natural == "wood"   )) then
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         if (( passedt.operator ~= nil ) and
             ( passedt.operator ~= ""  )) then
            passedt.name = "(" .. passedt.operator .. ")"
            passedt.operator = nil
         end
      else
         if (( passedt.operator ~= nil           )  and
             ( passedt.operator ~= ""            )  and
             ( passedt.operator ~= passedt.name  )) then
            passedt.name = passedt.name .. " (" .. passedt.operator .. ")"
            passedt.operator = nil
         end
      end
   end

  if (((  passedt.landuse   == "forest"     )  and
       (  passedt.leaf_type ~= nil          )  and
       (  passedt.leaf_type ~= ""           )) or
      (   passedt.natural   == "forest"      ) or
      (   passedt.landcover == "trees"       ) or
      ((  passedt.natural   == "tree_group" )  and
       (( passedt.landuse   == nil         )   or
        ( passedt.landuse   == ""          ))  and
       (( passedt.leisure   == nil         )   or
        ( passedt.leisure   == ""          )))) then
      passedt.landuse = nil
      passedt.natural = "wood"
   end

-- ----------------------------------------------------------------------------
-- The "landcover" layer considers a whole bunch of tags to incorporate into
-- one layer.  The way that this is done (derived from OSM Carto from some
-- years back) means that an unexpected and unrendered "landuse" tag might
-- prevent a valid "natural" one from being displayed.
-- Other combinations will also be affected, but have not been seen occurring
-- together.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse ~= nil    ) and
       ( passedt.landuse ~= ""     ) and
       ( passedt.natural == "wood" )) then
      passedt.landuse = nil
   end

   if (( passedt.leaf_type   == "broadleaved"  )  and
       ( passedt.natural     == "wood"         )) then
      passedt.landuse = nil
      passedt.natural = "broadleaved"
   end

   if (( passedt.leaf_type   == "needleleaved" )  and
       ( passedt.natural     == "wood"         )) then
      passedt.landuse = nil
      passedt.natural = "needleleaved"
   end

   if (( passedt.leaf_type   == "mixed"        )  and
       ( passedt.natural     == "wood"         )) then
      passedt.landuse = nil
      passedt.natural = "mixedleaved"
   end

-- ----------------------------------------------------------------------------
-- Render amenity=layby as parking.
-- highway=rest_area is used a lot in the UK for laybies, so map that over too.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "layby"     ) or
       ( passedt.highway == "rest_area" )) then
      passedt.amenity = "parking"
   end

-- ----------------------------------------------------------------------------
-- Lose any "access=permissive" on parking; it should not be greyed out as it
-- is "somewhere we can park".
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "parking"    ) and
       ( passedt.access  == "permissive" )) then
      passedt.access = nil
   end

-- ----------------------------------------------------------------------------
-- Scooter rental
-- All legal scooter rental / scooter parking in UK are private; these are the
-- the tags currently used.
-- "network" is a bit of a special case because normally it means "lwn" etc.
-- ----------------------------------------------------------------------------
   if ((   passedt.amenity                == "escooter_rental"         ) or
       (   passedt.amenity                == "scooter_parking"         ) or
       (   passedt.amenity                == "kick-scooter_rental"     ) or
       (   passedt.amenity                == "small_electric_vehicle"  ) or
       ((  passedt.amenity                == "parking"                )  and
        (( passedt.parking                == "e-scooter"             )   or
         ( passedt.small_electric_vehicle == "designated"            ))) or
       ((  passedt.amenity                == "bicycle_parking"        )  and
        (  passedt.small_electric_vehicle == "designated"             ))) then
      passedt.amenity = "scooter_rental"
      passedt.access = nil

      if ((( passedt.name     == nil )  or
           ( passedt.name     == ""  )) and
          (( passedt.operator == nil )  or
           ( passedt.operator == ""  )) and
          (  passedt.network  ~= nil  ) and
          (  passedt.network  ~= ""   )) then
         passedt.name = passedt.network
         passedt.network = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Render for-pay parking areas differently.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "parking"  ) and
       (( passedt.fee     ~= nil       )  and
        ( passedt.fee     ~= ""        )  and
        ( passedt.fee     ~= "no"      )  and
        ( passedt.fee     ~= "0"       ))) then
      passedt.amenity = "parking_pay"
   end

-- ----------------------------------------------------------------------------
-- Render for-pay bicycle_parking areas differently.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "bicycle_parking"  ) and
       (( passedt.fee     ~= nil               )  and
        ( passedt.fee     ~= ""                )  and
        ( passedt.fee     ~= "no"              )  and
        ( passedt.fee     ~= "0"               ))) then
      passedt.amenity = "bicycle_parking_pay"
   end

-- ----------------------------------------------------------------------------
-- Render for-pay motorcycle_parking areas differently.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "motorcycle_parking"  ) and
       (( passedt.fee     ~= nil               )  and
        ( passedt.fee     ~= ""                )  and
        ( passedt.fee     ~= "no"              )  and
        ( passedt.fee     ~= "0"               ))) then
      passedt.amenity = "motorcycle_parking_pay"
   end

-- ----------------------------------------------------------------------------
-- Render for-pay toilets differently.
-- Also use different icons for male and female, if these are separate.
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "toilets" ) then
      if (( passedt.fee     ~= nil       )  and
          ( passedt.fee     ~= ""        )  and
          ( passedt.fee     ~= "no"      )  and
          ( passedt.fee     ~= "0"       )) then
         if (( passedt.male   == "yes" ) and
             ( passedt.female ~= "yes" )) then
            passedt.amenity = "toilets_pay_m"
         else
            if (( passedt.female == "yes"       ) and
                ( passedt.male   ~= "yes"       )) then
               passedt.amenity = "toilets_pay_w"
            else
               passedt.amenity = "toilets_pay"
            end
         end
      else
         if (( passedt.male   == "yes" ) and
             ( passedt.female ~= "yes" )) then
            passedt.amenity = "toilets_free_m"
         else
            if (( passedt.female == "yes"       ) and
                ( passedt.male   ~= "yes"       )) then
               passedt.amenity = "toilets_free_w"
            end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Render for-pay shower differently.
-- Also use different icons for male and female, if these are separate.
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "shower" ) then
      if (( passedt.fee     ~= nil       )  and
          ( passedt.fee     ~= ""        )  and
          ( passedt.fee     ~= "no"      )  and
          ( passedt.fee     ~= "0"       )) then
         if (( passedt.male   == "yes" ) and
             ( passedt.female ~= "yes" )) then
            passedt.amenity = "shower_pay_m"
         else
            if (( passedt.female == "yes"       ) and
                ( passedt.male   ~= "yes"       )) then
               passedt.amenity = "shower_pay_w"
            else
               passedt.amenity = "shower_pay"
            end
         end
      else
         if (( passedt.male   == "yes" ) and
             ( passedt.female ~= "yes" )) then
            passedt.amenity = "shower_free_m"
         else
            if (( passedt.female == "yes"       ) and
                ( passedt.male   ~= "yes"       )) then
               passedt.amenity = "shower_free_w"
            end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Render parking spaces as parking.  Most in the UK are not part of larger
-- parking areas, and most do not have an access tag, but many should have.
--
-- This does not work where e.g. Supermarket car parks have been mapped:
-- https://github.com/SomeoneElseOSM/SomeoneElse-style/issues/14
--
-- Also map emergency bays (used in place of hard shoulders) in the same way.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "parking_space" ) or
       ( passedt.highway == "emergency_bay" )) then
       if (( passedt.fee     ~= nil       )  and
           ( passedt.fee     ~= ""        )  and
           ( passedt.fee     ~= "no"      )  and
           ( passedt.fee     ~= "0"       )) then
         if ( passedt.parking_space == "disabled" ) then
            passedt.amenity = "parking_paydisabled"
         else
            passedt.amenity = "parking_pay"
         end
      else
         if ( passedt.parking_space == "disabled" ) then
            passedt.amenity = "parking_freedisabled"
         else
            passedt.amenity = "parking"
         end
      end

      if (( passedt.access == nil  ) or
          ( passedt.access == ""   )) then
         passedt.access = "no"
      end
   end

-- ----------------------------------------------------------------------------
-- Render amenity=leisure_centre and leisure=leisure_centre 
-- as leisure=sports_centre
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "leisure_centre" ) or
       ( passedt.leisure == "leisure_centre" )) then
      passedt.leisure = "sports_centre"
   end

-- ----------------------------------------------------------------------------
-- Sand dunes
-- ----------------------------------------------------------------------------
   if (( passedt.natural == "dune"       ) or
       ( passedt.natural == "dunes"      ) or
       ( passedt.natural == "sand_dunes" )) then
      passedt.natural = "sand"
   end

-- ----------------------------------------------------------------------------
-- Render tidal sand with more blue
-- ----------------------------------------------------------------------------
   if ((  passedt.natural   == "sand"       ) and
       (( passedt.tidal     == "yes"       )  or
        ( passedt.wetland   == "tidalflat" ))) then
      passedt.natural = "tidal_sand"
   end

-- ----------------------------------------------------------------------------
-- Golf (and sandpits)
-- ----------------------------------------------------------------------------
   if ((( passedt.golf       == "bunker"  )  or
        ( passedt.playground == "sandpit" )) and
       (( passedt.natural     == nil      )  or
        ( passedt.natural     == ""       ))) then
      passedt.natural = "sand"
   end

   if ( passedt.golf == "tee" ) then
      passedt.leisure = "garden"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = passedt.ref
      end
   end

   if ( passedt.golf == "green" ) then
      passedt.leisure = "golfgreen"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = passedt.ref
      end
   end

   if ( passedt.golf == "fairway" ) then
      passedt.leisure = "garden"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = passedt.ref
      end
   end

   if ( passedt.golf == "pin" ) then
      passedt.leisure = "leisurenonspecific"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = passedt.ref
      end
   end

   if ((  passedt.golf    == "rough" ) and
       (( passedt.natural == nil    )  or
        ( passedt.natural == ""     ))) then
      passedt.natural = "scrub"
   end

   if ((  passedt.golf    == "driving_range"  ) and
       (( passedt.leisure == nil             )  or
        ( passedt.leisure == ""              ))) then
      passedt.leisure = "pitch"
   end

   if ((  passedt.golf    == "path"  ) and
       (( passedt.highway == nil    )  or
        ( passedt.highway == ""     ))) then
      passedt.highway = "pathnarrow"
   end

   if ((  passedt.golf    == "practice"  ) and
       (( passedt.leisure == nil        )  or
        ( passedt.leisure == ""         ))) then
      passedt.leisure = "garden"
   end

-- ----------------------------------------------------------------------------
-- Playground stuff
--
-- The "leisure=nil" check here is because there are some unusual combinations
-- of "playground" tags on otherwise-rendered "leisure" things.
--
-- "landuse=playground" is a rare synonym of "leisure=playground".
-- "leisure=playground".is handled in the rendering code.
-- ----------------------------------------------------------------------------
   if ((  passedt.landuse == "playground"  ) and
       (( passedt.leisure == nil          )  or
        ( passedt.leisure == ""           ))) then
      passedt.leisure = "playground"
   end

   if (((  passedt.leisure    == nil           )   or
        (  passedt.leisure    == ""            ))  and
       ((  passedt.playground == "swing"       )   or
        (  passedt.playground == "basketswing" ))) then
      passedt.amenity = "playground_swing"
   end

   if ((( passedt.leisure    == nil         )   or
        ( passedt.leisure    == ""          ))  and
       (  passedt.playground == "structure"  )) then
      passedt.amenity = "playground_structure"
   end

   if ((( passedt.leisure    == nil             )   or
        ( passedt.leisure    == ""              ))  and
       (  passedt.playground == "climbingframe"  )) then
      passedt.amenity = "playground_climbingframe"
   end

   if ((( passedt.leisure    == nil     )   or
        ( passedt.leisure    == ""      ))  and
       (  passedt.playground == "slide"  )) then
      passedt.amenity = "playground_slide"
   end

   if ((( passedt.leisure    == nil       )   or
        ( passedt.leisure    == ""        ))  and
       (  passedt.playground == "springy"  )) then
      passedt.amenity = "playground_springy"
   end

   if ((( passedt.leisure    == nil       )   or
        ( passedt.leisure    == ""        ))  and
       (  passedt.playground == "zipwire"  )) then
      passedt.amenity = "playground_zipwire"
   end

   if ((( passedt.leisure    == nil      )   or
        ( passedt.leisure    == ""       ))  and
       (  passedt.playground == "seesaw"  )) then
      passedt.amenity = "playground_seesaw"
   end

   if ((( passedt.leisure    == nil          )   or
        ( passedt.leisure    == ""           ))  and
       (  passedt.playground == "roundabout"  )) then
      passedt.amenity = "playground_roundabout"
   end

-- ----------------------------------------------------------------------------
-- Various leisure=pitch icons
-- Note that these are also listed at the end in 
-- "Shops etc. with icons already".
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "pitch"        )  and
       ( passedt.sport   == "table_tennis" )) then
      passedt.amenity = "pitch_tabletennis"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                      )  and
       (( passedt.sport   == "association_football"      )   or
        ( passedt.sport   == "football"                  )   or
        ( passedt.sport   == "multi;soccer;basketball"   )   or
        ( passedt.sport   == "football;basketball"       )   or
        ( passedt.sport   == "football;rugby"            )   or
        ( passedt.sport   == "football;soccer"           )   or
        ( passedt.sport   == "soccer"                    )   or
        ( passedt.sport   == "soccer;archery"            )   or
        ( passedt.sport   == "soccer;athletics"          )   or
        ( passedt.sport   == "soccer;basketball"         )   or
        ( passedt.sport   == "soccer;cricket"            )   or
        ( passedt.sport   == "soccer;field_hockey"       )   or
        ( passedt.sport   == "soccer;football"           )   or
        ( passedt.sport   == "soccer;gaelic_games"       )   or
        ( passedt.sport   == "soccer;gaelic_games;rugby" )   or
        ( passedt.sport   == "soccer;hockey"             )   or
        ( passedt.sport   == "soccer;multi"              )   or
        ( passedt.sport   == "soccer;rugby"              )   or
        ( passedt.sport   == "soccer;rugby_union"        )   or
        ( passedt.sport   == "soccer;tennis"             ))) then
      passedt.amenity = "pitch_soccer"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch"                    )  and
       (( passedt.sport  == "basketball"              )   or
        ( passedt.sport  == "basketball;soccer"       )   or
        ( passedt.sport  == "basketball;football"     )   or
        ( passedt.sport  == "basketball;multi"        )   or
        ( passedt.sport  == "basketball;netball"      )   or
        ( passedt.sport  == "basketball;tennis"       )   or
        ( passedt.sport  == "multi;basketball"        )   or
        ( passedt.sport  == "multi;basketball;soccer" ))) then
      passedt.amenity = "pitch_basketball"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                )  and
       (( passedt.sport   == "cricket"             )   or
        ( passedt.sport   == "cricket_rugby_union" )   or
        ( passedt.sport   == "cricket;soccer"      )   or
        ( passedt.sport   == "cricket_nets"        )   or
        ( passedt.sport   == "cricket_nets;multi"  ))) then
      passedt.amenity = "pitch_cricket"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch"           )  and
       (( passedt.sport  == "skateboard"     )   or
        ( passedt.sport  == "skateboard;bmx" ))) then
      passedt.amenity = "pitch_skateboard"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                )  and
       (( passedt.sport   == "climbing"            )   or
        ( passedt.sport   == "climbing;bouldering" ))) then
      passedt.amenity = "pitch_climbing"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                )  and
       (( passedt.sport   == "rugby"               )   or
        ( passedt.sport   == "rugby;cricket"       )   or
        ( passedt.sport   == "rugby;football"      )   or
        ( passedt.sport   == "rugby;rubgy_union"   )   or
        ( passedt.sport   == "rugby;soccer"        )   or
        ( passedt.sport   == "rugby_league"        )   or
        ( passedt.sport   == "rugby_union"         )   or
        ( passedt.sport   == "rugby_union;cricket" )   or
        ( passedt.sport   == "rugby_union;soccer"  ))) then
      passedt.amenity = "pitch_rugby"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "chess" )) then
      passedt.amenity = "pitch_chess"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"              )  and
       (( passedt.sport   == "tennis"            )   or
        ( passedt.sport   == "tennis;basketball" )   or
        ( passedt.sport   == "tennis;bowls"      )   or
        ( passedt.sport   == "tennis;hockey"     )   or
        ( passedt.sport   == "tennis;multi"      )   or
        ( passedt.sport   == "tennis;netball"    )   or
        ( passedt.sport   == "tennis;soccer"     )   or
        ( passedt.sport   == "tennis;squash"     ))) then
      passedt.amenity = "pitch_tennis"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"             )  and
       (( passedt.sport   == "athletics"        )   or
        ( passedt.sport   == "athletics;soccer" )   or
        ( passedt.sport   == "long_jump"        )   or
        ( passedt.sport   == "running"          )   or
        ( passedt.sport   == "shot-put"         ))) then
      passedt.amenity = "pitch_athletics"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "boules" )) then
      passedt.amenity = "pitch_boules"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"         )  and
       (( passedt.sport   == "bowls"        )   or
        ( passedt.sport   == "bowls;tennis" ))) then
      passedt.amenity = "pitch_bowls"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "croquet" )) then
      passedt.amenity = "pitch_croquet"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"         )  and
       (( passedt.sport   == "cycling"      )   or
        ( passedt.sport   == "bmx"          )   or
        ( passedt.sport   == "cycling;bmx"  )   or
        ( passedt.sport   == "bmx;mtb"      )   or
        ( passedt.sport   == "bmx;cycling"  )   or
        ( passedt.sport   == "mtb"          ))) then
      passedt.amenity = "pitch_cycling"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "equestrian" )) then
      passedt.amenity = "pitch_equestrian"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                  )  and
       (( passedt.sport   == "gaelic_games"          )   or
        ( passedt.sport   == "gaelic_games;handball" )   or
        ( passedt.sport   == "gaelic_games;soccer"   )   or
        ( passedt.sport   == "shinty"                ))) then
      passedt.amenity = "pitch_gaa"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                  )  and
       (( passedt.sport   == "field_hockey"          )   or
        ( passedt.sport   == "field_hockey;soccer"   )   or
        ( passedt.sport   == "hockey"                )   or
        ( passedt.sport   == "hockey;soccer"         ))) then
      passedt.amenity = "pitch_hockey"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "multi" )) then
      passedt.amenity = "pitch_multi"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "netball" )) then
      passedt.amenity = "pitch_netball"
      passedt.leisure = "unnamedpitch"
   end

   if (( passedt.leisure == "pitch" )  and
       ( passedt.sport   == "polo" )) then
      passedt.amenity = "pitch_polo"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"           )  and
       (( passedt.sport   == "shooting"       ) or
        ( passedt.sport   == "shooting_range" ))) then
      passedt.amenity = "pitch_shooting"
      passedt.leisure = "unnamedpitch"
   end

   if ((  passedt.leisure == "pitch"                                             )  and
       (( passedt.sport   == "baseball"                                         ) or
        ( passedt.sport   == "baseball;soccer"                                  ) or
        ( passedt.sport   == "baseball;softball"                                ) or
        ( passedt.sport   == "baseball;cricket"                                 ) or
        ( passedt.sport   == "multi;baseball"                                   ) or
        ( passedt.sport   == "baseball;lacrosse;multi"                          ) or
        ( passedt.sport   == "baseball;american_football;ice_hockey;basketball" ))) then
      passedt.amenity = "pitch_baseball"
      passedt.leisure = "unnamedpitch"
   end

-- ----------------------------------------------------------------------------
-- Apparently there are a few "waterway=brook" in the UK.  Render as stream.
-- Likewise "tidal_channel" as stream and "drainage_channel" as ditch.
-- ----------------------------------------------------------------------------
   if (( passedt.waterway == "brook"         ) or
       ( passedt.waterway == "flowline"      ) or
       ( passedt.waterway == "tidal_channel" )) then
      passedt.waterway = "stream"
   end

   if ( passedt.waterway == "drainage_channel" ) then
      passedt.waterway = "ditch"
   end

-- ----------------------------------------------------------------------------
-- Handle "natural=pond" as water.
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "pond" ) then
      passedt.natural = "water"
   end

-- ----------------------------------------------------------------------------
-- Handle "waterway=mill_pond" as water.
-- "dock" is displayed with a water fill.
-- ----------------------------------------------------------------------------
   if ( passedt.waterway == "mill_pond" ) then
      passedt.waterway = "dock"
   end

-- ----------------------------------------------------------------------------
-- Display intermittent rivers as "intriver"
-- ----------------------------------------------------------------------------
   if (( passedt.waterway     == "river"  )  and
       ( passedt.intermittent == "yes"    )) then
      passedt.waterway = "intriver"
   end

-- ----------------------------------------------------------------------------
-- Display intermittent stream as "intstream"
-- ----------------------------------------------------------------------------
   if (( passedt.waterway     == "stream"  )  and
       ( passedt.intermittent == "yes"     )) then
      passedt.waterway = "intstream"
   end

-- ----------------------------------------------------------------------------
-- Things that are both towers and monuments or memorials 
-- should render as the latter.
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made  == "tower"     ) and
       (( passedt.historic  == "memorial" )  or
        ( passedt.historic  == "monument" ))) then
      passedt.man_made = nil
   end

   if ((( passedt.tourism == "gallery"     )   or
        ( passedt.tourism == "museum"      ))  and
       (  passedt.amenity == "arts_centre"  )) then
      passedt.amenity = nil
   end

   if ((( passedt.tourism == "attraction"  )   or 
        ( passedt.tourism == "artwork"     )   or
        ( passedt.tourism == "yes"         ))  and
       (  passedt.amenity == "arts_centre"  )) then
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Mineshafts
-- First make sure that we treat historic ones also tagged as man_made 
-- as historic
-- ----------------------------------------------------------------------------
   if (((( passedt.disusedCman_made == "mine"       )  or
         ( passedt.disusedCman_made == "mineshaft"  )  or
         ( passedt.disusedCman_made == "mine_shaft" )) and
        (( passedt.man_made         == nil          )  or
         ( passedt.man_made         == ""           ))) or
       ((( passedt.man_made == "mine"               )  or
         ( passedt.man_made == "mineshaft"          )  or
         ( passedt.man_made == "mine_shaft"         )) and
        (( passedt.historic == "yes"                )  or
         ( passedt.historic == "mine"               )  or
         ( passedt.historic == "mineshaft"          )  or
         ( passedt.historic == "mine_shaft"         )  or
         ( passedt.historic == "mine_adit"          )  or
         ( passedt.historic == "mine_level"         )  or
         ( passedt.disused  == "yes"                )))) then
      passedt.historic = "mineshaft"
      passedt.man_made = nil
      passedt.disusedCman_made = nil
      passedt.tourism  = nil
   end

-- ----------------------------------------------------------------------------
-- Then other spellings of man_made=mineshaft
-- ----------------------------------------------------------------------------
   if (( passedt.man_made   == "mine"       )  or
       ( passedt.industrial == "mine"       )  or
       ( passedt.man_made   == "mine_shaft" )) then
      passedt.man_made = "mineshaft"
   end

-- ----------------------------------------------------------------------------
-- and the historic equivalents
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "mine_shaft"        ) or
       ( passedt.historic == "mine_adit"         ) or
       ( passedt.historic == "mine_level"        ) or
       ( passedt.historic == "mine"              )) then
      passedt.historic = "mineshaft"

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Before we assume that a "historic=fort" is some sort of castle (big walls,
-- moat, that sort of thing) check that it's not prehistoric or some sort of 
-- hill fort (banks and ditches, people running around painted blue).  If it 
-- is, set "historic=archaeological_site" so it gets picked up as one below.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic              == "fort"          ) and
       (( passedt.fortification_type    == "hill_fort"    )  or
        ( passedt.fortification_type    == "hillfort"     ))) then
      passedt.historic            = "archaeological_site"
      passedt.archaeological_site = "fortification"
      passedt.fortification_type  = "hill_fort"
   end

-- ----------------------------------------------------------------------------
-- Similarly, catch "historic" "ringfort"s
-- ----------------------------------------------------------------------------
   if ((( passedt.historic           == "fortification" )   and
        ( passedt.fortification_type == "ringfort"      ))  or
       (  passedt.historic           == "rath"           )) then
      passedt.historic            = "archaeological_site"
      passedt.archaeological_site = "fortification"
      passedt.fortification_type  = "ringfort"
   end

-- ----------------------------------------------------------------------------
-- Catch other archaeological fortifications.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic              == "fort"           ) and
       (( passedt.fortification_type    == "broch"         )  or
        ( passedt.historicCcivilization == "prehistoric"   )  or
        ( passedt.historicCcivilization == "iron_age"      )  or
        ( passedt.historicCcivilization == "ancient_roman" ))) then
      passedt.historic            = "archaeological_site"
      passedt.archaeological_site = "fortification"
   end

-- ----------------------------------------------------------------------------
-- First, remove non-castle castles that have been tagfiddled into the data.
-- Castles go through as "historic=castle"
-- Note that archaeological sites that are castles are handled elsewhere.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic    == "castle"       ) and
       (( passedt.castle_type == "stately"     )  or
        ( passedt.castle_type == "manor"       )  or
        ( passedt.castle_type == "palace"      )  or
        ( passedt.castle_type == "manor_house" ))) then
      passedt.historic = "manor"
   end

   if (( passedt.historic == "castle" ) or
       ( passedt.historic == "fort"   )) then
      passedt.historic = "castle"

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Manors go through as "historic=manor"
-- Note that archaeological sites that are manors are handled elsewhere.
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "manor"           ) or
       ( passedt.historic == "lodge"           ) or
       ( passedt.historic == "mansion"         ) or
       ( passedt.historic == "country_mansion" ) or
       ( passedt.historic == "stately_home"    ) or
       ( passedt.historic == "palace"          )) then
      passedt.historic = "manor"
      passedt.tourism = nil

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Martello Towers go through as "historic=martello_tower"
-- Some other structural tags that might otherwise get shown are removed.
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "martello_tower"        ) or
       ( passedt.historic == "martello_tower;bunker" ) or
       ( passedt.historic == "martello_tower;fort"   )) then
      passedt.historic = "martello_tower"
      passedt.fortification_type = nil
      passedt.man_made = nil
      passedt.towerCtype = nil

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Unless an active place of worship,
-- monasteries etc. go through as "historic=monastery"
-- "historic=ruins;ruins=monastery" are handled the same way.
-- ----------------------------------------------------------------------------
   if ((   passedt.historic == "abbey"            ) or
       (   passedt.historic == "cathedral"        ) or
       (   passedt.historic == "monastery"        ) or
       (   passedt.historic == "priory"           ) or
       ((  passedt.historic == "ruins"            )  and
        (( passedt.ruins == "abbey"              )  or
         ( passedt.ruins == "cathedral"          )  or
         ( passedt.ruins == "monastery"          )  or
         ( passedt.ruins == "priory"             )))) then
      if ( passedt.amenity == "place_of_worship" ) then
         passedt.historic = nil
      else
         passedt.historic = "monastery"

         if ((( passedt.landuse == nil )  or
              ( passedt.landuse == ""  )) and
             (( passedt.leisure == nil )  or
              ( passedt.leisure == ""  )) and
             (( passedt.natural == nil )  or
              ( passedt.natural == ""  ))) then
            passedt.landuse = "historic"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Non-historic crosses go through as "man_made=cross".  
-- See also memorial crosses below.
-- ----------------------------------------------------------------------------
   if (( passedt.man_made == "cross"         ) or
       ( passedt.man_made == "summit_cross"  ) or
       ( passedt.man_made == "wayside_cross" )) then
      passedt.man_made = "cross"
   end

-- ----------------------------------------------------------------------------
-- Various historic crosses go through as "historic=cross".  
-- See also memorial crosses below.
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "wayside_cross"    ) or
       ( passedt.historic == "high_cross"       ) or
       ( passedt.historic == "cross"            ) or
       ( passedt.historic == "market_cross"     ) or
       ( passedt.historic == "tau_cross"        ) or
       ( passedt.historic == "celtic_cross"     )) then
      passedt.historic = "cross"

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Historic churches go through as "historic=church", 
-- if they're not also an amenity or something else.
-- ----------------------------------------------------------------------------
   if ((( passedt.historic == "chapel"           )  or
        ( passedt.historic == "church"           )  or
        ( passedt.historic == "place_of_worship" )  or
        ( passedt.historic == "wayside_chapel"   )) and
       (  passedt.amenity  == nil                 ) and
       (  passedt.shop     == nil                 )) then
      passedt.historic = "church"
      passedt.building = "yes"
      passedt.tourism = nil

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Historic pinfolds go through as "historic=pinfold", 
-- Some have recently been added as "historic=pound".
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "pinfold" )  or
       ( passedt.amenity  == "pinfold" )  or
       ( passedt.historic == "pound"   )) then
      passedt.historic = "pinfold"

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- City gates go through as "historic=city_gate"
-- Note that historic=gate are generally much smaller and are not included here.
--
-- Also, there are individual icons for these:
-- "historic=battlefield", "historic=stocks" (also used for "pillory"), 
-- "historic=well", "historic=dovecote"
-- ----------------------------------------------------------------------------
   if ( passedt.historic == "pillory" ) then
      passedt.historic = "stocks"
   end

   if (( passedt.historic == "city_gate"   ) or
       ( passedt.historic == "battlefield" ) or
       ( passedt.historic == "stocks"      ) or
       ( passedt.historic == "well"        ) or
       ( passedt.historic == "dovecote"    )) then
      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- historic=grave_yard goes through as historic=nonspecific, with fill for 
-- amenity=grave_yard if no landuse fill already.
-- ----------------------------------------------------------------------------
   if (((  passedt.historic        == "grave_yard"  )  or
        (  passedt.historic        == "cemetery"    )  or
        (  passedt.disusedCamenity == "grave_yard"  )  or
        (( passedt.historic        == "ruins"      )   and
         ( passedt.ruins           == "grave_yard" ))) and
       (( passedt.amenity         == nil          )  or
        ( passedt.amenity         == ""           )) and
       (  passedt.landuse         ~= "cemetery"    )) then
      passedt.historic = "nonspecific"

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  ))) then
         passedt.landuse = "cemetery"
      end
   end

-- ----------------------------------------------------------------------------
-- Towers go through as various historic towers
-- We also send ruined towers through here.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "tower"        ) or
       (  passedt.historic == "round_tower"  ) or
       (( passedt.historic == "ruins"       )  and
        ( passedt.ruins    == "tower"       ))) then
      passedt.man_made = nil

      if ((  passedt.historic  == "round_tower"  ) or
          ( passedt.towerCtype == "round_tower"  ) or
          ( passedt.towerCtype == "shot_tower"   )) then
         passedt.historic = "historicroundtower"
      else
         if ( passedt.towerCtype == "defensive" ) then
            passedt.historic = "historicdefensivetower"
         else
            if (( passedt.towerCtype == "observation" ) or
                ( passedt.towerCtype == "watchtower"  )) then
               passedt.historic = "historicobservationtower"
            else
               if ( passedt.towerCtype == "bell_tower" ) then
                  passedt.historic = "historicchurchtower"
               else
                  passedt.historic = "historicsquaretower"
               end  -- bell_tower
            end  -- observation
         end  -- defensive
      end  -- round_tower

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Both kilns and lime kilns are shown with the same distinctive bottle kiln
-- shape.
-- ----------------------------------------------------------------------------
   if (( passedt.historic       == "lime_kiln" ) or
       ( passedt.ruinsCman_made == "kiln"      )) then
      passedt.historic       = "kiln"
      passedt.ruinsCman_made = nil
   end

-- ----------------------------------------------------------------------------
-- Show village_pump as water_pump
-- ----------------------------------------------------------------------------
   if ( passedt.historic  == "village_pump" ) then
      passedt.historic = "water_pump"
   end

-- ----------------------------------------------------------------------------
-- For aircraft without names, try and construct something
-- First use aircraft:model and/or ref.  If still no name, inscription.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "aircraft" )  and
       (( passedt.name     == nil        )  or
        ( passedt.name     == ""         ))) then
      if (( passedt.aircraftCmodel ~= nil ) and
          ( passedt.aircraftCmodel ~= ""  )) then
         passedt.name = passedt.aircraftCmodel
      end

      if (( passedt.ref ~= nil ) and
          ( passedt.ref ~= ""  )) then
         if (( passedt.name == nil ) or
             ( passedt.name == ""  )) then
            passedt.name = passedt.ref
         else
            passedt.name = passedt.name .. " " .. passedt.ref
         end
      end

      if ((( passedt.name        == nil )   or
           ( passedt.name        == ""  ))  and
          (  passedt.inscription ~= nil  )  and
          (  passedt.inscription ~= ""   )) then
         passedt.name = passedt.inscription
      end
   end

-- ----------------------------------------------------------------------------
-- Add a building tag to specific historic items that are likely buildings 
-- Note that "historic=mill" does not have a building tag added.
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "aircraft"           ) or
       ( passedt.historic == "ice_house"          ) or
       ( passedt.historic == "kiln"               ) or
       ( passedt.historic == "ship"               ) or
       ( passedt.historic == "tank"               ) or
       ( passedt.historic == "watermill"          ) or
       ( passedt.historic == "windmill"           )) then
      if ( passedt.ruins == "yes" ) then
         passedt.building = "roof"
      else
         passedt.building = "yes"
      end
   end

-- ----------------------------------------------------------------------------
-- Add a building tag to nonspecific historic items that are likely buildings 
-- so that buildings.mss can process it.  Some shouldn't assume buildings 
-- (e.g. "fort" below).  Some use "roof" (which I use for "nearly a building" 
-- elsewhere).  It's sent through as "nonspecific".
-- "stone" has a building tag added because some are mapped as closed ways.
-- "landuse" is cleared because it might have been set for some building types
--  above.
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "baths"              ) or
       ( passedt.historic == "building"           ) or
       ( passedt.historic == "chlochan"           ) or
       ( passedt.historic == "gate_house"         ) or
       ( passedt.historic == "heritage_building"  ) or
       ( passedt.historic == "house"              ) or
       ( passedt.historic == "locomotive"         ) or
       ( passedt.historic == "protected_building" ) or
       ( passedt.historic == "residence"          ) or
       ( passedt.historic == "roundhouse"         ) or
       ( passedt.historic == "smithy"             ) or
       ( passedt.historic == "sound_mirror"       ) or
       ( passedt.historic == "standing_stone"     ) or
       ( passedt.historic == "trough"             ) or
       ( passedt.historic == "vehicle"            )) then
      if ( passedt.ruins == "yes" ) then
         passedt.building = "roof"
      else
         passedt.building = "yes"
      end

      passedt.historic = "nonspecific"
      passedt.landuse  = nil
      passedt.tourism  = nil
   end

-- ----------------------------------------------------------------------------
-- historic=wreck is usually on nodes and has its own icon
-- ----------------------------------------------------------------------------
   if ( passedt.historic == "wreck" ) then
      passedt.building = "roof"
   end

   if ( passedt.historic == "aircraft_wreck" ) then
      passedt.building = "roof"
   end

-- ----------------------------------------------------------------------------
-- Ruined buildings do not have their own icon
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "ruins"    )  and
       (  passedt.ruins    == "building" )  and
       (( passedt.barrier  == nil        )  or
        ( passedt.barrier  == ""         ))) then
      passedt.building = "roof"
      passedt.historic = "nonspecific"
   end
   
   if ((  passedt.historic == "ruins"             ) and
       (( passedt.ruins    == "church"           )  or
        ( passedt.ruins    == "place_of_worship" )  or
        ( passedt.ruins    == "wayside_chapel"   )  or
        ( passedt.ruins    == "chapel"           )) and
       (( passedt.amenity  == nil                )  or
        ( passedt.amenity  == ""                 ))) then
      passedt.building = "roof"
      passedt.historic = "church"
   end

   if ((  passedt.historic == "ruins"           ) and
       (( passedt.ruins    == "castle"         )  or
        ( passedt.ruins    == "fort"           )  or
        ( passedt.ruins    == "donjon"         )) and
       (( passedt.amenity  == nil              )  or
        ( passedt.amenity  == ""               ))) then
      passedt.historic = "historicarchcastle"
   end

-- ----------------------------------------------------------------------------
-- "historic=industrial" has been used as a modifier for all sorts.  
-- We're not interested in most of these but do display a historic dot for 
-- some.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "industrial"  ) and
       (( passedt.building == nil          )  or
        ( passedt.building == ""           )) and
       (( passedt.man_made == nil          )  or
        ( passedt.man_made == ""           )) and
       (( passedt.waterway == nil          )  or
        ( passedt.waterway == ""           )) and
       ( passedt.name     ~= nil            ) and
       ( passedt.name     ~= ""             )) then
      passedt.historic = "nonspecific"
      passedt.tourism = nil

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- Some tumuli are tagged as tombs, so dig those out first.
-- They are then picked up below.
--
-- Tombs that remain go straight through unless we need to set landuse.
-- ----------------------------------------------------------------------------
   if ( passedt.historic == "tomb" ) then
      if ( passedt.tomb == "tumulus" ) then
         passedt.historic            = "archaeological_site"
         passedt.archaeological_site = "tumulus"
      else
         if ((( passedt.landuse == nil )  or
              ( passedt.landuse == ""  )) and
             (( passedt.leisure == nil )  or
              ( passedt.leisure == ""  )) and
             (( passedt.natural == nil )  or
              ( passedt.natural == ""  ))) then
            passedt.landuse = "historic"
         end
      end
   end
   
-- ----------------------------------------------------------------------------
-- The catch-all for most "sensible" historic values that are displayed with
-- a historic dot regardless of whether they have a name.
--
-- disused:landuse=cemetery goes through here rather than as 
-- historic=grave_yard above because the notes suggest that these are not 
-- visible as graveyards any more, so no graveyard fill.
-- ----------------------------------------------------------------------------   
   if ((   passedt.historic == "almshouse"                 ) or
       (   passedt.historic == "anchor"                    ) or
       (   passedt.historic == "bakery"                    ) or
       (   passedt.historic == "barrow"                    ) or
       (   passedt.historic == "battery"                   ) or
       (   passedt.historic == "bridge_site"               ) or
       (   passedt.historic == "camp"                      ) or
       (   passedt.historic == "deserted_medieval_village" ) or
       (   passedt.historic == "drinking_fountain"         ) or
       (   passedt.historic == "fortification"             ) or
       (   passedt.historic == "gate"                      ) or
       (   passedt.historic == "grinding_mill"             ) or
       (   passedt.historic == "hall"                      ) or
       (   passedt.historic == "jail"                      ) or
       (   passedt.historic == "millstone"                 ) or
       (   passedt.historic == "monastic_grange"           ) or
       (   passedt.historic == "mound"                     ) or
       (   passedt.historic == "naval_mine"                ) or
       (   passedt.historic == "oratory"                   ) or
       (   passedt.historic == "police_call_box"           ) or
       (   passedt.historic == "prison"                    ) or
       (   passedt.historic == "ruins"                     ) or
       (   passedt.historic == "sawmill"                   ) or
       (   passedt.historic == "shelter"                   ) or
       (   passedt.historic == "statue"                    ) or
       (   passedt.historic == "theatre"                   ) or
       (   passedt.historic == "toll_house"                ) or
       (   passedt.historic == "tower_house"               ) or
       (   passedt.historic == "village"                   ) or
       (   passedt.historic == "workhouse"                 ) or
       ((  passedt.disusedClanduse == "cemetery"          )  and
        (( passedt.landuse         == nil                )   or
         ( passedt.landuse         == ""                 ))  and
        (( passedt.leisure         == nil                )   or
         ( passedt.leisure         == ""                 ))  and
        (( passedt.amenity         == nil                )   or
         ( passedt.amenity         == ""                 )))) then
      passedt.historic = "nonspecific"
      passedt.tourism = nil
      passedt.disusedClanduse = nil

      if ((( passedt.landuse == nil )  or
           ( passedt.landuse == ""  )) and
          (( passedt.leisure == nil )  or
           ( passedt.leisure == ""  )) and
          (( passedt.natural == nil )  or
           ( passedt.natural == ""  ))) then
         passedt.landuse = "historic"
      end
   end

-- ----------------------------------------------------------------------------
-- palaeolontological_site
-- ----------------------------------------------------------------------------
   if ( passedt.geological == "palaeontological_site" ) then
      passedt.historic = "palaeontological_site"
   end

-- ----------------------------------------------------------------------------
-- historic=icon shouldn't supersede amenity or tourism tags.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "icon"  ) and
       (( passedt.amenity  == nil    )  or
        ( passedt.amenity  == ""     )) and
       (( passedt.tourism  == nil    )  or
        ( passedt.tourism  == ""     ))) then
      passedt.historic = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Historic markers
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "marker"          ) or
       ( passedt.historic == "plaque"          ) or
       ( passedt.historic == "memorial_plaque" ) or
       ( passedt.historic == "blue_plaque"     )) then
      passedt.tourism = "informationplaque"
   end

   if ( passedt.historic == "pillar" ) then
      passedt.barrier = "bollard"
      passedt.historic = nil
   end

   if ( passedt.historic == "cairn" ) then
      passedt.man_made = "cairn"
      passedt.historic = nil
   end

   if (( passedt.historic == "chimney" ) or
       ( passedt.man_made == "chimney" ) or
       ( passedt.building == "chimney" )) then
      if (( tonumber(passedt.height) or 0 ) >  50 ) then
         passedt.man_made = "bigchimney"
      else
         passedt.man_made = "chimney"
      end
      passedt.historic = nil
   end

-- ----------------------------------------------------------------------------
-- Beacons - render historic ones, not radio ones.
-- ----------------------------------------------------------------------------
   if ((( passedt.man_made == "beacon"        )  or
        ( passedt.man_made == "signal_beacon" )  or
        ( passedt.landmark == "beacon"        )  or
        ( passedt.historic == "beacon"        )) and
       (  passedt.airmark  == nil              ) and
       (  passedt.aeroway  == nil              ) and
       (  passedt.natural  ~= "hill"           ) and
       (  passedt.natural  ~= "peak"           )) then
      passedt.historic = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Render historic railway stations.
-- ----------------------------------------------------------------------------
   if ((( passedt.abandonedCrailway == "station"         )  or
        ( passedt.disusedCrailway   == "station"         )  or
        ( passedt.historicCrailway  == "station"         )  or
        ( passedt.historic          == "railway_station" )) and
       (  passedt.tourism           ~= "information"      )) then
      passedt.historic = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Add landuse=military to some military things.
-- ----------------------------------------------------------------------------
   if (( passedt.military == "office"                             ) or
       ( passedt.military == "offices"                            ) or
       ( passedt.military == "barracks"                           ) or
       ( passedt.military == "naval_base"                         ) or
       ( passedt.military == "depot"                              ) or
       ( passedt.military == "registration_and_enlistment_office" ) or
       ( passedt.military == "checkpoint"                         ) or
       ( passedt.military == "danger_area"                        ) or
       ( passedt.hazard   == "shooting_range"                     ) or
       ( passedt.sport    == "shooting"                           ) or
       ( passedt.sport    == "shooting_range"                     )) then
      passedt.landuse = "military"
   end

-- ----------------------------------------------------------------------------
-- Render castle_wall as city_wall
-- ----------------------------------------------------------------------------
   if (( passedt.barrier   == "wall"        )  and
       ( passedt.wall      == "castle_wall" )) then
      passedt.historic = "citywalls"
   end

-- ----------------------------------------------------------------------------
-- Get rid of landuse=conservation if we can.  It's a bit of a special case;
-- in raster maps it has a label like grass but no green fill.
-- ----------------------------------------------------------------------------
   if ((  passedt.landuse  == "conservation"  ) and
       (( passedt.historic ~= nil            )  or
        ( passedt.leisure  ~= nil            )  or
        ( passedt.natural  ~= nil            ))) then
      passedt.landuse = nil
   end

-- ----------------------------------------------------------------------------
-- "wayside_shrine" and various memorial crosses.
-- ----------------------------------------------------------------------------
   if ((   passedt.historic   == "wayside_shrine"   ) or
       ((  passedt.historic   == "memorial"        )  and
        (( passedt.memorial   == "mercat_cross"   )   or
         ( passedt.memorial   == "cross"          )   or
         ( passedt.memorial   == "celtic_cross"   )   or
         ( passedt.memorial   == "cross;stone"    )))) then
      passedt.historic = "memorialcross"
   end

   if (( passedt.historic   == "memorial"     ) and
       ( passedt.memorial   == "war_memorial" )) then
      passedt.historic = "warmemorial"
   end

   if ((  passedt.historic      == "memorial"     ) and
       (( passedt.memorial      == "plaque"      )  or
        ( passedt.memorial      == "blue_plaque" )  or
        ( passedt.memorialCtype == "plaque"      ))) then
      passedt.historic = "memorialplaque"
   end

   if ((  passedt.historic   == "memorial"         ) and
       (( passedt.memorial   == "pavement plaque" )  or
        ( passedt.memorial   == "pavement_plaque" ))) then
      passedt.historic = "memorialpavementplaque"
   end

   if ((  passedt.historic      == "memorial"  ) and
       (( passedt.memorial      == "statue"   )  or
        ( passedt.memorialCtype == "statue"   ))) then
      passedt.historic = "memorialstatue"
   end

   if (( passedt.historic   == "memorial"    ) and
       ( passedt.memorial   == "sculpture"   )) then
      passedt.historic = "memorialsculpture"
   end

   if (( passedt.historic   == "memorial"    ) and
       ( passedt.memorial   == "stone"       )) then
      passedt.historic = "memorialstone"
   end

-- ----------------------------------------------------------------------------
-- Ogham stones mapped without other tags
-- ----------------------------------------------------------------------------
   if ( passedt.historic   == "ogham_stone" ) then
      passedt.historic = "oghamstone"
   end

-- ----------------------------------------------------------------------------
-- Stones that are not boundary stones.
-- Note that "marker=boundary_stone" are handled elsewhere.
-- ----------------------------------------------------------------------------
   if (( passedt.marker   == "stone"          ) or
       ( passedt.natural  == "stone"          ) or
       ( passedt.man_made == "stone"          ) or
       ( passedt.man_made == "standing_stone" )) then
      passedt.historic = "naturalstone"

      append_inscription( passedt )
   end

-- ----------------------------------------------------------------------------
-- stones and standing stones
-- The latter is intended to look proper ancient history; 
-- the former more recent,
-- See also historic=archaeological_site, especially megalith, below
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "stone"         ) or
       ( passedt.historic == "bullaun_stone" )) then
      passedt.historic = "historicstone"
   end

   if ( passedt.historic   == "standing_stone" ) then
      passedt.historic = "historicstandingstone"
   end

-- ----------------------------------------------------------------------------
-- Show earthworks as archaeological rather than historic.
-- ----------------------------------------------------------------------------
   if ( passedt.historic == "earthworks"        ) then
      passedt.historic = "archaeological_site"
   end

-- ----------------------------------------------------------------------------
-- archaeological sites
--
-- The subtag of archaeological_site was traditionally site_type, but after
-- some tagfiddling to and fro was then both archaeological_site and site_type
-- and then (July 2023) just archaeological_site; I handle both.
--
-- If something is tagged as both an archaeological site and a place or a 
-- tourist attraction, lose the other tag.
-- Add historic landuse if there isn't already something 
-- that would set an area fill such as landuse or natural.
--
-- Then handle different types of archaeological sites.
-- fortification
-- tumulus
--
-- megalith / standing stone
-- The default icon for a megalith / standing stone is one standing stone.
-- Stone circles are shown as such 
-- Some groups of stones are shown with two stones.
-- ----------------------------------------------------------------------------
   if ( passedt.historic == "archaeological_site" ) then
      passedt.place = nil
      passedt.tourism = nil

      if (( passedt.landuse               == nil      ) and
          ( passedt.leisure               == nil      ) and
          ( passedt.natural               == nil      )  and
          ( passedt.historicCcivilization ~= "modern" )) then
         passedt.landuse = "historic"
      end

      if (( passedt.archaeological_site == "fortification" ) or 
          ( passedt.site_type           == "fortification" )) then
-- ----------------------------------------------------------------------------
-- Is the fortification a ringfort?
-- There are 9k of them in Ireland
-- ----------------------------------------------------------------------------
         if ( passedt.fortification_type == "ringfort" ) then
            passedt.historic = "historicringfort"
         else
-- ----------------------------------------------------------------------------
-- Is the fortification a hill fort (either spelling)?
-- Confusingly, some of these are mapped as fortification_type and some as
-- archaeological_site.
-- Also look for "hilltop_enclosure" here - see e.g. 
-- https://www.openstreetmap.org/changeset/145424438 and
-- comments in https://www.openstreetmap.org/changeset/145424213 .
-- ----------------------------------------------------------------------------
            if (( passedt.fortification_type == "hill_fort"          ) or
                ( passedt.fortification_type == "hillfort"           ) or
                ( passedt.fortification_type == "hilltop_enclosure"  )) then
               passedt.historic = "historichillfort"
            else
-- ----------------------------------------------------------------------------
-- Is the fortification a motte?
-- ----------------------------------------------------------------------------
               if (( passedt.fortification_type == "motte"             ) or
                   ( passedt.fortification_type == "motte_and_bailey"  )) then
                  passedt.historic = "historicarchmotte"
               else
-- ----------------------------------------------------------------------------
-- Is the fortification a castle?
-- Confusingly, some of these are mapped as fortification_type and some as
-- archaeological_site.
-- ----------------------------------------------------------------------------
                  if ( passedt.fortification_type == "castle" ) then
                     passedt.historic = "historicarchcastle"
                  else
-- ----------------------------------------------------------------------------
-- Is the fortification a promontory fort?
-- ----------------------------------------------------------------------------
                     if ( passedt.fortification_type == "promontory_fort" ) then
                        passedt.historic = "historicpromontoryfort"
                     else
-- ----------------------------------------------------------------------------
-- Show as a generic fortification
-- ----------------------------------------------------------------------------
                        passedt.historic = "historicfortification"
                     end  -- promontory fort
                  end  -- castle
               end  -- motte
            end  -- hill_fort
         end  -- ringfort
      else
-- ----------------------------------------------------------------------------
-- Not a fortification.  Check for tumulus
-- ----------------------------------------------------------------------------
         if ((  passedt.archaeological_site == "tumulus"  ) or 
             (  passedt.site_type           == "tumulus"  ) or
             (( passedt.archaeological_site == "tomb"    )  and
              ( passedt.tomb                == "tumulus" ))) then
            passedt.historic = "historictumulus"
         else
-- ----------------------------------------------------------------------------
-- Not a fortification or tumulus.  Check for megalith or standing stone.
-- ----------------------------------------------------------------------------
            if (( passedt.archaeological_site == "megalith"       ) or 
                ( passedt.site_type           == "megalith"       ) or
                ( passedt.archaeological_site == "standing_stone" ) or 
                ( passedt.site_type           == "standing_stone" )) then
               if (( passedt.megalith_type == "stone_circle" ) or
                   ( passedt.megalith_type == "ring_cairn"   ) or
                   ( passedt.megalith_type == "henge"        )) then
                  passedt.historic = "historicstonecircle"
               else
-- ----------------------------------------------------------------------------
-- We have a megalith or standing stone. Check megalith_type for dolmen etc.
-- ----------------------------------------------------------------------------
                  if (( passedt.megalith_type == "dolmen"          ) or
                      ( passedt.megalith_type == "long_barrow"     ) or
                      ( passedt.megalith_type == "passage_grave"   ) or
                      ( passedt.megalith_type == "court_tomb"      ) or
                      ( passedt.megalith_type == "cist"            ) or
                      ( passedt.megalith_type == "wedge_tomb"      ) or
                      ( passedt.megalith_type == "tholos"          ) or
                      ( passedt.megalith_type == "chamber"         ) or
                      ( passedt.megalith_type == "cairn"           ) or
                      ( passedt.megalith_type == "round_barrow"    ) or
                      ( passedt.megalith_type == "gallery_grave"   ) or
                      ( passedt.megalith_type == "tomb"            ) or
                      ( passedt.megalith_type == "chambered_cairn" ) or
                      ( passedt.megalith_type == "chamber_cairn"   ) or
                      ( passedt.megalith_type == "portal_tomb"     )) then
                     passedt.historic = "historicmegalithtomb"
                  else
-- ----------------------------------------------------------------------------
-- We have a megalith or standing stone. Check megalith_type for stone_row
-- ----------------------------------------------------------------------------
                     if (( passedt.megalith_type == "alignment"  ) or
                         ( passedt.megalith_type == "stone_row"  ) or
                         ( passedt.megalith_type == "stone_line" )) then
                           passedt.historic = "historicstonerow"
                     else
-- ----------------------------------------------------------------------------
-- We have a megalith or standing stone, but megalith_type says it is not a 
-- dolmen etc., stone circle or stone row.  
-- Just use the normal standing stone icon.
-- ----------------------------------------------------------------------------
                        passedt.historic = "historicstandingstone"
                     end  -- if alignment
                  end  -- if dolmen
               end  -- if stone circle
            else
-- ----------------------------------------------------------------------------
-- Not a fortification, tumulus, megalith or standing stone.
-- Check for hill fort (either spelling) or "hilltop_enclosure"
-- (see https://www.openstreetmap.org/changeset/145424213 )
-- ----------------------------------------------------------------------------
               if (( passedt.archaeological_site == "hill_fort"         ) or
                   ( passedt.site_type           == "hill_fort"         ) or
                   ( passedt.archaeological_site == "hillfort"          ) or
                   ( passedt.site_type           == "hillfort"          ) or
                   ( passedt.archaeological_site == "hilltop_enclosure" )) then
                  passedt.historic = "historichillfort"
               else
-- ----------------------------------------------------------------------------
-- Check for castle
-- Confusingly, some of these are mapped as fortification_type and some as
-- archaeological_site.
-- ----------------------------------------------------------------------------
                  if ( passedt.archaeological_site == "castle" ) then
                     passedt.historic = "historicarchcastle"
                  else
-- ----------------------------------------------------------------------------
-- Is the archaeological site a crannog?
-- ----------------------------------------------------------------------------
                     if ( passedt.archaeological_site == "crannog" ) then
                        passedt.historic = "historiccrannog"
                     else
                        if (( passedt.archaeological_site == "settlement" ) and
                            ( passedt.fortification_type  == "ringfort"   )) then
                           passedt.historic = "historicringfort"
-- ----------------------------------------------------------------------------
-- There's no code an an "else" here, just this comment:
--                      else
--
-- If set, archaeological_site is not fortification, tumulus, 
-- megalith / standing stone, hill fort, castle or settlement that is also 
-- a ringfort.  Most will not have archaeological_site set.
-- The standard icon for historic=archaeological_site will be used 
-- ----------------------------------------------------------------------------
                        end -- settlement that is also ringfort
                     end  -- crannog
                  end  -- if castle
               end  -- if hill fort
            end  -- if megalith
         end  -- if tumulus
      end  -- if fortification
   end  -- if archaeological site

   if ( passedt.historic   == "rune_stone" ) then
      passedt.historic = "runestone"
   end

   if ( passedt.place_of_worship   == "mass_rock" ) then
      passedt.amenity = nil
      passedt.historic = "massrock"
   end

-- ----------------------------------------------------------------------------
-- Memorial plates
-- ----------------------------------------------------------------------------
   if ((  passedt.historic      == "memorial"  ) and
       (( passedt.memorial      == "plate"    )  or
        ( passedt.memorialCtype == "plate"    ))) then
      passedt.historic = "memorialplate"
   end

-- ----------------------------------------------------------------------------
-- Memorial benches
-- ----------------------------------------------------------------------------
   if (( passedt.historic   == "memorial"    ) and
       ( passedt.memorial   == "bench"       )) then
      passedt.historic = "memorialbench"
   end

-- ----------------------------------------------------------------------------
-- Historic graves, and memorial graves and graveyards
-- ----------------------------------------------------------------------------
   if ((   passedt.historic   == "grave"         ) or
       ((  passedt.historic   == "memorial"     )  and
        (( passedt.memorial   == "grave"       )   or
         ( passedt.memorial   == "graveyard"   )))) then
      passedt.historic = "memorialgrave"
   end

-- ----------------------------------------------------------------------------
-- Memorial obelisks
-- ----------------------------------------------------------------------------
   if ((   passedt.man_made      == "obelisk"     ) or
       (   passedt.landmark      == "obelisk"     ) or
       ((  passedt.historic      == "memorial"   ) and
        (( passedt.memorial      == "obelisk"   )  or
         ( passedt.memorialCtype == "obelisk"   )))) then
      passedt.historic = "memorialobelisk"
   end

-- ----------------------------------------------------------------------------
-- Render alternative taggings of camp_site etc.
-- ----------------------------------------------------------------------------
   if (( passedt.tourism == "camping"                ) or
       ( passedt.tourism == "camp_site;caravan_site" )) then
      passedt.tourism = "camp_site"
   end

   if ( passedt.tourism == "caravan_site;camp_site" ) then
      passedt.tourism = "caravan_site"
   end

   if ( passedt.tourism == "adventure_holiday"  ) then
      passedt.tourism = "hostel"
   end

-- ----------------------------------------------------------------------------
-- Chalets
--
-- Depending on other tags, these will be treated as singlechalet (z17)
-- or as chalet (z16).  Processing here is simpler than for Garmin as we don't
-- have to worry where on the search menu something will appear.
--
-- We assume that tourism=chalet with no building tag could be either a
-- self-contained chalet park or just one chalet.  Leave tagging as is.
--
-- We assume that tourism=chalet with a building tag is a 
-- self-contained chalet or chalet within a resort.  Change to "singlechalet".
-- ----------------------------------------------------------------------------
   if ( passedt.tourism == "chalet" ) then
      passedt.leisure = nil

      if ((  passedt.name     == nil  ) or
          (  passedt.name     == ""   ) or
          (( passedt.building ~= nil ) and
           ( passedt.building ~= ""  ))) then
         passedt.tourism = "singlechalet"
      end
   end

-- ----------------------------------------------------------------------------
-- "leisure=trailhead" is an occasional mistagging for "highway=trailhead"
-- ----------------------------------------------------------------------------
   if ((  passedt.leisure == "trailhead"  ) and
       (( passedt.highway == nil         )  or
        ( passedt.highway == ""          ))) then
      passedt.highway = "trailhead"
      passedt.leisure = nil
   end

-- ----------------------------------------------------------------------------
-- Trailheads appear in odd combinations, not all of which make sense.
--
-- If someone's tagged a trailhead as a locality; likely it's not really one
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "trailhead" ) and
       ( passedt.place   == "locality"  )) then
      passedt.place = nil
   end

-- ----------------------------------------------------------------------------
-- If a trailhead also has a tourism tag, go with whatever tourism tag that is,
-- rather than sending it through as "informationroutemarker" below.
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "trailhead" ) and
       ( passedt.tourism ~= nil         ) and
       ( passedt.tourism ~= ""          )) then
      passedt.highway = nil
   end

-- ----------------------------------------------------------------------------
-- If a trailhead has no name but an operator, use that
-- ----------------------------------------------------------------------------
   if ((  passedt.highway  == "trailhead"  ) and
       (( passedt.name     == nil         )  or
        ( passedt.name     == ""          )) and
       (  passedt.operator ~= nil          ) and
       (  passedt.operator ~= ""           )) then
      passedt.name = passedt.operator
   end

-- ----------------------------------------------------------------------------
-- If a trailhead still has no name, remove it
-- ----------------------------------------------------------------------------
   if ((  passedt.highway  == "trailhead"  ) and
       (( passedt.name     == nil         )  or
        ( passedt.name     == ""          ))) then
      passedt.highway = nil
   end

-- ----------------------------------------------------------------------------
-- Render amenity=information as tourism
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "information"  ) then
      passedt.tourism = "information"
   end

-- ----------------------------------------------------------------------------
-- Let's send amenity=grave_yard and landuse=cemetery through as
-- landuse=cemetery.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "grave_yard" ) or
       ( passedt.landuse == "grave_yard" )) then
      passedt.amenity = nil
      passedt.landuse = "cemetery"
   end

-- ----------------------------------------------------------------------------
-- A special case to check before the "vacant shops" check at the end - 
-- potentially remove disused:amenity=grave_yard
-- ----------------------------------------------------------------------------
   if (( passedt.disusedCamenity == "grave_yard" ) and
       ( passedt.landuse         == "cemetery"   )) then
      passedt.disusedCamenity = nil
   end

-- ----------------------------------------------------------------------------
-- Cemeteries are separated by religion here.
-- "unnamed" is potentially set lower down.  All 6 are selected in project.mml.
--
-- There is a special case for Jehovahs Witnesses - don't use the normal Christian
-- symbol (a cross)
-- ----------------------------------------------------------------------------
   if ( passedt.landuse == "cemetery" ) then
      if ( passedt.religion == "christian" ) then
         if ( passedt.denomination == "jehovahs_witness" ) then
            passedt.landuse = "othercemetery"
         else
            passedt.landuse = "christiancemetery"
         end
      else
         if ( passedt.religion == "jewish" ) then
            passedt.landuse = "jewishcemetery"
         else
            passedt.landuse = "othercemetery"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Treat heliports as aerodromes.
-- Done before the "disused" logic below and the "large/small" logic 
-- further down.
--
-- Heliports are similar to airports, except an icao code (present on many
-- more airports) can also determine that a heliport is "public".
-- ----------------------------------------------------------------------------
   if ( passedt.aeroway == "heliport" ) then
      passedt.aeroway = "aerodrome"

      if ((( passedt.iata  == nil )   or
           ( passedt.iata  == ""  ))  and
          ( passedt.icao  ~= nil   )  and
          ( passedt.icao  ~= ""    )) then
         passedt.iata = passedt.icao
      end
   end

-- ----------------------------------------------------------------------------
-- Disused aerodromes etc. - handle disused=yes.
-- ----------------------------------------------------------------------------
   if (( passedt.aeroway        == "aerodrome" ) and
       ( passedt.disused        == "yes"       )) then
      passedt.aeroway = nil
      passedt.disusedCaeroway = "aerodrome"
   end

   if (( passedt.aeroway        == "runway" ) and
       ( passedt.disused        == "yes"       )) then
      passedt.aeroway = nil
      passedt.disusedCaeroway = "runway"
   end

   if (( passedt.aeroway        == "taxiway" ) and
       ( passedt.disused        == "yes"       )) then
      passedt.aeroway = nil
      passedt.disusedCaeroway = "taxiway"
   end

-- ----------------------------------------------------------------------------
-- If a quarry is disused or historic, it's still likely a hole in the ground, 
-- so render it as something.
-- However, if there's a natural tag, that should take precendence, and 
-- landuse is cleared.
-- ----------------------------------------------------------------------------
   if (((  passedt.disusedClanduse == "quarry"   )  and
        (( passedt.landuse         == nil       )   or
         ( passedt.landuse         == ""        ))) or
       ((  passedt.historic        == "quarry"   )  and
        (( passedt.landuse         == nil       )   or
         ( passedt.landuse         == ""        ))) or
       ((  passedt.landuse         == "quarry"   )  and
        (( passedt.disused         == "yes"     )   or
         ( passedt.historic        == "yes"     )))) then
      if (( passedt.natural == nil )  or
          ( passedt.natural == ""  )) then
         passedt.landuse = "historicquarry"
      else
         passedt.landuse = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Where both historic and natural might carry a name, we need to change some
-- natural tags to unnamed versions
-- ----------------------------------------------------------------------------
   if (( passedt.historic == "archaeological_site"   ) or
       ( passedt.historic == "battlefield"           ) or
       ( passedt.historic == "castle"                ) or
       ( passedt.historic == "church"                ) or
       ( passedt.historic == "historicfortification" ) or
       ( passedt.historic == "historichillfort"      ) or
       ( passedt.historic == "historicmegalithtomb"  ) or
       ( passedt.historic == "historicringfort"      ) or
       ( passedt.historic == "historicstandingstone" ) or
       ( passedt.historic == "historicstonecircle"   ) or
       ( passedt.historic == "historictumulus"       ) or
       ( passedt.historic == "manor"                 ) or
       ( passedt.historic == "memorial"              ) or
       ( passedt.historic == "memorialobelisk"       ) or
       ( passedt.historic == "monastery"             ) or
       ( passedt.historic == "mineshaft"             ) or
       ( passedt.historic == "nonspecific"           ) or
       ( passedt.leisure  == "nature_reserve"        )) then
      if ( passedt.natural == "wood" ) then
         passedt.natural = "unnamedwood"
      end

      if ( passedt.natural == "broadleaved" ) then
         passedt.natural = "unnamedbroadleaved"
      end

      if ( passedt.natural == "mixedleaved" ) then
         passedt.natural = "unnamedmixedleaved"
      end

      if ( passedt.natural == "needleleaved" ) then
         passedt.natural = "unnamedneedleleaved"
      end

      if ( passedt.natural == "heath" ) then
         passedt.natural = "unnamedheath"
      end

      if ( passedt.natural == "scrub" ) then
         passedt.natural = "unnamedscrub"
      end

      if ( passedt.natural == "mud" ) then
         passedt.natural = "unnamedmud"
      end

      if ( passedt.natural == "tidal_mud" ) then
         passedt.natural = "unnamedtidal_mud"
      end

      if ( passedt.natural == "bare_rock" ) then
         passedt.natural = "unnamedbare_rock"
      end

      if ( passedt.natural == "beach" ) then
         passedt.natural = "unnamedbeach"
      end

      if ( passedt.natural == "sand" ) then
         passedt.natural = "unnamedsand"
      end

      if ( passedt.natural == "tidal_sand" ) then
         passedt.natural = "unnamedtidal_sand"
      end

      if ( passedt.natural == "wetland" ) then
         passedt.natural = "unnamedwetland"
      end

      if ( passedt.natural == "grassland" ) then
         passedt.natural = "unnamedgrassland"
      end
   end

-- ----------------------------------------------------------------------------
-- Change commercial landuse from aerodromes so that no name is displayed 
-- from that.
-- There's a similar issue with e.g. leisure=fishing / landuse=grass, which has
-- already been rewritten to "park" by now.
-- Some combinations are incompatible so we "just need to pick one".
-- ----------------------------------------------------------------------------
   if (( passedt.aeroway  == "aerodrome"             ) or
       ( passedt.historic == "archaeological_site"   ) or
       ( passedt.historic == "battlefield"           ) or
       ( passedt.historic == "castle"                ) or
       ( passedt.historic == "church"                ) or
       ( passedt.historic == "historicfortification" ) or
       ( passedt.historic == "historichillfort"      ) or
       ( passedt.historic == "historicmegalithtomb"  ) or
       ( passedt.historic == "historicringfort"      ) or
       ( passedt.historic == "historicstandingstone" ) or
       ( passedt.historic == "historicstonecircle"   ) or
       ( passedt.historic == "historictumulus"       ) or
       ( passedt.historic == "manor"                 ) or
       ( passedt.historic == "memorial"              ) or
       ( passedt.historic == "memorialobelisk"       ) or
       ( passedt.historic == "monastery"             ) or
       ( passedt.historic == "mineshaft"             ) or
       ( passedt.historic == "nonspecific"           ) or
       ( passedt.leisure  == "common"                ) or
       ( passedt.leisure  == "garden"                ) or
       ( passedt.leisure  == "nature_reserve"        ) or
       ( passedt.leisure  == "park"                  ) or
       ( passedt.leisure  == "pitch"                 ) or
       ( passedt.leisure  == "sports_centre"         ) or
       ( passedt.leisure  == "track"                 ) or
       ( passedt.tourism  == "theme_park"            )) then
      if ( passedt.landuse == "allotments" ) then
         passedt.landuse = "unnamedallotments"
      end

      if ( passedt.landuse == "christiancemetery" ) then
         passedt.landuse = "unnamedchristiancemetery"
      end

      if ( passedt.landuse == "jewishcemetery" ) then
         passedt.landuse = "unnamedjewishcemetery"
      end

      if ( passedt.landuse == "othercemetery" ) then
         passedt.landuse = "unnamedothercemetery"
      end

      if ( passedt.landuse == "commercial" ) then
         passedt.landuse = "unnamedcommercial"
      end

      if (( passedt.landuse == "construction" )  or
          ( passedt.landuse == "brownfield"   )  or
          ( passedt.landuse == "greenfield"   )) then
         passedt.landuse = "unnamedconstruction"
      end

      if ( passedt.landuse == "farmland" ) then
         passedt.landuse = "unnamedfarmland"
      end

      if ( passedt.landuse == "farmgrass" ) then
         passedt.landuse = "unnamedfarmgrass"
      end

      if ( passedt.landuse == "farmyard" ) then
         passedt.landuse = "unnamedfarmyard"
      end

      if ( passedt.landuse == "forest" ) then
         passedt.landuse = "unnamedforest"
      end

      if ( passedt.landuse == "grass" ) then
         passedt.landuse = "unnamedgrass"
      end

      if ( passedt.landuse == "industrial" ) then
         passedt.landuse = "unnamedindustrial"
      end

      if ( passedt.landuse == "landfill" ) then
         passedt.landuse = "unnamedlandfill"
      end

      if ( passedt.landuse == "meadow" ) then
         passedt.landuse = "unnamedmeadow"
      end

      if ( passedt.landuse == "wetmeadow" ) then
         passedt.landuse = "unnamedwetmeadow"
      end

      if ( passedt.landuse == "meadowwildflower" ) then
         passedt.landuse = "unnamedmeadowwildflower"
      end

      if ( passedt.landuse == "meadowperpetual" ) then
         passedt.landuse = "unnamedmeadowperpetual"
      end

      if ( passedt.landuse == "meadowtransitional" ) then
         passedt.landuse = "unnamedmeadowtransitional"
      end

      if ( passedt.landuse == "saltmarsh" ) then
         passedt.landuse = "unnamedsaltmarsh"
      end

      if ( passedt.landuse == "orchard" ) then
         passedt.landuse = "unnamedorchard"
      end

      if ( passedt.landuse  == "quarry" ) then
         passedt.landuse = "unnamedquarry"
      end

      if ( passedt.landuse  == "historicquarry" ) then
         passedt.landuse = "unnamedhistoricquarry"
      end

      if ( passedt.landuse == "residential" ) then
         passedt.landuse = "unnamedresidential"
      end
   end

-- ----------------------------------------------------------------------------
-- Aerodrome size.
-- Large public airports should have an airport icon.  Others should not.
-- ----------------------------------------------------------------------------
   if ( passedt.aeroway == "aerodrome" ) then
      if ((  passedt.iata           ~= nil          ) and
          (  passedt.iata           ~= ""           ) and
          (  passedt.aerodromeCtype ~= "military"   ) and
          (( passedt.military       == nil         )  or
           ( passedt.military       == ""          ))) then
         passedt.aeroway = "large_aerodrome"

         if (( passedt.name == nil ) or
             ( passedt.name == ""  )) then
            passedt.name = passedt.iata
         else
            passedt.name = passedt.name .. " (" .. passedt.iata .. ")"
         end
      else
         if ((  passedt.aerodromeCtype == "military"   ) or
             (( passedt.military       ~= nil         )  and
              ( passedt.military       ~= ""          ))) then
            passedt.aeroway = "military_aerodrome"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Grass runways
-- These are rendered less prominently.
-- ----------------------------------------------------------------------------
   if (( passedt.aeroway == "runway" ) and
       ( passedt.surface == "grass"  )) then
      passedt.aeroway = "grass_runway"
   end

   if (( passedt.aeroway == "apron"  ) and
       ( passedt.surface == "grass"  )) then
      passedt.landuse = "grass"
      passedt.aeroway = nil
   end

   if (( passedt.aeroway == "taxiway"  ) and
       ( passedt.surface == "grass"    )) then
      passedt.highway = "track"
      passedt.aeroway = nil
   end


-- ----------------------------------------------------------------------------
-- Render airport parking positions as gates.
-- ----------------------------------------------------------------------------
   if ( passedt.aeroway == "parking_position" ) then
      passedt.aeroway = "gate"

      if (( passedt.ref ~= nil ) and
          ( passedt.ref ~= ""  )) then
         passedt.ref = "(" .. passedt.ref .. ")"
      end
   end

-- ----------------------------------------------------------------------------
-- Shops etc. with icons already - just add "unnamedcommercial" landuse.
-- The exception is where landuse is set to something we want to keep.
-- ----------------------------------------------------------------------------
   if (((( passedt.shop       ~= nil                 )   and
         ( passedt.shop       ~= ""                  ))  or
        (( passedt.amenity    ~= nil                 )   and
         ( passedt.amenity    ~= ""                  )   and
         ( passedt.amenity    ~= "holy_well"         )   and
         ( passedt.amenity    ~= "holy_spring"       )   and
         ( passedt.amenity    ~= "biergarten"        )   and
         ( passedt.amenity    ~= "pitch_baseball"    )   and
         ( passedt.amenity    ~= "pitch_basketball"  )   and
         ( passedt.amenity    ~= "pitch_chess"       )   and
         ( passedt.amenity    ~= "pitch_cricket"     )   and
         ( passedt.amenity    ~= "pitch_climbing"    )   and
         ( passedt.amenity    ~= "pitch_athletics"   )   and
         ( passedt.amenity    ~= "pitch_boules"      )   and
         ( passedt.amenity    ~= "pitch_bowls"       )   and
         ( passedt.amenity    ~= "pitch_croquet"     )   and
         ( passedt.amenity    ~= "pitch_cycling"     )   and
         ( passedt.amenity    ~= "pitch_equestrian"  )   and
         ( passedt.amenity    ~= "pitch_gaa"         )   and
         ( passedt.amenity    ~= "pitch_hockey"      )   and
         ( passedt.amenity    ~= "pitch_multi"       )   and
         ( passedt.amenity    ~= "pitch_netball"     )   and
         ( passedt.amenity    ~= "pitch_polo"        )   and
         ( passedt.amenity    ~= "pitch_shooting"    )   and
         ( passedt.amenity    ~= "pitch_rugby"       )   and
         ( passedt.amenity    ~= "pitch_skateboard"  )   and
         ( passedt.amenity    ~= "pitch_soccer"      )   and
         ( passedt.amenity    ~= "pitch_tabletennis" )   and
         ( passedt.amenity    ~= "pitch_tennis"      ))  or
        (  passedt.tourism    == "hotel"              )  or
        (  passedt.tourism    == "guest_house"        )  or
        (  passedt.tourism    == "attraction"         )  or
        (  passedt.tourism    == "viewpoint"          )  or
        (  passedt.tourism    == "museum"             )  or
        (  passedt.tourism    == "hostel"             )  or
        (  passedt.tourism    == "gallery"            )  or
        (  passedt.tourism    == "apartment"          )  or
        (  passedt.tourism    == "bed_and_breakfast"  )  or
        (  passedt.tourism    == "motel"              )  or
        (  passedt.tourism    == "theme_park"         )) and
       (   passedt.leisure    ~= "garden"              )) then
      if (( passedt.landuse == nil ) or
          ( passedt.landuse == ""  )) then
         passedt.landuse = "unnamedcommercial"
      end
   end

end -- generic_before_function()

function append_prow_ref( passedt )
    if (( passedt.prow_ref ~= nil ) and
        ( passedt.prow_ref ~= ""  )) then
       if (( passedt.name == nil )  or
           ( passedt.name == "" )) then
          passedt.name     = "(" .. passedt.prow_ref .. ")"
          passedt.prow_ref = nil
       else
          passedt.name     = passedt.name .. " (" .. passedt.prow_ref .. ")"
          passedt.prow_ref = nil
       end
    end
end -- append_prow_ref

function append_accommodation( passedt )
   if (( passedt.accommodation ~= nil  ) and
       ( passedt.accommodation ~= "no" )) then
      passedt.amenity = passedt.amenity .. "y"
   else
      passedt.amenity = passedt.amenity .. "n"
   end
end

function append_wheelchair( passedt )
   if ( passedt.wheelchair == "yes" ) then
      passedt.amenity = passedt.amenity .. "y"
   else
      if ( passedt.wheelchair == "limited" ) then
         passedt.amenity = passedt.amenity .. "l"
      else
         if ( passedt.wheelchair == "no" ) then
            passedt.amenity = passedt.amenity .. "n"
         else
            passedt.amenity = passedt.amenity .. "d"
         end
      end
   end
end


function append_beer_garden( passedt )
   if ( passedt.beer_garden == "yes" ) then
      passedt.amenity = passedt.amenity .. "g"
   else
      if ( passedt.outdoor_seating == "yes" ) then
         passedt.amenity = passedt.amenity .. "o"
      else
         passedt.amenity = passedt.amenity .. "d"
      end
   end
end

-- ----------------------------------------------------------------------------
-- Designed to set "ele" to a new value
-- ----------------------------------------------------------------------------
function append_inscription( passedt )
   if (( passedt.name ~= nil ) and
       ( passedt.name ~= ""  )) then
      passedt.ele = passedt.name
   else
      passedt.ele = nil
   end

   if ( passedt.inscription ~= nil ) then
       if ( passedt.ele == nil ) then
           passedt.ele = passedt.inscription
       else
           passedt.ele = passedt.ele .. " " .. passedt.inscription
       end
   end
end


-- ----------------------------------------------------------------------------
-- Designed to append any directions to an "ele" that might already have
-- "inscription" in it.
-- ----------------------------------------------------------------------------
function append_directions( passedt )
   if (( passedt.direction_north ~= nil ) and
       ( passedt.direction_north ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "N: " .. passedt.direction_north
      else
         passedt.ele = passedt.ele .. ", N: " .. passedt.direction_north
      end
   end

   if (( passedt.direction_northeast ~= nil ) and
       ( passedt.direction_northeast ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "NE: " .. passedt.direction_northeast
      else
         passedt.ele = passedt.ele .. ", NE: " .. passedt.direction_northeast
      end
   end

   if (( passedt.direction_east ~= nil ) and
       ( passedt.direction_east ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "E: " .. passedt.direction_east
      else
         passedt.ele = passedt.ele .. ", E: " .. passedt.direction_east
      end
   end

   if (( passedt.direction_southeast ~= nil ) and
       ( passedt.direction_southeast ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "SE: " .. passedt.direction_southeast
      else
         passedt.ele = passedt.ele .. ", SE: " .. passedt.direction_southeast
      end
   end

   if (( passedt.direction_south ~= nil ) and
       ( passedt.direction_south ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "S: " .. passedt.direction_south
      else
         passedt.ele = passedt.ele .. ", S: " .. passedt.direction_south
      end
   end

   if (( passedt.direction_southwest ~= nil ) and
       ( passedt.direction_southwest ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "SW: " .. passedt.direction_southwest
      else
         passedt.ele = passedt.ele .. ", SW: " .. passedt.direction_southwest
      end
   end

   if (( passedt.direction_west ~= nil ) and
       ( passedt.direction_west ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "W: " .. passedt.direction_west
      else
         passedt.ele = passedt.ele .. ", W: " .. passedt.direction_west
      end
   end

   if (( passedt.direction_northwest ~= nil ) and
       ( passedt.direction_northwest ~= ""  )) then
      if (( passedt.ele == nil ) and
          ( passedt.ele == ""  )) then
         passedt.ele = "NW: " .. passedt.direction_northwest
      else
         passedt.ele = passedt.ele .. ", NW: " .. passedt.direction_northwest
      end
   end
end

function generic_after_function( passedt )
-- ----------------------------------------------------------------------------
-- When processing data for layers note that something might have be a feature
-- that needs adding to more than one layer (perhaps based on the same 
-- key/value combination, perhaps based on a different one).
-- ----------------------------------------------------------------------------
    generic_after_building( passedt )
    generic_after_poi( passedt )
    generic_after_land1( passedt )
    generic_after_land2( passedt )
end -- generic_after_function()

-- ----------------------------------------------------------------------------
-- building layer
-- ----------------------------------------------------------------------------
function generic_after_building( passedt )
    if (( passedt.building ~= nil ) and
        ( passedt.building ~= ""  )) then
        Layer("building", true)
	Attribute( "class", "building_" .. passedt.building )
	Attribute( "name", Find( "name" ) )
    end
end -- generic_after_building()

-- ----------------------------------------------------------------------------
-- poi layer
-- ----------------------------------------------------------------------------
function generic_after_poi( passedt )
    if (( passedt.amenity ~= ""  ) and
        ( passedt.amenity ~= nil )) then
        LayerAsCentroid( "poi" )
	Attribute( "class","amenity_" .. passedt.amenity )
	Attribute( "name", Find( "name" ) )
        MinZoom( 14 )
    else
        if (( passedt.place ~= ""  ) and
            ( passedt.place ~= nil )) then
            LayerAsCentroid( "place" )
    	    Attribute( "name", Find( "name" ))

            if (( passedt.place == "country" ) or
                ( passedt.place == "state"   )) then
                MinZoom( 5 )
            else
                if ( passedt.place == "city" ) then
                    MinZoom( 5 )
                else
                    if ( passedt.place == "town" ) then
                        MinZoom( 8 )
                    else
                        if (( passedt.place == "suburb"  ) or
                            ( passedt.place == "village" )) then
                            MinZoom( 11 )
                        else
                            if (( passedt.place == "hamlet"            ) or
                                ( passedt.place == "locality"          ) or
                                ( passedt.place == "neighbourhood"     ) or
                                ( passedt.place == "isolated_dwelling" ) or
                                ( passedt.place == "farm"              )) then
                                MinZoom( 13 )
                            else
                                MinZoom( 14 )
                            end -- hamlet
                        end -- suburb
                    end -- town
                end -- city
            end --country
	else -- place
            if (( passedt.shop ~= ""  ) and
                ( passedt.shop ~= nil )) then
                LayerAsCentroid( "poi" )
    	        Attribute( "class","shop_" .. passedt.shop )
    	        Attribute( "name", Find( "name" ) )
                MinZoom( 14 )
            else
                if (( passedt.tourism ~= ""  ) and
                    ( passedt.tourism ~= nil )) then
                    LayerAsCentroid( "poi" )
                    Attribute( "class", "tourism_" .. passedt.tourism )
                    Attribute( "name", Find( "name" ) )
                    MinZoom( 14 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
                end -- tourism
            end -- shop
        end -- place
    end -- amenity
end -- generic_after_poi()

-- ----------------------------------------------------------------------------
-- There are two "land" layers - "land1" and "land2".
-- Where two features might get shown, the lua code above adds the one to
-- show the label for to "land1" and adds the other "unnamed" one to "land2"
--
-- land1 layer
-- ----------------------------------------------------------------------------
function generic_after_land1( passedt )
    if (( passedt.landuse == "forest"          ) or
        ( passedt.landuse == "farmland"        )) then
        Layer( "land1", true )
        Attribute( "class", "landuse_" .. passedt.landuse )
        Attribute( "name", Find( "name" ) )
        MinZoom( 8 )
    else
        if (( passedt.landuse == "grass"                     ) or
            ( passedt.landuse == "residential"               ) or
            ( passedt.landuse == "meadow"                    ) or
            ( passedt.landuse == "wetmeadow"                 ) or
            ( passedt.landuse == "farmyard"                  ) or
            ( passedt.landuse == "farmgrass"                 ) or
            ( passedt.landuse == "recreation_ground"         ) or
            ( passedt.landuse == "retail"                    ) or
            ( passedt.landuse == "industrial"                ) or
            ( passedt.landuse == "railway"                   ) or
            ( passedt.landuse == "commercial"                ) or
            ( passedt.landuse == "brownfield"                ) or
            ( passedt.landuse == "greenfield"                ) or
            ( passedt.landuse == "construction"              ) or
            ( passedt.landuse == "landfill"                  ) or
            ( passedt.landuse == "historic"                  ) or
            ( passedt.landuse == "orchard"                   ) or
            ( passedt.landuse == "meadowtransitional"        ) or
            ( passedt.landuse == "meadowwildflower"          ) or
            ( passedt.landuse == "meadowperpetual"           ) or
            ( passedt.landuse == "saltmarsh"                 ) or
            ( passedt.landuse == "reedbed"                   ) or
            ( passedt.landuse == "allotments"                ) or
            ( passedt.landuse == "christiancemetery"         ) or
            ( passedt.landuse == "jewishcemetery"            ) or
            ( passedt.landuse == "othercemetery"             )) then
            Layer( "land1", true )
            Attribute( "class", "landuse_" .. passedt.landuse )
            Attribute( "name", Find( "name" ) )
            MinZoom( 9 )
        else
            if (( passedt.landuse == "village_green"          ) or
                ( passedt.landuse == "quarry"                 ) or
                ( passedt.landuse == "historicquarry"         )) then
                Layer( "land1", true )
                Attribute( "class", "landuse_" .. passedt.landuse )
                Attribute( "name", Find( "name" ) )
                MinZoom( 10 )
            else
                if ( passedt.landuse == "garages" ) then
                    Layer( "land1", true )
                    Attribute( "class", "landuse_" .. passedt.landuse )
                    Attribute( "name", Find( "name" ) )
                    MinZoom( 11 )
                else
                    if ( passedt.landuse == "vineyard" ) then
                        Layer( "land1", true )
                        Attribute( "class", "landuse_" .. passedt.landuse )
                        Attribute( "name", Find( "name" ) )
                        MinZoom( 12 )
                    else
                        render_leisure_land1( passedt )
                    end -- landuse=vineyard 12
                end -- landuse=garages 11
            end -- landuse=quarry 10
        end -- landuse=grass etc. 9
    end -- landuse=forest 8
end -- generic_after_land1()

function render_leisure_land1( passedt )
    if ( passedt.leisure == "nature_reserve" ) then
        Layer( "land1", true )
        Attribute( "class", "leisure_" .. passedt.leisure )
        Attribute( "name", Find( "name" ) )
        MinZoom( 6 )
    else
        if (( passedt.leisure == "common"            ) or
            ( passedt.leisure == "park"              ) or
            ( passedt.leisure == "recreation_ground" ) or
            ( passedt.leisure == "garden"            ) or
            ( passedt.leisure == "golfgreen"         ) or
            ( passedt.leisure == "golf_course"       ) or
            ( passedt.leisure == "sports_centre"     ) or
            ( passedt.leisure == "stadium"           ) or
            ( passedt.leisure == "pitch"             ) or
            ( passedt.leisure == "track"             )) then
            Layer( "land1", true )
            Attribute( "class", "leisure_" .. passedt.leisure )
            Attribute( "name", Find( "name" ) )
            MinZoom( 9 )
        else
            if ( passedt.leisure == "nature_reserve" ) then
                Layer( "land1", true )
                Attribute( "class", "leisure_" .. passedt.leisure )
                Attribute( "name", Find( "name" ) )
                MinZoom( 10 )
            else
                if (( passedt.leisure == "playground" ) or
                    ( passedt.leisure == "schoolyard" )) then
                    Layer( "land1", true )
                    Attribute( "class", "leisure_" .. passedt.leisure )
                    Attribute( "name", Find( "name" ) )
                    MinZoom( 12 )
                else
                    if ( passedt.leisure == "swimming_pool" ) then
                        Layer( "land1", true )
                        Attribute( "class", "leisure_" .. passedt.leisure )
                        Attribute( "name", Find( "name" ) )
                        MinZoom( 13 )
                    else
                        render_military_land1( passedt )
                    end -- leisure=swimming_pool etc. 13
                end -- leisure=playground etc.  12
            end -- leisure=nature_reserve etc. 10
        end -- leisure=common etc. 9
    end -- leisure=nature_reserve 6
end -- render_leisure_land1()

function render_military_land1( passedt )
    if ( passedt.military == "barracks" ) then
        Layer( "land1", true )
        Attribute( "class", "military_" .. passedt.military )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
    else
        render_natural_land1( passedt )
    end
end -- render_military_land1()

function render_natural_land1( passedt )
    if ( passedt.natural == "desert" ) then
        Layer( "land1", true )
        Attribute( "class", "natural_" .. passedt.natural )
        Attribute( "name", Find( "name" ) )
        MinZoom( 7 )
    else
        if (( passedt.natural == "wood"         ) or
            ( passedt.natural == "broadleaved"  ) or
            ( passedt.natural == "needleleaved" ) or
            ( passedt.natural == "mixedleaved"  )) then
            Layer( "land1", true )
            Attribute( "class", "natural_" .. passedt.natural )
            Attribute( "name", Find( "name" ) )
            MinZoom( 8 )
        else
            if (( passedt.natural == "beach"         ) or
                ( passedt.natural == "tidal_beach"   ) or
                ( passedt.natural == "mud"           ) or
                ( passedt.natural == "tidal_mud"     ) or
                ( passedt.natural == "bare_rock"     ) or
                ( passedt.natural == "tidal_rock"    ) or
                ( passedt.natural == "sand"          ) or
                ( passedt.natural == "tidal_sand"    ) or
                ( passedt.natural == "scree"         ) or
                ( passedt.natural == "tidal_scree"   ) or
                ( passedt.natural == "shingle"       ) or
                ( passedt.natural == "tidal_shingle" ) or
                ( passedt.natural == "heath"         ) or
                ( passedt.natural == "grassland"     ) or
                ( passedt.natural == "scrub"         )) then
                Layer( "land1", true )
                Attribute( "class", "natural_" .. passedt.natural )
                Attribute( "name", Find( "name" ) )
                MinZoom( 9 )
            else
                if (( passedt.natural == "wetland"  ) or
                    ( passedt.natural == "reef"     ) or
                    ( passedt.natural == "reefsand" )) then
                    Layer( "land1", true )
                    Attribute( "class", "natural_" .. passedt.natural )
                    Attribute( "name", Find( "name" ) )
                    MinZoom( 12 )
                else
                    render_power_land1( passedt )
                end -- wetland 12
            end -- beach etc. 9
        end -- wood 8
    end -- desert 7
end -- render_natural_land1()

function render_power_land1( passedt )
    if (( passedt.power == "station"   ) or
        ( passedt.power == "generator" )) then
        Layer( "land1", true )
        Attribute( "class", "power_" .. passedt.power )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
    else
        if ( passedt.power == "substation" ) then
            Layer( "land1", true )
            Attribute( "class", "power_" .. passedt.power )
            Attribute( "name", Find( "name" ) )
            MinZoom( 12 )
        else
            render_tourism_land1( passedt )
        end -- power=substation 12
    end -- power=generator 9
end -- render_power_land1()

function render_tourism_land1( passedt )
    if (( passedt.tourism == "zoo"        ) or
        ( passedt.tourism == "attraction" )) then
        Layer( "land1", true )
        Attribute( "class", "tourism_" .. passedt.tourism )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
    else
        if (( passedt.tourism == "camp_site"    ) or
            ( passedt.tourism == "caravan_site" ) or
            ( passedt.tourism == "picnic_site"  ) or
            ( passedt.tourism == "theme_park"   )) then
            Layer( "land1", true )
            Attribute( "class", "tourism_" .. passedt.tourism )
            Attribute( "name", Find( "name" ) )
            MinZoom( 12 )
        else
            render_aeroway_land1( passedt )
        end -- tourism=camp_site etc. 12
    end -- tourism=zoo 9
end -- render_tourism_land1()

function render_aeroway_land1( passedt )
    if ( passedt.aeroway == "apron"     ) then
        Layer( "land1", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        Attribute( "name", Find( "name" ) )
        MinZoom( 12 )
    else
        render_amenity_land1( passedt )
    end -- aeroway=apron 12
end -- render_aeroway_land1()

function render_amenity_land1( passedt )
    if (( passedt.amenity == "parking"              ) or
        ( passedt.amenity == "parking_pay"          ) or
        ( passedt.amenity == "parking_freedisabled" ) or
        ( passedt.amenity == "parking_paydisabled"  ) or
        ( passedt.amenity == "university"           ) or
        ( passedt.amenity == "college"              ) or
        ( passedt.amenity == "school"               ) or
        ( passedt.amenity == "hospital"             ) or
        ( passedt.amenity == "kindergarten"         )) then
        Layer( "land1", true )
        Attribute( "class", "amenity_" .. passedt.amenity )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
    end -- amenity=parking etc. 9
end -- render_amenity_land1()

-- ----------------------------------------------------------------------------
-- land2 layer
-- ----------------------------------------------------------------------------
function generic_after_land2( passedt )
    if (( passedt.landuse == "unnamedforest"   ) or
        ( passedt.landuse == "unnamedfarmland" )) then
        Layer( "land2", true )
        Attribute( "class", "landuse_" .. passedt.landuse )
        MinZoom( 8 )
    else
        if (( passedt.landuse == "unnamedgrass"              ) or
            ( passedt.landuse == "unnamedresidential"        ) or
            ( passedt.landuse == "unnamedmeadow"             ) or
            ( passedt.landuse == "unnamedwetmeadow"          ) or
            ( passedt.landuse == "unnamedfarmyard"           ) or
            ( passedt.landuse == "unnamedfarmgrass"          ) or
            ( passedt.landuse == "unnamedindustrial"         ) or
            ( passedt.landuse == "unnamedcommercial"         ) or
            ( passedt.landuse == "unnamedconstruction"       ) or
            ( passedt.landuse == "unnamedlandfill"           ) or
            ( passedt.landuse == "unnamedorchard"            ) or
            ( passedt.landuse == "unnamedmeadowtransitional" ) or
            ( passedt.landuse == "unnamedmeadowwildflower"   ) or
            ( passedt.landuse == "unnamedmeadowperpetual"    ) or
            ( passedt.landuse == "unnamedsaltmarsh"          ) or
            ( passedt.landuse == "unnamedallotments"         ) or
            ( passedt.landuse == "unnamedchristiancemetery"  ) or
            ( passedt.landuse == "unnamedjewishcemetery"     ) or
            ( passedt.landuse == "unnamedothercemetery"      ) or
            ( passedt.landuse == "military"                  )) then
            Layer( "land2", true )
            Attribute( "class", "landuse_" .. passedt.landuse )

            if ( passedt.landuse == "military" ) then
                Attribute( "name", Find( "name" ) )
            end

            MinZoom( 9 )
        else
            if (( passedt.landuse == "unnamedquarry"          ) or
                ( passedt.landuse == "unnamedhistoricquarry"  )) then
                Layer( "land2", true )
                Attribute( "class", "landuse_" .. passedt.landuse )
                MinZoom( 10 )
            else
                render_leisure_land2( passedt )
            end -- landuse=unnamedquarry 10
        end -- landuse=unnamedgrass etc. 9
    end -- landuse=unnamedforest 8
end -- generic_after_land2()

function render_leisure_land2( passedt )
    if ( passedt.leisure == "unnamedpitch" ) then
        Layer( "land2", true )
        Attribute( "class", "leisure_" .. passedt.leisure )
        MinZoom( 9 )
    else
        render_natural_land2( passedt )
    end -- leisure=unnamedpitch 9
end -- render_leisure_land2()

function render_natural_land2( passedt )
    if (( passedt.natural == "unnamedwood"         ) or
        ( passedt.natural == "unnamedbroadleaved"  ) or
        ( passedt.natural == "unnamedneedleleaved" ) or
        ( passedt.natural == "unnamedmixedleaved"  )) then
        Layer( "land2", true )
        Attribute( "class", "natural_" .. passedt.natural )
        MinZoom( 8 )
    else
        if (( passedt.natural == "unnamedheath"      ) or
            ( passedt.natural == "unnamedscrub"      ) or
            ( passedt.natural == "unnamedmud"        ) or
            ( passedt.natural == "unnamedtidal_mud"  ) or
            ( passedt.natural == "unnamedbare_rock"  ) or
            ( passedt.natural == "unnamedbeach"      ) or
            ( passedt.natural == "unnamedsand"       ) or
            ( passedt.natural == "unnamedtidal_sand" ) or
            ( passedt.natural == "unnamedgrassland"  )) then
            Layer( "land2", true )
            Attribute( "class", "natural_" .. passedt.natural )
            MinZoom( 9 )
        else
            if ( passedt.natural == "unnamedwetland"     ) then
                Layer( "land2", true )
                Attribute( "class", "natural_" .. passedt.natural )
                MinZoom( 12 )
            else
                render_aeroway_land2( passedt )
            end -- natural=unnamedwetland
        end -- natural=unnamedheath 9
    end -- natural=unnamedheath 8
end -- render_natural_land2()

function render_aeroway_land2( passedt )
    if (( passedt.aeroway == "aerodrome"       ) or
        ( passedt.aeroway == "large_aerodrome" )) then
        Layer( "land2", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        Attribute( "name", Find( "name" ) )
        MinZoom( 12 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
    end -- aeroway=aerodrome 12
end -- render_aeroway_land2()

