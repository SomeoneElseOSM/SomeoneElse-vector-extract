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
    generic_before_function()

-- No node-specific code yet

    generic_after_function()
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
    generic_before_function()

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
    local highway = fix_corridors( Find("highway"), Find("layer"), Find("level") )

-- ----------------------------------------------------------------------------
-- Consolidate some rare highway types into ones we can display.
-- ----------------------------------------------------------------------------
    highway = process_golf_tracks( highway, Find("golf") )

-- ------------------------------------------------------------------------------
-- Which other tags do we need to look at to see if a highway way has a 
-- sidewalk or a verge?
-- ------------------------------------------------------------------------------
    local sidewalk = Find("sidewalk")
    local sidewalkCleft = Find("sidewalk:left")
    local sidewalkCright = Find("sidewalk:right")
    local sidewalkCboth = Find("sidewalk:both")
    local footway = Find("footway")
    local shoulder = Find("shoulder")
    local hard_shoulder = Find("hard_shoulder")
    local cycleway = Find("cycleway")
    local segregated = Find("segregated")

    local verge = Find("verge")

-- ------------------------------------------------------------------------------
-- Other tags
-- ------------------------------------------------------------------------------
    local waterway = Find("waterway")
    local building = Find("building")

-- ----------------------------------------------------------------------------
-- highway processing
-- ----------------------------------------------------------------------------
    if ( highway ~= "" ) then
        Layer("transportation", false)

-- ----------------------------------------------------------------------------
-- Some highway types are temporarily rewritten to "catch all"s of 
-- "pathnarrow" and "pathwide", before designation processing is added.
-- Others are written through as the OSM highway type.
-- For roads, sidewalk / verge information is written to an "edge" value.
-- ----------------------------------------------------------------------------
        if (( highway == "path"      ) or
            ( highway == "footway"   ) or
            ( highway == "bridleway" ) or
            ( highway == "cycleway"  ) or
            ( highway == "steps"     )) then
            Attribute( "class", "pathnarrow" )
        else
	    if ( highway == "track" ) then
                Attribute( "class", "pathwide" )
            else
                Attribute( "class", highway )
            end
        end

-- ----------------------------------------------------------------------------
-- If there is a sidewalk, set "edge" to "sidewalk"
-- ----------------------------------------------------------------------------
        if (( sidewalk == "both"            ) or 
            ( sidewalk == "left"            ) or 
            ( sidewalk == "mapped"          ) or 
            ( sidewalk == "separate"        ) or 
            ( sidewalk == "right"           ) or 
            ( sidewalk == "shared"          ) or 
            ( sidewalk == "yes"             ) or
            ( sidewalkCboth == "separate"   ) or 
            ( sidewalkCboth == "yes"        ) or
            ( sidewalkCleft == "separate"   ) or 
            ( sidewalkCleft == "segregated" ) or
            ( sidewalkCleft == "yes"        ) or
            ( sidewalkCright == "separate"  ) or 
            ( sidewalkCright == "yes"       ) or
            ( footway  == "separate"        ) or 
            ( footway  == "yes"             ) or
            ( shoulder == "both"            ) or
            ( shoulder == "left"            ) or 
            ( shoulder == "right"           ) or 
            ( shoulder == "yes"             ) or
            ( hard_shoulder == "yes"        ) or
            ( cycleway == "track"           ) or
            ( cycleway == "opposite_track"  ) or
            ( cycleway == "yes"             ) or
            ( cycleway == "separate"        ) or
            ( cycleway == "sidewalk"        ) or
            ( cycleway == "sidepath"        ) or
            ( cycleway == "segregated"      ) or
            ( segregated == "yes"           ) or
            ( segregated == "right"         )) then
            Attribute("edge", "sidewalk")
        else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk but there is a verge, set "edge" to "verge"
-- ----------------------------------------------------------------------------
            if (( verge == "both"     ) or
                ( verge == "left"     ) or
                ( verge == "separate" ) or
                ( verge == "right"    ) or
                ( verge == "yes"      )) then
                Attribute("edge", "verge")
            end
        end
    end

-- ----------------------------------------------------------------------------
-- Other processing - still to be added
-- ----------------------------------------------------------------------------
    if waterway~="" then
        Layer("waterway", false)
        Attribute("class", waterway)
    end

    if building~="" then
        Layer("building", true)
    end

    generic_after_function()
end -- way_function()


-- ------------------------------------------------------------------------------
-- Generic code called for both nodes and ways.
-- "_before_" is called before any node or way specific code, "_after_" after.
-- For methods available, see
-- https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md#principal-lua-functions
-- ------------------------------------------------------------------------------
function generic_before_function()
-- ----------------------------------------------------------------------------
-- Invalid layer values - change them to something plausible.
-- ----------------------------------------------------------------------------
    Attribute( "layer", fix_invalid_layer_values( Find("layer"), Find("bridge"), Find("embankment") ))

-- ----------------------------------------------------------------------------
-- Treat "was:" as "disused:"
-- ----------------------------------------------------------------------------
   if (( Find("was:amenity")     ~= nil ) and
       ( Find("disused:amenity") == nil )) then
      Attribute( "disused:amenity", Find( "was:amenity" ))
   end

   if (( Find("was:waterway")     ~= nil ) and
       ( Find("disused:waterway") == nil )) then
      Attribute( "disused:waterway", Find( "was:waterway" ))
   end

   if (( Find("was:railway")     ~= nil ) and
       ( Find("disused:railway") == nil )) then
      Attribute( "disused:railway", Find( "was:railway" ))
   end

   if (( Find("was:aeroway")     ~= nil ) and
       ( Find("disused:aeroway") == nil )) then
      Attribute( "disused:aeroway", Find( "was:aeroway" ))
   end

   if (( Find("was:landuse")     ~= nil ) and
       ( Find("disused:landuse") == nil )) then
      Attribute( "disused:landuse", Find( "was:landuse" ))
   end

   if (( Find("was:shop")     ~= nil ) and
       ( Find("disused:shop") == nil )) then
      Attribute( "disused:shop", Find( "was:shop" ))
   end

