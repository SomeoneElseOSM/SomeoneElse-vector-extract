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
node_keys = { "amenity", "attraction", "climbing", "emergency", "entrance", "healthcare", 
              "landuse", "leisure", "natural", "pitch", "place", "place_of_worship", "playground", 
              "power", "shop", "sport", "tourism", "zoo" }

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
    nodet.ruinsCbuilding = Find("ruins:building")
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
    nodet.power_source = Find("power_source")
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
    nodet.basin = Find("basin")
    nodet.flood_prone = Find("flood_prone")
    nodet.hazard_prone = Find("hazard_prone")
    nodet.hazard_type = Find("hazard_type")
    nodet.fuelCelectricity = Find("fuel:electricity")
    nodet.fuelCdiesel = Find("fuel:diesel")
    nodet.LPG = Find("LPG")
    nodet.fuelClpg = Find("fuel:lpg")
    nodet.fuelCH2 = Find("fuel:H2")
    nodet.fuelCLH2 = Find("fuel:LH2")
    nodet.railway = Find("railway")
    nodet.disusedCbuilding = Find("disused:building")
    nodet.buildingCtype = Find("building:type")
    nodet.watermillCdisused = Find("watermill:disused")
    nodet.windmillCdisused = Find("windmill:disused")
    nodet.defensive_works = Find("defensive_works")
    nodet.is_sidepath = Find("is_sidepath")
    nodet.is_sidepathCof = Find("is_sidepath:of")
    nodet.is_sidepathCofCname = Find("is_sidepath:of:name")
    nodet.is_sidepathCofCref = Find("is_sidepath:of:ref")
    nodet.recycling_type = Find("recycling_type")
    nodet.outlet = Find("outlet")
    nodet.covered = Find("covered")
    nodet.booth = Find("booth")
    nodet.telephone_kiosk = Find("telephone_kiosk")
    nodet.removedCamenity = Find("removed:amenity")
    nodet.abandonedCamenity = Find("abandoned:amenity")
    nodet.demolishedCamenity = Find("demolished:amenity")
    nodet.razedCamenity = Find("razed:amenity")
    nodet.old_amenity = Find("old_amenity")
    nodet.emergency = Find("emergency")
    nodet.colour = Find("colour")
    nodet.business = Find("business")
    nodet.office = Find("office")
    nodet.company = Find("company")
    nodet.craft = Find("craft")
    nodet.diplomatic = Find("diplomatic")
    nodet.embassy = Find("embassy")
    nodet.consulate = Find("consulate")
    nodet.peak = Find("peak")
    nodet.disusedCmilitary = Find("disused:military")
    nodet.geological = Find("geological")
    nodet.hunting_stand = Find("hunting_stand")
    nodet.harbour = Find("harbour")
    nodet.accommodation = Find("accommodation")
    nodet.cuisine = Find("cuisine")
    nodet.wheelchair = Find("wheelchair")
    nodet.outdoor_seating = Find("outdoor_seating")
    nodet.gate = Find("gate")
    nodet.locked = Find("locked")
    nodet.dog_gate = Find("dog_gate")
    nodet.entrance = Find("entrance")
    nodet.public_transport = Find("public_transport")
    nodet.school = Find("school")
    nodet.seamarkCrescue_stationCcategory = Find("seamark:rescue_station:category")
    nodet.healthcare = Find("healthcare")
    nodet.social_facility = Find("social_facility")
    nodet.club = Find("club")
    nodet.gambling = Find("gambling")
    nodet.danceCteaching = Find("dance:teaching")
    nodet.healthcareCspeciality = Find("healthcare:speciality")
    nodet.vending = Find("vending")
    nodet.vending_machine = Find("vending_machine")
    nodet.paymentChonesty_box = Find("payment:honesty_box")
    nodet.foodCeggs = Find("food:eggs")
    nodet.pitch = Find("pitch")
    nodet.ele = Find("ele")
    nodet.prominence = Find("prominence")
    nodet.bench = Find("bench")
    nodet.munro = Find("munro")
    nodet.location = Find("location")
    nodet.buildingCruins = Find("building:ruins")
    nodet.ruinedCbuilding = Find("ruined:building")
    nodet.species = Find("species")
    nodet.taxon = Find("taxon")
    nodet.lock_ref = Find("lock_ref")
    nodet.lock_name = Find("lock_name")
    nodet.bridgeCname = Find("bridge:name")
    nodet.bridge_name = Find("bridge_name")
    nodet.bridgeCref = Find("bridge:ref")
    nodet.canal_bridge_ref = Find("canal_bridge_ref")
    nodet.bridge_ref = Find("bridge_ref")
    nodet.tunnelCname = Find("tunnel:name")
    nodet.tunnel_name = Find("tunnel_name")
    nodet.tpuk_ref = Find("tpuk_ref")
    nodet.underground = Find("underground")
    nodet.generatorCsource = Find("generator:source")
    nodet.generatorCmethod = Find("generator:method")
    nodet.plantCsource = Find("plant:source")
    nodet.monitoringCwater_level = Find("monitoring:water_level")
    nodet.monitoringCwater_flow = Find("monitoring:water_flow")
    nodet.monitoringCwater_velocity = Find("monitoring:water_velocity")
    nodet.monitoringCweather = Find("monitoring:weather")
    nodet.weatherCradar = Find("weather:radar")
    nodet.monitoringCwater_level = Find("monitoring:water_level")
    nodet.monitoringCrainfall = Find("monitoring:rainfall")
    nodet.monitoringCseismic_activity = Find("monitoring:seismic_activity")
    nodet.monitoringCsky_brightness = Find("monitoring:sky_brightness")
    nodet.monitoringCair_quality = Find("monitoring:air_quality")
    nodet.usage = Find("usage")
    nodet.station = Find("station")
    nodet.railwayCminiature = Find("railway:miniature")
    nodet.crossing = Find("crossing")
    nodet.disusedCtourism = Find("disused:tourism")
    nodet.ruinsCtourism = Find("ruins:tourism")
    nodet.board_type = Find("board_type")
    nodet.information = Find("information")
    nodet.operatorCtype = Find("operator:type")
    nodet.boardCtitle = Find("board:title")
    nodet.guide_type = Find("guide_type")
    nodet.ncn_milepost = Find("ncn_milepost")
    nodet.sustrans_ref = Find("sustrans_ref")
    nodet.theatre = Find("theatre")
    nodet.fence_type = Find("fence_type")
    nodet.zero_waste = Find("zero_waste")
    nodet.bulk_purchase = Find("bulk_purchase")
    nodet.reusable_packaging = Find("reusable_packaging")
    nodet.trade = Find("trade")
    nodet.brand = Find("brand")

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
    wayt.power_source = Find("power_source")
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
    wayt.basin = Find("basin")
    wayt.flood_prone = Find("flood_prone")
    wayt.hazard_prone = Find("hazard_prone")
    wayt.hazard_type = Find("hazard_type")
    wayt.fuelCelectricity = Find("fuel:electricity")
    wayt.fuelCdiesel = Find("fuel:diesel")
    wayt.LPG = Find("LPG")
    wayt.fuelClpg = Find("fuel:lpg")
    wayt.fuelCH2 = Find("fuel:H2")
    wayt.fuelCLH2 = Find("fuel:LH2")
    wayt.railway = Find("railway")
    wayt.disusedCbuilding = Find("disused:building")
    wayt.buildingCtype = Find("building:type")
    wayt.watermillCdisused = Find("watermill:disused")
    wayt.windmillCdisused = Find("windmill:disused")
    wayt.defensive_works = Find("defensive_works")
    wayt.is_sidepath = Find("is_sidepath")
    wayt.is_sidepathCof = Find("is_sidepath:of")
    wayt.is_sidepathCofCname = Find("is_sidepath:of:name")
    wayt.is_sidepathCofCref = Find("is_sidepath:of:ref")
    wayt.recycling_type = Find("recycling_type")
    wayt.outlet = Find("outlet")
    wayt.covered = Find("covered")
    wayt.booth = Find("booth")
    wayt.telephone_kiosk = Find("telephone_kiosk")
    wayt.removedCamenity = Find("removed:amenity")
    wayt.abandonedCamenity = Find("abandoned:amenity")
    wayt.demolishedCamenity = Find("demolished:amenity")
    wayt.razedCamenity = Find("razed:amenity")
    wayt.old_amenity = Find("old_amenity")
    wayt.emergency = Find("emergency")
    wayt.colour = Find("colour")
    wayt.business = Find("business")
    wayt.office = Find("office")
    wayt.company = Find("company")
    wayt.craft = Find("craft")
    wayt.diplomatic = Find("diplomatic")
    wayt.embassy = Find("embassy")
    wayt.consulate = Find("consulate")
    wayt.peak = Find("peak")
    wayt.disusedCmilitary = Find("disused:military")
    wayt.geological = Find("geological")
    wayt.hunting_stand = Find("hunting_stand")
    wayt.harbour = Find("harbour")
    wayt.accommodation = Find("accommodation")
    wayt.cuisine = Find("cuisine")
    wayt.wheelchair = Find("wheelchair")
    wayt.outdoor_seating = Find("outdoor_seating")
    wayt.gate = Find("gate")
    wayt.locked = Find("locked")
    wayt.dog_gate = Find("dog_gate")
    wayt.entrance = Find("entrance")
    wayt.public_transport = Find("public_transport")
    wayt.school = Find("school")
    wayt.seamarkCrescue_stationCcategory = Find("seamark:rescue_station:category")
    wayt.healthcare = Find("healthcare")
    wayt.social_facility = Find("social_facility")
    wayt.club = Find("club")
    wayt.gambling = Find("gambling")
    wayt.danceCteaching = Find("dance:teaching")
    wayt.healthcareCspeciality = Find("healthcare:speciality")
    wayt.vending = Find("vending")
    wayt.vending_machine = Find("vending_machine")
    wayt.paymentChonesty_box = Find("payment:honesty_box")
    wayt.foodCeggs = Find("food:eggs")
    wayt.pitch = Find("pitch")
    wayt.ele = Find("ele")
    wayt.prominence = Find("prominence")
    wayt.bench = Find("bench")
    wayt.munro = Find("munro")
    wayt.location = Find("location")
    wayt.buildingCruins = Find("building:ruins")
    wayt.ruinedCbuilding = Find("ruined:building")
    wayt.species = Find("species")
    wayt.taxon = Find("taxon")
    wayt.lock_ref = Find("lock_ref")
    wayt.lock_name = Find("lock_name")
    wayt.bridgeCname = Find("bridge:name")
    wayt.bridge_name = Find("bridge_name")
    wayt.bridgeCref = Find("bridge:ref")
    wayt.canal_bridge_ref = Find("canal_bridge_ref")
    wayt.bridge_ref = Find("bridge_ref")
    wayt.tunnelCname = Find("tunnel:name")
    wayt.tunnel_name = Find("tunnel_name")
    wayt.tpuk_ref = Find("tpuk_ref")
    wayt.underground = Find("underground")
    wayt.generatorCsource = Find("generator:source")
    wayt.generatorCmethod = Find("generator:method")
    wayt.plantCsource = Find("plant:source")
    wayt.monitoringCwater_level = Find("monitoring:water_level")
    wayt.monitoringCwater_flow = Find("monitoring:water_flow")
    wayt.monitoringCwater_velocity = Find("monitoring:water_velocity")
    wayt.monitoringCweather = Find("monitoring:weather")
    wayt.weatherCradar = Find("weather:radar")
    wayt.monitoringCwater_level = Find("monitoring:water_level")
    wayt.monitoringCrainfall = Find("monitoring:rainfall")
    wayt.monitoringCseismic_activity = Find("monitoring:seismic_activity")
    wayt.monitoringCsky_brightness = Find("monitoring:sky_brightness")
    wayt.monitoringCair_quality = Find("monitoring:air_quality")
    wayt.usage = Find("usage")
    wayt.station = Find("station")
    wayt.railwayCminiature = Find("railway:miniature")
    wayt.crossing = Find("crossing")
    wayt.disusedCtourism = Find("disused:tourism")
    wayt.ruinsCtourism = Find("ruins:tourism")
    wayt.board_type = Find("board_type")
    wayt.information = Find("information")
    wayt.operatorCtype = Find("operator:type")
    wayt.boardCtitle = Find("board:title")
    wayt.guide_type = Find("guide_type")
    wayt.ncn_milepost = Find("ncn_milepost")
    wayt.sustrans_ref = Find("sustrans_ref")
    wayt.theatre = Find("theatre")
    wayt.fence_type = Find("fence_type")
    wayt.zero_waste = Find("zero_waste")
    wayt.bulk_purchase = Find("bulk_purchase")
    wayt.reusable_packaging = Find("reusable_packaging")
    wayt.trade = Find("trade")
    wayt.brand = Find("brand")

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

        if (( wayt.name ~= nil )   and
            ( wayt.name ~= ""  ))  then
	Attribute( "name", wayt.name )
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
-- Render bus guideways as "a sort of railway" rather than in their own
-- highway layer.
-- ----------------------------------------------------------------------------
   if (passedt.highway == "bus_guideway") then
      passedt.highway = nil
      passedt.railway = "bus_guideway"
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
-- Alleged petrol stations that only do fuel:electricity are probably 
-- actually charging stations.
--
-- The combination of "amenity=fuel, electricity, no diesel" is as good as
-- we can make  it without guessing based on brand.  "fuel, electricity,
-- some sort of petrol, no diesel" is not a thing in the UK/IE data currently.
-- Similarly, electric waterway=fuel are charging stations.
--
-- Show vending machines that sell petrol as fuel.
-- One UK/IE example, on an airfield, and "UL91" finds it.
--
-- Show aeroway=fuel as amenity=fuel.  All so far in UK/IE are 
-- general aviation.
--
-- Show waterway=fuel with a "fuel pump on a boat" icon.
--
-- Once we've got those out of the way, detect amenity=fuel that also sell
-- electricity, hydrogen and LPG.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity          == "fuel" ) and
       ( passedt.fuelCelectricity == "yes"  )  and
       ( passedt.fuelCdiesel      == nil    )) then
      passedt.amenity = "charging_station"
   end

   if (( passedt.waterway         == "fuel" ) and
       ( passedt.fuelCelectricity == "yes"  )) then
      passedt.amenity = "charging_station"
      passedt.waterway = nil
   end

   if (( passedt.amenity == "vending_machine" ) and
       ( passedt.vending == "fuel"            )  and
       ( passedt.fuel    == "UL91"            )) then
      passedt.amenity = "fuel"
   end

   if ( passedt.aeroway == "fuel" ) then
      passedt.aeroway = nil
      passedt.amenity = "fuel"
   end

   if ( passedt.waterway == "fuel" ) then
      passedt.amenity = "fuel_w"
      passedt.waterway = nil
   end

   if (( passedt.amenity          == "fuel" ) and
       ( passedt.fuelCelectricity == "yes"  )  and
       ( passedt.fuelCdiesel      == "yes"  )) then
      passedt.amenity = "fuel_e"
   end

   if ((  passedt.amenity  == "fuel"  ) and
       (( passedt.fuelCH2  == "yes"  )  or
        ( passedt.fuelCLH2 == "yes"  ))) then
      passedt.amenity = "fuel_h"
   end

   if ((  passedt.amenity  == "fuel"  ) and
       (( passedt.LPG      == "yes"  )  or
        ( passedt.fuel     == "lpg"  )  or
        ( passedt.fuelClpg == "yes"  ))) then
      passedt.amenity = "fuel_l"
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
-- Bridge structures - display as building=roof.
-- Also farmyard "bunker silos" and canopies, and natural arches.
-- Also railway traversers and more.
-- ----------------------------------------------------------------------------
   if ((    passedt.man_made         == "bridge"          ) or
       (    passedt.natural          == "arch"            ) or
       (    passedt.man_made         == "bunker_silo"     ) or
       (    passedt.amenity          == "feeding_place"   ) or
       (    passedt.railway          == "traverser"       ) or
       (    passedt.building         == "canopy"          ) or
       (    passedt.building         == "car_port"        ) or
       (((( passedt.disusedCbuilding ~= nil            )    and
          ( passedt.disusedCbuilding ~= ""             ))   or
         (  passedt.amenity          == "parcel_locker" )   or
         (  passedt.amenity          == "zooaviary"     )   or
         (  passedt.animal           == "horse_walker"  )   or
         (  passedt.leisure          == "bleachers"     )   or
         (  passedt.leisure          == "bandstand"     )) and
        ((  passedt.building         == nil             )  and
         (  passedt.building         == ""              ))) or
       (    passedt.buildingCtype    == "canopy"          ) or
       ((   passedt.covered          == "roof"           )  and
        ((  passedt.building         == nil             )   or
         (  passedt.building         == ""              ))  and
        ((  passedt.highway          == nil             )   or
         (  passedt.highway          == ""              ))  and
        ((  passedt.tourism          == nil             )   or
         (  passedt.tourism          == ""              )))) then
      passedt.building      = "roof"
      passedt.buildingCtype = nil
   end

-- ----------------------------------------------------------------------------
-- Ensure that allegedly operational windmills are treated as such and not as
-- "historic".
-- ----------------------------------------------------------------------------
   if (( passedt.man_made == "watermill") or
       ( passedt.man_made == "windmill" )) then
      if (( passedt.disused           == "yes"  ) or
          ( passedt.watermillCdisused == "yes"  ) or
          ( passedt.windmillCdisused  == "yes"  )) then
         passedt.historic = passedt.man_made
         passedt.man_made = nil
      else
         passedt.historic = nil
      end
   end

   if ((( passedt.disusedCman_made == "watermill")  or
        ( passedt.disusedCman_made == "windmill" )) and
       (( passedt.amenity          == nil        )  or
        ( passedt.amenity          == ""         )) and
       (( passedt.man_made         == nil        )  or
        ( passedt.man_made         == ""         )) and
       (( passedt.shop             == nil        )  or
        ( passedt.shop             == ""         ))) then
      passedt.historic = passedt.disusedCman_made
      passedt.disusedCman_made = nil
   end

-- ----------------------------------------------------------------------------
-- Render (windmill buildings and former windmills) that are not something 
-- else as historic windmills.
-- ----------------------------------------------------------------------------
   if ((  passedt.historic == "ruins"      ) and
       (( passedt.ruins    == "watermill" )  or
        ( passedt.ruins    == "windmill"  ))) then
      passedt.historic = passedt.ruins
      passedt.ruins = "yes"
   end

   if (((   passedt.building == "watermill"        )  or
        (   passedt.building == "former_watermill" )) and
       (((  passedt.amenity  == nil                )  or
         (  passedt.amenity  == ""                 )) and
        ((  passedt.man_made == nil                )  or
         (  passedt.man_made == ""                 )) and
        ((  passedt.historic == nil                )  or
         (  passedt.historic == ""                 )  or
         (  passedt.historic == "restoration"      )  or
         (  passedt.historic == "heritage"         )  or
         (  passedt.historic == "industrial"       )  or
         (  passedt.historic == "tower"            )))) then
      passedt.historic = "watermill"
   end

   if (((   passedt.building == "windmill"        )  or
        (   passedt.building == "former_windmill" )) and
       (((  passedt.amenity  == nil               )  or
         (  passedt.amenity  == ""                )) and
        ((  passedt.man_made == nil               )  or
         (  passedt.man_made == ""                )) and
        ((  passedt.historic == nil               )  or
         (  passedt.historic == ""                )  or
         (  passedt.historic == "restoration"     )  or
         (  passedt.historic == "heritage"        )  or
         (  passedt.historic == "industrial"      )  or
         (  passedt.historic == "tower"           )))) then
      passedt.historic = "windmill"
   end

