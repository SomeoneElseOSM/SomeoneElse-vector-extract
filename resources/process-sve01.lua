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

-- ----------------------------------------------------------------------------
-- Some highway types are temporarily rewritten to "catch all"s of 
-- "pathnarrow" and "pathwide", before designation processing is added.
-- Others are written through as the OSM highway type.
-- For roads, sidewalk / verge information is written to an "edge" value.
-- ----------------------------------------------------------------------------
        if (( wayt.highway == "path"      ) or
            ( wayt.highway == "footway"   ) or
            ( wayt.highway == "bridleway" ) or
            ( wayt.highway == "cycleway"  ) or
            ( wayt.highway == "steps"     )) then
            Attribute( "class", "pathnarrow" )
        else
	    if ( wayt.highway == "track" ) then
                Attribute( "class", "pathwide" )
            else
                Attribute( "class", wayt.highway )
            end
        end

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
            ( wayt.sidewalkCleft == "separate"   ) or 
            ( wayt.sidewalkCleft == "segregated" ) or
            ( wayt.sidewalkCleft == "yes"        ) or
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
            end
        end
    end

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

   if ((  passedt.trail_visibility == "intermediate"  )  or
       (  passedt.trail_visibility == "intermittent"  )  or
       (  passedt.trail_visibility == "indistinct"    )  or
       (  passedt.trail_visibility == "medium"        )  or
       (  passedt.trail_visibility == "low"           )  or
       (  passedt.overgrown        == "yes"           )  or
       (  passedt.obstacle         == "vegetation"    )  or
       (( passedt.trail_visibility == nil            )   and
        ( passedt.informal         == "yes"          ))) then
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

end -- generic_before_function()


function generic_after_function( passedt )
    if (( passedt.amenity ~= ""  ) and
        ( passedt.amenity ~= nil )) then
        LayerAsCentroid( "poi" )
	Attribute( "class","amenity_" .. passedt.amenity )
	Attribute( "name", Find( "name" ))
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
    	        Attribute( "name", Find( "name" ))
	    else
                if (( passedt.tourism ~= ""  ) and
                    ( passedt.tourism ~= nil )) then
                    LayerAsCentroid( "poi" )
            	Attribute( "class","tourism_" .. passedt.tourism )
            	Attribute( "name", Find( "name" ))
                end -- tourism
            end -- shop
        end -- place
    end -- amenity
end -- generic_after_function()
