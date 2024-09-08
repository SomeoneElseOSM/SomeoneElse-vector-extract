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

    generic_before_function( wayt )

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
    if ( wayt.highway ~= "" ) then
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
    end -- highway

-- ----------------------------------------------------------------------------
-- Other processing - still to be added
-- ----------------------------------------------------------------------------
    if wayt.waterway~="" then
        Layer("waterway", false)
        Attribute("class", wayt.waterway)
    end

    if wayt.building~="" then
        Layer("building", true)
    end

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
-- Handle place=islet as place=island
-- Handle place=quarter
-- Handle natural=cape etc. as place=locality if no other place tag.
-- ----------------------------------------------------------------------------
   passedt.place = consolidate_place( passedt.place, passedt.natural )

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
-- Send driveways through to the rendering code as a specific highway type
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
-- at low zoom levels of nature reserves.
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

function generic_after_function( passedt )
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
                else
                    if (( passedt.landuse == "forest"          ) or
                        ( passedt.landuse == "unnamedforest"   ) or
                        ( passedt.landuse == "farmland"        ) or
                        ( passedt.landuse == "unnamedfarmland" )) then
                        Layer( "land", true )
                        Attribute( "class", "landuse_" .. passedt.landuse )

                        if (( passedt.landuse == "forest"   )  or
                            ( passedt.landuse == "farmland" )) then
                            Attribute( "name", Find( "name" ) )
                        end

                        MinZoom( 8 )
                    else
                        if (( passedt.landuse == "grass"                     ) or
                            ( passedt.landuse == "unnamedgrass"              ) or
                            ( passedt.landuse == "residential"               ) or
                            ( passedt.landuse == "unnamedresidential"        ) or
                            ( passedt.landuse == "meadow"                    ) or
                            ( passedt.landuse == "unnamedmeadow"             ) or
                            ( passedt.landuse == "wetmeadow"                 ) or
                            ( passedt.landuse == "farmyard"                  ) or
                            ( passedt.landuse == "unnamedfarmyard"           ) or
                            ( passedt.landuse == "farmgrass"                 ) or
                            ( passedt.landuse == "unnamedfarmgrass"          ) or
                            ( passedt.landuse == "recreation_ground"         ) or
                            ( passedt.landuse == "retail"                    ) or
                            ( passedt.landuse == "industrial"                ) or
                            ( passedt.landuse == "unnamedindustrial"         ) or
                            ( passedt.landuse == "railway"                   ) or
                            ( passedt.landuse == "commercial"                ) or
                            ( passedt.landuse == "unnamedcommercial"         ) or
                            ( passedt.landuse == "brownfield"                ) or
                            ( passedt.landuse == "greenfield"                ) or
                            ( passedt.landuse == "construction"              ) or
                            ( passedt.landuse == "unnamedconstruction"       ) or
                            ( passedt.landuse == "landfill"                  ) or
                            ( passedt.landuse == "unnamedlandfill"           ) or
                            ( passedt.landuse == "historic"                  ) or
                            ( passedt.landuse == "orchard"                   ) or
                            ( passedt.landuse == "unnamedorchard"            ) or
                            ( passedt.landuse == "meadowtransitional"        ) or
                            ( passedt.landuse == "unnamedmeadowtransitional" ) or
                            ( passedt.landuse == "meadowwildflower"          ) or
                            ( passedt.landuse == "unnamedmeadowwildflower"   ) or
                            ( passedt.landuse == "meadowperpetual"           ) or
                            ( passedt.landuse == "unnamedmeadowperpetual"    ) or
                            ( passedt.landuse == "saltmarsh"                 ) or
                            ( passedt.landuse == "reedbed"                   ) or
                            ( passedt.landuse == "allotments"                ) or
                            ( passedt.landuse == "unnamedallotments"         )) then
                            Layer( "land", true )
                            Attribute( "class", "landuse_" .. passedt.landuse )

                            if (( passedt.landuse == "grass"              )  or
                                ( passedt.landuse == "residential"        )  or
                                ( passedt.landuse == "meadow"             )  or
                                ( passedt.landuse == "wetmeadow"          )  or
                                ( passedt.landuse == "farmyard"           )  or
                                ( passedt.landuse == "farmgrass"          )  or
                                ( passedt.landuse == "recreation_ground"  )  or
                                ( passedt.landuse == "retail"             )  or
                                ( passedt.landuse == "industrial"         )  or
                                ( passedt.landuse == "railway"            )  or
                                ( passedt.landuse == "commercial"         )  or
                                ( passedt.landuse == "brownfield"         )  or
                                ( passedt.landuse == "greenfield"         )  or
                                ( passedt.landuse == "construction"       )  or
                                ( passedt.landuse == "landfill"           )  or
                                ( passedt.landuse == "historic"           )  or
                                ( passedt.landuse == "orchard"            )  or
                                ( passedt.landuse == "meadowtransitional" )  or
                                ( passedt.landuse == "meadowwildflower"   )  or
                                ( passedt.landuse == "meadowperpetual"    )  or
                                ( passedt.landuse == "saltmarsh"          )  or
                                ( passedt.landuse == "reedbed"            )  or
                                ( passedt.landuse == "allotments"         )) then
                                Attribute( "name", Find( "name" ) )
                            end

                            MinZoom( 9 )
	                else
                            if (( passedt.landuse == "village_green"          ) or
                                ( passedt.landuse == "quarry"                 ) or
                                ( passedt.landuse == "unnamedquarry"          ) or
                                ( passedt.landuse == "historicquarry"         ) or
                                ( passedt.landuse == "unnamedhistoricquarry"  )) then
                                Layer( "land", true )
                                Attribute( "class", "landuse_" .. passedt.landuse )

                                if (( passedt.landuse == "village_green"  )  or
                                    ( passedt.landuse == "quarry"         )  or
                                    ( passedt.landuse == "historicquarry" )) then
                                    Attribute( "name", Find( "name" ) )
                                end

                                MinZoom( 10 )
	                    else
                                if ( passedt.landuse == "garages" ) then
                                    Layer( "land", true )
                                    Attribute( "class", "landuse_" .. passedt.landuse )
                                    Attribute( "name", Find( "name" ) )
                                    MinZoom( 11 )
	                        else
                                    if ( passedt.landuse == "vineyard" ) then
                                        Layer( "land", true )
                                        Attribute( "class", "landuse_" .. passedt.landuse )
                                        Attribute( "name", Find( "name" ) )
                                        MinZoom( 12 )
	                            else
                                        render_leisure_function( passedt )
	                            end -- landuse=vineyard 12
	                        end -- landuse=garages 11
	                    end -- landuse=village_green 10
	                end -- landuse=grass etc. 9
                    end -- landuse=forest 8
                end -- tourism
            end -- shop
        end -- place
    end -- amenity
end -- generic_after_function()

function render_leisure_function( passedt )
    if ( passedt.leisure == "common" ) then
        Layer( "land", true )
        Attribute( "class", "leisure_" .. passedt.leisure )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
    else
        if (( passedt.leisure == "nature_reserve" ) or
            ( passedt.leisure == "garden"         )) then
            Layer( "land", true )
            Attribute( "class", "leisure_" .. passedt.leisure )
            Attribute( "name", Find( "name" ) )
            MinZoom( 10 )
        else
            if ( passedt.leisure == "swimming_pool" ) then
                Layer( "land", true )
                Attribute( "class", "leisure_" .. passedt.leisure )
                Attribute( "name", Find( "name" ) )
                MinZoom( 13 )
            end -- leisure=swimming_pool etc. 13
        end -- leisure=nature_reserve etc. 10
    end -- leisure=common 9
end -- render_leisure_function()