-- ----------------------------------------------------------------------------
-- Render ruined mills and mines etc. that are not something else as historic.
-- Items in this list are assumed to be not operational, so the "man_made" 
-- tag is cleared.
-- ----------------------------------------------------------------------------
   if (( passedt.historic  == "ruins"        ) and
       (( passedt.ruins    == "lime_kiln"   )  or
        ( passedt.ruins    == "manor"       )  or
        ( passedt.ruins    == "mill"        )  or
        ( passedt.ruins    == "mine"        )  or
        ( passedt.ruins    == "round_tower" )  or
        ( passedt.ruins    == "village"     )  or
        ( passedt.ruins    == "well"        ))) then
      passedt.historic = passedt.ruins
      passedt.ruins = "yes"
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- We can assume that any allegedly non-historic ice_houses are actually 
-- historic.  Any coexisting historic keys will just be stuff like "building".
-- ----------------------------------------------------------------------------
   if ( passedt.man_made == "ice_house" ) then
      passedt.historic = "ice_house"
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Sound mirrors
-- ----------------------------------------------------------------------------
   if ( passedt.man_made == "sound mirror" ) then

      if ( passedt.historic == "ruins" ) then
         passedt.ruins = "yes"
      end

      passedt.historic = "sound_mirror"
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Specific defensive_works not mapped as something else
-- ----------------------------------------------------------------------------
   if ((  passedt.defensive_works == "battery"  ) and
       (( passedt.barrier         == nil       )  or
        ( passedt.barrier         == ""        )) and
       (( passedt.building        == nil       )  or
        ( passedt.building        == ""        )) and
       (( passedt.historic        == nil       )  or
        ( passedt.historic        == ""        )) and
       (( passedt.landuse         == nil       )  or
        ( passedt.landuse         == ""        )) and
       (( passedt.man_made        == nil       )  or
        ( passedt.man_made        == ""        )) and
       (( passedt.place           == nil       )  or
        ( passedt.place           == ""        ))) then
      passedt.historic = "battery"
      passedt.defensive_works = nil
   end

-- ----------------------------------------------------------------------------
-- Remove name from footway=sidewalk (we expect it to be rendered via the
-- road that this is a sidewalk for), or "is_sidepath=yes" etc.
-- ----------------------------------------------------------------------------
   if ((( passedt.footway             == "sidewalk" )  or
        ( passedt.cycleway            == "sidewalk" )  or
        ( passedt.is_sidepath         == "yes"      )  or
        ( passedt.is_sidepathCof      ~= nil        )  or
        ( passedt.is_sidepathCof      ~= ""         )  or
        ( passedt.is_sidepathCofCname ~= nil        )  or
        ( passedt.is_sidepathCofCname ~= ""         )  or
        ( passedt.is_sidepathCofCref  ~= nil        )  or
        ( passedt.is_sidepathCofCref  ~= ""         )) and
       (( passedt.name                ~= nil        )  or
        ( passedt.name                ~= ""         ))) then
      passedt.name = nil
   end

-- ----------------------------------------------------------------------------
-- Waste transfer stations
-- First, try and identify mistagged ones.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "waste_transfer_station" ) and
       ( passedt.recycling_type == "centre"          )) then
      passedt.amenity = "recyclingcentre"
      passedt.landuse = "industrial"
   end

-- ----------------------------------------------------------------------------
-- Next, treat "real" waste transfer stations as industrial.  We remove the 
-- amenity tag here because there's no icon for amenity=waste_transfer_station;
-- an amenity tag would see it treated as landuse=unnamedcommercial with the
-- amenity tag bringing the name (which it won't here).  The "industrial" tag
-- forces it through the brand/operator logic.
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "waste_transfer_station" ) then
      passedt.amenity = nil
      passedt.landuse = "industrial"
      passedt.industrial = "waste_transfer_station"
   end

-- ----------------------------------------------------------------------------
-- Recycling bins and recycling centres.
-- Recycling bins are only shown from z19.  Recycling centres are shown from
-- z16 and have a characteristic icon.  Any object without recycling_type, or
-- with a different value, is assumed to be a bin, apart from one rogue
-- "scrap_yard".
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "recycling"         ) and
       ( passedt.recycling_type == "scrap_yard" )) then
         passedt.amenity = "scrapyard"
   end

   if ( passedt.amenity == "recycling" ) then
      if ( passedt.recycling_type == "centre" ) then
         passedt.amenity = "recyclingcentre"
         passedt.landuse = "industrial"
      end
   end

-- ----------------------------------------------------------------------------
-- Mistaggings for wastewater_plant
-- ----------------------------------------------------------------------------
   if (( passedt.man_made   == "sewage_works"      ) or
       ( passedt.man_made   == "wastewater_works"  )) then
      passedt.man_made = "wastewater_plant"
   end

-- ----------------------------------------------------------------------------
-- Outfalls, sewage and otherwise.  We process "man_made=outfall", but also
-- catch outlets not tagged with that.
-- ----------------------------------------------------------------------------
   if (( passedt.outlet ~= nil  ) and
       ( passedt.outlet ~= ""   ) and
       ( passedt.outlet ~= "no" )) then
      passedt.man_made = "outfall"
   end

-- ----------------------------------------------------------------------------
-- Electricity substations
-- ----------------------------------------------------------------------------
   if (( passedt.power == "substation"  )  or
       ( passedt.power == "sub_station" )) then
      passedt.power   = nil

      if (( passedt.building == nil  ) or
          ( passedt.building == ""   ) or
          ( passedt.building == "no" )) then
         passedt.landuse = "industrial"
      else
         passedt.building = "yes"
         passedt.landuse = "industrialbuilding"
      end

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = "(el.sub.)"
      else
         passedt.name = passedt.name .. " (el.sub.)"
      end
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
-- Former telephone boxes
-- ----------------------------------------------------------------------------
   if ((( passedt.covered         == "booth"          )   and
        ( passedt.booth           ~= "K1"             )   and
        ( passedt.booth           ~= "KX100"          )   and
        ( passedt.booth           ~= "KX200"          )   and
        ( passedt.booth           ~= "KX300"          )   and
        ( passedt.booth           ~= "KXPlus"         )   and
        ( passedt.booth           ~= "KX410"          )   and
        ( passedt.booth           ~= "KX420"          )   and
        ( passedt.booth           ~= "KX520"          )   and
        ( passedt.booth           ~= "oakham"         )   and
        ( passedt.booth           ~= "ST6"            ))  or
       (  passedt.booth           == "K2"              )  or
       (  passedt.booth           == "K4 Post Office"  )  or
       (  passedt.booth           == "K6"              )  or
       (  passedt.booth           == "K8"              )  or
       (  passedt.telephone_kiosk == "K6"              )  or
       (  passedt.man_made        == "telephone_box"   )  or
       (  passedt.building        == "telephone_box"   )  or
       (  passedt.historic        == "telephone"       )  or
       (  passedt.disusedCamenity == "telephone"       )  or
       (  passedt.removedCamenity == "telephone"       )) then
      if ((( passedt.amenity   == "telephone"    )  or
           ( passedt.amenity   == "phone"        )) and
          (  passedt.emergency ~= "defibrillator" ) and
          (  passedt.emergency ~= "phone"         ) and
          (  passedt.tourism   ~= "information"   ) and
          (  passedt.tourism   ~= "artwork"       ) and
          (  passedt.tourism   ~= "museum"        )) then
	 if ( passedt.colour == "black" ) then
            passedt.amenity = "boothtelephoneblack"
	 else
	    if (( passedt.colour == "white" ) or
	        ( passedt.colour == "cream" )) then
               passedt.amenity = "boothtelephonewhite"
	    else
    	       if ( passedt.colour == "blue" ) then
                  passedt.amenity = "boothtelephoneblue"
	       else
    	          if ( passedt.colour == "green" ) then
                     passedt.amenity = "boothtelephonegreen"
		  else
    	             if ( passedt.colour == "grey" ) then
                        passedt.amenity = "boothtelephonegrey"
		     else
    	                if ( passedt.colour == "gold" ) then
                           passedt.amenity = "boothtelephonegold"
			else
                           passedt.amenity = "boothtelephonered"
			end
		     end
		  end
	       end
	    end
	 end
	    
         passedt.tourism = nil
         passedt.emergency = nil
      else
         if ( passedt.emergency == "defibrillator" ) then
             passedt.amenity   = "boothdefibrillator"
             passedt.disusedCamenity = nil
             passedt.emergency = nil
         else
            if (( passedt.amenity == "public_bookcase" )  or
                ( passedt.amenity == "library"         )) then
               passedt.amenity = "boothlibrary"
               passedt.disusedCamenity = nil
            else
               if ( passedt.amenity == "bicycle_repair_station" ) then
                  passedt.amenity = "boothbicyclerepairstation"
                  passedt.disusedCamenity = nil
               else
                  if ( passedt.amenity == "atm" ) then
                     passedt.amenity = "boothatm"
                     passedt.disusedCamenity = nil
                  else
                     if ( passedt.tourism == "information" ) then
                        passedt.amenity = "boothinformation"
                        passedt.disusedCamenity = nil
                        passedt.tourism = nil
                     else
                        if ( passedt.tourism == "artwork" ) then
                           passedt.amenity = "boothartwork"
                           passedt.disusedCamenity = nil
                           passedt.tourism = nil
                        else
                           if ( passedt.tourism == "museum" ) then
                              passedt.amenity = "boothmuseum"
                              passedt.disusedCamenity = nil
                              passedt.tourism = nil
		  	   else
                              if (( passedt.disusedCamenity    == "telephone"        )  or
                                  ( passedt.removedCamenity    == "telephone"        )  or
                                  ( passedt.abandonedCamenity  == "telephone"        )  or
                                  ( passedt.demolishedCamenity == "telephone"        )  or
                                  ( passedt.razedCamenity      == "telephone"        )  or
                                  ( passedt.old_amenity        == "telephone"        )  or
                                  ( passedt.historicCamenity   == "telephone"        )  or
                                  ( passedt.disused            == "telephone"        )  or
                                  ( passedt.wasCamenity        == "telephone"        )  or
                                  ( passedt.oldCamenity        == "telephone"        )  or
                                  ( passedt.amenity            == "former_telephone" )  or
                                  ( passedt.historic           == "telephone"        )) then
                                 passedt.amenity         = "boothdisused"
                                 passedt.disusedCamenity = nil
                                 passedt.historic        = nil
                              end
                           end
			end
                     end
                  end
               end
            end
         end
      end
   end
   
-- ----------------------------------------------------------------------------
-- "business" and "company" are used as an alternative to "office" and 
-- "industrial" by some people.  Wherever someone has used a more 
-- frequently-used tag we defer to that.
-- ----------------------------------------------------------------------------
   if ((( passedt.business   ~= nil  )  and
        ( passedt.business   ~= ""   )) and
       (( passedt.office     == nil  )  or
        ( passedt.office     == ""   )) and
       (( passedt.shop       == nil  )  or
        ( passedt.shop       == ""   ))) then
      passedt.office = "yes"
      passedt.business = nil
   end

   if ((( passedt.company   ~= nil  )  and
        ( passedt.company   ~= ""   )) and
       (( passedt.man_made  == nil  )  or
        ( passedt.man_made  == ""   )) and
       (( passedt.office    == nil  )  or
        ( passedt.office    == ""   )) and
       (( passedt.shop      == nil  )  or
        ( passedt.shop      == ""   ))) then
      passedt.office = "yes"
      passedt.company = nil
   end

-- ----------------------------------------------------------------------------
-- Remove generic offices if shop is set.
-- ----------------------------------------------------------------------------
   if ((  passedt.shop   ~= nil        )  and
       (  passedt.shop   ~= ""         )  and
       (  passedt.shop   ~= "no"       )  and
       (  passedt.shop   ~= "vacant"   )  and
       (( passedt.office == "company" )   or
        ( passedt.office == "vacant"  )   or
        ( passedt.office == "yes"     ))) then
      passedt.office = nil
   end

-- ----------------------------------------------------------------------------
-- Mappings to shop=car
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "car;car_repair"  )  or
       ( passedt.shop    == "car_showroom"    )  or
       ( passedt.shop    == "vehicle"         )) then
      passedt.shop = "car"
   end

-- ----------------------------------------------------------------------------
-- Mappings to shop=bicycle
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "bicycle_repair"   ) then
      passedt.shop = "bicycle"
   end

-- ----------------------------------------------------------------------------
-- Map craft=car_repair etc. to shop=car_repair
-- ----------------------------------------------------------------------------
   if (( passedt.craft   == "car_repair"         )  or
       ( passedt.craft   == "coachbuilder"       )  or
       ( passedt.shop    == "car_service"        )  or
       ( passedt.amenity == "vehicle_inspection" )  or
       ( passedt.shop    == "car_bodyshop"       )  or
       ( passedt.shop    == "vehicle_inspection" )  or
       ( passedt.shop    == "mechanic"           )  or
       ( passedt.shop    == "car_repair;car"     )  or
       ( passedt.shop    == "car_repair;tyres"   )) then
      passedt.shop    = "car_repair"
      passedt.amenity = nil
      passedt.craft   = nil
   end

-- ----------------------------------------------------------------------------
-- Map various diplomatic things to embassy.
-- Pedants may claim that some of these aren't legally embassies, and they'd
-- be correct, but I use the same icon for all of these currently.
-- ----------------------------------------------------------------------------
   if (((  passedt.diplomatic == "embassy"            )  and
        (( passedt.embassy    == nil                 )   or
         ( passedt.embassy    == ""                  )   or
         ( passedt.embassy    == "yes"               )   or
         ( passedt.embassy    == "high_commission"   )   or
         ( passedt.embassy    == "nunciature"        )   or
         ( passedt.embassy    == "delegation"        ))) or
       ((  passedt.diplomatic == "consulate"          )  and
        (( passedt.consulate  == nil                 )   or
         ( passedt.consulate  == ""                  )   or
         ( passedt.consulate  == "consulate_general" )   or
         ( passedt.consulate  == "yes"               ))) or
       ( passedt.diplomatic == "embassy;consulate"     ) or
       ( passedt.diplomatic == "embassy;mission"       ) or
       ( passedt.diplomatic == "consulate;embassy"     )) then
      passedt.amenity    = "embassy"
      passedt.diplomatic = nil
      passedt.office     = nil
   end

   if (((  passedt.diplomatic == "embassy"              )  and
        (( passedt.embassy    == "residence"           )   or
         ( passedt.embassy    == "branch_embassy"      )   or
         ( passedt.embassy    == "mission"             ))) or
       ((  passedt.diplomatic == "consulate"            )  and
        (( passedt.consulate  == "consular_office"     )   or
         ( passedt.consulate  == "residence"           )   or
         ( passedt.consulate  == "consular_agency"     ))) or
       (   passedt.diplomatic == "permanent_mission"     ) or
       (   passedt.diplomatic == "trade_delegation"      ) or
       (   passedt.diplomatic == "liaison"               ) or
       (   passedt.diplomatic == "non_diplomatic"        ) or
       (   passedt.diplomatic == "mission"               ) or
       (   passedt.diplomatic == "trade_mission"         )) then
      if ( passedt.amenity == "embassy" ) then
         passedt.amenity = nil
      end

      passedt.diplomatic = nil

-- ----------------------------------------------------------------------------
-- "office" is set to something that will definitely display here, just in case
-- it was set to some value that would not.
-- ----------------------------------------------------------------------------
      passedt.office = "yes"
   end

-- ----------------------------------------------------------------------------
-- Things that are both localities and peaks or hills 
-- should render as the latter.
-- Also, some other combinations (most amenities, some man_made, etc.)
-- Note that "hill" is handled by the rendering code as similar to "peak" but
-- only at higher zooms.  See 19/03/2023 in changelog.html .
-- ----------------------------------------------------------------------------
   if ((   passedt.place    == "locality"       ) and
       ((  passedt.natural  == "peak"          )  or
        (  passedt.natural  == "hill"          )  or
        (( passedt.amenity  ~= nil            )   and
         ( passedt.amenity  ~= ""             ))  or
        (( passedt.man_made ~= nil            )   and
         ( passedt.man_made ~= ""             ))  or
        (( passedt.historic ~= nil            )   and
         ( passedt.historic ~= ""             )))) then
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
-- Detect unusual taggings of hills
-- ----------------------------------------------------------------------------
   if (( passedt.natural == "peak" ) and
       ( passedt.peak    == "hill" )) then
      passedt.natural = "hill"
   end

-- ----------------------------------------------------------------------------
-- Holy wells might be natural=spring or something else.
-- Make sure that we set "amenity" to something other than "place_of_worship"
-- The one existing "holy_well" is actually a spring.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "holy_well" ) and
       ( passedt.natural == "spring"    )) then
      passedt.amenity = "holy_spring"
      passedt.natural = nil
   end

   if ( passedt.place_of_worship == "holy_well" ) then
      passedt.man_made = nil
      if ( passedt.natural == "spring" ) then
         passedt.amenity = "holy_spring"
         passedt.natural = nil
      else
         passedt.amenity = "holy_well"
         passedt.natural = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Springs - lose a historic tag, if set.
-- ----------------------------------------------------------------------------
   if (( passedt.natural == "spring" ) and
       ( passedt.historic ~= nil     ) and
       ( passedt.historic ~= ""      )) then
      passedt.historic = nil
   end

