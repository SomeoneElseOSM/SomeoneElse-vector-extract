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
-- ------------------------------------------------------------------------------
function node_function( node )
-- No node-specific code yet

    generic_function( node )
end -- node_function()

-- ------------------------------------------------------------------------------
-- Main entry point for processing ways
-- ------------------------------------------------------------------------------
function way_function(way)
-- ----------------------------------------------------------------------------
-- Invalid layer values - change them to something plausible.
-- ----------------------------------------------------------------------------
    way:Attribute( "layer", fix_invalid_layer_values( way:Find("layer"), way:Find("bridge"), way:Find("embankment") ))

    local highway = way:Find("highway")

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

    generic_function( way )
end -- way_function()

-- ------------------------------------------------------------------------------
-- Generic code called for both nodes and ways.
-- ------------------------------------------------------------------------------
function generic_function( passed_obj )
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
end -- generic_function()
