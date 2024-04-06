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
node_keys = { "amenity", "shop", "tourism" }

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
function node_function( node )
    generic_before_function( node )

-- No node-specific code yet

    generic_after_function( node )
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
function way_function(way)
    generic_before_function( way )

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
    local highway = fix_corridors( way:Find("highway"), way:Find("layer"), way:Find("level") )

-- ----------------------------------------------------------------------------
-- Consolidate some rare highway types into ones we can display.
-- ----------------------------------------------------------------------------
    highway = process_golf_tracks( highway, way:Find("golf") )

-- ------------------------------------------------------------------------------
-- Which other tags do we need to look at to see if a highway way has a 
-- sidewalk or a verge?
-- ------------------------------------------------------------------------------
    local sidewalk = way:Find("sidewalk")
    local sidewalkCleft = way:Find("sidewalk:left")
    local sidewalkCright = way:Find("sidewalk:right")
    local sidewalkCboth = way:Find("sidewalk:both")
    local footway = way:Find("footway")
    local shoulder = way:Find("shoulder")
    local hard_shoulder = way:Find("hard_shoulder")
    local hardshoulder = way:Find("hardshoulder")
    local cycleway = way:Find("cycleway")
    local segregated = way:Find("segregated")

    local verge = way:Find("verge")

-- ------------------------------------------------------------------------------
-- Other tags
-- ------------------------------------------------------------------------------
    local waterway = way:Find("waterway")
    local building = way:Find("building")

-- ----------------------------------------------------------------------------
-- highway processing
-- ----------------------------------------------------------------------------
    if ( highway ~= "" ) then
        way:Layer("transportation", false)

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
            way:Attribute( "class", "pathnarrow" )
        else
	    if ( highway == "track" ) then
                way:Attribute( "class", "pathwide" )
            else
                way:Attribute( "class", highway )
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
            ( hardshoulder  == "yes"        ) or
            ( cycleway == "track"           ) or
            ( cycleway == "opposite_track"  ) or
            ( cycleway == "yes"             ) or
            ( cycleway == "separate"        ) or
            ( cycleway == "sidewalk"        ) or
            ( cycleway == "sidepath"        ) or
            ( cycleway == "segregated"      ) or
            ( segregated == "yes"           ) or
            ( segregated == "right"         )) then
            way:Attribute("edge", "sidewalk")
        else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk but there is a verge, set "edge" to "verge"
-- ----------------------------------------------------------------------------
            if (( verge == "both"     ) or
                ( verge == "left"     ) or
                ( verge == "separate" ) or
                ( verge == "right"    ) or
                ( verge == "yes"      )) then
                way:Attribute("edge", "verge")
            end
        end
    end

-- ----------------------------------------------------------------------------
-- Other processing - still to be added
-- ----------------------------------------------------------------------------
    if waterway~="" then
        way:Layer("waterway", false)
        way:Attribute("class", waterway)
    end

    if building~="" then
        way:Layer("building", true)
    end

    generic_after_function( way )
end -- way_function()


-- ------------------------------------------------------------------------------
-- Generic code called for both nodes and ways.
-- "_before_" is called before any node or way specific code, "_after_" after.
-- For methods available with passed_obj, see
-- https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md#principal-lua-functions
-- ------------------------------------------------------------------------------
function generic_before_function( passed_obj )
-- ----------------------------------------------------------------------------
-- Invalid layer values - change them to something plausible.
-- ----------------------------------------------------------------------------
    passed_obj:Attribute( "layer", fix_invalid_layer_values( passed_obj:Find("layer"), passed_obj:Find("bridge"), passed_obj:Find("embankment") ))