-- ----------------------------------------------------------------------------
-- Inverse springs - where water seeps below ground
-- We already show "dry" sinkholes; show these in the same way.
-- ----------------------------------------------------------------------------
   if ( passedt.waterway == "cave_of_debouchement" ) then
      passedt.natural = "sinkhole"
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
-- "historic=bunker" and "historic=ruins;ruins=bunker"
-- This is set here to prevent unnamedcommercial being set just below.
-- 3 selections make up our "historic" bunkers, "or"ed together.
-- The first "or" includes "building=pillbox" because they are all historic.
-- In the "disused" check we also include "building=bunker".
-- ----------------------------------------------------------------------------
   if ((((  passedt.historic == "bunker"                      )   or
         (( passedt.historic == "ruins"                      )    and
          ( passedt.ruins    == "bunker"                     ))   or
         (  passedt.historic == "pillbox"                     )   or
         (  passedt.building == "pillbox"                     ))  and
        (   passedt.military == nil                            )) or
       ((   passedt.disusedCmilitary == "bunker"               )  and
        ((  passedt.military         == nil                   )   or
         (  passedt.military         == ""                    ))) or
       (((  passedt.military         == "bunker"              )   or
         (  passedt.building         == "bunker"              ))  and
        ((  passedt.disused          == "yes"                 )   or
         (( passedt.historic         ~= nil                  )   and
          ( passedt.historic         ~= ""                   )   and
          ( passedt.historic         ~= "no"                 ))))) then
      passedt.historic = "bunker"
      passedt.disused = nil
      passedt.disusedCmilitary = nil
      passedt.military = nil
      passedt.ruins = nil
      passedt.tourism  = nil

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
-- Boulders - are they climbing boulders or not?
-- If yes, let them get detected as "climbing pitches" ("amenity=pitch_climbing") 
-- or non-pitch climbing features ("natural=climbing")
-- ----------------------------------------------------------------------------
   if ((  passedt.natural    == "boulder"          ) or
       (( passedt.natural    == "stone"           )  and
        ( passedt.geological == "glacial_erratic" ))) then
      if (( passedt.sport    ~= "climbing"            ) and
          ( passedt.sport    ~= "climbing;bouldering" ) and
          ( passedt.climbing ~= "boulder"             )) then
         passedt.natural = "rock"
      end
   end

-- ----------------------------------------------------------------------------
-- leisure=dog_park is used a few times.  Map to pitch to differentiate from
-- underlying park.
-- "cricket_nets" is an oddity.  See https://lists.openstreetmap.org/pipermail/tagging/2023-January/thread.html#66908 .
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "dog_park"           ) or
       ( passedt.sport   == "cricket_nets"       ) or
       ( passedt.sport   == "cricket_nets;multi" ) or
       ( passedt.leisure == "practice_pitch"     )) then
      passedt.leisure = "pitch"
   end

-- ----------------------------------------------------------------------------
-- Show skate parks etc. (that aren't skate shops, or some other leisure 
-- already) as pitches.
-- ----------------------------------------------------------------------------
   if ((( passedt.sport    == "skateboard"     )  or
        ( passedt.sport    == "skateboard;bmx" )) and
       (( passedt.shop     == nil              )  or
        ( passedt.shop     == ""               )) and
       (( passedt.leisure  == nil              )  or
        ( passedt.leisure  == ""               ))) then
      passedt.leisure = "pitch"
   end

-- ----------------------------------------------------------------------------
-- Map leisure=wildlife_hide to bird_hide etc.  Many times it will be.
-- ----------------------------------------------------------------------------
   if (( passedt.leisure      == "wildlife_hide" ) or
       ( passedt.amenity      == "wildlife_hide" ) or
       ( passedt.man_made     == "wildlife_hide" ) or
       ( passedt.amenity      == "bird_hide"     )) then
      passedt.leisure  = "bird_hide"
      passedt.amenity  = nil
      passedt.man_made = nil
   end

   if ((( passedt.amenity       == "hunting_stand" )   and
        ( passedt.hunting_stand == "grouse_butt"   ))  or
       ( passedt.man_made       == "grouse_butt"    )) then
      passedt.leisure = "grouse_butt"
      passedt.amenity = nil
      passedt.man_made = nil
   end

   if ( passedt.amenity == "hunting_stand" ) then
      passedt.leisure = "hunting_stand"
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Treat harbour=yes as landuse=harbour, if not already landuse.
-- ----------------------------------------------------------------------------
   if ((  passedt.harbour == "yes"  ) and
       (( passedt.landuse == nil   )  or
        ( passedt.landuse == ""    ))) then
      passedt.landuse = "harbour"
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
-- Restaurants with accommodation
-- ----------------------------------------------------------------------------
   if (( passedt.amenity       == "restaurant" )  and
       ( passedt.accommodation == "yes"        )) then
      passedt.amenity = "restaccomm"
   end

-- ----------------------------------------------------------------------------
-- "cafe" - consolidation of lesser used tags
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "cafe"       ) then
      passedt.amenity = "cafe"
   end

   if (( passedt.shop == "sandwiches" ) or
       ( passedt.shop == "sandwich"   )) then
      passedt.amenity = "cafe"
      passedt.cuisine = "sandwich"
   end

-- ----------------------------------------------------------------------------
-- Cafes with accommodation, without, and with wheelchair tags or without
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "cafe" ) then
      if ( passedt.accommodation == "yes" ) then
         if ( passedt.wheelchair == "yes" ) then
            if ( passedt.outdoor_seating == "yes" ) then
               passedt.amenity = "cafe_yyy"
            else
               passedt.amenity = "cafe_yyd"
            end
         else
            if ( passedt.wheelchair == "limited" ) then
               if ( passedt.outdoor_seating == "yes" ) then
                  passedt.amenity = "cafe_yly"
               else
                  passedt.amenity = "cafe_yld"
               end
	    else
	       if ( passedt.wheelchair == "no" ) then
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "cafe_yny"
                  else
                     passedt.amenity = "cafe_ynd"
                  end
	       else
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "cafe_ydy"
                  else
                     passedt.amenity = "cafe_ydd"
                  end
	       end
	    end
         end
      else
         if ( passedt.wheelchair == "yes" ) then
            if ( passedt.outdoor_seating == "yes" ) then
               passedt.amenity = "cafe_dyy"
            else
               passedt.amenity = "cafe_dyd"
            end
         else
            if ( passedt.wheelchair == "limited" ) then
               if ( passedt.outdoor_seating == "yes" ) then
                  passedt.amenity = "cafe_dly"
               else
                  passedt.amenity = "cafe_dld"
               end
	    else
	       if ( passedt.wheelchair == "no" ) then
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "cafe_dny"
                  else
                     passedt.amenity = "cafe_dnd"
                  end
               else
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "cafe_ddy"
                  else
                     passedt.amenity = "cafe_ddd"
                  end
	       end
	    end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Bars with accommodation, without, and with wheelchair tags or without
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "bar" ) then
      if ( passedt.accommodation == "yes" ) then
         if ( passedt.wheelchair == "yes" ) then
            if ( passedt.outdoor_seating == "yes" ) then
               passedt.amenity = "bar_yyy"
            else
               passedt.amenity = "bar_yyd"
            end
         else
            if ( passedt.wheelchair == "limited" ) then
               if ( passedt.outdoor_seating == "yes" ) then
                  passedt.amenity = "bar_yly"
               else
                  passedt.amenity = "bar_yld"
               end
	    else
	       if ( passedt.wheelchair == "no" ) then
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "bar_yny"
                  else
                     passedt.amenity = "bar_ynd"
                  end
	       else
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "bar_ydy"
                  else
                     passedt.amenity = "bar_ydd"
                  end
	       end
	    end
         end
      else
         if ( passedt.wheelchair == "yes" ) then
            if ( passedt.outdoor_seating == "yes" ) then
               passedt.amenity = "bar_dyy"
            else
               passedt.amenity = "bar_dyd"
            end
         else
            if ( passedt.wheelchair == "limited" ) then
               if ( passedt.outdoor_seating == "yes" ) then
                  passedt.amenity = "bar_dly"
               else
                  passedt.amenity = "bar_dld"
               end
	    else
	       if ( passedt.wheelchair == "no" ) then
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "bar_dny"
                  else
                     passedt.amenity = "bar_dnd"
                  end
               else
                  if ( passedt.outdoor_seating == "yes" ) then
                     passedt.amenity = "bar_ddy"
                  else
                     passedt.amenity = "bar_ddd"
                  end
	       end
	    end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Render building societies as banks.  Also shop=bank and credit unions.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "building_society" ) or
       ( passedt.shop    == "bank"             ) or
       ( passedt.amenity == "credit_union"     )) then
      passedt.amenity = "bank"
   end

-- ----------------------------------------------------------------------------
-- Banks with wheelchair tags or without
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "bank" ) then
      if ( passedt.wheelchair == "yes" ) then
         passedt.amenity = "bank_y"
      else
         if ( passedt.wheelchair == "limited" ) then
            passedt.amenity = "bank_l"
         else
            if ( passedt.wheelchair == "no" ) then
               passedt.amenity = "bank_n"
            end
          end
      end
   end

-- ----------------------------------------------------------------------------
-- Various mistagging, comma and semicolon healthcare
-- Note that health centres currently appear as "health nonspecific".
-- ----------------------------------------------------------------------------
   if ((   passedt.amenity    == "doctors; pharmacy"       ) or
       (   passedt.amenity    == "surgery"                 ) or
       ((( passedt.healthcare == "doctor"                )   or
         ( passedt.healthcare == "doctor;pharmacy"       )   or
         ( passedt.healthcare == "general_practitioner"  ))  and
        (( passedt.amenity    == nil                     )   or
         ( passedt.amenity    == ""                      )))) then
      passedt.amenity = "doctors"
   end

   if (((   passedt.healthcare            == "dentist"    )  or
        ((  passedt.healthcareCspeciality == "dentistry" )   and
         (( passedt.healthcare            == "yes"      )    or
          ( passedt.healthcare            == "centre"   )    or
          ( passedt.healthcare            == "clinic"   )))) and
       ((  passedt.amenity    == nil                      )  or
        (  passedt.amenity    == ""                       ))) then
      passedt.amenity = "dentist"
      passedt.healthcare = nil
   end

   if ((  passedt.healthcare == "hospital"  ) and
       (( passedt.amenity    == nil        )  or
        ( passedt.amenity    == ""         ))) then
      passedt.amenity = "hospital"
   end

-- ----------------------------------------------------------------------------
-- Ensure that vaccination centries (e.g. for COVID 19) that aren't already
-- something else get shown as something.
-- Things that _are_ something else get (e.g. community centres) get left as
-- that something else.
-- ----------------------------------------------------------------------------
   if ((( passedt.healthcare            == "vaccination_centre" )  or
        ( passedt.healthcare            == "sample_collection"  )  or
        ( passedt.healthcareCspeciality == "vaccination"        )) and
       (( passedt.amenity               == nil                  )  or
        ( passedt.amenity               == ""                   )) and
       (( passedt.leisure               == nil                  )  or
        ( passedt.leisure               == ""                   )) and
       (( passedt.shop                  == nil                  )  or
        ( passedt.shop                  == ""                   ))) then
      passedt.amenity = "clinic"
   end

-- ----------------------------------------------------------------------------
-- If something is mapped both as a supermarket and a pharmacy, suppress the
-- tags for the latter.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "supermarket" ) and
       ( passedt.amenity == "pharmacy"    )) then
      passedt.amenity = nil
   end

   if (((  passedt.healthcare == "pharmacy"                   )  and
        (( passedt.amenity    == nil                         )   or
         ( passedt.amenity    == ""                          ))) or
       ((  passedt.shop       == "cosmetics"                  )  and
        (  passedt.pharmacy   == "yes"                        )  and
        (( passedt.amenity    == nil                         )   or
         ( passedt.amenity    == ""                          ))) or
       ((  passedt.shop       == "chemist"                    )  and
        (  passedt.pharmacy   == "yes"                        )  and
        (( passedt.amenity    == nil                         )   or
         ( passedt.amenity    == ""                          ))) or
       ((  passedt.amenity    == "clinic"                     )  and
        (  passedt.pharmacy   == "yes"                        ))) then
      passedt.amenity = "pharmacy"
   end

-- ----------------------------------------------------------------------------
-- Pharmacies with wheelchair tags or without
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "pharmacy" ) then
      if ( passedt.wheelchair == "yes" ) then
         passedt.amenity = "pharmacy_y"
      else
         if ( passedt.wheelchair == "limited" ) then
            passedt.amenity = "pharmacy_l"
         else
            if ( passedt.wheelchair == "no" ) then
               passedt.amenity = "pharmacy_n"
            end
          end
      end
   end

-- ----------------------------------------------------------------------------
-- Left luggage
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "luggage_locker"  ) then
      passedt.amenity = "left_luggage"
      passedt.shop    = nil
   end

-- ----------------------------------------------------------------------------
-- Parcel lockers
-- ----------------------------------------------------------------------------
   if (((  passedt.amenity         == "vending_machine"                )  and
        (( passedt.vending         == "parcel_pickup;parcel_mail_in"  )   or
         ( passedt.vending         == "parcel_mail_in;parcel_pickup"  )   or
         ( passedt.vending         == "parcel_mail_in"                )   or
         ( passedt.vending         == "parcel_pickup"                 )   or
         ( passedt.vending_machine == "parcel_pickup"                 )))  or
       (   passedt.amenity         == "parcel_box"                      )  or
       (   passedt.amenity         == "parcel_pickup"                   )) then
      passedt.amenity  = "parcel_locker"
   end

-- ----------------------------------------------------------------------------
-- Excrement bags
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "vending_machine" ) and
       ( passedt.vending == "excrement_bags"  )) then
      passedt.amenity  = "vending_excrement"
   end

-- ----------------------------------------------------------------------------
-- Reverse vending machines
-- Other vending machines have their own icon
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "vending_machine" ) and
       ( passedt.vending == "bottle_return"   )) then
      passedt.amenity  = "bottle_return"
   end

-- ----------------------------------------------------------------------------
-- If a farm shop doesn't have a name but does have named produce, map across
-- to vending machine, and also the produce into "vending" for consideration 
-- below.
-- ----------------------------------------------------------------------------
   if ((  passedt.shop                == "farm"  ) and
       (  passedt.name                == nil     ) and
       (( passedt.produce             ~= nil    )  or
        ( passedt.paymentChonesty_box == "yes"  ))) then
      passedt.amenity = "vending_machine"

      if ( passedt.produce == nil )  then
         if ( passedt.foodCeggs == "yes" )  then
            passedt.produce = "eggs"
         else
            passedt.produce = "farm shop honesty box"
         end
      end

      passedt.vending = passedt.produce
      passedt.shop    = nil
   end

   if ((  passedt.shop == "eggs"  ) and
       (  passedt.name == nil     )) then
      passedt.amenity = "vending_machine"
      passedt.vending = passedt.shop
      passedt.shop    = nil
   end

-- ----------------------------------------------------------------------------
-- Some vending machines get the thing sold as the label.
-- "farm shop honesty box" might have been assigned higher up.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "vending_machine"        ) and
       (  passedt.name    == nil                      ) and
       (( passedt.vending == "milk"                  )  or
        ( passedt.vending == "eggs"                  )  or
        ( passedt.vending == "potatoes"              )  or
        ( passedt.vending == "honey"                 )  or
        ( passedt.vending == "cheese"                )  or
        ( passedt.vending == "vegetables"            )  or
        ( passedt.vending == "fruit"                 )  or
        ( passedt.vending == "food"                  )  or
        ( passedt.vending == "photos"                )  or
        ( passedt.vending == "maps"                  )  or
        ( passedt.vending == "newspapers"            )  or
        ( passedt.vending == "farm shop honesty box" ))) then
      passedt.name = "(" .. passedt.vending .. ")"
   end

-- ----------------------------------------------------------------------------
-- Render amenity=piano as musical_instrument
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "piano" ) then
      passedt.amenity = "musical_instrument"

      if ( passedt.name == nil ) then
            passedt.name = "Piano"
      end
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
   if (( passedt.natural  == "pond"       ) or
       ( passedt.waterway == "dock"       ) or
       ( passedt.waterway == "mill_pond"  )) then
      passedt.natural = "water"
      passedt.waterway = nil
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
-- Display "location=underground" waterways as tunnels.
--
-- There are currently no "location=overground" waterways that are not
-- also "man_made=pipeline".
-- ----------------------------------------------------------------------------
   if ((( passedt.waterway ~= nil           )   and
        ( passedt.waterway ~= ""            ))  and
       (( passedt.location == "underground" )   or
        ( passedt.covered  == "yes"         ))  and
       (( passedt.tunnel   == nil           )   or
        ( passedt.tunnel   == ""            ))) then
      passedt.tunnel = "yes"
   end

-- ----------------------------------------------------------------------------
-- Display "location=overground" and "location=overhead" pipelines as bridges.
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "pipeline"    ) and
       (( passedt.location == "overground" )  or
        ( passedt.location == "overhead"   )) and
       (( passedt.bridge   == nil          )  or
        ( passedt.bridge   == ""           ))) then
      passedt.bridge = "yes"
   end

-- ----------------------------------------------------------------------------
-- Pipelines
-- We display pipelines as waterways, because there is explicit bridge handling
-- for waterways.
-- Also note that some seamarks
-- ----------------------------------------------------------------------------
   if (( passedt.man_made     == "pipeline"           ) or
       ( passedt.seamarkCtype == "pipeline_submarine" )) then
      passedt.man_made     = nil
      passedt.seamarkCtype = nil
      passedt.waterway     = "pipeline"
   end

-- ----------------------------------------------------------------------------
-- Display gantries as pipeline bridges
-- ----------------------------------------------------------------------------
   if ( passedt.man_made == "gantry" ) then
      passedt.man_made = nil
      passedt.waterway = "pipeline"
      passedt.bridge = "yes"
   end

-- ----------------------------------------------------------------------------
-- Display military bunkers
-- Historic bunkers have been dealt with higher up.
-- ----------------------------------------------------------------------------
   if ((   passedt.military == "bunker"   ) or
       ((  passedt.building == "bunker"  )  and
        (( passedt.disused  == nil      )   or
         ( passedt.disused  == ""       ))  and
        (( passedt.historic == nil      )   or
         ( passedt.historic == ""       )))) then
      passedt.man_made = "militarybunker"
      passedt.military = nil

      if ( passedt.building == nil ) then
         passedt.building = "yes"
      end
   end

-- ----------------------------------------------------------------------------
-- Supermarkets as normal buildings
-- ----------------------------------------------------------------------------
   if ((  passedt.building   == "supermarket"      ) or
       (  passedt.man_made   == "storage_tank"     ) or
       (  passedt.man_made   == "silo"             ) or
       (  passedt.man_made   == "tank"             ) or
       (  passedt.man_made   == "water_tank"       ) or
       (  passedt.man_made   == "kiln"             ) or
       (  passedt.man_made   == "gasometer"        ) or
       (  passedt.man_made   == "oil_tank"         ) or
       (  passedt.man_made   == "greenhouse"       ) or
       (  passedt.man_made   == "water_treatment"  ) or
       (  passedt.man_made   == "trickling_filter" ) or
       (  passedt.man_made   == "filter_bed"       ) or
       (  passedt.man_made   == "filtration_bed"   ) or
       (  passedt.man_made   == "waste_treatment"  ) or
       (  passedt.man_made   == "lighthouse"       ) or
       (  passedt.man_made   == "street_cabinet"   ) or
       (  passedt.man_made   == "aeroplane"        ) or
       (  passedt.man_made   == "helicopter"       )) then
      passedt.building = "yes"
   end

-- ----------------------------------------------------------------------------
-- Only show telescopes as buildings if they don't already have a landuse set.
-- Some large radio telescopes aren't large buildings.
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "telescope"  ) and
       (( passedt.landuse  == nil         )  or
        ( passedt.landuse  == ""          ))) then
      passedt.building = "yes"
   end

