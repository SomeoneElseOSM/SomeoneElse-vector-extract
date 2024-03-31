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

-- Similarly for ways

function way_function(way)
	local highway = way:Find("highway")
	local verge = way:Find("verge")
	local waterway = way:Find("waterway")
	local building = way:Find("building")

	if highway~="" then
	    way:Layer("transportation", false)
	    way:Attribute("class", highway)

	    if (( verge == "both"     ) or
                ( verge == "left"     ) or
                ( verge == "separate" ) or
                ( verge == "right"    ) or
                ( verge == "yes"      )) then
                way:Attribute("edge", "verge")
            end

--	    way:Attribute("id",way:Id())
--	    way:AttributeNumeric("area",37)
	end
	if waterway~="" then
		way:Layer("waterway", false)
		way:Attribute("class", waterway)
	end
	if building~="" then
		way:Layer("building", true)
	end
end