-- ----------------------------------------------------------------------------
-- Treat "was:" as "disused:"
-- ----------------------------------------------------------------------------
   if (( passed_obj:Find("was:amenity")     ~= nil ) and
       ( passed_obj:Find("disused:amenity") == nil )) then
      passed_obj:Attribute( "disused:amenity", passed_obj:Find( "was:amenity" ))
   end

   if (( passed_obj:Find("was:waterway")     ~= nil ) and
       ( passed_obj:Find("disused:waterway") == nil )) then
      passed_obj:Attribute( "disused:waterway", passed_obj:Find( "was:waterway" ))
   end

   if (( passed_obj:Find("was:railway")     ~= nil ) and
       ( passed_obj:Find("disused:railway") == nil )) then
      passed_obj:Attribute( "disused:railway", passed_obj:Find( "was:railway" ))
   end

   if (( passed_obj:Find("was:aeroway")     ~= nil ) and
       ( passed_obj:Find("disused:aeroway") == nil )) then
      passed_obj:Attribute( "disused:aeroway", passed_obj:Find( "was:aeroway" ))
   end

   if (( passed_obj:Find("was:landuse")     ~= nil ) and
       ( passed_obj:Find("disused:landuse") == nil )) then
      passed_obj:Attribute( "disused:landuse", passed_obj:Find( "was:landuse" ))
   end

   if (( passed_obj:Find("was:shop")     ~= nil ) and
       ( passed_obj:Find("disused:shop") == nil )) then
      passed_obj:Attribute( "disused:shop", passed_obj:Find( "was:shop" ))
   end

-- ----------------------------------------------------------------------------
-- Treat "closed:" as "disused:" in some cases too.
-- ----------------------------------------------------------------------------
   if (( passed_obj:Find("closed:amenity")  ~= nil ) and
       ( passed_obj:Find("disused:amenity") == nil )) then
      passed_obj:Attribute( "disused:amenity", passed_obj:Find( "closed:amenity" ))
   end

   if (( passed_obj:Find("closed:shop")  ~= nil ) and
       ( passed_obj:Find("disused:shop") == nil )) then
      passed_obj:Attribute( "disused:shop", passed_obj:Find( "closed:shop" ))
   end

-- ----------------------------------------------------------------------------
-- Treat "status=abandoned" as "disused=yes"
-- ----------------------------------------------------------------------------
   if ( passed_obj:Find("status") == "abandoned" ) then
      passed_obj:Attribute( "disused", "yes" )
   end

-- ----------------------------------------------------------------------------
-- If there are different names on each side of the street, we create one name
-- containing both.
-- If "name" does not exist but "name:en" does, use that.
-- ----------------------------------------------------------------------------
   passed_obj:Attribute( "name", set_name_left_right_en( passed_obj:Find("name"), passed_obj:Find("name:left"), passed_obj:Find("name:right"), passed_obj:Find("name:en") ))

-- ----------------------------------------------------------------------------
-- Move refs to consider as "official" to official_ref
-- ----------------------------------------------------------------------------
   passed_obj:Attribute( "official_ref", set_official_ref( passed_obj:Find("official_ref"), passed_obj:Find("highway_authority_ref"), passed_obj:Find("highway_ref"), passed_obj:Find("admin_ref"), passed_obj:Find("admin:ref"), passed_obj:Find("loc_ref"), passed_obj:Find("ref") ))

end -- generic_before_function()


function generic_after_function( passed_obj )
    local amenity  = passed_obj:Find("amenity")
    local shop = passed_obj:Find("shop")
    local tourism  = passed_obj:Find("tourism")

    if ( amenity ~= "" ) then
        passed_obj:LayerAsCentroid( "poi" )
	passed_obj:Attribute( "class","amenity_" .. amenity )
	passed_obj:Attribute( "name", passed_obj:Find( "name" ))
    else
        if ( shop ~= "" ) then
            passed_obj:LayerAsCentroid( "poi" )
    	    passed_obj:Attribute( "class","shop_" .. shop )
    	    passed_obj:Attribute( "name", passed_obj:Find( "name" ))
	else
            if ( tourism ~= "" ) then
                passed_obj:LayerAsCentroid( "poi" )
        	passed_obj:Attribute( "class","tourism_" .. tourism )
        	passed_obj:Attribute( "name", passed_obj:Find( "name" ))
            end -- tourism
        end -- shop
    end -- amenity
end -- generic_after_function()