-- ----------------------------------------------------------------------------
-- building=ruins is rendered as a half-dark building.
-- The wiki tries to guide building=ruins towards follies only but ruins=yes
-- "not a folly but falling down".  That doesn't match what mappers do but 
-- render both as half-dark.
-- ----------------------------------------------------------------------------
   if (((    passedt.building        ~= nil               )   and
        (    passedt.building        ~= ""                )   and
        (((  passedt.historic        == "ruins"         )     and
          (( passedt.ruins           == nil            )      or
           ( passedt.ruins           == ""             )))    or
         (   passedt.ruins           == "yes"            )    or
         (   passedt.ruins           == "barn"           )    or
         (   passedt.ruins           == "barrack"        )    or
         (   passedt.ruins           == "blackhouse"     )    or
         (   passedt.ruins           == "house"          )    or
         (   passedt.ruins           == "hut"            )    or
         (   passedt.ruins           == "farm_auxiliary" )    or
         (   passedt.ruins           == "farmhouse"      )))  or
       (     passedt.ruinsCbuilding  == "yes"              )  or
       (     passedt.buildingCruins  == "yes"              )  or
       (     passedt.ruinedCbuilding == "yes"              )  or
       (     passedt.building        == "collapsed"        )) then
      passedt.building = "ruins"
   end
   
-- ----------------------------------------------------------------------------
-- Map man_made=monument to historic=monument (handled below).
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "monument" )  and
       (( passedt.tourism  == nil       )   or
        ( passedt.tourism  == ""        ))) then
      passedt.historic = "monument"
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Map man_made=geoglyph to natural=bare_rock if another natural tag such as 
-- scree is not already set
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "geoglyph"  ) and
       (( passedt.leisure  == nil        )  or
        ( passedt.leisure  == ""         ))) then
      if (( passedt.natural  == nil ) or
          ( passedt.natural  == ""  )) then
         passedt.natural  = "bare_rock"
      end

      passedt.man_made = nil
      passedt.tourism  = nil
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
-- hazard=plant is fairly rare, but render as a nonspecific historic dot.
-- ----------------------------------------------------------------------------
   if ((( passedt.hazard  == "plant"                    )  or
        ( passedt.hazard  == "toxic_plant"              )) and
       (( passedt.species == "Heracleum mantegazzianum" )  or
        ( passedt.taxon   == "Heracleum mantegazzianum" ))) then
      passedt.historic = "nonspecific"
      passedt.name = "Hogweed"
   end

-- ----------------------------------------------------------------------------
-- If something has a "lock_ref", append it to "lock_name" (if it exists) or
-- "name" (if it doesn't)
-- ----------------------------------------------------------------------------
   if (( passedt.lock_ref ~= nil ) and
       ( passedt.lock_ref ~= ""  )) then
      if (( passedt.lock_name ~= nil ) and
          ( passedt.lock_name ~= ""  )) then
         passedt.lock_name = passedt.lock_name .. " (" .. passedt.lock_ref .. ")"
      else
         if (( passedt.name ~= nil ) and
             ( passedt.name ~= ""  )) then
            passedt.name = passedt.name .. " (" .. passedt.lock_ref .. ")"
         else
            passedt.lock_name = "(" .. passedt.lock_ref .. ")"
         end
      end

      passedt.lock_ref = nil
   end

-- ----------------------------------------------------------------------------
-- If something (now) has a "lock_name", use it in preference to "name".
-- ----------------------------------------------------------------------------
   if (( passedt.lock_name ~= nil ) and
       ( passedt.lock_name ~= ""  )) then
      passedt.name = passedt.lock_name
   end

-- ----------------------------------------------------------------------------
-- If set, move bridge:name to bridge_name
-- ----------------------------------------------------------------------------
   if ( passedt.bridgeCname ~= nil ) then
      passedt.bridge_name = passedt.bridgeCname
      passedt.bridgeCname = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move bridge_name to name
-- ----------------------------------------------------------------------------
   if ( passedt.bridge_name ~= nil ) then
      passedt.name = passedt.bridge_name
      passedt.bridge_name = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move bridge:ref to bridge_ref
-- ----------------------------------------------------------------------------
   if ( passedt.bridgeCref ~= nil ) then
      passedt.bridge_ref = passedt.bridgeCref
      passedt.bridgeCref = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move canal_bridge_ref to bridge_ref
-- ----------------------------------------------------------------------------
   if ( passedt.canal_bridge_ref ~= nil ) then
      passedt.bridge_ref = passedt.canal_bridge_ref
      passedt.canal_bridge_ref = nil
   end

-- ----------------------------------------------------------------------------
-- If set and relevant, do something with bridge_ref
-- ----------------------------------------------------------------------------
   if ((   passedt.bridge_ref ~= nil   ) and
       (   passedt.bridge_ref ~= ""    ) and
       ((( passedt.highway    ~= nil )   and
         ( passedt.highway    ~= ""  ))  or
        (( passedt.railway    ~= nil )   and
         ( passedt.railway    ~= ""  ))  or
        (( passedt.waterway   ~= nil )   and
         ( passedt.waterway   ~= ""  )))) then
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = "{" .. passedt.bridge_ref .. ")"
      else
         passedt.name = passedt.name .. " {" .. passedt.bridge_ref .. ")"
      end

      passedt.bridge_ref = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move tunnel:name to tunnel_name
-- ----------------------------------------------------------------------------
   if (( passedt.tunnelCname ~= nil ) and
       ( passedt.tunnelCname ~= ""  )) then
      passedt.tunnel_name = passedt.tunnelCname
      passedt.tunnelCname = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move tunnel_name to name
-- ----------------------------------------------------------------------------
   if (( passedt.tunnel_name ~= nil ) and
       ( passedt.tunnel_name ~= ""  )) then
      passedt.name = passedt.tunnel_name
      passedt.tunnel_name = nil
   end

-- ----------------------------------------------------------------------------
-- If something has a "tpuk_ref", use it in preference to "name".
-- It's in brackets because it's likely not signed.
-- ----------------------------------------------------------------------------
   if (( passedt.tpuk_ref ~= nil ) and
       ( passedt.tpuk_ref ~= ""  )) then
      passedt.name = "(" .. passedt.tpuk_ref .. ")"
   end

-- ----------------------------------------------------------------------------
-- Disused railway platforms
-- ----------------------------------------------------------------------------
   if (( passedt.railway == "platform" ) and
       ( passedt.disused == "yes"       )) then
      passedt.railway = nil
      passedt.disusedCrailway = "platform"
   end

-- ----------------------------------------------------------------------------
-- Suppress Underground railway platforms
-- ----------------------------------------------------------------------------
   if ((  passedt.railway     == "platform"     ) and
       (( passedt.location    == "underground" )  or
        ( passedt.underground == "yes"         )  or
        (( tonumber(passedt.layer) or 0 ) <  0 ))) then
      passedt.railway = nil
   end

-- ----------------------------------------------------------------------------
-- If railway platforms have a ref, use it.
-- ----------------------------------------------------------------------------
   if (( passedt.railway == "platform" ) and
       ( passedt.ref     ~= nil        ) and
       ( passedt.ref     ~= ""         )) then
      passedt.name = "Platform " .. passedt.ref
      passedt.ref  = nil
   end

-- ----------------------------------------------------------------------------
-- Add "water" to some "wet" features for rendering.
-- (the last part currently vector only)
-- ----------------------------------------------------------------------------
   if (( passedt.man_made   == "wastewater_reservoir"  ) or
       ( passedt.man_made   == "lagoon"                ) or
       ( passedt.man_made   == "lake"                  ) or
       ( passedt.man_made   == "reservoir"             ) or
       ( passedt.basin      == "wastewater"            ) or
       ( passedt.natural    == "lake"                  )) then
      passedt.natural = "water"
   end

-- ----------------------------------------------------------------------------
-- Coalesce non-intermittent water into one tag.
-- ----------------------------------------------------------------------------
   if ( passedt.landuse == "reservoir"  ) then
      passedt.natural = "water"
      passedt.landuse = nil
   end

   if ( passedt.waterway == "riverbank"  ) then
      passedt.natural = "water"
      passedt.waterway = nil
   end

-- ----------------------------------------------------------------------------
-- Suppress "name" on riverbanks mapped as "natural=water"
-- ----------------------------------------------------------------------------
   if (( passedt.natural   == "water"  ) and
       ( passedt.water     == "river"  )) then
      passedt.name = nil
   end

-- ----------------------------------------------------------------------------
-- Handle intermittent water areas.
-- ----------------------------------------------------------------------------
   if ((( passedt.natural      == "water"  )  or
        ( passedt.landuse      == "basin"  )) and
       ( passedt.intermittent == "yes"      )) then
      passedt.natural = "intermittentwater"
      passedt.landuse = nil
   end

-- ----------------------------------------------------------------------------
-- Also try and detect flood plains etc.
-- ----------------------------------------------------------------------------
   if ((   passedt.natural      == "floodplain"     ) or
       ((( passedt.flood_prone  == "yes"          )   or
         (( passedt.hazard_prone == "yes"        )    and
          ( passedt.hazard_type  == "flood"      )))  and
        (( passedt.natural      == nil            )   or
         ( passedt.natural      == ""             ))  and
        (( passedt.highway      == nil            )   or
         ( passedt.highway      == ""             ))) or
       ((( passedt.natural      == nil            )   or
         ( passedt.natural      == ""             ))  and
        (  passedt.landuse      ~= "basin"         )  and
        (( passedt.basin        == "detention"    )   or
         ( passedt.basin        == "retention"    )   or
         ( passedt.basin        == "infiltration" )   or
         ( passedt.basin        == "side_pound"   )))) then
      passedt.natural = "flood_prone"
   end

-- ----------------------------------------------------------------------------
-- Handle intermittent wetland areas.
-- ----------------------------------------------------------------------------
   if (( passedt.natural      == "wetland"  )  and
       ( passedt.intermittent == "yes"      )) then
      passedt.natural = "intermittentwetland"
   end

-- ----------------------------------------------------------------------------
-- Map wind turbines to, er, wind turbines and make sure that they don't also
-- appear as towers.
-- ----------------------------------------------------------------------------
   if (( passedt.man_made   == "wind_turbine" ) or
       ( passedt.man_made   == "windpump"     )) then
      passedt.power        = "generator"
      passedt.power_source = "wind"
   end

   if ((  passedt.man_made         == "tower"         ) and
       (  passedt.power            == "generator"     ) and
       (( passedt.power_source     == "wind"         )  or
        ( passedt.generatorCsource == "wind"         )  or
        ( passedt.generatorCmethod == "wind_turbine" )  or
        ( passedt.plantCsource     == "wind"         )  or
        ( passedt.generatorCmethod == "wind"         ))) then
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Change solar panels to "roof"
-- ----------------------------------------------------------------------------
   if (( passedt.power            == "generator"    ) and
       ( passedt.generatorCmethod == "photovoltaic" )) then
      passedt.power    = nil
      passedt.building = "roof"
   end

-- ----------------------------------------------------------------------------
-- Railway ventilation shaft nodes.
-- These are rendered as a stubby black tower.
-- ----------------------------------------------------------------------------
   if (( passedt.building   == "air_shaft"         ) or
       ( passedt.man_made   == "air_shaft"         ) or
       ( passedt.tunnel     == "air_shaft"         ) or
       ( passedt.historic   == "air_shaft"         ) or
       ( passedt.railway    == "ventilation_shaft" ) or
       ( passedt.tunnel     == "ventilation_shaft" ) or
       ( passedt.tunnel     == "ventilation shaft" ) or
       ( passedt.building   == "ventilation_shaft" ) or
       ( passedt.man_made   == "ventilation_shaft" ) or
       ( passedt.building   == "vent_shaft"        ) or
       ( passedt.man_made   == "vent_shaft"        ) or
       ( passedt.towerCtype == "vent"              ) or
       ( passedt.towerCtype == "ventilation_shaft" )) then
      passedt.man_made = "ventilation_shaft"

      if (( passedt.building == nil ) or
          ( passedt.building == ""  )) then
         passedt.building = "roof"
      end
   end

-- ----------------------------------------------------------------------------
-- Horse mounting blocks
-- ----------------------------------------------------------------------------
   if (( passedt.amenity   == "mounting_block"       ) or
       ( passedt.historic  == "mounting_block"       ) or
       ( passedt.amenity   == "mounting_step"        ) or
       ( passedt.amenity   == "mounting_steps"       ) or
       ( passedt.amenity   == "horse_dismount_block" )) then
      passedt.man_made = "mounting_block"
   end

-- ----------------------------------------------------------------------------
-- Water monitoring stations
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made                  == "monitoring_station"  ) and
       (( passedt.monitoringCwater_level    == "yes"                )  or
        ( passedt.monitoringCwater_flow     == "yes"                )  or
        ( passedt.monitoringCwater_velocity == "yes"                ))) then
      passedt.man_made = "monitoringwater"
   end

-- ----------------------------------------------------------------------------
-- Weather monitoring stations
-- ----------------------------------------------------------------------------
   if (( passedt.man_made               == "monitoring_station" ) and
       ( passedt.monitoringCweather     == "yes"                ) and
       ( passedt.weatherCradar          == nil                  ) and
       ( passedt.monitoringCwater_level == nil                  )) then
      passedt.man_made = "monitoringweather"
   end

-- ----------------------------------------------------------------------------
-- Rainfall monitoring stations
-- ----------------------------------------------------------------------------
   if (( passedt.man_made               == "monitoring_station" ) and
       ( passedt.monitoringCrainfall    == "yes"                ) and
       ( passedt.monitoringCweather     == nil                  ) and
       ( passedt.monitoringCwater_level == nil                  )) then
      passedt.man_made = "monitoringrainfall"
   end

-- ----------------------------------------------------------------------------
-- Earthquake monitoring stations
-- ----------------------------------------------------------------------------
   if (( passedt.man_made                     == "monitoring_station" ) and
       ( passedt.monitoringCseismic_activity  == "yes"                )) then
      passedt.man_made = "monitoringearthquake"
   end

-- ----------------------------------------------------------------------------
-- Sky brightness monitoring stations
-- ----------------------------------------------------------------------------
   if (( passedt.man_made                   == "monitoring_station" ) and
       ( passedt.monitoringCsky_brightness  == "yes"                )) then
      passedt.man_made = "monitoringsky"
   end

-- ----------------------------------------------------------------------------
-- Air quality monitoring stations
-- ----------------------------------------------------------------------------
   if (( passedt.man_made               == "monitoring_station" ) and
       ( passedt.monitoringCair_quality == "yes"                ) and
       ( passedt.monitoringCweather     == nil                  )) then
      passedt.man_made = nil
      passedt.landuse = "industrial"
      if ( passedt.name == nil ) then
         passedt.name = "(air quality)"
      else
         passedt.name = passedt.name .. " (air quality)"
      end
   end

-- ----------------------------------------------------------------------------
-- Golf ball washers
-- ----------------------------------------------------------------------------
   if ( passedt.golf == "ball_washer" ) then
      passedt.man_made = "golfballwasher"
   end

-- ----------------------------------------------------------------------------
-- Advertising Columns
-- ----------------------------------------------------------------------------
   if ( passedt.advertising == "column" ) then
      passedt.tourism = "advertising_column"
   end

-- ----------------------------------------------------------------------------
-- railway=transfer_station - show as "halt"
-- This is for Manulla Junction, https://www.openstreetmap.org/node/5524753168
-- ----------------------------------------------------------------------------
   if ( passedt.railway == "transfer_station" ) then
      passedt.railway = "halt"
   end

-- ----------------------------------------------------------------------------
-- Show unspecified "public_transport=station" as "railway=halt"
-- These are normally one of amenity=bus_station, railway=station or
--  aerialway=station.  If they are none of these at least sow them as something.
-- ----------------------------------------------------------------------------
   if ((  passedt.public_transport == "station" ) and
       (( passedt.amenity          == nil      )  or
        ( passedt.amenity          == ""       )) and
       (( passedt.railway          == nil      )  or
        ( passedt.railway          == ""       )) and
       (( passedt.aerialway        == nil      )  or
        ( passedt.aerialway        == ""       ))) then
      passedt.railway          = "halt"
      passedt.public_transport = nil
   end

-- ----------------------------------------------------------------------------
-- "tourism" stations - show with brown text rather than blue.
-- ----------------------------------------------------------------------------
   if (((( passedt.railway           == "station"   )    or
         ( passedt.railway           == "halt"      ))   and
        (( passedt.usage             == "tourism"   )    or
         ( passedt.station           == "miniature" )    or
         ( passedt.tourism           == "yes"       )))  or
       (   passedt.railwayCminiature == "station"     )) then
      passedt.amenity = "tourismstation"
      passedt.railway = nil
      passedt.railwayCminiature = nil
   end

-- ----------------------------------------------------------------------------
-- railway=crossing - show as level crossings.
-- ----------------------------------------------------------------------------
   if ( passedt.railway == "crossing" ) then
      passedt.railway = "level_crossing"
   end

-- ----------------------------------------------------------------------------
-- Various types of traffic light controlled crossings
-- ----------------------------------------------------------------------------
   if ((( passedt.crossing == "traffic_signals"         )  or
        ( passedt.crossing == "toucan"                  )  or
        ( passedt.crossing == "puffin"                  )  or
        ( passedt.crossing == "traffic_signals;island"  )  or
        ( passedt.crossing == "traffic_lights"          )  or
        ( passedt.crossing == "island;traffic_signals"  )  or
        ( passedt.crossing == "signals"                 )  or
        ( passedt.crossing == "pegasus"                 )  or
        ( passedt.crossing == "pedestrian_signals"      )  or
        ( passedt.crossing == "light_controlled"        )  or
        ( passedt.crossing == "light controlled"        )) and
       (( passedt.highway  == nil                       )  or
        ( passedt.highway  == ""                        ))) then
      passedt.highway = "traffic_signals"
      passedt.crossing = nil
   end

-- ----------------------------------------------------------------------------
-- highway=passing_place to turning_circle
-- Not really the same thing, but a "widening of the road" should be good 
-- enough.  
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "passing_place" ) then
      passedt.highway = "turning_circle"
   end

-- ----------------------------------------------------------------------------
-- highway=escape to service
-- There aren't many escape lanes mapped, but they do exist
-- ----------------------------------------------------------------------------
   if ( passedt.highway   == "escape" ) then
      passedt.highway = "service"
      passedt.access  = "destination"
   end

-- ----------------------------------------------------------------------------
-- Render guest houses subtagged as B&B as B&B
-- ----------------------------------------------------------------------------
   if (( passedt.tourism     == "guest_house"       ) and
       ( passedt.guest_house == "bed_and_breakfast" )) then
      passedt.tourism = "bed_and_breakfast"
   end