-- ----------------------------------------------------------------------------
-- Treat "closed:" as "disused:" in some cases too.
-- ----------------------------------------------------------------------------
   if (( Find("closed:amenity")  ~= nil ) and
       ( Find("disused:amenity") == nil )) then
      Attribute( "disused:amenity", Find( "closed:amenity" ))
   end

   if (( Find("closed:shop")  ~= nil ) and
       ( Find("disused:shop") == nil )) then
      Attribute( "disused:shop", Find( "closed:shop" ))
   end

-- ----------------------------------------------------------------------------
-- Treat "status=abandoned" as "disused=yes"
-- ----------------------------------------------------------------------------
   if ( Find("status") == "abandoned" ) then
      Attribute( "disused", "yes" )
   end

-- ----------------------------------------------------------------------------
-- If there are different names on each side of the street, we create one name
-- containing both.
-- If "name" does not exist but "name:en" does, use that.
-- ----------------------------------------------------------------------------
   Attribute( "name", set_name_left_right_en( Find("name"), Find("name:left"), Find("name:right"), Find("name:en") ))

-- ----------------------------------------------------------------------------
-- Move refs to consider as "official" to official_ref
-- ----------------------------------------------------------------------------
   Attribute( "official_ref", set_official_ref( Find("official_ref"), Find("highway_authority_ref"), Find("highway_ref"), Find("admin_ref"), Find("admin:ref"), Find("loc_ref"), Find("ref") ))

-- ----------------------------------------------------------------------------
-- "Sabristas" sometimes add dubious names to motorway junctions.  Don't show
-- them if they're not signed.
-- ----------------------------------------------------------------------------
   Attribute( "name", suppress_unsigned_motorway_junctions( Find("name"), Find("highway"), Find("name:signed"), Find("name:absent"), Find("unsigned") ))

-- ----------------------------------------------------------------------------
-- Move unsigned road refs to the name, in brackets.
-- ----------------------------------------------------------------------------
   t = { Find("name"), Find("highway"), Find("name:signed"), Find("name:absent"), Find("official_ref"), Find("ref"), Find("ref:signed"), Find("unsigned") }
   suppress_unsigned_road_refs( t )

   if ( t[1] ~= nil ) then
      Attribute( "name", t[1] )
   end

   if ( t[2] ~= nil ) then
      Attribute( "highway", t[2] )
   end

   if ( t[3] ~= nil ) then
      Attribute( "name:signed", t[3] )
   end

   if ( t[4] ~= nil ) then
      Attribute( "name:absent", t[4] )
   end

   if ( t[5] ~= nil ) then
      Attribute( "official_ref", t[5] )
   end

   if ( t[6] ~= nil ) then
      Attribute( "ref", t[6] )
   end

   if ( t[7] ~= nil ) then
      Attribute( "ref:signed", t[7] )
   end

   if ( t[8] ~= nil ) then
      Attribute( "unsigned", t[8] )
   end

-- ----------------------------------------------------------------------------
-- Handle place=islet as place=island
-- Handle place=quarter
-- Handle natural=cape etc. as place=locality if no other place tag.
-- ----------------------------------------------------------------------------
   Attribute( "place", consolidate_place( Find("place"), Find("natural") ))

end -- generic_before_function()


function generic_after_function()
    local amenity  = Find("amenity")
    local place = Find("place")
    local shop = Find("shop")
    local tourism  = Find("tourism")

    if ( amenity ~= "" ) then
        LayerAsCentroid( "poi" )
	Attribute( "class","amenity_" .. amenity )
	Attribute( "name", Find( "name" ))
    else
        if ( place ~= "" ) then
            LayerAsCentroid( "place" )
    	    Attribute( "name", Find( "name" ))

            if (( place == "country" ) or
                ( place == "state"   )) then
                MinZoom( 5 )
            else
                if ( place == "city" ) then
                    MinZoom( 5 )
                else
                    if ( place == "town" ) then
                        MinZoom( 8 )
                    else
                        if (( place == "suburb"  ) or
                            ( place == "village" )) then
                            MinZoom( 11 )
                        else
                            if (( place == "hamlet"            ) or
                                ( place == "locality"          ) or
                                ( place == "neighbourhood"     ) or
                                ( place == "isolated_dwelling" ) or
                                ( place == "farm"              )) then
                                MinZoom( 13 )
                            else
                                MinZoom( 14 )
                            end -- hamlet
                        end -- suburb
                    end -- town
                end -- city
            end --country
	else -- place
            if ( shop ~= "" ) then
                LayerAsCentroid( "poi" )
    	        Attribute( "class","shop_" .. shop )
    	        Attribute( "name", Find( "name" ))
	    else
                if ( tourism ~= "" ) then
                    LayerAsCentroid( "poi" )
            	Attribute( "class","tourism_" .. tourism )
            	Attribute( "name", Find( "name" ))
                end -- tourism
            end -- shop
        end -- place
    end -- amenity
end -- generic_after_function()
