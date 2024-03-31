-- Nodes will only be processed if one of these keys is present

node_keys = { "amenity", "shop" }

-- Initialize Lua logic

function init_function()
end

-- Finalize Lua logic()
function exit_function()
end

-- Assign nodes to a layer, and set attributes, based on OSM tags

function node_function(node)
	local amenity = node:Find("amenity")
	local shop = node:Find("shop")
	if amenity~="" or shop~="" then
		node:Layer("poi", false)
		if amenity~="" then node:Attribute("class","amenity_" .. amenity)
		else node:Attribute("class","shop_" .. shop) end
		node:Attribute("name", node:Find("name"))
	end
end

-- ------------------------------------------------------------------------------
-- Main entry point for processing ways
-- ------------------------------------------------------------------------------
function way_function(way)
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

	if ( highway ~= "" ) then
	    way:Layer("transportation", false)
	    way:Attribute("class", highway)

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
end