-- ----------------------------------------------------------------------------
-- "self_catering" is increasingly common and a series of different icons are
-- used for them, based on values for whether it is:
--
-- self catering       yes or no
-- multiple occupancy  yes, no, or don't know
-- urban setting       urban, rural, or don't know
-- cheap               yes (like a hostel) or no (like a hotel)
--
-- The resulting values such as "tourism_guest_yyyy" are passed through to be 
-- rendered.
-- ----------------------------------------------------------------------------
   if (( passedt.tourism   == "self_catering"           ) or
       ( passedt.tourism   == "accommodation"           ) or
       ( passedt.tourism   == "holiday_let"             )) then
      passedt.tourism = "tourism_guest_yddd"
   end

   if ( passedt.tourism   == "apartment"               ) then
      passedt.tourism = "tourism_guest_ynyn"
   end

   if (( passedt.tourism   == "holiday_cottage"         ) or
       ( passedt.tourism   == "cottage"                 )) then
      passedt.tourism = "tourism_guest_ynnn"
   end

   if (( passedt.tourism   == "holiday_village"         ) or
       ( passedt.tourism   == "holiday_park"            ) or
       ( passedt.tourism   == "holiday_lets"            )) then
      passedt.tourism = "tourism_guest_dynd"
   end

   if ( passedt.tourism   == "spa_resort"              ) then
      passedt.tourism = "tourism_guest_nynn"
   end

   if ( passedt.tourism   == "Holiday Lodges"          ) then
      passedt.tourism = "tourism_guest_yynd"
   end

   if (( passedt.tourism   == "aparthotel"              ) or
       ( passedt.tourism   == "apartments"              )) then
      passedt.tourism = "tourism_guest_yyyn"
   end

-- ----------------------------------------------------------------------------
-- tourism=bed_and_breakfast was removed by the "style police" in
-- https://github.com/gravitystorm/openstreetmap-carto/pull/695
-- That now has its own icon.
-- Self-catering is handled above.
-- That just leaves "tourism=guest_house":
-- ----------------------------------------------------------------------------
   if ( passedt.tourism   == "guest_house"          ) then
      passedt.tourism = "tourism_guest_nydn"
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

      if ((( passedt.name     == nil )  or
           ( passedt.name     == ""  )) or
          (( passedt.building ~= nil )  and
           ( passedt.building ~= ""  ))) then
         passedt.tourism = "singlechalet"
      end
   end

-- ----------------------------------------------------------------------------
-- "leisure=trailhead" is an occasional mistagging for "highway=trailhead"
-- ----------------------------------------------------------------------------
   if ((  passedt.leisure == "trailhead" ) and
       (( passedt.highway == nil        )  or
        ( passedt.highway == ""         ))) then
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
   if ((  passedt.highway  == "trailhead" ) and
       (( passedt.name     == nil        )  or
        ( passedt.name     == ""         ))) then
      passedt.highway = nil
   end

-- ----------------------------------------------------------------------------
-- Render amenity=information as tourism
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "information"  ) then
      passedt.tourism = "information"
   end

-- ----------------------------------------------------------------------------
-- Various types of information - PNFS guideposts first.
-- ----------------------------------------------------------------------------
   if (( passedt.tourism    == "information"                          ) and
       (( passedt.operator  == "Peak & Northern Footpaths Society"   )  or
        ( passedt.operator  == "Peak and Northern Footpaths Society" )  or
        ( passedt.operator  == "Peak District & Northern Counties Footpaths Preservation Society" ))) then
      passedt.tourism = "informationpnfs"
   end

-- ----------------------------------------------------------------------------
-- Some information boards don't have a "tourism" tag
-- ----------------------------------------------------------------------------
   if (( passedt.information     == "board" ) and
       ( passedt.disusedCtourism == nil     ) and
       ( passedt.ruinsCtourism   == nil     ) and
       ( passedt.historic        == nil     )) then
      if ( passedt.board_type == "public_transport" ) then
         passedt.tourism = "informationpublictransport"
      else
         passedt.tourism = "informationboard"
      end
   end

-- ----------------------------------------------------------------------------
-- Information boards
-- ----------------------------------------------------------------------------
   if ((   passedt.amenity     == "notice_board"                       )  or
       (   passedt.tourism     == "village_sign"                       )  or
       (   passedt.man_made    == "village_sign"                       )  or
       ((  passedt.tourism     == "information"                       )   and
        (( passedt.information == "board"                            )    or
         ( passedt.information == "board;map"                        )    or
         ( passedt.information == "citymap"                          )    or
         ( passedt.information == "departure times and destinations" )    or
         ( passedt.information == "electronic_board"                 )    or
         ( passedt.information == "estate_map"                       )    or
         ( passedt.information == "former_telephone_box"             )    or
         ( passedt.information == "hikingmap"                        )    or
         ( passedt.information == "history"                          )    or
         ( passedt.information == "hospital map"                     )    or
         ( passedt.information == "information_board"                )    or
         ( passedt.information == "interpretation"                   )    or
         ( passedt.information == "interpretive_board"               )    or
         ( passedt.information == "leaflet_board"                    )    or
         ( passedt.information == "leaflets"                         )    or
         ( passedt.information == "map and posters"                  )    or
         ( passedt.information == "map"                              )    or
         ( passedt.information == "map;board"                        )    or
         ( passedt.information == "map_board"                        )    or
         ( passedt.information == "nature"                           )    or
         ( passedt.information == "notice_board"                     )    or
         ( passedt.information == "noticeboard"                      )    or
         ( passedt.information == "orientation_map"                  )    or
         ( passedt.information == "sitemap"                          )    or
         ( passedt.information == "tactile_map"                      )    or
         ( passedt.information == "tactile_model"                    )    or
         ( passedt.information == "terminal"                         )    or
         ( passedt.information == "wildlife"                         )))) then
      if ( passedt.board_type == "public_transport" ) then
         passedt.tourism = "informationpublictransport"
      else
         passedt.tourism = "informationboard"
      end
   end

   if ((  passedt.amenity     == "notice_board"       )  or
       (  passedt.tourism     == "sign"               )  or
       (  passedt.emergency   == "beach_safety_sign"  )  or
       (( passedt.tourism     == "information"       )   and
        ( passedt.information == "sign"              ))) then
      if ( passedt.operatorCtype == "military" ) then
         passedt.tourism = "militarysign"
      else
         passedt.tourism = "informationsign"
      end
   end

   if ((( passedt.tourism     == "informationboard"           )   or
        ( passedt.tourism     == "informationpublictransport" )   or
        ( passedt.tourism     == "informationsign"            )   or
        ( passedt.tourism     == "militarysign"               ))  and
       (  passedt.name        == nil                           )  and
       (  passedt.boardCtitle ~= nil                           )) then
      passedt.name = passedt.boardCtitle
   end

   if (((  passedt.tourism     == "information"                       )  and
        (( passedt.information == "guidepost"                        )   or
         ( passedt.information == "fingerpost"                       )   or
         ( passedt.information == "marker"                           ))) or
       (   passedt.man_made    == "signpost"                           )) then
      if ( passedt.guide_type == "intermediary" ) then
         passedt.tourism = "informationroutemarker"
      else
         passedt.tourism = "informationmarker"
         passedt.ele = nil

	 if (( passedt.name ~= nil ) and
             ( passedt.name ~= ""  )) then
	    passedt.ele = passedt.name
	 end

         append_directions( passedt )
      end
   end

   if (((  passedt.tourism     == "information"                       )   and
        (( passedt.information == "route_marker"                     )    or
         ( passedt.information == "trail_blaze"                      )))  or
       (   passedt.highway     == "trailhead"                          )) then
      passedt.tourism = "informationroutemarker"
   end

   if ((  passedt.tourism     == "information"                       )  and
       (( passedt.information == "office"                           )   or
        ( passedt.information == "kiosk"                            )   or
        ( passedt.information == "visitor_centre"                   ))) then
      passedt.tourism = "informationoffice"
   end

   if ((  passedt.tourism     == "information"                       )  and
       (( passedt.information == "blue_plaque"                      )   or
        ( passedt.information == "plaque"                           ))) then
      passedt.tourism = "informationplaque"
   end

   if (( passedt.tourism     == "information"                       )  and
       ( passedt.information == "audioguide"                        )) then
      passedt.tourism = "informationear"
   end

-- ----------------------------------------------------------------------------
-- NCN Route markers
-- ----------------------------------------------------------------------------
   if ( passedt.ncn_milepost == "dudgeon" ) then
      passedt.tourism = "informationncndudgeon"
      passedt.name    = passedt.sustrans_ref
   end

   if ( passedt.ncn_milepost == "mccoll" ) then
      passedt.tourism = "informationncnmccoll"
      passedt.name    = passedt.sustrans_ref
   end

   if ( passedt.ncn_milepost == "mills" ) then
      passedt.tourism = "informationncnmills"
      passedt.name    = passedt.sustrans_ref
   end

   if ( passedt.ncn_milepost == "rowe" ) then
      passedt.tourism = "informationncnrowe"
      passedt.name    = passedt.sustrans_ref
   end

   if (( passedt.ncn_milepost == "unknown" )  or
       ( passedt.ncn_milepost == "yes"     )) then
      passedt.tourism = "informationncnunknown"
      passedt.name    = passedt.sustrans_ref
   end


-- ----------------------------------------------------------------------------
-- Change some common semicolon values to the first in the list.
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "bar;restaurant" ) then
      passedt.amenity = "bar"
   end

   if ( passedt.shop == "butcher;greengrocer" ) then
      passedt.shop = "butcher"
   end

-- ----------------------------------------------------------------------------
-- Things that are both peaks and memorials should render as the latter.
-- ----------------------------------------------------------------------------
   if ((( passedt.natural   == "hill"     )  or
        ( passedt.natural   == "peak"     )) and
       (  passedt.historic  == "memorial"  )) then
      passedt.natural = nil
   end

-- ----------------------------------------------------------------------------
-- Things that are both peaks and cairns should render as the former.
-- ----------------------------------------------------------------------------
   if ((( passedt.natural   == "hill"     )  or
        ( passedt.natural   == "peak"     )) and
       (  passedt.man_made  == "cairn"     )) then
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Beacons - render historic ones, not radio ones.
-- ----------------------------------------------------------------------------
   if ((( passedt.man_made == "beacon"        )  or
        ( passedt.man_made == "signal_beacon" )  or
        ( passedt.landmark == "beacon"        )  or
        ( passedt.historic == "beacon"        )) and
       (( passedt.airmark  == nil             )  or
        ( passedt.airmark  == ""              )) and
       (( passedt.aeroway  == nil             )  or
        ( passedt.aeroway  == ""              )) and
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
       ( passedt.hazard   == "shooting_range"                     ) or
       ( passedt.sport    == "shooting"                           ) or
       ( passedt.sport    == "shooting_range"                     )) then
      passedt.landuse = "military"
   end

-- ----------------------------------------------------------------------------
-- Extract concert hall theatres as concert halls
-- ----------------------------------------------------------------------------
   if ((( passedt.amenity == "theatre"      )  and
        ( passedt.theatre == "concert_hall" )) or
       (  passedt.amenity == "music_venue"   )) then
      passedt.amenity = "concert_hall"
   end

-- ----------------------------------------------------------------------------
-- Show natural=embankment as man_made=embankment.
-- Where it is used in UK/IE (which is rarely) it seems to be for single-sided
-- ones.
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "embankment"   ) then
      passedt.man_made = "embankment"
   end

-- ----------------------------------------------------------------------------
-- man_made=embankment and natural=cliff displays as a non-sided cliff 
-- Often it's combined with highway though, and that is handled separately.
-- In that case it's passed through to the stylesheet as bridge=levee.
-- embankment handling is asymmetric for railways currently - it's checked
-- before we apply the "man_made=levee" tag, but "bridge=levee" is not applied.
-- ----------------------------------------------------------------------------
   if ((( passedt.barrier    == "flood_bank"    )  or
        ( passedt.barrier    == "bund"          )  or
        ( passedt.barrier    == "mound"         )  or
        ( passedt.barrier    == "ridge"         )  or
        ( passedt.barrier    == "embankment"    )  or
        ( passedt.man_made   == "dyke"          )  or
        ( passedt.man_made   == "levee"         )  or
        ( passedt.embankment == "yes"           )  or
        ( passedt.barrier    == "berm"          )  or
        ( passedt.natural    == "ridge"         )  or
        ( passedt.natural    == "earth_bank"    )  or
        ( passedt.natural    == "arete"         )) and
       (( passedt.highway    == nil             )  or
        ( passedt.highway    == ""              )  or
        ( passedt.highway    == "badpathwide"   )  or
        ( passedt.highway    == "badpathnarrow" )) and
       (( passedt.railway    == nil             )  or
        ( passedt.railway    == ""              )) and
       (( passedt.waterway   == nil             )  or
        ( passedt.waterway   == ""              ))) then
      passedt.man_made = "levee"
      passedt.barrier = nil
      passedt.embankment = nil
   end

-- ----------------------------------------------------------------------------
-- Re the "bridge" check below, we've already changed valid ones to "yes"
-- above.
-- ----------------------------------------------------------------------------
   if (((  passedt.barrier    == "flood_bank"     )  or
        (  passedt.man_made   == "dyke"           )  or
        (  passedt.man_made   == "levee"          )  or
        (  passedt.embankment == "yes"            )  or
        (  passedt.natural    == "ridge"          )  or
        (  passedt.natural    == "arete"          )) and
       ((( passedt.highway    ~= nil             )   and
         ( passedt.highway    ~= "badpathwide"   )   and
         ( passedt.highway    ~= "badpathnarrow" ))  or
        (( passedt.railway    ~= nil             )   and
         ( passedt.railway    ~= ""              ))  or
        (( passedt.waterway   ~= nil             )   and
         ( passedt.waterway   ~= ""              ))) and
       (   passedt.bridge     ~= "yes"             ) and
       (   passedt.tunnel     ~= "yes"             )) then
      passedt.bridge = "levee"
      passedt.barrier = nil
      passedt.man_made = nil
      passedt.embankment = nil
   end

-- ----------------------------------------------------------------------------
-- Assume "natural=hedge" should be "barrier=hedge".
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "hedge" ) then
      passedt.barrier = "hedge"
   end

-- ----------------------------------------------------------------------------
-- map "fences that are really hedges" as fences.
-- ----------------------------------------------------------------------------
   if (( passedt.barrier    == "fence" ) and
       ( passedt.fence_type == "hedge" )) then
      passedt.barrier = "hedge"
   end

-- ----------------------------------------------------------------------------
-- At this point let's try and handle hedge tags on other area features as
-- linear hedges.
-- "hedge" can be either a linear or an area feature in this style.
-- "hedgeline" can only be a linear feature in this style.
-- ----------------------------------------------------------------------------
   if ((   passedt.barrier    == "hedge"              ) and
       ((( passedt.landuse    ~= nil                )   and
         ( passedt.landuse    ~= ""                 ))  or
        (( passedt.natural    ~= nil                )   and
         ( passedt.natural    ~= ""                 ))  or
        (( passedt.leisure    ~= nil                )   and
         ( passedt.leisure    ~= ""                 ))  or
        (( passedt.amenity    ~= nil                )   and
         ( passedt.amenity    ~= ""                 ))  or
        (( passedt.historic   ~= nil                )   and
         ( passedt.historic   ~= ""                 ))  or
        (( passedt.landcover  ~= nil                )   and
         ( passedt.landcover  ~= ""                 ))  or
        (( passedt.tourism    ~= nil                )   and
         ( passedt.tourism    ~= ""                 ))  or
        (  passedt.man_made   == "wastewater_plant"  )  or
        (( passedt.surface    ~= nil                )   and
         ( passedt.surface    ~= ""                 )))) then
      passedt.barrier = "hedgeline"
   end

-- ----------------------------------------------------------------------------
-- map "alleged shrubberies" as hedge areas.
-- ----------------------------------------------------------------------------
   if ((  passedt.natural == "shrubbery"  ) and
       (( passedt.barrier == nil         )  or
        ( passedt.barrier == ""          ))) then
      passedt.natural = nil
      passedt.barrier = "hedge"
      passedt.area = "yes"
   end

-- ----------------------------------------------------------------------------
-- barrier=horse_jump is used almost exclusively on ways, so map to fence.
-- Also some other barriers.
-- ----------------------------------------------------------------------------
   if (( passedt.barrier == "horse_jump"     ) or
       ( passedt.barrier == "traffic_island" ) or
       ( passedt.barrier == "wire_fence"     ) or
       ( passedt.barrier == "wood_fence"     ) or
       ( passedt.barrier == "guard_rail"     ) or
       ( passedt.barrier == "railing"        )) then
      passedt.barrier = "fence"
   end

-- ----------------------------------------------------------------------------
-- barrier=ditch; handle as waterway=ditch.
-- ----------------------------------------------------------------------------
   if ( passedt.barrier == "ditch" ) then
      passedt.waterway = "ditch"
      passedt.barrier  = nil
   end

-- ----------------------------------------------------------------------------
-- There's now a barrier=kissing_gate icon.
-- For gates, choose which of the two gate icons to used based on tagging.
-- "sally_port" is mapped to gate largely because of misuse in the data.
-- ----------------------------------------------------------------------------
   if ((  passedt.barrier   == "turnstile"              )  or
       (  passedt.barrier   == "full-height_turnstile"  )  or
       (  passedt.barrier   == "kissing_gate;gate"      )  or
       (( passedt.barrier   == "gate"                  )   and
        ( passedt.gate      == "kissing"               ))) then
      passedt.barrier = "kissing_gate"
   end

-- ----------------------------------------------------------------------------
-- gates
-- ----------------------------------------------------------------------------
   if (( passedt.barrier   == "gate"                  )  or
       ( passedt.barrier   == "swing_gate"            )  or
       ( passedt.barrier   == "footgate"              )  or
       ( passedt.barrier   == "wicket_gate"           )  or
       ( passedt.barrier   == "hampshire_gate"        )  or
       ( passedt.barrier   == "bump_gate"             )  or
       ( passedt.barrier   == "lych_gate"             )  or
       ( passedt.barrier   == "lytch_gate"            )  or
       ( passedt.barrier   == "flood_gate"            )  or
       ( passedt.barrier   == "sally_port"            )  or
       ( passedt.barrier   == "pengate"               )  or
       ( passedt.barrier   == "pengates"              )  or
       ( passedt.barrier   == "gate;stile"            )  or
       ( passedt.barrier   == "cattle_grid;gate"      )  or
       ( passedt.barrier   == "gate;kissing_gate"     )  or
       ( passedt.barrier   == "pull_apart_gate"       )  or
       ( passedt.barrier   == "snow_gate"             )) then
      if (( passedt.locked == "yes"         ) or
          ( passedt.locked == "permanently" ) or
          ( passedt.status == "locked"      ) or
          ( passedt.gate   == "locked"      )) then
         passedt.barrier = "gate_locked"
      else
         passedt.barrier = "gate"
      end
   end

-- ----------------------------------------------------------------------------
-- lift gates
-- ----------------------------------------------------------------------------
   if (( passedt.barrier    == "border_control"   ) or
       ( passedt.barrier    == "ticket_barrier"   ) or
       ( passedt.barrier    == "ticket"           ) or
       ( passedt.barrier    == "security_control" ) or
       ( passedt.barrier    == "checkpoint"       ) or
       ( passedt.industrial == "checkpoint"       ) or
       ( passedt.barrier    == "gatehouse"        )) then
      passedt.barrier = "lift_gate"
   end

-- ----------------------------------------------------------------------------
-- render barrier=bar as barrier=horse_stile (Norfolk)
-- ----------------------------------------------------------------------------
   if ( passedt.barrier == "bar" ) then
      passedt.barrier = "horse_stile"
   end

-- ----------------------------------------------------------------------------
-- render various cycle barrier synonyms
-- ----------------------------------------------------------------------------
   if (( passedt.barrier   == "chicane"               )  or
       ( passedt.barrier   == "squeeze"               )  or
       ( passedt.barrier   == "motorcycle_barrier"    )  or
       ( passedt.barrier   == "horse_barrier"         )  or
       ( passedt.barrier   == "a_frame"               )) then
      passedt.barrier = "cycle_barrier"
   end

-- ----------------------------------------------------------------------------
-- render various synonyms for stile as barrier=stile
-- ----------------------------------------------------------------------------
   if (( passedt.barrier   == "squeeze_stile"   )  or
       ( passedt.barrier   == "ramblers_gate"   )  or
       ( passedt.barrier   == "squeeze_point"   )  or
       ( passedt.barrier   == "step_over"       )  or
       ( passedt.barrier   == "stile;gate"      )) then
      passedt.barrier = "stile"
   end

-- ----------------------------------------------------------------------------
-- Has this stile got a dog gate?
-- ----------------------------------------------------------------------------
   if (( passedt.barrier  == "stile" ) and
       ( passedt.dog_gate == "yes"   )) then
      passedt.barrier = "dog_gate_stile"
   end

-- ----------------------------------------------------------------------------
-- remove barrier=entrance as it's not really a barrier.
-- ----------------------------------------------------------------------------
   if ( passedt.barrier   == "entrance" ) then
      passedt.barrier = nil
   end

-- ----------------------------------------------------------------------------
-- Render main entrances
-- Note that "railway=train_station_entrance" isn't shown as a subway entrance.
-- ----------------------------------------------------------------------------
   if ((( passedt.entrance         == "main"                   )  or
        ( passedt.building         == "entrance"               )  or
        ( passedt.entrance         == "entrance"               )  or
        ( passedt.public_transport == "entrance"               )  or
        ( passedt.railway          == "entrance"               )  or
        ( passedt.railway          == "train_station_entrance" )  or
        ( passedt.school           == "entrance"               )) and
       (( passedt.amenity          == nil                      )  or
        ( passedt.amenity          == ""                       )) and
       (( passedt.barrier          == nil                      )  or
        ( passedt.barrier          == ""                       )) and
       (( passedt.building         == nil                      )  or
        ( passedt.building         == ""                       )) and
       (( passedt.craft            == nil                      )  or
        ( passedt.craft            == ""                       )) and
       (( passedt.highway          == nil                      )  or
        ( passedt.highway          == ""                       )) and
       (( passedt.office           == nil                      )  or
        ( passedt.office           == ""                       )) and
       (( passedt.shop             == nil                      )  or
        ( passedt.shop             == ""                       )) and
       (( passedt.tourism          == nil                      )  or
        ( passedt.tourism          == ""                       ))) then
      passedt.amenity = "entrancemain"
   end

-- ----------------------------------------------------------------------------
-- natural=tree_row was added to the standard style file after my version.
-- I'm not convinced that it makes sense to distinguish from hedge, so I'll
-- just display as hedge.
-- ----------------------------------------------------------------------------
   if ( passedt.natural   == "tree_row" ) then
      passedt.barrier = "hedgeline"
   end

-- ----------------------------------------------------------------------------
-- Render castle_wall as city_wall
-- ----------------------------------------------------------------------------
   if (( passedt.barrier   == "wall"        )  and
       ( passedt.wall      == "castle_wall" )) then
      passedt.historic = "citywalls"
   end

-- ----------------------------------------------------------------------------
-- Render lines on sports pitches
-- ----------------------------------------------------------------------------
   if ( passedt.pitch == "line" ) then
      passedt.barrier = "pitchline"
   end

-- ----------------------------------------------------------------------------
-- Climbing features (boulders, stones, etc.)
-- Deliberately only use this for outdoor features that would not otherwise
-- display, so not cliffs etc.
-- ----------------------------------------------------------------------------
   if ((( passedt.sport    == "climbing"            )  or
        ( passedt.sport    == "climbing;bouldering" )  or
        ( passedt.climbing == "boulder"             )) and
       (  passedt.natural  ~= "hill"           ) and
       (  passedt.natural  ~= "peak"           ) and
       (  passedt.natural  ~= "cliff"          ) and
       (  passedt.leisure  ~= "sports_centre"  ) and
       (  passedt.leisure  ~= "climbing_wall"  ) and
       (  passedt.shop     ~= "sports"         ) and
       (  passedt.tourism  ~= "attraction"     ) and
       (( passedt.building == nil             )  or
        ( passedt.building == ""              )) and
       (  passedt.man_made ~= "tower"          ) and
       (  passedt.barrier  ~= "wall"           ) and
       (  passedt.amenity  ~= "pitch_climbing" )) then
      passedt.natural = "climbing"
   end

-- ----------------------------------------------------------------------------
-- Big peaks and big prominent peaks
-- ----------------------------------------------------------------------------
   if ((  passedt.natural              == "peak"     ) and
       (( tonumber(passedt.ele) or 0 ) >  914        )) then
      if (( tonumber(passedt.prominence) or 0 ) == 0 ) then
         if ( passedt.munro == "yes" ) then
            passedt.prominence = "0"
         else
            passedt.prominence = passedt.ele
	 end
      end
      if (( tonumber(passedt.prominence) or 0 ) >  500 ) then
         passedt.natural = "bigprompeak"
      else
         passedt.natural = "bigpeak"
      end
   end

-- ----------------------------------------------------------------------------
-- natural=fell is used for all sorts of things, but render as heath, except
-- where someone's mapped it on a footpath.
-- ----------------------------------------------------------------------------
   if ( passedt.natural == "fell" ) then
      if (( passedt.highway == nil ) or
          ( passedt.highway == ""  )) then
         passedt.natural = "heath"
      else
         passedt.natural = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Do show loungers as benches.
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "lounger" ) then
      passedt.amenity = "bench"
   end

-- ----------------------------------------------------------------------------
-- Don't show "standing benches" as benches.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "bench"          ) and
       ( passedt.bench   == "stand_up_bench" )) then
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Get rid of landuse=conservation if we can.  It's a bit of a special case;
-- in raster maps it has a label like grass but no green fill.
-- ----------------------------------------------------------------------------
   if ((   passedt.landuse  == "conservation"   ) and
       ((( passedt.historic ~= nil            )   and
         ( passedt.historic ~= ""             ))  or
        (( passedt.leisure  ~= nil            )   and
         ( passedt.leisure  ~= ""             ))  or
        (( passedt.natural  ~= nil            )   and
         ( passedt.natural  ~= ""             )))) then
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

      if ((( passedt.landuse               == nil      )   or
           ( passedt.landuse               == ""       ))  and
          (( passedt.leisure               == nil      )   or
           ( passedt.leisure               == ""       ))  and
          (( passedt.natural               == nil      )   or
           ( passedt.natural               == ""       ))  and
          (  passedt.historicCcivilization ~= "modern"  )) then
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
-- If we still have an "amenity=place_of_worship", 
-- send places of worship through to the vector rendering code as 
-- a specific place_of_woship type (raster does not do this)
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "place_of_worship" ) then
      if ( passedt.religion == "christian" ) then
         passedt.amenity = "place_of_worship_christian"
      else
         if ( passedt.religion == "muslim" ) then
            passedt.amenity = "place_of_worship_muslim"
         else
            if ( passedt.religion == "sikh" ) then
               passedt.amenity = "place_of_worship_sikh"
            else
               if ( passedt.religion == "jewish" ) then
                  passedt.amenity = "place_of_worship_jewish"
               else
                  if ( passedt.religion == "hindu" ) then
                     passedt.amenity = "place_of_worship_hindu"
                  else
                     if ( passedt.religion == "buddhist" ) then
                        passedt.amenity = "place_of_worship_buddhist"
                     else
                        if ( passedt.religion == "shinto" ) then
                           passedt.amenity = "place_of_worship_shinto"
                        else
                           if ( passedt.religion == "taoist" ) then
                              passedt.amenity = "place_of_worship_taoist"
                           else
                              passedt.amenity = "place_of_worship_other"
                           end
                        end
                     end
                  end
               end
            end
         end
      end
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
-- Render shop=newsagent as shop=convenience
-- It's near enough in meaning I think.  Likewise kiosk (bit of a stretch,
-- but nearer than anything else)
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "newsagent"           ) or
       ( passedt.shop   == "kiosk"               ) or
       ( passedt.shop   == "forecourt"           ) or
       ( passedt.shop   == "food"                ) or
       ( passedt.shop   == "grocery"             ) or
       ( passedt.shop   == "grocer"              ) or
       ( passedt.shop   == "frozen_food"         ) or
       ( passedt.shop   == "convenience;alcohol" )) then
      passedt.shop = "convenience"
   end

-- ----------------------------------------------------------------------------
-- Render "eco" shops with their own icons
-- ----------------------------------------------------------------------------
   if ((   passedt.shop               == "zero_waste"          ) or
       (   passedt.shop               == "eco_refill"          ) or
       (   passedt.shop               == "refill"              ) or
       ((( passedt.shop               == "convenience"        )  or
         ( passedt.shop               == "general"            )  or
         ( passedt.shop               == "grocer"             )  or
         ( passedt.shop               == "grocery"            )  or
         ( passedt.shop               == "yes"                )  or
         ( passedt.shop               == "food"               )) and
        (( passedt.zero_waste         == "yes"                )  or
         ( passedt.zero_waste         == "only"               )  or
         ( passedt.bulk_purchase      == "yes"                )  or
         ( passedt.bulk_purchase      == "only"               )  or
         ( passedt.reusable_packaging == "yes"                )))) then
      passedt.shop = "ecoconv"
   end

   if ((  passedt.shop               == "supermarket"         ) and
       (( passedt.zero_waste         == "yes"                )  or
        ( passedt.zero_waste         == "only"               )  or
        ( passedt.bulk_purchase      == "yes"                )  or
        ( passedt.bulk_purchase      == "only"               )  or
        ( passedt.reusable_packaging == "yes"                ))) then
      passedt.shop = "ecosupermarket"
   end

   if ((  passedt.shop               == "greengrocer"         ) and
       (( passedt.zero_waste         == "yes"                )  or
        ( passedt.zero_waste         == "only"               )  or
        ( passedt.bulk_purchase      == "yes"                )  or
        ( passedt.bulk_purchase      == "only"               )  or
        ( passedt.reusable_packaging == "yes"                ))) then
      passedt.shop = "ecogreengrocer"
   end

-- ----------------------------------------------------------------------------
-- Render shop=variety etc. with a "pound" icon.  "variety_store" is the most 
-- popular tagging but "variety" is also used.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "variety"       ) or
       ( passedt.shop   == "pound"         ) or
       ( passedt.shop   == "thrift"        ) or
       ( passedt.shop   == "variety_store" )) then
      passedt.shop = "discount"
   end

-- ----------------------------------------------------------------------------
-- shoe shops
-- ----------------------------------------------------------------------------
   if (( passedt.shop == "shoes"        ) or
       ( passedt.shop == "footwear"     )) then
      passedt.shop = "shoes"
   end

-- ----------------------------------------------------------------------------
-- "clothes" consolidation.  "baby_goods" is here because there will surely
-- be some clothes there!
-- ----------------------------------------------------------------------------
   if (( passedt.shop == "fashion"      ) or
       ( passedt.shop == "boutique"     ) or
       ( passedt.shop == "vintage"      ) or
       ( passedt.shop == "bridal"       ) or
       ( passedt.shop == "wedding"      ) or
       ( passedt.shop == "baby_goods"   ) or
       ( passedt.shop == "baby"         ) or
       ( passedt.shop == "dance"        ) or
       ( passedt.shop == "clothes_hire" ) or
       ( passedt.shop == "clothing"     ) or
       ( passedt.shop == "hat"          ) or
       ( passedt.shop == "hats"         ) or
       ( passedt.shop == "wigs"         )) then
      passedt.shop = "clothes"
   end

-- ----------------------------------------------------------------------------
-- "electronics"
-- Looking at the tagging of shop=electronics, there's a fair crossover with 
-- electrical.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "electronics"             ) or
       ( passedt.craft   == "electronics_repair"      ) or
       ( passedt.shop    == "electronics_repair"      ) or
       ( passedt.amenity == "electronics_repair"      )) then
      passedt.shop = "electronics"
   end

-- ----------------------------------------------------------------------------
-- "electrical" consolidation
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "radiotechnics"           ) or
       ( passedt.shop    == "appliance"               ) or
       ( passedt.shop    == "electrical_supplies"     ) or
       ( passedt.shop    == "electrical_repair"       ) or
       ( passedt.shop    == "tv_repair"               ) or
       ( passedt.shop    == "gadget"                  ) or
       ( passedt.shop    == "appliances"              ) or
       ( passedt.shop    == "vacuum_cleaner"          ) or
       ( passedt.shop    == "sewing_machines"         ) or
       ( passedt.shop    == "domestic_appliances"     ) or
       ( passedt.shop    == "white_goods"             ) or
       ( passedt.shop    == "electricals"             ) or
       ( passedt.trade   == "electrical"              ) or
       ( passedt.name    == "City Electrical Factors" )) then
      passedt.shop = "electrical"
   end

-- ----------------------------------------------------------------------------
-- Show industrial=distributor as offices.
-- This sounds odd, but matches how this is used UK/IE
-- ----------------------------------------------------------------------------
   if ((  passedt.industrial == "distributor" ) and
       (( passedt.office     == nil          ) or
        ( passedt.office     == ""           ))) then
      passedt.office = "yes"
   end

-- ----------------------------------------------------------------------------
-- "funeral" consolidation.  All of these spellings currently in use in the UK
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "funeral"             ) or
       ( passedt.office  == "funeral_director"    ) or
       ( passedt.office  == "funeral_directors"   ) or
       ( passedt.amenity == "funeral"             ) or
       ( passedt.amenity == "funeral_directors"   ) or
       ( passedt.amenity == "undertaker"          )) then
      passedt.shop = "funeral_directors"
   end

-- ----------------------------------------------------------------------------
-- "jewellery" consolidation.  "jewelry" is in the database, until recently
-- "jewellery" was too.  The style handles "jewellery", hence the change here.
-- ----------------------------------------------------------------------------
   if (( passedt.shop  == "jewelry"                 ) or
       ( passedt.shop  == "jewelry;pawnbroker"      ) or
       ( passedt.shop  == "yes;jewelry;e-cigarette" ) or
       ( passedt.shop  == "jewelry;sunglasses"      ) or
       ( passedt.shop  == "yes;jewelry"             ) or
       ( passedt.shop  == "jewelry;art;crafts"      ) or
       ( passedt.shop  == "jewelry;fabric"          ) or
       ( passedt.shop  == "watch"                   ) or
       ( passedt.shop  == "watches"                 ) or
       ( passedt.craft == "jeweller"                ) or
       ( passedt.craft == "jewellery_repair"        ) or
       ( passedt.craft == "engraver"                )) then
      passedt.shop  = "jewellery"
      passedt.craft = nil
   end

-- ----------------------------------------------------------------------------
-- "department_store" consolidation.
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "department" ) then
      passedt.shop = "department_store"
   end

-- ----------------------------------------------------------------------------
-- "catalogue shop" consolidation.
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "outpost"  ) then
      passedt.shop = "catalogue"
   end

-- ----------------------------------------------------------------------------
-- man_made=flagpole
-- Non-MOD ones are passed straight through to be rendered.  MOD ones are
-- changed to flagpole_red so that they can be rendered differently.
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "flagpole"             )  and
       (( passedt.operator == "Ministry of Defence" )   or
        ( passedt.operator == "MOD"                 ))) then
      passedt.man_made = "flagpole_red"
      passedt.operator = nil
   end

-- ----------------------------------------------------------------------------
-- Windsocks
-- ----------------------------------------------------------------------------
   if (( passedt.aeroway  == "windsock" ) or
       ( passedt.landmark == "windsock" )) then
      passedt.man_made = "windsock"
   end
   
-- ----------------------------------------------------------------------------
-- Before potentially using brand or operator as a bracketed suffix after the
-- name, explicitly exclude some "non-brands" - "Independent", etc.
-- ----------------------------------------------------------------------------
   if (( passedt.brand   == "Independant"            ) or
       ( passedt.brand   == "Independent"            ) or
       ( passedt.brand   == "Traditional Free House" ) or
       ( passedt.brand   == "independant"            ) or
       ( passedt.brand   == "independent"            )) then
      passedt.brand = nil
   end

   if (( passedt.operator   == "(free_house)"            ) or
       ( passedt.operator   == "Free Brewery"            ) or
       ( passedt.operator   == "Free House"              ) or
       ( passedt.operator   == "Free house"              ) or
       ( passedt.operator   == "Free"                    ) or
       ( passedt.operator   == "Freehold"                ) or
       ( passedt.operator   == "Freehouse"               ) or
       ( passedt.operator   == "Independant"             ) or
       ( passedt.operator   == "Independent"             ) or
       ( passedt.operator   == "free house"              ) or
       ( passedt.operator   == "free"                    ) or
       ( passedt.operator   == "free_house"              ) or
       ( passedt.operator   == "freehouse"               ) or
       ( passedt.operator   == "independant"             ) or
       ( passedt.operator   == "independent free house"  ) or
       ( passedt.operator   == "independent"             )) then
      passedt.operator = nil
   end

-- ----------------------------------------------------------------------------
-- Handle these as bicycle_rental:
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "bicycle_parking;bicycle_rental" ) then
      passedt.amenity = "bicycle_rental"
   end

-- ----------------------------------------------------------------------------
-- If no name use brand or operator on amenity=fuel, among others.  
-- If there is brand or operator, use that with name.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity   == "atm"              ) or
       ( passedt.amenity   == "fuel"             ) or
       ( passedt.amenity   == "fuel_e"           ) or
       ( passedt.amenity   == "fuel_h"           ) or
       ( passedt.amenity   == "fuel_l"           ) or
       ( passedt.amenity   == "fuel_w"           ) or
       ( passedt.amenity   == "charging_station" ) or
       ( passedt.amenity   == "bicycle_rental"   ) or
       ( passedt.amenity   == "scooter_rental"   ) or
       ( passedt.amenity   == "vending_machine"   ) or
       (( passedt.amenity  ~= nil                )  and
        ( string.match( passedt.amenity, "pub_" ))) or
       ( passedt.amenity   == "pub"               ) or
       ( passedt.amenity   == "cafe"             ) or
       ( passedt.amenity   == "cafe_dld"         ) or
       ( passedt.amenity   == "cafe_dnd"         ) or
       ( passedt.amenity   == "cafe_dyd"         ) or
       ( passedt.amenity   == "cafe_ydd"         ) or
       ( passedt.amenity   == "cafe_yld"         ) or
       ( passedt.amenity   == "cafe_ynd"         ) or
       ( passedt.amenity   == "cafe_yyd"         ) or
       ( passedt.amenity   == "restaurant"       ) or
       ( passedt.amenity   == "restaccomm"       ) or
       ( passedt.amenity   == "doctors"          ) or
       ( passedt.amenity   == "pharmacy"         ) or
       ( passedt.amenity   == "pharmacy_l"       ) or
       ( passedt.amenity   == "pharmacy_n"       ) or
       ( passedt.amenity   == "pharmacy_y"       ) or
       ( passedt.amenity   == "parcel_locker"    ) or
       ( passedt.amenity   == "veterinary"       ) or
       ( passedt.amenity   == "animal_boarding"  ) or
       ( passedt.amenity   == "cattery"          ) or
       ( passedt.amenity   == "kennels"          ) or
       ( passedt.amenity   == "animal_shelter"   ) or
       ( passedt.animal    == "shelter"          ) or
       ( passedt.craft      ~= nil               ) or
       ( passedt.emergency  ~= nil               ) or
       ( passedt.industrial ~= nil               ) or
       ( passedt.man_made   ~= nil               ) or
       ( passedt.office     ~= nil               ) or
       ( passedt.shop       ~= nil               ) or
       ( passedt.tourism    == "hotel"           ) or
       ( passedt.military   == "barracks"        )) then
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         if (( passedt.brand ~= nil ) and
             ( passedt.brand ~= ""  )) then
            passedt.name = passedt.brand
            passedt.brand = nil
         else
            if (( passedt.operator ~= nil ) and
                ( passedt.operator ~= ""  )) then
               passedt.name = passedt.operator
               passedt.operator = nil
            end
         end
      else
         if (( passedt.brand ~= nil                                ) and
             ( passedt.brand ~= ""                                 ) and
             ( not string.match( passedt.name, passedt.brand )) and
             ( not string.match( passedt.brand, passedt.name ))) then
            passedt.name = passedt.name .. " (" .. passedt.brand .. ")"
            passedt.brand = nil
	 else
            if (( passedt.operator ~= nil                                ) and
                ( passedt.operator ~= ""                                 ) and
                ( not string.match( passedt.name, passedt.operator )) and
                ( not string.match( passedt.operator, passedt.name ))) then
               passedt.name = passedt.name .. " (" .. passedt.operator .. ")"
               passedt.operator = nil
            end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- emergency=water_rescue is a poorly-designed key that makes it difficult to
-- tell e.g. lifeboats from lifeboat stations.
-- However, if we've got one of various buildings, it's a lifeboat station.
-- ----------------------------------------------------------------------------
   if (  passedt.emergency == "water_rescue" ) then
      if (( passedt.building  == "boathouse"        ) or
          ( passedt.building  == "commercial"       ) or
          ( passedt.building  == "container"        ) or
          ( passedt.building  == "house"            ) or
          ( passedt.building  == "industrial"       ) or
          ( passedt.building  == "lifeboat_station" ) or
          ( passedt.building  == "no"               ) or
          ( passedt.building  == "office"           ) or
          ( passedt.building  == "public"           ) or
          ( passedt.building  == "retail"           ) or
          ( passedt.building  == "roof"             ) or
          ( passedt.building  == "ruins"            ) or
          ( passedt.building  == "service"          ) or
          ( passedt.building  == "yes"              )) then
         passedt.emergency = "lifeboat_station"
      else
         if (( passedt.building                         == "ship"                ) or
             ( passedt.seamarkCrescue_stationCcategory  == "lifeboat_on_mooring" )) then
            passedt.amenity   = "lifeboat"
            passedt.emergency = nil
         else
            passedt.emergency = "lifeboat_station"
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Handling of objects not (yet) tagfiddled to "emergency=water_rescue":
-- Sometimes lifeboats are mapped in the see separately to the 
-- lifeboat station, and sometimes they're tagged _on_ the lifeboat station.
-- If the latter, show the lifeboat station.
-- Also detect lifeboats and coastguards tagged only as seamarks.
--
-- See below for the similar but different tag "emergency=water_rescue_station"
-- which seems to be used on buildings, huts, etc. (not lifeboats).
-- ----------------------------------------------------------------------------
   if ((  passedt.seamarkCrescue_stationCcategory == "lifeboat_on_mooring"  ) and
       (( passedt.amenity                         == nil                   )  or
        ( passedt.amenity                         == ""                    ))) then
      passedt.amenity  = "lifeboat"
   end

   if ((  passedt.seamarkCtype == "coastguard_station"  ) and
       (( passedt.amenity      == nil                  )  or
        ( passedt.amenity      == ""                   ))) then
      passedt.amenity  = "coast_guard"
   end

   if (( passedt.amenity   == "lifeboat"         ) and
       ( passedt.emergency == "lifeboat_station" )) then
      passedt.amenity  = nil
   end

-- ----------------------------------------------------------------------------
-- Similarly, various government offices.  Job Centres first.
-- Lifeboat stations are also in here.
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity    == "job_centre"               ) or
       (  passedt.amenity    == "jobcentre"                ) or
       (  passedt.name       == "Jobcentre Plus"           ) or
       (  passedt.name       == "JobCentre Plus"           ) or
       (  passedt.name       == "Job Centre Plus"          ) or
       (  passedt.office     == "government"               ) or
       (  passedt.office     == "police"                   ) or
       (  passedt.government == "police"                   ) or
       (  passedt.amenity    == "public_building"          ) or
       (  passedt.office     == "administrative"           ) or
       (  passedt.office     == "register"                 ) or
       (  passedt.amenity    == "register_office"          ) or
       (  passedt.office     == "council"                  ) or
       (  passedt.office     == "drainage_board"           ) or
       (  passedt.office     == "forestry"                 ) or
       (  passedt.amenity    == "courthouse"               ) or
       (  passedt.office     == "justice"                  ) or
       (  passedt.amenity    == "townhall"                 ) or
       (  passedt.amenity    == "village_hall"             ) or
       (  passedt.building   == "village_hall"             ) or
       (  passedt.amenity    == "crematorium"              ) or
       (  passedt.amenity    == "hall"                     ) or
       (  passedt.amenity    == "fire_station"             ) or
       (  passedt.emergency  == "fire_station"             ) or
       (  passedt.amenity    == "lifeboat_station"         ) or
       (  passedt.emergency  == "lifeboat_station"         ) or
       (  passedt.emergency  == "lifeguard_tower"          ) or
       (  passedt.emergency  == "water_rescue_station"     ) or
       (( passedt.emergency  == "lifeguard"               )  and
        (( passedt.lifeguard == "base"                   )   or
         ( passedt.lifeguard == "tower"                  ))) or
       (  passedt.amenity    == "coast_guard"              ) or
       (  passedt.emergency  == "coast_guard"              ) or
       (  passedt.emergency  == "ses_station"              ) or
       (  passedt.amenity    == "archive"                  )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "nonspecific"
      passedt.government  = nil
      passedt.tourism  = nil
   end

-- ----------------------------------------------------------------------------
-- Ambulance stations
-- ----------------------------------------------------------------------------
   if (( passedt.amenity   == "ambulance_station"       ) or
       ( passedt.emergency == "ambulance_station"       )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity  = "ambulance_station"
   end

   if (( passedt.amenity   == "mountain_rescue"       ) or
       ( passedt.emergency == "mountain_rescue"       )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity  = "mountain_rescue"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = "Mountain Rescue"
      end
   end

   if (( passedt.amenity   == "mountain_rescue_box"       ) or
       ( passedt.emergency == "rescue_box"                )) then
      passedt.amenity  = "mountain_rescue_box"

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = "Mountain Rescue Supplies"
      end
   end

-- ----------------------------------------------------------------------------
-- Current monasteries et al go through as "amenity=monastery"
-- Note that historic=gate are generally much smaller and are not included here.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "monastery" ) or
       ( passedt.amenity == "convent"   )) then
      passedt.amenity = "monastery"

      if (( passedt.landuse == nil ) or
          ( passedt.landuse == ""  )) then
         passedt.landuse = "unnamedcommercial"
      end
   end

-- ----------------------------------------------------------------------------
-- Non-government (commercial) offices that you might visit for a service.
-- "communication" below seems to be used for marketing / commercial PR.
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.office      == "it"                      ) or
       ( passedt.office      == "computer"                ) or
       ( passedt.office      == "consulting"              ) or
       ( passedt.office      == "construction_company"    ) or
       ( passedt.office      == "courier"                 ) or
       ( passedt.office      == "advertising"             ) or
       ( passedt.office      == "advertising_agency"      ) or
       ( passedt.amenity     == "post_depot"              ) or
       ( passedt.office      == "lawyer"                  ) or
       ( passedt.shop        == "lawyer"                  ) or
       ( passedt.amenity     == "lawyer"                  ) or
       ( passedt.shop        == "legal"                   ) or
       ( passedt.office      == "solicitor"               ) or
       ( passedt.shop        == "solicitor"               ) or
       ( passedt.amenity     == "solicitor"               ) or
       ( passedt.office      == "solicitors"              ) or
       ( passedt.amenity     == "solicitors"              ) or
       ( passedt.office      == "accountant"              ) or
       ( passedt.shop        == "accountant"              ) or
       ( passedt.office      == "accountants"             ) or
       ( passedt.amenity     == "accountants"             ) or
       ( passedt.office      == "tax_advisor"             ) or
       ( passedt.amenity     == "tax_advisor"             ) or
       ( passedt.office      == "employment_agency"       ) or
       ( passedt.office      == "home_care"               ) or
       ( passedt.healthcare  == "home_care"               ) or
       ( passedt.shop        == "employment_agency"       ) or
       ( passedt.shop        == "employment"              ) or
       ( passedt.shop        == "jobs"                    ) or
       ( passedt.office      == "recruitment_agency"      ) or
       ( passedt.office      == "recruitment"             ) or
       ( passedt.shop        == "recruitment"             ) or
       ( passedt.office      == "insurance"               ) or
       ( passedt.office      == "architect"               ) or
       ( passedt.office      == "telecommunication"       ) or
       ( passedt.office      == "financial"               ) or
       ( passedt.office      == "newspaper"               ) or
       ( passedt.office      == "delivery"                ) or
       ( passedt.amenity     == "delivery_office"         ) or
       ( passedt.amenity     == "sorting_office"          ) or
       ( passedt.office      == "parcel"                  ) or
       ( passedt.office      == "therapist"               ) or
       ( passedt.office      == "surveyor"                ) or
       ( passedt.office      == "geodesist"               ) or
       ( passedt.office      == "marketing"               ) or
       ( passedt.office      == "graphic_design"          ) or
       ( passedt.office      == "interior_design"         ) or
       ( passedt.office      == "builder"                 ) or
       ( passedt.office      == "training"                ) or
       ( passedt.office      == "web_design"              ) or
       ( passedt.office      == "design"                  ) or
       ( passedt.shop        == "design"                  ) or
       ( passedt.office      == "communication"           ) or
       ( passedt.office      == "security"                ) or
       ( passedt.office      == "engineer"                ) or
       ( passedt.office      == "engineering"             ) or
       ( passedt.craft       == "hvac"                    ) or
       ( passedt.office      == "hvac"                    ) or
       ( passedt.shop        == "heating"                 ) or
       ( passedt.office      == "laundry"                 ) or
       ( passedt.amenity     == "coworking_space"         ) or
       ( passedt.office      == "coworking"               ) or
       ( passedt.office      == "coworking_space"         ) or
       ( passedt.office      == "serviced_offices"        ) or
       ( passedt.amenity     == "studio"                  ) or
       ( passedt.amenity     == "prison"                  ) or
       ( passedt.amenity     == "music_school"            ) or
       ( passedt.amenity     == "cooking_school"          ) or
       ( passedt.craft       == "electrician"             ) or
       ( passedt.craft       == "electrician;plumber"     ) or
       ( passedt.office      == "electrician"             ) or
       ( passedt.shop        == "electrician"             )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Other nonspecific offices.  
-- If any of the "diplomatic" ones should be shown as embassies, the "office"
-- tag will have been removed above.
-- ----------------------------------------------------------------------------
   if (( passedt.office     == "it"                      ) or
       ( passedt.office     == "ngo"                     ) or
       ( passedt.office     == "organization"            ) or
       ( passedt.office     == "diplomatic"              ) or
       ( passedt.office     == "educational_institution" ) or
       ( passedt.office     == "university"              ) or
       ( passedt.office     == "charity"                 ) or
       ((( passedt.office          == nil              )   or
         ( passedt.office          == ""               ))  and
        (( passedt.social_facility == "outreach"       )   or
         ( passedt.social_facility == "food_bank"      ))) or
       ( passedt.office     == "religion"                ) or
       ( passedt.office     == "marriage_guidance"       ) or
       ( passedt.amenity    == "education_centre"        ) or
       ( passedt.man_made   == "observatory"             ) or
       ( passedt.man_made   == "telescope"               ) or
       ( passedt.amenity    == "laboratory"              ) or
       ( passedt.healthcare == "laboratory"              ) or
       ( passedt.amenity    == "medical_laboratory"      ) or
       ( passedt.amenity    == "research_institute"      ) or
       ( passedt.office     == "political_party"         ) or
       ( passedt.office     == "politician"              ) or
       ( passedt.office     == "political"               ) or
       ( passedt.office     == "property_maintenance"    ) or
       ( passedt.office     == "quango"                  ) or
       ( passedt.office     == "association"             ) or
       ( passedt.amenity    == "advice"                  ) or
       ( passedt.amenity    == "advice_service"          )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Similarly, nonspecific leisure facilities.
-- Non-private swimming pools:
--
-- Note - this is an old tag that was often used for the whole area 
-- (building etc.) of a swimming pool, although the wiki documentation wasn't 
-- explicit.  It corresponds best with "leisure=sports_centre" 
-- (rendered in its own right).  "leisure=swimming_pool" is for the wet bit;
-- that is also rendered in its own right (in blue).
-- Note there's no explicit "if private" check on the wet bit.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "swimming_pool" ) and
       ( passedt.access  ~= "no"            )) then
      passedt.leisure = "leisurenonspecific"
   end

-- ----------------------------------------------------------------------------
-- Render outdoor swimming areas with blue names (if named)
-- leisure=pool is either a turkish bath, a hot spring or a private 
-- swimming pool.
-- leisure=swimming is either a mistagged swimming area or a 
-- mistagged swimming pool
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "swimming_area" ) or
       ( passedt.leisure == "pool"          ) or
       ( passedt.leisure == "swimming"      )) then
      passedt.leisure = "swimming_pool"
   end

-- ----------------------------------------------------------------------------
-- A couple of odd sports taggings:
-- ----------------------------------------------------------------------------
   if ( passedt.leisure == "sport" ) then
      if ( passedt.sport   == "golf"  ) then
         passedt.leisure = "golf_course"
      else
         passedt.leisure = "leisurenonspecific"
      end
   end

-- ----------------------------------------------------------------------------
-- Try and catch grass on horse_riding
-- ----------------------------------------------------------------------------
   if ( passedt.leisure == "horse_riding" ) then
      passedt.leisure = "leisurenonspecific"

      if ((  passedt.surface == "grass"  ) and
          (( passedt.landuse == nil     )  or
           ( passedt.landuse == ""      ))) then
         passedt.landuse = "unnamedgrass"
      end
   end

-- ----------------------------------------------------------------------------
-- If we have any named leisure=outdoor_seating left, 
-- change it to "leisurenonspecific", but don't set landuse.
-- ----------------------------------------------------------------------------
   if (( passedt.leisure == "outdoor_seating" ) and
       ( passedt.name    ~= nil               ) and
       ( passedt.name    ~= ""                )) then
      passedt.leisure = "leisurenonspecific"
   end

-- ----------------------------------------------------------------------------
-- Mazes
-- ----------------------------------------------------------------------------
   if ((( passedt.leisure    == "maze" )  or
        ( passedt.attraction == "maze" )) and
       (( passedt.historic   == nil    )  or
        ( passedt.historic   == ""     ))) then
      passedt.leisure = "leisurenonspecific"
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Other nonspecific leisure.  We add an icon and label via "leisurenonspecific".
-- In most cases we also add unnamedcommercial landuse 
-- to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity  == "arts_centre"              ) or
       ( passedt.amenity  == "bingo"                    ) or
       ( passedt.amenity  == "boat_rental"              ) or
       ( passedt.amenity  == "brothel"                  ) or
       ( passedt.amenity  == "church_hall"              ) or
       ( passedt.amenity  == "club"                     ) or
       ( passedt.amenity  == "club_house"               ) or
       ( passedt.amenity  == "clubhouse"                ) or
       ( passedt.amenity  == "community_centre"         ) or
       ( passedt.amenity  == "community_hall"           ) or
       ( passedt.amenity  == "conference_centre"        ) or
       ( passedt.amenity  == "dancing_school"           ) or
       ( passedt.amenity  == "dojo"                     ) or
       ( passedt.amenity  == "escape_game"              ) or
       ( passedt.amenity  == "events_venue"             ) or
       ( passedt.amenity  == "exhibition_centre"        ) or
       ( passedt.amenity  == "function_room"            ) or
       ( passedt.amenity  == "gym"                      ) or
       ( passedt.amenity  == "outdoor_education_centre" ) or
       ( passedt.amenity  == "public_bath"              ) or
       ( passedt.amenity  == "scout_hall"               ) or
       ( passedt.amenity  == "scout_hut"                ) or
       ( passedt.amenity  == "social_centre"            ) or
       ( passedt.amenity  == "social_club"              ) or
       ( passedt.amenity  == "working_mens_club"        ) or
       ( passedt.amenity  == "youth_centre"             ) or
       ( passedt.amenity  == "youth_club"               ) or
       ( passedt.building == "club_house"               ) or
       ( passedt.building == "clubhouse"                ) or
       ( passedt.building == "community_centre"         ) or
       ( passedt.building == "scout_hut"                ) or
       ( passedt.club     == "scout"                    ) or
       ( passedt.club     == "scouts"                   ) or
       ( passedt.club     == "sport"                    ) or
       ((( passedt.club    == "yes"                   )   or
         ( passedt.club    == "social"                )   or
         ( passedt.club    == "freemasonry"           )   or
         ( passedt.club    == "sailing"               )   or
         ( passedt.club    == "youth"                 )   or
         ( passedt.club    == "politics"              )   or
         ( passedt.club    == "veterans"              )   or
         ( passedt.club    == "social_club"           )   or
         ( passedt.club    == "music"                 )   or
         ( passedt.club    == "working_men"           )   or
         ( passedt.club    == "yachting"              )   or
         ( passedt.club    == "tennis"                )   or
         ( passedt.club    == "army_cadets"           )   or
         ( passedt.club    == "sports"                )   or
         ( passedt.club    == "rowing"                )   or
         ( passedt.club    == "football"              )   or
         ( passedt.club    == "snooker"               )   or
         ( passedt.club    == "fishing"               )   or
         ( passedt.club    == "sea_scout"             )   or
         ( passedt.club    == "conservative"          )   or
         ( passedt.club    == "golf"                  )   or
         ( passedt.club    == "cadet"                 )   or
         ( passedt.club    == "youth_movement"        )   or
         ( passedt.club    == "bridge"                )   or
         ( passedt.club    == "bowling"               )   or
         ( passedt.club    == "air_cadets"            )   or
         ( passedt.club    == "scuba_diving"          )   or
         ( passedt.club    == "model_railway"         )   or
         ( passedt.club    == "boat"                  )   or
         ( passedt.club    == "card_games"            )   or
         ( passedt.club    == "girlguiding"           )   or
         ( passedt.club    == "guide"                 )   or
         ( passedt.club    == "photography"           )   or
         ( passedt.club    == "sea_cadets"            )   or
         ( passedt.club    == "theatre"               )   or
         ( passedt.club    == "women"                 )   or
         ( passedt.club    == "charity"               )   or
         ( passedt.club    == "bowls"                 )   or
         ( passedt.club    == "military"              )   or
         ( passedt.club    == "model_aircraft"        )   or
         ( passedt.club    == "labour_club"           )   or
         ( passedt.club    == "boxing"                )   or
         ( passedt.club    == "game"                  )   or
         ( passedt.club    == "automobile"            ))  and
        (( passedt.leisure == nil                     )   or
         ( passedt.leisure == ""                      ))  and
        (( passedt.amenity == nil                     )   or
         ( passedt.amenity == ""                      ))  and
        (( passedt.shop    == nil                     )   or
         ( passedt.shop    == ""                      ))  and
        (  passedt.name    ~= nil                      )  and
        (  passedt.name    ~= ""                       )) or
       ((  passedt.club    == "cricket"                )  and
        (( passedt.leisure == nil                     )   or
         ( passedt.leisure == ""                      ))  and
        (( passedt.amenity == nil                     )   or
         ( passedt.amenity == ""                      ))  and
        (( passedt.shop    == nil                     )   or
         ( passedt.shop    == ""                      ))  and
        (( passedt.landuse == nil                     )   or
         ( passedt.landuse == ""                      ))  and
        (( passedt.name    ~= nil                     )   and
         ( passedt.name    ~= ""                      ))) or
       ( passedt.gambling == "bingo"                    ) or
       ( passedt.leisure  == "adventure_park"           ) or
       ( passedt.leisure  == "beach_resort"             ) or
       ( passedt.leisure  == "bingo"                    ) or
       ( passedt.leisure  == "bingo_hall"               ) or
       ( passedt.leisure  == "bowling_alley"            ) or
       ( passedt.leisure  == "climbing"                 ) or
       ( passedt.leisure  == "club"                     ) or
       ( passedt.leisure  == "dance"                    ) or
       ( passedt.leisure  == "dojo"                     ) or
       ( passedt.leisure  == "escape_game"              ) or
       ( passedt.leisure  == "firepit"                  ) or
       ( passedt.leisure  == "fitness_centre"           ) or
       ( passedt.leisure  == "hackerspace"              ) or
       ( passedt.leisure  == "high_ropes_course"        ) or
       ( passedt.leisure  == "horse_riding"             ) or
       ( passedt.leisure  == "ice_rink"                 ) or
       ((  passedt.leisure == "indoor_golf"             )  and
        (( passedt.amenity == nil                      )   or
         ( passedt.amenity == ""                       ))) or
       ( passedt.leisure  == "indoor_play"              ) or
       ( passedt.leisure  == "inflatable_park"          ) or
       ( passedt.leisure  == "miniature_golf"           ) or
       ( passedt.leisure  == "resort"                   ) or
       ( passedt.leisure  == "sailing_club"             ) or
       ( passedt.leisure  == "sauna"                    ) or
       ( passedt.leisure  == "social_club"              ) or
       ( passedt.leisure  == "soft_play"                ) or
       ( passedt.leisure  == "summer_camp"              ) or
       ( passedt.leisure  == "trampoline"               ) or
       ( passedt.playground  == "trampoline"            ) or
       ( passedt.leisure  == "trampoline_park"          ) or
       ( passedt.leisure  == "water_park"               ) or
       ( passedt.leisure  == "yoga"                     ) or
       ((( passedt.leisure        == nil               )   or
         ( passedt.leisure        == ""                ))  and
        (( passedt.amenity        == nil               )   or
         ( passedt.amenity        == ""                ))  and
        (( passedt.shop           == nil               )   or
         ( passedt.shop           == ""                ))  and
        (  passedt.danceCteaching == "yes"              )) or
       ( passedt.name     == "Bingo Hall"               ) or
       ( passedt.name     == "Castle Bingo"             ) or
       ( passedt.name     == "Gala Bingo"               ) or
       ( passedt.name     == "Mecca Bingo"              ) or
       ( passedt.name     == "Scout Hall"               ) or
       ( passedt.name     == "Scout Hut"                ) or
       ( passedt.name     == "Scout hut"                ) or
       ( passedt.shop     == "boat_rental"              ) or
       ( passedt.shop     == "fitness"                  ) or
       ( passedt.sport    == "laser_tag"                ) or
       ( passedt.sport    == "model_aerodrome"          ) or
       ((( passedt.sport   == "yoga"                  )   or
         ( passedt.sport   == "yoga;pilates"          ))  and
        (( passedt.shop     == nil                    )   or
         ( passedt.shop     == ""                     ))  and
        (( passedt.amenity  == nil                    )   or
         ( passedt.amenity  == ""                     ))) or
       ( passedt.tourism  == "cabin"                    ) or
       ( passedt.tourism  == "resort"                   ) or
       ( passedt.tourism  == "trail_riding_station"     ) or
       ( passedt.tourism  == "wilderness_hut"           ) or
       (( passedt.building == "yes"                    )  and
        (( passedt.amenity  == nil                    )   or
         ( passedt.amenity  == ""                     ))  and
        (( passedt.leisure  == nil                    )   or
         ( passedt.leisure  == ""                     ))  and
        (  passedt.sport    ~= nil                     )  and
        (  passedt.sport    ~= ""                      ))) then
      if (( passedt.landuse == nil ) or
          ( passedt.landuse == ""  )) then
         passedt.landuse = "unnamedcommercial"
      end

      passedt.leisure = "leisurenonspecific"
      passedt.disusedCamenity = nil
   end

-- ----------------------------------------------------------------------------
-- Some museum / leisure combinations are likely more "leisury" than "museumy"
-- ----------------------------------------------------------------------------
   if (( passedt.tourism == "museum"             ) and 
       ( passedt.leisure == "leisurenonspecific" )) then
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Emergency phones
-- ----------------------------------------------------------------------------
   if ((  passedt.emergency == "phone"  ) and
       (( passedt.amenity   == nil     )  or
        ( passedt.amenity   == ""      ))) then
      passedt.amenity = "emergency_phone"
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
-- potentially remove disusedCamenity=grave_yard
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
-- that needs adding to more than one layer.  For example, something might 
-- be a nature reserve (which will end up in the "land1" layer") and a wood
-- (which will go into land2).  The code, mostly called from 
-- "generic_before_function()" makes sure that things that (mostly) should 
-- have names go in "land1" and things that should not go in "land2"
--
-- Each of "land1" and "land2" should also look after icons (and if relevent 
-- names) for things in that layer.  
--
-- After the "land1" processing we go into "generic_after_poi" to pick up 
-- any leftover names and/or icons that haven't already been processed as 
-- part of the "land1" layer.  
--
-- After that, "land2" is processed for any second tags that should also get
-- shown alongside "land1".  For example, "land1" may be 
-- "leisure=nature_reserve" and "land2" could be "natural=wood".
-- ----------------------------------------------------------------------------
    generic_after_building( passedt )
    
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
-- There are two "land" layers - "land1" and "land2".
-- Where two features might get shown, the lua code above adds the one to
-- show the label for to "land1" and adds the other "unnamed" one to "land2"
--
-- The first thing we process is non-intermittent water
-- 
-- land1 layer
-- ----------------------------------------------------------------------------
function generic_after_land1( passedt )
    if (( passedt.natural == "water"   ) or
        ( passedt.natural == "glacier" )) then
        Layer( "land1", true )
        Attribute( "class", "natural_" .. passedt.natural )
        Attribute( "name", Find( "name" ) )
        MinZoom( 5 )
    else
        render_amenity_land1( passedt )
    end
end -- generic_after_land1()

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
    else
        if (( passedt.amenity == "shelter"                    ) or
            ( passedt.amenity == "atm"                        ) or
            ( passedt.amenity == "bank"                       ) or
            ( passedt.amenity == "bank_l"                     ) or
            ( passedt.amenity == "bank_n"                     ) or
            ( passedt.amenity == "bank_y"                     ) or
            ( passedt.amenity == "bar"                        ) or
            ( passedt.amenity == "bar_ddd"                    ) or
            ( passedt.amenity == "bar_dld"                    ) or
            ( passedt.amenity == "bar_dnd"                    ) or
            ( passedt.amenity == "bar_dyd"                    ) or
            ( passedt.amenity == "bar_ydd"                    ) or
            ( passedt.amenity == "bar_yld"                    ) or
            ( passedt.amenity == "bar_ynd"                    ) or
            ( passedt.amenity == "bar_yyd"                    ) or
            ( passedt.amenity == "bar_ddy"                    ) or
            ( passedt.amenity == "bar_dly"                    ) or
            ( passedt.amenity == "bar_dny"                    ) or
            ( passedt.amenity == "bar_dyy"                    ) or
            ( passedt.amenity == "bar_ydy"                    ) or
            ( passedt.amenity == "bar_yly"                    ) or
            ( passedt.amenity == "bar_yny"                    ) or
            ( passedt.amenity == "bar_yyy"                    ) or
            ( passedt.amenity == "nightclub"                  ) or
            ( passedt.amenity == "concert_hall"               ) or
            ( passedt.amenity == "car_sharing"                ) or
            ( passedt.amenity == "taxi"                       ) or
            ( passedt.amenity == "taxi_office"                ) or
            ( passedt.amenity == "bicycle_rental"             ) or
            ( passedt.amenity == "scooter_rental"             ) or
            ( passedt.amenity == "bicycle_parking"            ) or
            ( passedt.amenity == "bicycle_parking_pay"        ) or
            ( passedt.amenity == "motorcycle_parking"         ) or
            ( passedt.amenity == "motorcycle_parking_pay"     ) or
            ( passedt.amenity == "bus_station"                ) or
            ( passedt.amenity == "ferry_terminal"             ) or
            ( passedt.amenity == "entrancemain"               ) or
            ( passedt.amenity == "cafe_ddd"                   ) or
            ( passedt.amenity == "cafe_dld"                   ) or
            ( passedt.amenity == "cafe_dnd"                   ) or
            ( passedt.amenity == "cafe_dyd"                   ) or
            ( passedt.amenity == "cafe_ydd"                   ) or
            ( passedt.amenity == "cafe_yld"                   ) or
            ( passedt.amenity == "cafe_ynd"                   ) or
            ( passedt.amenity == "cafe_yyd"                   ) or
            ( passedt.amenity == "cafe_ddy"                   ) or
            ( passedt.amenity == "cafe_dly"                   ) or
            ( passedt.amenity == "cafe_dny"                   ) or
            ( passedt.amenity == "cafe_dyy"                   ) or
            ( passedt.amenity == "cafe_ydy"                   ) or
            ( passedt.amenity == "cafe_yly"                   ) or
            ( passedt.amenity == "cafe_yny"                   ) or
            ( passedt.amenity == "cafe_yyy"                   ) or
            ( passedt.amenity == "cinema"                     ) or
            ( passedt.amenity == "fire_station"               ) or
            ( passedt.amenity == "lifeboat"                   ) or
            ( passedt.amenity == "fuel"                       ) or
            ( passedt.amenity == "fuel_e"                     ) or
            ( passedt.amenity == "fuel_h"                     ) or
            ( passedt.amenity == "fuel_l"                     ) or
            ( passedt.amenity == "fuel_w"                     ) or
            ( passedt.amenity == "charging_station"           ) or
            ( passedt.amenity == "embassy"                    ) or
            ( passedt.amenity == "library"                    ) or
            ( passedt.amenity == "courthouse"                 ) or
            ( passedt.amenity == "monastery"                  ) or
            ( passedt.amenity == "zooaviary"                  ) or
            ( passedt.amenity == "zooenclosure"               ) or
            ( passedt.amenity == "vending_machine"            ) or
            ( passedt.amenity == "vending_excrement"          ) or
            ( passedt.amenity == "bottle_return"              ) or
            ( passedt.amenity == "waste_basket"               ) or
            ( passedt.amenity == "waste_disposal"             ) or
            ( passedt.amenity == "grit_bin"                   ) or
            ( passedt.amenity == "left_luggage"               ) or
            ( passedt.amenity == "parcel_locker"              ) or
            ( passedt.amenity == "bench"                      ) or
            ( passedt.amenity == "playground_swing"           ) or
            ( passedt.amenity == "playground_structure"       ) or
            ( passedt.amenity == "playground_climbingframe"   ) or
            ( passedt.amenity == "playground_slide"           ) or
            ( passedt.amenity == "playground_springy"         ) or
            ( passedt.amenity == "playground_zipwire"         ) or
            ( passedt.amenity == "playground_seesaw"          ) or
            ( passedt.amenity == "playground_roundabout"      ) or
            ( passedt.amenity == "pitch_tabletennis"          ) or
            ( passedt.amenity == "pitch_soccer"               ) or
            ( passedt.amenity == "pitch_basketball"           ) or
            ( passedt.amenity == "pitch_cricket"              ) or
            ( passedt.amenity == "pitch_skateboard"           ) or
            ( passedt.amenity == "pitch_climbing"             ) or
            ( passedt.amenity == "pitch_rugby"                ) or
            ( passedt.amenity == "pitch_chess"                ) or
            ( passedt.amenity == "pitch_tennis"               ) or
            ( passedt.amenity == "pitch_athletics"            ) or
            ( passedt.amenity == "pitch_boules"               ) or
            ( passedt.amenity == "pitch_bowls"                ) or
            ( passedt.amenity == "pitch_croquet"              ) or
            ( passedt.amenity == "pitch_cycling"              ) or
            ( passedt.amenity == "pitch_equestrian"           ) or
            ( passedt.amenity == "pitch_gaa"                  ) or
            ( passedt.amenity == "pitch_hockey"               ) or
            ( passedt.amenity == "pitch_multi"                ) or
            ( passedt.amenity == "pitch_netball"              ) or
            ( passedt.amenity == "pitch_polo"                 ) or
            ( passedt.amenity == "pitch_shooting"             ) or
            ( passedt.amenity == "pitch_baseball"             ) or
            ( passedt.amenity == "doctors"                    ) or
            ( passedt.amenity == "dentist"                    ) or
            ( passedt.amenity == "pharmacy"                   ) or
            ( passedt.amenity == "pharmacy_l"                 ) or
            ( passedt.amenity == "pharmacy_n"                 ) or
            ( passedt.amenity == "pharmacy_y"                 ) or
            ( passedt.amenity == "ambulance_station"          ) or
            ( passedt.amenity == "mountain_rescue"            ) or
            ( passedt.amenity == "mountain_rescue_box"        ) or
            ( passedt.amenity == "place_of_worship_christian" ) or
            ( passedt.amenity == "place_of_worship_muslim"    ) or
            ( passedt.amenity == "place_of_worship_sikh"      ) or
            ( passedt.amenity == "place_of_worship_jewish"    ) or
            ( passedt.amenity == "place_of_worship_hindu"     ) or
            ( passedt.amenity == "place_of_worship_buddhist"  ) or
            ( passedt.amenity == "place_of_worship_shinto"    ) or
            ( passedt.amenity == "place_of_worship_taoist"    ) or
            ( passedt.amenity == "place_of_worship_other"     ) or
            ( passedt.amenity == "holy_spring"                ) or
            ( passedt.amenity == "holy_well"                  )) then
            Layer( "land1", true )
            Attribute( "class", "amenity_" .. passedt.amenity )
            Attribute( "name", Find( "name" ) )
            MinZoom( 14 )
        else
            render_landuse_land1( passedt )
        end -- amenity=shelter 15
    end -- amenity=parking etc. 9
end -- render_amenity_land1()

function render_landuse_land1( passedt )
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
end -- render_landuse_land1()

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
    if ( passedt.aeroway == "apron" ) then
        Layer( "land1", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        Attribute( "name", Find( "name" ) )
        MinZoom( 12 )
    else
-- ------------------------------------------------------------------------------
-- At this point we've done all thing "landuse" processing for things that might 
-- be in the "land1" layer, including displaying names and/or icons for them.
-- The call to "generic_after_poi()" below displays things that should also have
-- a name and/or an icon, but don't have an area fill or outline.
-- ------------------------------------------------------------------------------
            generic_after_poi( passedt )
    end -- aeroway=apron 12
end -- render_aeroway_land1()

-- ----------------------------------------------------------------------------
-- land2 layer
-- ----------------------------------------------------------------------------
function generic_after_land2( passedt )
    if (( passedt.natural == "intermittentwater" ) or
        ( passedt.natural == "flood_prone"       )) then
        Layer( "land2", true )
        Attribute( "class", "natural_" .. passedt.natural )
        Attribute( "name", Find( "name" ) )
        MinZoom( 9 )
    else
        render_landuse_land2( passedt )
    end
end -- generic_after_land2()

function render_landuse_land2( passedt )
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
        if ( passedt.leisure == "marina" ) then
            Layer( "land2", true )
            Attribute( "class", "leisure_" .. passedt.leisure )
            MinZoom( 13 )
        else
            render_natural_land2( passedt )
        end -- leisure=marina 13
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
    else
        render_boundary_land2( passedt )
    end -- aeroway=aerodrome 12
end -- render_aeroway_land2()

function render_boundary_land2( passedt )
    if ( passedt.boundary == "national_park" ) then
        Layer( "land2", true )
        Attribute( "class", "boundary_" .. passedt.boundary )
        Attribute( "name", Find( "name" ) )
        MinZoom( 6 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
    end -- boundary=national_park 6
end -- render_boundary_land2()


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
-- No else here yet
-- ------------------------------------------------------------------------------
                end -- tourism
            end -- shop
        end -- place
    end -- amenity
end -- generic_after_poi()

