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
node_keys = { "advertising", "aerialway", "aeroway", "amenity", "attraction", "barrier", 
              "canoe", "climbing", "craft", "disused:military", "emergency", 
              "entrance", "harbour", "historic", "healthcare", "highway", "information", 
              "landuse", "lcn_ref", "leisure", "man_made", 
              "military", "natural", "ncn_milepost", "pitch", "place", 
              "place_of_worship", "playground", "power", "railway", "shop", 
              "sport", "tourism", "waterway", "whitewater", "zoo" }

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
    nodet.oldCamenity = Find("old:amenity")
    nodet.historicCamenity = Find("historic:amenity")
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
    nodet.agrarian = Find("agrarian")
    nodet.height = Find("height")
    nodet.towerCconstruction = Find("tower:type")
    nodet.support = Find("support")
    nodet.buildingCpart = Find("building:part")
    nodet.drinking_water = Find("drinking_water")
    nodet.indoor = Find("indoor")
    nodet.rescue_equipment = Find("rescue_equipment")
    nodet.railwayChistoric = Find("railway:historic")
    nodet.railwayCpreserved = Find("railway:preserved")
    nodet.whitewater = Find("whitewater")
    nodet.canoe = Find("canoe")
    nodet.flow_control = Find("flow_control")
    nodet.historicCwaterway = Find("historic:waterway")
    nodet.abandonedCwaterway = Find("abandoned:waterway")
    nodet.waterwayChistoric = Find("waterway:historic")
    nodet.waterwayCabandoned = Find("waterway:abandoned")
    nodet.nameChistoric = Find("name:historic")
    nodet.historicCname = Find("historic:name")
    nodet.real_ale = Find("real_ale")
    nodet.beer_garden = Find("beer_garden")
    nodet.amenityCdisused = Find("amenity:disused")
    nodet.disusedCpub = Find("disused:pub")
    nodet.descriptionCfloor = Find("description:floor")
    nodet.floorCmaterial = Find("floor:material")
    nodet.micropub = Find("micropub")
    nodet.pub = Find("pub")
    nodet.opening_hoursCcovid19 = Find("opening_hours:covid19")
    nodet.accessCcovid19 = Find("access:covid19")
    nodet.food = Find("food")
    nodet.noncarpeted = Find("noncarpeted")
    nodet.microbrewery = Find("microbrewery")
    nodet.lamp_type = Find("lamp_type")
    nodet.departures_board = Find("departures_board")
    nodet.passenger_information_display = Find("passenger_information_display")
    nodet.disusedChighway = Find("disused:highway")
    nodet.physically_present = Find("physically_present")
    nodet.naptanCindicator = Find("naptan:indicator")
    nodet.bus_speech_output_name = Find("bus_speech_output_name")
    nodet.bus_display_name = Find("bus_display_name")
    nodet.website = Find("website")
    nodet.timetable = Find("timetable")
    nodet.departures_boardCspeech_output = Find("departures_board:speech_output")
    nodet.passenger_information_displayCspeech_output = Find("passenger_information_display:speech_output")
    nodet.flag = Find("flag")
    nodet.pole = Find("pole")
    nodet.naptanCBusStopType = Find("naptan:BusStopType")
    nodet.direction_north = Find("direction_north")
    nodet.direction_northeast = Find("direction_northeast")
    nodet.direction_east = Find("direction_east")
    nodet.direction_southeast = Find("direction_southeast")
    nodet.direction_south = Find("direction_south")
    nodet.direction_southwest = Find("direction_southwest")
    nodet.direction_west = Find("direction_west")
    nodet.direction_northwest = Find("direction_northwest")
    nodet.parking = Find("parking")
    nodet.opening_hours = Find("opening_hours")
    nodet.addrChousename = Find("addr:housename")
    nodet.addrCunit = Find("addr:unit")
    nodet.addrChousenumber = Find("addr:housenumber")
    nodet.areaChighway = Find("area:highway")
    nodet.lcn_ref = Find("lcn_ref")
    nodet.advertising = Find("advertising")
    nodet.volcanoCstatus = Find("volcano:status")
    nodet.route = Find("route")
    nodet.water = Find("water")
    nodet.aerialway = Find("aerialway")
    nodet.capital = Find("capital")

    generic_before_function( nodet )

-- ----------------------------------------------------------------------------
-- Node-specific code
-- Consolidate some "ford" values into "yes".
-- This is here rather than in "generic" because "generic" is called after this
-- There is a similar section in way-only.
-- ----------------------------------------------------------------------------
   if (( nodet.ford == "Tidal_Causeway" ) or
       ( nodet.ford == "ford"           ) or 
       ( nodet.ford == "intermittent"   ) or
       ( nodet.ford == "seasonal"       ) or
       ( nodet.ford == "stream"         ) or
       ( nodet.ford == "tidal"          )) then
      nodet.ford = "yes"
   end

   if ( nodet.ford == "yes" ) then
      nodet.highway = "ford"
      nodet.ford    = nil
   end

   if ( nodet.ford    == "stepping_stones" ) then
      nodet.barrier = "stepping_stones"
      nodet.ford    = nil
   end

-- ----------------------------------------------------------------------------
-- Map non-linear unknown (and some known) barriers to bollard
-- ----------------------------------------------------------------------------
   if (( nodet.barrier  == "yes"            ) or
       ( nodet.barrier  == "barrier"        ) or
       ( nodet.barrier  == "tank_trap"      ) or
       ( nodet.barrier  == "dragons_teeth"  ) or
       ( nodet.barrier  == "bollards"       ) or
       ( nodet.barrier  == "bus_trap"       ) or
       ( nodet.barrier  == "car_trap"       ) or
       ( nodet.barrier  == "rising_bollard" ) or
       ( nodet.barrier  == "steps"          ) or
       ( nodet.barrier  == "step"           ) or
       ( nodet.barrier  == "post"           ) or
       ( nodet.man_made == "post"           ) or
       ( nodet.man_made == "marker_post"    ) or
       ( nodet.man_made == "boundary_post"  ) or
       ( nodet.man_made == "concrete_post"  ) or
       ( nodet.barrier  == "stone"          ) or
       ( nodet.barrier  == "hoarding"       ) or
       ( nodet.barrier  == "sump_buster"    ) or
       ( nodet.barrier  == "gate_pier"      ) or
       ( nodet.barrier  == "gate_post"      ) or
       ( nodet.man_made == "gate_post"      ) or
       ( nodet.man_made == "gatepost"       ) or
       ( nodet.barrier  == "pole"           )) then
      nodet.barrier = "bollard"
   end

-- ----------------------------------------------------------------------------
-- Render barrier=chain on nodes as horse_stile.  At least sone of the time 
-- it's correct.
-- ----------------------------------------------------------------------------
   if ( nodet.barrier == "chain" ) then
      nodet.barrier = "horse_stile"
   end

-- ----------------------------------------------------------------------------
-- Render barrier=v_stile on nodes as stile.  
-- ----------------------------------------------------------------------------
   if ( nodet.barrier == "v_stile" ) then
      nodet.barrier = "stile"
   end

-- ----------------------------------------------------------------------------
-- highway=turning_loop on nodes to turning_circle
-- "turning_loop" is mostly used on nodes, with one way in UK/IE data.
-- ----------------------------------------------------------------------------
   if ( nodet.highway == "turning_loop" ) then
      nodet.highway = "turning_circle"
   end

-- ----------------------------------------------------------------------------
-- Change natural=bare_rock and natural=rocks on nodes to natural=rock
-- So that an icon (the all-black, non-climbing boulder one) is displayed
-- ----------------------------------------------------------------------------
   if (( nodet.natural == "bare_rock" ) or
       ( nodet.natural == "rocks"     ) or
       ( nodet.natural == "stones"    )) then
      nodet.natural = "rock"
   end

-- ----------------------------------------------------------------------------
-- If lcn_ref exists (for example as a location in a local cycling network),
-- render it via a "man_made" tag if there's no other tags on that node.
-- ----------------------------------------------------------------------------
   if ((  nodet.lcn_ref ~= nil  ) and
       (  nodet.lcn_ref ~= ""   ) and
       (( nodet.ref     == nil )  or
        ( nodet.ref     == ""  ))) then
      nodet.man_made = "lcn_ref"
      nodet.ref     = nodet.lcn_ref
      nodet.lcn_ref = nil
   end

-- ------------------------------------------------------------------------------
-- (end of the node-specific code)
--
-- Actually writing out nodes (and polygons) is done in "generic_after_function"
-- ------------------------------------------------------------------------------
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
    wayt.is_closed = IsClosed()
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
    wayt.oldCamenity = Find("old:amenity")
    wayt.historicCamenity = Find("historic:amenity")
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
    wayt.agrarian = Find("agrarian")
    wayt.height = Find("height")
    wayt.towerCconstruction = Find("tower:type")
    wayt.support = Find("support")
    wayt.buildingCpart = Find("building:part")
    wayt.drinking_water = Find("drinking_water")
    wayt.indoor = Find("indoor")
    wayt.rescue_equipment = Find("rescue_equipment")
    wayt.railwayChistoric = Find("railway:historic")
    wayt.railwayCpreserved = Find("railway:preserved")
    wayt.whitewater = Find("whitewater")
    wayt.canoe = Find("canoe")
    wayt.flow_control = Find("flow_control")
    wayt.historicCwaterway = Find("historic:waterway")
    wayt.abandonedCwaterway = Find("abandoned:waterway")
    wayt.waterwayChistoric = Find("waterway:historic")
    wayt.waterwayCabandoned = Find("waterway:abandoned")
    wayt.nameChistoric = Find("name:historic")
    wayt.historicCname = Find("historic:name")
    wayt.real_ale = Find("real_ale")
    wayt.beer_garden = Find("beer_garden")
    wayt.amenityCdisused = Find("amenity:disused")
    wayt.disusedCpub = Find("disused:pub")
    wayt.descriptionCfloor = Find("description:floor")
    wayt.floorCmaterial = Find("floor:material")
    wayt.micropub = Find("micropub")
    wayt.pub = Find("pub")
    wayt.opening_hoursCcovid19 = Find("opening_hours:covid19")
    wayt.accessCcovid19 = Find("access:covid19")
    wayt.food = Find("food")
    wayt.noncarpeted = Find("noncarpeted")
    wayt.microbrewery = Find("microbrewery")
    wayt.lamp_type = Find("lamp_type")
    wayt.departures_board = Find("departures_board")
    wayt.passenger_information_display = Find("passenger_information_display")
    wayt.disusedChighway = Find("disused:highway")
    wayt.physically_present = Find("physically_present")
    wayt.naptanCindicator = Find("naptan:indicator")
    wayt.bus_speech_output_name = Find("bus_speech_output_name")
    wayt.bus_display_name = Find("bus_display_name")
    wayt.website = Find("website")
    wayt.timetable = Find("timetable")
    wayt.departures_boardCspeech_output = Find("departures_board:speech_output")
    wayt.passenger_information_displayCspeech_output = Find("passenger_information_display:speech_output")
    wayt.flag = Find("flag")
    wayt.pole = Find("pole")
    wayt.naptanCBusStopType = Find("naptan:BusStopType")
    wayt.direction_north = Find("direction_north")
    wayt.direction_northeast = Find("direction_northeast")
    wayt.direction_east = Find("direction_east")
    wayt.direction_southeast = Find("direction_southeast")
    wayt.direction_south = Find("direction_south")
    wayt.direction_southwest = Find("direction_southwest")
    wayt.direction_west = Find("direction_west")
    wayt.direction_northwest = Find("direction_northwest")
    wayt.parking = Find("parking")
    wayt.opening_hours = Find("opening_hours")
    wayt.addrChousename = Find("addr:housename")
    wayt.addrCunit = Find("addr:unit")
    wayt.addrChousenumber = Find("addr:housenumber")
    wayt.areaChighway = Find("area:highway")
    wayt.lcn_ref = Find("lcn_ref")
    wayt.advertising = Find("advertising")
    wayt.volcanoCstatus = Find("volcano:status")
    wayt.route = Find("route")
    wayt.water = Find("water")
    wayt.aerialway = Find("aerialway")
    wayt.capital = Find("capital")

    generic_before_function( wayt )

-- ----------------------------------------------------------------------------
-- Way-specific code
-- Consolidate some "ford" values into "yes".
-- This is here rather than in "generic" because "generic" is called after this
-- There is a similar section in way-only.
-- ----------------------------------------------------------------------------
   if (( wayt.ford == "Tidal_Causeway" ) or
       ( wayt.ford == "ford"           ) or 
       ( wayt.ford == "intermittent"   ) or
       ( wayt.ford == "seasonal"       ) or
       ( wayt.ford == "stream"         ) or
       ( wayt.ford == "tidal"          )) then
      wayt.ford = "yes"
   end

-- ----------------------------------------------------------------------------
-- If a highway has tidal=yes but not yet a ford or bridge tag, add ford=yes
-- ----------------------------------------------------------------------------
   if ((  wayt.tidal   == "yes"  ) and
       (  wayt.highway ~= nil    ) and
       (  wayt.highway ~= ""     ) and
       (( wayt.ford    == nil   )  or
        ( wayt.ford    == ""    )) and
       (( wayt.bridge  == nil   )  or
        ( wayt.bridge  == ""    ))) then
      wayt.ford = "yes"
   end

-- ----------------------------------------------------------------------------
-- "barrier=gate" on a way is a dark line; on bridleways it looks 
-- "sufficiently different" to mark fords out.
-- ----------------------------------------------------------------------------
   if (( wayt.ford == "yes"             ) or
       ( wayt.ford == "stepping_stones" ))then
      wayt.barrier = "ford"
   end

-- ----------------------------------------------------------------------------
-- Treat a linear "door" and some other linear barriers as "gate"
--
-- A "lock_gate" mapped as a node gets its own "locks" layer in 
-- water-features.mss (for historical reasons that no longer make sense).
-- There's no explicit node or generic code for lock_gate.
-- ----------------------------------------------------------------------------
   if (( wayt.barrier  == "door"       ) or
       ( wayt.barrier  == "swing_gate" ) or
       ( wayt.waterway == "lock_gate"  )) then
      wayt.barrier  = "gate"
      wayt.waterway = nil
   end

-- ----------------------------------------------------------------------------
-- Map linear tank traps, and some others, to wall
-- ----------------------------------------------------------------------------
   if (( wayt.barrier == "tank_trap"      ) or
       ( wayt.barrier == "dragons_teeth"  ) or
       ( wayt.barrier == "obstruction"    ) or
       ( wayt.barrier == "sea_wall"       ) or
       ( wayt.barrier == "flood_wall"     ) or
       ( wayt.barrier == "block"          ) or
       ( wayt.barrier == "haha"           ) or
       ( wayt.barrier == "jersey_barrier" ) or
       ( wayt.barrier == "retaining_wall" )) then
      wayt.barrier = "wall"
   end

-- ----------------------------------------------------------------------------
-- Map linear unknown and other barriers to fence.
-- In some cases this is a bit of a stretch - you can walk up some steps, or
-- through a cycle barrier for example.  Fence was chosen as the "current
-- minimal thickness linear barrier".  If a narrower one is introduced it
-- would make sense to make traversable ones in this list to that.
-- ----------------------------------------------------------------------------
   if (( wayt.barrier == "yes"             ) or
       ( wayt.barrier == "barrier"         ) or
       ( wayt.barrier == "bollard"         ) or
       ( wayt.barrier == "steps"           ) or
       ( wayt.barrier == "step"            ) or
       ( wayt.barrier == "hoarding"        ) or
       ( wayt.barrier == "hand_rail_fence" ) or
       ( wayt.barrier == "horse_stile"     ) or
       ( wayt.barrier == "chain"           ) or
       ( wayt.barrier == "stile"           ) or
       ( wayt.barrier == "v_stile"         ) or
       ( wayt.barrier == "cycle_barrier"   )) then
      wayt.barrier = "fence"
   end

   if (( wayt.public_transport == "platform" ) and
       ( wayt.highway          ~= "platform" ) and
       ( wayt.highway          ~= "bus_stop" ) and
       ( wayt.railway          ~= "platform" )) then
      wayt.highway = "platform"
   end

-- ----------------------------------------------------------------------------
-- Map sinkholes mapped as ways to a non-area cliff.
-- It's pot luck whether the triangles will appear on the right side of the
-- cliff, but by chance most of the few UK ones do seem to be drawn the 
-- "correct" way around.
-- ----------------------------------------------------------------------------
   if ( wayt.natural == "sinkhole" ) then
      wayt.natural = "cliff"
      wayt.area = "no"
   end

-- ----------------------------------------------------------------------------
-- Add building=roof on shelter and bicycle_parking ways if no building tag 
-- already.
-- ----------------------------------------------------------------------------
   if ((( wayt.amenity  == "shelter"          )   or
        ( wayt.amenity  == "bicycle_parking"  ))  and
       (( wayt.building == nil                )   or
        ( wayt.building == ""                 ))  and
       (  wayt.covered  ~= "no"                )) then
      wayt.building = "roof"
   end

-- ----------------------------------------------------------------------------
-- A "leisure=track" can be either a linear or an area feature
-- https://wiki.openstreetmap.org/wiki/Tag%3Aleisure%3Dtrack
-- Assign a highway tag (gallop or leisuretrack) so that linear features can
-- be explicitly rendered.
-- "sport" is often (but not always) used to separate different types of
-- leisure tracks.
--
-- If on an area, on raster the way will go into planet_osm_polygon and the highway
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
-- Remove landuse=military from non-closed ways
-- This is because while the linear raster rendering code doesn't even see this
-- because it's in a different table, the vector code sees everything in land1
-- or land2, regardless of geometry.
-- ----------------------------------------------------------------------------
    if (( not wayt.is_closed         ) and
        ( wayt.landuse == "military" )) then
        wayt.landuse = nil
    end

-- ----------------------------------------------------------------------------
-- (end of the way-specific code)
--
-- Linear transportation layer
-- ----------------------------------------------------------------------------
    wr_after_transportation( wayt )

-- ----------------------------------------------------------------------------
-- Linear waterway layer
-- ----------------------------------------------------------------------------
    way_after_waterway( wayt )

-- ----------------------------------------------------------------------------
-- The linearbarrier layer shouldn't have points in it, so we process that 
-- here.  There are some checks for "not a polygon" here for e.g. hedges.
-- ----------------------------------------------------------------------------
    way_after_linearbarrier( wayt )

-- ----------------------------------------------------------------------------
-- After dealing with linear aeroways we need to deal with area ones in
-- "generic_after_function", but we don't want that to have a go at showing
-- linear ones as areas, so we remove those here.  We do want it to do points,
-- which the "generic_after_function( nodet )" call above will do.
-- ----------------------------------------------------------------------------
    if ((  not wayt.is_closed              ) and
        (( wayt.aeroway == "grass_runway" )  or
         ( wayt.aeroway == "runway"       )  or
         ( wayt.aeroway == "taxiway"      ))) then
        wayt.aeroway = nil
    end

-- ----------------------------------------------------------------------------
-- Actually writing out most other nodes (and polygons) is done 
-- in "generic_after_function"
-- 
-- Linear features should have been handled above.
-- ----------------------------------------------------------------------------
    generic_after_function( wayt )
end -- way_function()


-- ------------------------------------------------------------------------------
-- Only certain relations are accepted.
-- See https://github.com/systemed/tilemaker/blob/master/docs/RELATIONS.md#stage-1-accepting-relations
-- Accept all route relations.
-- Once done, relation_function() will be called for each one.
-- ------------------------------------------------------------------------------
function relation_scan_function()
    if Find("type")=="route" then
        Accept()
    end
end -- relation_scan_function()

-- ------------------------------------------------------------------------------
-- Main entry point for processing relations
-- See https://github.com/systemed/tilemaker/blob/master/docs/RELATIONS.md#writing-relation-geometries
-- ------------------------------------------------------------------------------
function relation_function()
    local relationt = {}
    relationt.is_closed = IsClosed()
    relationt.amenity = Find("amenity")
    relationt.place = Find("place")
    relationt.shop = Find("shop")
    relationt.wasCshop = Find("was:shop")
    relationt.closedCshop = Find("closed:shop")
    relationt.disusedCshop = Find("disused:shop")
    relationt.tourism = Find("tourism")
    relationt.layer = Find("layer")
    relationt.bridge = Find("bridge")
    relationt.tunnel = Find("tunnel")
    relationt.embankment = Find("embankment")
    relationt.highrelation = Find("highrelation")
    relationt.level = Find("level")
    relationt.golf = Find("golf")
    relationt.sidewalk = Find("sidewalk")
    relationt.sidewalkCleft = Find("sidewalk:left")
    relationt.sidewalkCright = Find("sidewalk:right")
    relationt.sidewalkCboth = Find("sidewalk:both")
    relationt.footrelation = Find("footrelation")
    relationt.shoulder = Find("shoulder")
    relationt.hard_shoulder = Find("hard_shoulder")
    relationt.cyclerelation = Find("cyclerelation")
    relationt.segregated = Find("segregated")
    relationt.verge = Find("verge")
    relationt.waterrelation = Find("waterrelation")
    relationt.building = Find("building")
    relationt.natural = Find("natural")
    relationt.wasCamenity = Find("was:amenity")
    relationt.oldCamenity = Find("old:amenity")
    relationt.historicCamenity = Find("historic:amenity")
    relationt.closedCamenity = Find("closed:amenity")
    relationt.disusedCamenity = Find("disused:amenity")
    relationt.wasCwaterrelation = Find("was:waterrelation")
    relationt.disusedCwaterrelation = Find("disused:waterrelation")
    relationt.wasCrailrelation = Find("was:railrelation")
    relationt.disusedCrailrelation = Find("disused:railrelation")
    relationt.aerorelation = Find("aerorelation")
    relationt.wasCaerorelation = Find("was:aerorelation")
    relationt.disusedCaerorelation = Find("disused:aerorelation")
    relationt.landuse = Find("landuse")
    relationt.wasClanduse = Find("was:landuse")
    relationt.disusedClanduse = Find("disused:landuse")
    relationt.status = Find("status")
    relationt.disused = Find("disused")
    relationt.name = Find("name")
    relationt.nameCleft = Find("name:left")
    relationt.nameCright = Find("name:right")
    relationt.nameCen = Find("name:en")
    relationt.nameCsigned = Find("name:signed")
    relationt.nameCabsent = Find("name:absent")
    relationt.old_name = Find("old_name")
    relationt.official_ref = Find("official_ref")
    relationt.highrelation_authority_ref = Find("highrelation_authority_ref")
    relationt.highrelation_ref = Find("highrelation_ref")
    relationt.admin_ref = Find("admin_ref")
    relationt.adminCref = Find("admin:ref")
    relationt.loc_ref = Find("loc_ref")
    relationt.ref = Find("ref")
    relationt.refCsigned = Find("ref:signed")
    relationt.unsigned = Find("unsigned")
    relationt.surface = Find("surface")
    relationt.visibility = Find("visibility")
    relationt.trail_visibility = Find("trail_visibility")
    relationt.footCphysical = Find("foot:physical")
    relationt.overgrown = Find("overgrown")
    relationt.obstacle = Find("obstacle")
    relationt.informal = Find("informal")
    relationt.width = Find("width")
    relationt.est_width = Find("est_width")
    relationt.maxwidth = Find("maxwidth")
    relationt.designation = Find("designation")
    relationt.prow_ref = Find("prow_ref")
    relationt.sac_scale = Find("sac_scale")
    relationt.scramble = Find("scramble")
    relationt.ladder = Find("ladder")
    relationt.access = Find("access")
    relationt.accessCfoot = Find("access:foot")
    relationt.accessCbicycle = Find("access:bicycle")
    relationt.accessChorse = Find("access:horse")
    relationt.foot = Find("foot")
    relationt.bicycle = Find("bicycle")
    relationt.horse = Find("horse")
    relationt.service = Find("service")
    relationt.motor_vehicle = Find("motor_vehicle")
    relationt.boundary = Find("boundary")
    relationt.protect_class = Find("protect_class")
    relationt.protection_title = Find("protection_title")
    relationt.leisure = Find("leisure")
    relationt.landcover = Find("landcover")
    relationt.barrier = Find("barrier")
    relationt.ford = Find("ford")
    relationt.oneway = Find("oneway")
    relationt.junction = Find("junction")
    relationt.farmland = Find("farmland")
    relationt.animal = Find("animal")
    relationt.meadow = Find("meadow")
    relationt.produce = Find("produce")
    relationt.historic = Find("historic")
    relationt.ruins = Find("ruins")
    relationt.ruinsCman_made = Find("ruins:man_made")
    relationt.towerCtype = Find("tower:type")
    relationt.aircraftCmodel = Find("aircraft:model")
    relationt.inscription = Find("inscription")
    relationt.tomb = Find("tomb")
    relationt.archaeological_site = Find("archaeological_site")
    relationt.geological = Find("geological")
    relationt.attraction = Find("attraction")
    relationt.reef = Find("reef")
    relationt.wetland = Find("wetland")
    relationt.tidal = Find("tidal")
    relationt.playground = Find("playground")
    relationt.sport = Find("sport")
    relationt.military = Find("military")
    relationt.hazard = Find("hazard")
    relationt.operator = Find("operator")
    relationt.leaf_type = Find("leaf_type")
    relationt.power = Find("power")
    relationt.power_source = Find("power_source")
    relationt.zoo = Find("zoo")
    relationt.industrial = Find("industrial")
    relationt.seamarkCtype = Find("seamark:type")
    relationt.religion = Find("religion")
    relationt.denomination = Find("denomination")
    relationt.iata = Find("iata")
    relationt.icao = Find("icao")
    relationt.aerodromeCtype = Find("aerodrome:type")
    relationt.small_electric_vehicle = Find("small_electric_vehicle")
    relationt.network = Find("network")
    relationt.fee = Find("fee")
    relationt.male = Find("male")
    relationt.female = Find("female")
    relationt.area = Find("area")
    relationt.man_made = Find("man_made")
    relationt.landmark = Find("landmark")
    relationt.airmark = Find("airmark")
    relationt.abandonedCrailrelation = Find("abandoned:railrelation")
    relationt.historicCrailrelation = Find("historic:railrelation")
    relationt.wall = Find("wall")
    relationt.memorial = Find("memorial")
    relationt.memorialCtype = Find("memorial:type")
    relationt.marker = Find("marker")
    relationt.historicCcivilisation = Find("historic:civilisation")
    relationt.site_type = Find("site_type")
    relationt.fortification_type = Find("fortification_type")
    relationt.megalith_type = Find("megalith_type")
    relationt.place_of_worship = Find("place_of_worship")
    relationt.climbing = Find("climbing")
    relationt.disusedCman_made = Find("disused:man_made")
    relationt.castle_type = Find("castle_type")
    relationt.pipeline = Find("pipeline")
    relationt.intermittent = Find("intermittent")
    relationt.basin = Find("basin")
    relationt.flood_prone = Find("flood_prone")
    relationt.hazard_prone = Find("hazard_prone")
    relationt.hazard_type = Find("hazard_type")
    relationt.fuelCelectricity = Find("fuel:electricity")
    relationt.fuelCdiesel = Find("fuel:diesel")
    relationt.LPG = Find("LPG")
    relationt.fuelClpg = Find("fuel:lpg")
    relationt.fuelCH2 = Find("fuel:H2")
    relationt.fuelCLH2 = Find("fuel:LH2")
    relationt.railrelation = Find("railrelation")
    relationt.disusedCbuilding = Find("disused:building")
    relationt.buildingCtype = Find("building:type")
    relationt.watermillCdisused = Find("watermill:disused")
    relationt.windmillCdisused = Find("windmill:disused")
    relationt.defensive_works = Find("defensive_works")
    relationt.is_sidepath = Find("is_sidepath")
    relationt.is_sidepathCof = Find("is_sidepath:of")
    relationt.is_sidepathCofCname = Find("is_sidepath:of:name")
    relationt.is_sidepathCofCref = Find("is_sidepath:of:ref")
    relationt.recycling_type = Find("recycling_type")
    relationt.outlet = Find("outlet")
    relationt.covered = Find("covered")
    relationt.booth = Find("booth")
    relationt.telephone_kiosk = Find("telephone_kiosk")
    relationt.removedCamenity = Find("removed:amenity")
    relationt.abandonedCamenity = Find("abandoned:amenity")
    relationt.demolishedCamenity = Find("demolished:amenity")
    relationt.razedCamenity = Find("razed:amenity")
    relationt.old_amenity = Find("old_amenity")
    relationt.emergency = Find("emergency")
    relationt.colour = Find("colour")
    relationt.business = Find("business")
    relationt.office = Find("office")
    relationt.company = Find("company")
    relationt.craft = Find("craft")
    relationt.diplomatic = Find("diplomatic")
    relationt.embassy = Find("embassy")
    relationt.consulate = Find("consulate")
    relationt.peak = Find("peak")
    relationt.disusedCmilitary = Find("disused:military")
    relationt.geological = Find("geological")
    relationt.hunting_stand = Find("hunting_stand")
    relationt.harbour = Find("harbour")
    relationt.accommodation = Find("accommodation")
    relationt.cuisine = Find("cuisine")
    relationt.wheelchair = Find("wheelchair")
    relationt.outdoor_seating = Find("outdoor_seating")
    relationt.gate = Find("gate")
    relationt.locked = Find("locked")
    relationt.dog_gate = Find("dog_gate")
    relationt.entrance = Find("entrance")
    relationt.public_transport = Find("public_transport")
    relationt.school = Find("school")
    relationt.seamarkCrescue_stationCcategory = Find("seamark:rescue_station:category")
    relationt.healthcare = Find("healthcare")
    relationt.social_facility = Find("social_facility")
    relationt.club = Find("club")
    relationt.gambling = Find("gambling")
    relationt.danceCteaching = Find("dance:teaching")
    relationt.healthcareCspeciality = Find("healthcare:speciality")
    relationt.vending = Find("vending")
    relationt.vending_machine = Find("vending_machine")
    relationt.paymentChonesty_box = Find("payment:honesty_box")
    relationt.foodCeggs = Find("food:eggs")
    relationt.pitch = Find("pitch")
    relationt.ele = Find("ele")
    relationt.prominence = Find("prominence")
    relationt.bench = Find("bench")
    relationt.munro = Find("munro")
    relationt.location = Find("location")
    relationt.buildingCruins = Find("building:ruins")
    relationt.ruinedCbuilding = Find("ruined:building")
    relationt.species = Find("species")
    relationt.taxon = Find("taxon")
    relationt.lock_ref = Find("lock_ref")
    relationt.lock_name = Find("lock_name")
    relationt.bridgeCname = Find("bridge:name")
    relationt.bridge_name = Find("bridge_name")
    relationt.bridgeCref = Find("bridge:ref")
    relationt.canal_bridge_ref = Find("canal_bridge_ref")
    relationt.bridge_ref = Find("bridge_ref")
    relationt.tunnelCname = Find("tunnel:name")
    relationt.tunnel_name = Find("tunnel_name")
    relationt.tpuk_ref = Find("tpuk_ref")
    relationt.underground = Find("underground")
    relationt.generatorCsource = Find("generator:source")
    relationt.generatorCmethod = Find("generator:method")
    relationt.plantCsource = Find("plant:source")
    relationt.monitoringCwater_level = Find("monitoring:water_level")
    relationt.monitoringCwater_flow = Find("monitoring:water_flow")
    relationt.monitoringCwater_velocity = Find("monitoring:water_velocity")
    relationt.monitoringCweather = Find("monitoring:weather")
    relationt.weatherCradar = Find("weather:radar")
    relationt.monitoringCwater_level = Find("monitoring:water_level")
    relationt.monitoringCrainfall = Find("monitoring:rainfall")
    relationt.monitoringCseismic_activity = Find("monitoring:seismic_activity")
    relationt.monitoringCsky_brightness = Find("monitoring:sky_brightness")
    relationt.monitoringCair_quality = Find("monitoring:air_quality")
    relationt.usage = Find("usage")
    relationt.station = Find("station")
    relationt.railrelationCminiature = Find("railrelation:miniature")
    relationt.crossing = Find("crossing")
    relationt.disusedCtourism = Find("disused:tourism")
    relationt.ruinsCtourism = Find("ruins:tourism")
    relationt.board_type = Find("board_type")
    relationt.information = Find("information")
    relationt.operatorCtype = Find("operator:type")
    relationt.boardCtitle = Find("board:title")
    relationt.guide_type = Find("guide_type")
    relationt.ncn_milepost = Find("ncn_milepost")
    relationt.sustrans_ref = Find("sustrans_ref")
    relationt.theatre = Find("theatre")
    relationt.fence_type = Find("fence_type")
    relationt.zero_waste = Find("zero_waste")
    relationt.bulk_purchase = Find("bulk_purchase")
    relationt.reusable_packaging = Find("reusable_packaging")
    relationt.trade = Find("trade")
    relationt.brand = Find("brand")
    relationt.agrarian = Find("agrarian")
    relationt.height = Find("height")
    relationt.towerCconstruction = Find("tower:type")
    relationt.support = Find("support")
    relationt.buildingCpart = Find("building:part")
    relationt.drinking_water = Find("drinking_water")
    relationt.indoor = Find("indoor")
    relationt.rescue_equipment = Find("rescue_equipment")
    relationt.railrelationChistoric = Find("railrelation:historic")
    relationt.railrelationCpreserved = Find("railrelation:preserved")
    relationt.whitewater = Find("whitewater")
    relationt.canoe = Find("canoe")
    relationt.flow_control = Find("flow_control")
    relationt.historicCwaterrelation = Find("historic:waterrelation")
    relationt.abandonedCwaterrelation = Find("abandoned:waterrelation")
    relationt.waterrelationChistoric = Find("waterrelation:historic")
    relationt.waterrelationCabandoned = Find("waterrelation:abandoned")
    relationt.nameChistoric = Find("name:historic")
    relationt.historicCname = Find("historic:name")
    relationt.real_ale = Find("real_ale")
    relationt.beer_garden = Find("beer_garden")
    relationt.amenityCdisused = Find("amenity:disused")
    relationt.disusedCpub = Find("disused:pub")
    relationt.descriptionCfloor = Find("description:floor")
    relationt.floorCmaterial = Find("floor:material")
    relationt.micropub = Find("micropub")
    relationt.pub = Find("pub")
    relationt.opening_hoursCcovid19 = Find("opening_hours:covid19")
    relationt.accessCcovid19 = Find("access:covid19")
    relationt.food = Find("food")
    relationt.noncarpeted = Find("noncarpeted")
    relationt.microbrewery = Find("microbrewery")
    relationt.lamp_type = Find("lamp_type")
    relationt.departures_board = Find("departures_board")
    relationt.passenger_information_display = Find("passenger_information_display")
    relationt.disusedChighrelation = Find("disused:highrelation")
    relationt.physically_present = Find("physically_present")
    relationt.naptanCindicator = Find("naptan:indicator")
    relationt.bus_speech_output_name = Find("bus_speech_output_name")
    relationt.bus_display_name = Find("bus_display_name")
    relationt.website = Find("website")
    relationt.timetable = Find("timetable")
    relationt.departures_boardCspeech_output = Find("departures_board:speech_output")
    relationt.passenger_information_displayCspeech_output = Find("passenger_information_display:speech_output")
    relationt.flag = Find("flag")
    relationt.pole = Find("pole")
    relationt.naptanCBusStopType = Find("naptan:BusStopType")
    relationt.direction_north = Find("direction_north")
    relationt.direction_northeast = Find("direction_northeast")
    relationt.direction_east = Find("direction_east")
    relationt.direction_southeast = Find("direction_southeast")
    relationt.direction_south = Find("direction_south")
    relationt.direction_southwest = Find("direction_southwest")
    relationt.direction_west = Find("direction_west")
    relationt.direction_northwest = Find("direction_northwest")
    relationt.parking = Find("parking")
    relationt.opening_hours = Find("opening_hours")
    relationt.addrChousename = Find("addr:housename")
    relationt.addrCunit = Find("addr:unit")
    relationt.addrChousenumber = Find("addr:housenumber")
    relationt.areaChighrelation = Find("area:highrelation")
    relationt.lcn_ref = Find("lcn_ref")
    relationt.advertising = Find("advertising")
    relationt.volcanoCstatus = Find("volcano:status")
    relationt.route = Find("route")
    relationt.type = Find("type")
    relationt.aerialway = Find("aerialway")
    relationt.capital = Find("capital")

    generic_before_function( relationt )

-- ----------------------------------------------------------------------------
-- Relation-specific code
-- ----------------------------------------------------------------------------
   if (( relationt.type     == "multipolygon" ) and
       ( relationt.junction == "yes"          )) then
      relationt.type = nil
   end

-- ----------------------------------------------------------------------------
-- Note that we're not doing any per-member processing for routes - we just
-- add a highway type to the relation and ensure that the style rules for it
-- handle it sensibly, as it's going to be overlaid over other highway types.
-- "ldpnwn" is used to allow for future different processing of different 
-- relations.
--
-- Name handling for cycle routes makes a special case of the National Byway.
--
-- MTB routes are processed only if they are not also another type of cycle
-- route (including LCN, which isn't actually shown in this rendering).
--
-- Processing routes,
-- Walking networks first.
-- We use "ref" rather than "name" on IWNs but not others.
-- We use "colour" as "name" if "colour" is set and "name" is not.
-- ----------------------------------------------------------------------------
   if (relationt.type == "route") then
      if (( relationt.network == "iwn" ) and
          ( relationt.ref     ~= nil   )) then
         relationt.name = relationt.ref
      end

      if ((( relationt.network == "iwn"         ) or
           ( relationt.network == "nwn"         ) or
           ( relationt.network == "rwn"         ) or
           ( relationt.network == "lwn"         ) or
           ( relationt.network == "lwn;lcn"     ) or
           ( relationt.network == "lwn;lcn;lhn" )) and
          (( relationt.name    ~= nil           )  or
           ( relationt.colour  ~= nil           ))) then
         if (( relationt.name   == nil ) and
             ( relationt.colour ~= nil )) then
            relationt.name = relationt.colour
         end

         relationt.highway = "ldpnwn"
      end  -- walking

-- ----------------------------------------------------------------------------
-- Cycle networks
-- We exclude some obviously silly refs.
-- We use "ref" rather than "name".
-- We handle loops on the National Byway and append (r) on other RCNs.
-- ----------------------------------------------------------------------------
      if (((  relationt.network == "ncn"           )  or
           (  relationt.network == "rcn"           )) and
          ((  relationt.state   == nil             )  or
           (( relationt.state   ~= "proposed"     )   and
            ( relationt.state   ~= "construction" )   and
            ( relationt.state   ~= "abandoned"    )))) then
         relationt.highway = "ldpncn"

         if ( relationt.ref == "N/A" ) then
            relationt.ref = nil
         end

         if (( relationt.name ~= nil                 ) and
             ( relationt.ref  == "NB"                ) and
             ( string.match( relationt.name, "Loop" ))) then
            relationt.ref = relationt.ref .. " (loop)"
         end

         if ( relationt.ref ~= nil ) then
            relationt.name = relationt.ref
         end

         if (( relationt.network == "rcn"       )  and
             ( relationt.name    ~= "NB"        )  and
             ( relationt.name    ~= "NB (loop)" )) then
            if ( relationt.name == nil ) then
               relationt.name = "(r)"
            else
               relationt.name = relationt.name .. " (r)"
            end
         end
      end -- cycle

-- ----------------------------------------------------------------------------
-- MTB networks
-- As long as there is a name, we append (m) here.
-- We don't show unnamed MTB "routes" as routes.
-- ----------------------------------------------------------------------------
      if (( relationt.route   == "mtb" ) and
          ( relationt.network ~= "ncn" ) and
          ( relationt.network ~= "rcn" ) and
          ( relationt.network ~= "lcn" )) then
         relationt.highway = "ldpmtb"

         if ( relationt.name == nil ) then
            relationt.highway = nil
         else
            relationt.name = relationt.name .. " (m)"
         end
      end -- MTB

-- ----------------------------------------------------------------------------
-- Horse networks
-- ----------------------------------------------------------------------------
      if (( relationt.network == "nhn"         ) or
          ( relationt.network == "rhn"         )  or
          ( relationt.network == "ncn;nhn;nwn" )) then
         relationt.highway = "ldpnhn"
      end

-- ----------------------------------------------------------------------------
-- Check for signage - remove unsigned networks
-- ----------------------------------------------------------------------------
      if (( relationt.highway == "ldpnwn" ) or
          ( relationt.highway == "ldpncn" ) or
          ( relationt.highway == "ldpmtb" ) or
          ( relationt.highway == "ldpnhn" )) then
         if ((  relationt.name        ~= nil     ) and
             (( relationt.nameCsigned == "no"   )  or
              ( relationt.nameCabsent == "yes"  )  or
              ( relationt.unsigned    == "yes"  )  or
              ( relationt.unsigned    == "name" ))) then
            relationt.name = nil
            relationt.nameCsigned = nil
            relationt.highway = nil
         end -- no name

         if ((  relationt.ref        ~= nil     ) and
             (( relationt.refCsigned == "no"   )  or
              ( relationt.unsigned   == "yes"  ))) then
            relationt.ref = nil
            relationt.refCsigned = nil
            relationt.unsigned = nil
            relationt.highway = nil
         end -- no ref
      end -- check for signage
   end -- route

-- ----------------------------------------------------------------------------
-- emergency=water_rescue is a poorly-designed key that makes it difficult to
-- tell e.g. lifeboats from lifeboat stations.
-- However, if we've got a multipolygon relation, it's a lifeboat station.
-- ----------------------------------------------------------------------------
   if (( relationt.type      == "multipolygon" ) and
       ( relationt.emergency == "water_rescue" )) then
      relationt.emergency = "lifeboat_station"
   end

-- ----------------------------------------------------------------------------
-- (end of the relation-specific code)
--
-- Linear transportation layer
-- ----------------------------------------------------------------------------
    wr_after_transportation( relationt )

-- ----------------------------------------------------------------------------
-- No calls to e.g. generic_after_function here because we don't currently
-- have any relations that would make sense to that.
-- ----------------------------------------------------------------------------
end

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
   if ((  passedt.wasCamenity     ~= nil  ) and
       (  passedt.wasCamenity     ~= ""   ) and
       (( passedt.disusedCamenity == nil )  or
        ( passedt.disusedCamenity == ""  ))) then
      passedt.disusedCamenity = passedt.wasCamenity
   end

   if ((  passedt.wasCwaterway     ~= nil  ) and
       (  passedt.wasCwaterway     ~= ""   ) and
       (( passedt.disusedCwaterway == nil )  or
        ( passedt.disusedCwaterway == ""  ))) then
      passedt.disusedCwaterway = passedt.wasCwaterway
   end

   if ((  passedt.wasCrailway     ~= nil  ) and
       (  passedt.wasCrailway     ~= ""   ) and
       (( passedt.disusedCrailway == nil )  or
        ( passedt.disusedCrailway == ""  ))) then
      passedt.disusedCrailway = passedt.wasCrailway
   end

   if ((  passedt.wasCaeroway     ~= nil  ) and
       (  passedt.wasCaeroway     ~= ""   ) and
       (( passedt.disusedCaeroway == nil )  or
        ( passedt.disusedCaeroway == ""  ))) then
      passedt.disusedCaeroway = passedt.wasCaeroway
   end

   if ((  passedt.wasClanduse     ~= nil  ) and
       (  passedt.wasClanduse     ~= ""   ) and
       (( passedt.disusedClanduse == nil )  or
        ( passedt.disusedClanduse == ""  ))) then
      passedt.disusedClanduse = passedt.wasClanduse
   end

   if ((  passedt.wasCshop     ~= nil  ) and
       (  passedt.wasCshop     ~= ""   ) and
       (( passedt.disusedCshop == nil )  or
        ( passedt.disusedCshop == ""  ))) then
      passedt.disusedCshop = passedt.wasCshop
   end

-- ----------------------------------------------------------------------------
-- Treat "closed:" as "disused:" in some cases too.
-- ----------------------------------------------------------------------------
   if ((  passedt.closedCamenity  ~= nil  ) and
       (  passedt.closedCamenity  ~= ""   ) and
       (( passedt.disusedCamenity == nil )  or
        ( passedt.disusedCamenity == ""  ))) then
      passedt.disusedCamenity = passedt.closedCamenity
   end

   if ((  passedt.closedCshop  ~= nil  ) and
       (  passedt.closedCshop  ~= ""   ) and
       (( passedt.disusedCshop == nil )  or
        ( passedt.disusedCshop == ""  ))) then
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
       (( passedt.name     == nil              )  or
        ( passedt.name     == ""               )) and
       (  passedt.old_name ~= nil               ) and
       (  passedt.old_name ~= ""                )) then
      passedt.name = "(" .. passedt.old_name .. ")"
      passedt.old_name = nil
   end

-- ----------------------------------------------------------------------------
-- If "visibility" is set but "trail_visibility" is not, use "visibility".
-- ----------------------------------------------------------------------------
   if ((  passedt.visibility       ~= nil  ) and
       (  passedt.visibility       ~= ""   ) and
       (( passedt.trail_visibility == nil )  or
        ( passedt.trail_visibility == ""  ))) then
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
   if ((  passedt.est_width ~= nil   ) and
       (  passedt.est_width ~= ""    ) and
       (( passedt.width     == nil  )  or
        ( passedt.width     == ""   ))) then
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

   if ((  passedt.highway          ~= nil    ) and
       (  passedt.highway          ~= ""     ) and
       (  passedt.scramble         == "yes"  ) and
       (( passedt.sac_scale        == nil   )  or
        ( passedt.sac_scale        == ""    )) and
       (( passedt.trail_visibility == nil   )  or
        ( passedt.trail_visibility == ""    ))) then
      passedt.trail_visibility = "intermediate"
   end

-- ----------------------------------------------------------------------------
-- Suppress non-designated very low-visibility paths
-- Various low-visibility trail_visibility values have been set to "bad" above
-- to suppress from normal display.
-- The "bridge" check (on trail_visibility, not sac_scale) is because if 
-- there's really a bridge there, surely you can see it?
-- ----------------------------------------------------------------------------
   if ((  passedt.highway          ~= nil    ) and
       (  passedt.highway          ~= ""     ) and
       (( passedt.designation      == nil   )  or
        ( passedt.designation      == ""    )) and
       (  passedt.trail_visibility == "bad"  )) then
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
       ( passedt.highway ~= ""    ) and
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
        ( passedt.bicycle == ""          )  or
        ( passedt.bicycle == "private"   )  or
        ( passedt.bicycle == "no"        )) and
       (( passedt.horse   == nil         )  or
        ( passedt.horse   == ""          )  or
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
   if ((( passedt.access      == nil                         )   or
        ( passedt.access      == ""                          ))  and
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
         (  passedt.foot        ~= ""                           )   and
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
       ((( passedt.landuse == nil    )  or
         ( passedt.landuse == ""     )) and
        (( passedt.leisure == nil    )  or
         ( passedt.leisure == ""     )) and
        (( passedt.aeroway == nil    )  or
         ( passedt.aeroway == ""     )))) then
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
   if (((  passedt.footway             == "sidewalk" )  or
        (  passedt.cycleway            == "sidewalk" )  or
        (  passedt.is_sidepath         == "yes"      )  or
        (( passedt.is_sidepathCof      ~= nil       )   and
         ( passedt.is_sidepathCof      ~= ""        ))  or
        (( passedt.is_sidepathCofCname ~= nil       )   and
         ( passedt.is_sidepathCofCname ~= ""        ))  or
        (( passedt.is_sidepathCofCref  ~= nil       )   and
         ( passedt.is_sidepathCofCref  ~= ""        ))) and
       ( passedt.name                ~= nil           ) and
       ( passedt.name                ~= ""            )) then
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
-- Pretend add landuse=industrial to some industrial sub-types to force 
-- name rendering.  Similarly, some commercial and leisure.
-- man_made=works drops the man_made tag to avoid duplicate labelling.
-- "parking=depot" is a special case - drop the parking tag there too.
-- ----------------------------------------------------------------------------
   if ( passedt.man_made   == "wastewater_plant" ) then
      passedt.man_made = nil
      passedt.landuse = "industrial"
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name = "(sewage)"
      else
         passedt.name = passedt.name .. " (sewage)"
      end
   end

   if (( passedt.amenity    == "bus_depot"              ) or
       ( passedt.amenity    == "depot"                  ) or
       ( passedt.amenity    == "fuel_depot"             ) or
       ( passedt.amenity    == "scrapyard"              ) or 
       ( passedt.craft      == "bakery"                 ) or
       ( passedt.craft      == "distillery"             ) or
       ( passedt.craft      == "sawmill"                ) or
       ( passedt.industrial == "auto_wrecker"           ) or 
       ( passedt.industrial == "automotive_industry"    ) or
       ( passedt.industrial == "bakery"                 ) or
       ( passedt.industrial == "brewery"                ) or 
       ( passedt.industrial == "bus_depot"              ) or
       ( passedt.industrial == "chemical"               ) or
       ( passedt.industrial == "concrete_plant"         ) or
       ( passedt.industrial == "construction"           ) or
       ( passedt.industrial == "depot"                  ) or 
       ( passedt.industrial == "distillery"             ) or 
       ( passedt.industrial == "electrical"             ) or
       ( passedt.industrial == "engineering"            ) or
       ( passedt.industrial == "factory"                ) or 
       ( passedt.industrial == "furniture"              ) or
       ( passedt.industrial == "gas"                    ) or
       ( passedt.industrial == "haulage"                ) or
       ( passedt.industrial == "machine_shop"           ) or
       ( passedt.industrial == "machinery"              ) or
       ( passedt.industrial == "metal_finishing"        ) or
       ( passedt.industrial == "mobile_equipment"       ) or
       ( passedt.industrial == "oil"                    ) or
       ( passedt.industrial == "packaging"              ) or
       ( passedt.industrial == "sawmill"                ) or
       ( passedt.industrial == "scaffolding"            ) or
       ( passedt.industrial == "scrap_yard"             ) or 
       ( passedt.industrial == "shop_fitters"           ) or
       ( passedt.industrial == "warehouse"              ) or
       ( passedt.industrial == "waste_handling"         ) or
       ( passedt.industrial == "woodworking"            ) or
       ( passedt.industrial == "yard"                   ) or 
       ( passedt.industrial == "yes"                    ) or 
       ( passedt.landuse    == "depot"                  ) or
       ( passedt.man_made   == "gas_station"            ) or
       ( passedt.man_made   == "gas_works"              ) or
       ( passedt.man_made   == "petroleum_well"         ) or 
       ( passedt.man_made   == "pumping_station"        ) or
       ( passedt.man_made   == "water_treatment"        ) or
       ( passedt.man_made   == "water_works"            ) or
       ( passedt.power      == "plant"                  )) then
      passedt.landuse = "industrial"
   end

-- ----------------------------------------------------------------------------
-- Sometimes covered reservoirs are "basically buildings", sometimes they have
-- e.g. landuse=grass set.  If the latter, don't show them as buildings.
-- The name will still appear via landuse.
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made   == "reservoir_covered"  ) and
       (( passedt.landuse    == nil                 )  or
        ( passedt.landuse    == ""                  ))) then
      passedt.building = "roof"
      passedt.landuse  = "industrialbuilding"
   end

   if (( passedt.building   == "industrial"             ) or
       ( passedt.building   == "depot"                  ) or 
       ( passedt.building   == "warehouse"              ) or
       ( passedt.building   == "works"                  ) or
       ( passedt.building   == "manufacture"            )) then
      passedt.landuse = "industrialbuilding"
   end

   if ( passedt.man_made   == "works" ) then
      passedt.man_made = nil

      if (( passedt.building == nil  ) or
          ( passedt.building == ""   ) or
          ( passedt.building == "no" )) then
         passedt.landuse = "industrial"
      else
         passedt.building = "yes"
         passedt.landuse = "industrialbuilding"
      end
   end

   if ( passedt.man_made   == "water_tower" ) then
      if ( passedt.building == "no" ) then
         passedt.landuse = "industrial"
      else
         passedt.building = "yes"
         passedt.landuse = "industrialbuilding"
      end
   end

   if ( passedt.parking   == "depot" ) then
      passedt.parking = nil
      passedt.landuse = "industrial"
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
       ( passedt.shop    == "car_repair;tyres"   )  or
       ( passedt.shop    == "vehicle_repair"     )) then
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
-- Don't show extinct volcanos as volcanos, just as peaks.
-- That's still iffy in some cases (e.g. Rockall), but better than nothing.
-- ----------------------------------------------------------------------------
   if ((  passedt.natural        == "volcano" ) and
       (  passedt.volcanoCstatus == "extinct" )) then
      passedt.natural = "peak"
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
          ( passedt.name == ""            )   or
          ( passedt.name == "Beer Garden" )) then
         passedt.amenity = nil
      end

      passedt.landuse = "unnamedgrass"
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
       ( passedt.natural ~= ""      ) and
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
-- Consolidate some unusual wheelchair tags
-- ----------------------------------------------------------------------------
   if (( passedt.wheelchair == "1"                )  or
       ( passedt.wheelchair == "2"                )  or
       ( passedt.wheelchair == "3"                )  or
       ( passedt.wheelchair == "5"                )  or
       ( passedt.wheelchair == "bell"             )  or
       ( passedt.wheelchair == "customers"        )  or
       ( passedt.wheelchair == "designated"       )  or
       ( passedt.wheelchair == "destination"      )  or
       ( passedt.wheelchair == "friendly"         )  or
       ( passedt.wheelchair == "full"             )  or
       ( passedt.wheelchair == "number of rooms"  )  or
       ( passedt.wheelchair == "official"         )  or
       ( passedt.wheelchair == "on request"       )  or
       ( passedt.wheelchair == "only"             )  or
       ( passedt.wheelchair == "permissive"       )  or
       ( passedt.wheelchair == "ramp"             )  or
       ( passedt.wheelchair == "unisex"           )) then
      passedt.wheelchair = "yes"
   end

   if (( passedt.wheelchair == "difficult"                    )  or
       ( passedt.wheelchair == "limited (No automatic door)"  )  or
       ( passedt.wheelchair == "limited, notice required"     )  or
       ( passedt.wheelchair == "restricted"                   )) then
      passedt.wheelchair = "limited"
   end

   if ( passedt.wheelchair == "impractical" ) then
      passedt.wheelchair = "limited"
   end

-- ----------------------------------------------------------------------------
-- Remove "real_ale" tag on industrial and craft breweries that aren't also
-- a pub, bar, restaurant, cafe etc. or hotel.
-- ----------------------------------------------------------------------------
   if ((( passedt.industrial == "brewery" ) or
        ( passedt.craft      == "brewery" )) and
       (  passedt.real_ale   ~= nil        ) and
       (  passedt.real_ale   ~= ""         ) and
       (  passedt.real_ale   ~= "maybe"    ) and
       (  passedt.real_ale   ~= "no"       ) and
       (( passedt.amenity    == nil       )  or
        ( passedt.amenity    == ""        )) and
       (  passedt.tourism   ~= "hotel"     )) then
      passedt.real_ale = nil
      passedt.real_cider = nil
   end

-- ----------------------------------------------------------------------------
-- Remove "shop" tag on industrial or craft breweries.
-- We pick one thing to display them as, and in this case it's "brewery".
-- ----------------------------------------------------------------------------
   if ((( passedt.industrial == "brewery" ) or
        ( passedt.craft      == "brewery" ) or
        ( passedt.craft      == "cider"   )) and
       (  passedt.shop       ~= nil        ) and
       (  passedt.shop       ~= ""         )) then
      passedt.shop = nil
   end

-- ----------------------------------------------------------------------------
-- Don't show pubs, cafes or restaurants if you can't actually get to them.
-- ----------------------------------------------------------------------------
   if ((( passedt.amenity == "pub"        ) or
        ( passedt.amenity == "cafe"       ) or
        ( passedt.amenity == "restaurant" )) and
       (  passedt.access  == "no"          )) then
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Suppress historic tag on pubs.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity  == "pub"     ) and
       ( passedt.historic ~= nil       ) and
       ( passedt.historic ~= ""        )) then
      passedt.historic = nil
   end

-- ----------------------------------------------------------------------------
-- If "leisure=music_venue" is set try and work out if something should take 
-- precedence.
-- We do this check here rather than at "concert_hall" further down because 
-- "bar" and "pub" can be changed below based on other tags.
-- ----------------------------------------------------------------------------
   if ( passedt.leisure == "music_venue" ) then
      if (( passedt.amenity == "bar" ) or
          ( passedt.amenity == "pub" )) then
         passedt.leisure = nil
      else
         passedt.amenity = "concert_hall"
      end
   end

-- ----------------------------------------------------------------------------
-- Things that are both hotels, B&Bs etc. and pubs should render as pubs, 
-- because I'm far more likely to be looking for the latter than the former.
-- This is done by removing the tourism tag for them.
--
-- People have used lots of tags for "former" or "dead" pubs.
-- "disused:amenity=pub" is the most popular.
--
-- Treat things that were pubs but are now something else as whatever else 
-- they now are.
--
-- If a real_ale tag has got stuck on something unexpected, don't render that
-- as a pub.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity   == "pub"   ) and
       ( passedt.tourism   ~= nil     ) and
       ( passedt.tourism   ~= ""      )) then
      if (( passedt.tourism   == "hotel"             ) or
          ( passedt.tourism   == "guest_house"       ) or
          ( passedt.tourism   == "bed_and_breakfast" ) or
          ( passedt.tourism   == "chalet"            ) or
          ( passedt.tourism   == "hostel"            ) or
          ( passedt.tourism   == "motel"             )) then
         passedt.accommodation = "yes"
      end

      passedt.tourism = nil
   end

   if (( passedt.tourism == "hotel" ) and
       ( passedt.pub     == "yes"   )) then
      passedt.accommodation = "yes"
      passedt.amenity = "pub"
      passedt.pub = nil
      passedt.tourism = nil
   end

   if ((( passedt.tourism  == "hotel"       )   or
        ( passedt.tourism  == "guest_house" ))  and
       (  passedt.real_ale ~= nil            )  and
       (  passedt.real_ale ~= ""             )  and
       (  passedt.real_ale ~= "maybe"        )  and
       (  passedt.real_ale ~= "no"           )) then
      passedt.accommodation = "yes"
      passedt.amenity = "pub"
      passedt.tourism = nil
   end

   if ((  passedt.leisure         == "outdoor_seating" ) and
       (( passedt.surface         == "grass"          ) or
        ( passedt.beer_garden     == "yes"            ) or
        ( passedt.outdoor_seating == "garden"         ))) then
      passedt.leisure = "garden"
      passedt.garden = "beer_garden"
   end

   if ((  passedt.abandonedCamenity == "pub"             )   or
       (  passedt.amenityCdisused   == "pub"             )   or
       (  passedt.disused           == "pub"             )   or
       (  passedt.disusedCpub       == "yes"             )   or
       (  passedt.former_amenity    == "former_pub"      )   or
       (  passedt.former_amenity    == "pub"             )   or
       (  passedt.former_amenity    == "old_pub"         )   or
       (  passedt.formerCamenity    == "pub"             )   or
       (  passedt.old_amenity       == "pub"             )) then
      passedt.disusedCamenity = "pub"
      passedt.amenityCdisused = nil
      passedt.disused = nil
      passedt.disusedCpub = nil
      passedt.former_amenity = nil
      passedt.old_amenity = nil
   end

   if ((  passedt.historic == "pub"  ) and
       (( passedt.amenity  == nil   )  or
        ( passedt.amenity  == ""    )) and
       (( passedt.shop     == nil   )  or
        ( passedt.shop     == ""    ))) then
      passedt.disusedCamenity = "pub"
      passedt.historic = nil
   end

   if ((  passedt.amenity           == "closed_pub"      )   or
       (  passedt.amenity           == "dead_pub"        )   or
       (  passedt.amenity           == "disused_pub"     )   or
       (  passedt.amenity           == "former_pub"      )   or
       (  passedt.amenity           == "old_pub"         )   or
       (( passedt.amenity           == "pub"            )    and
        ( passedt.disused           == "yes"            ))   or
       (( passedt.amenity           == "pub"            )    and
        ( passedt.opening_hours     == "closed"         ))) then
      passedt.disusedCamenity = "pub"
      passedt.amenityCdisused = nil
      passedt.disused = nil
      passedt.disusedCpub = nil
      passedt.former_amenity = nil
      passedt.old_amenity = nil
      passedt.amenity = nil
   end

   if ((   passedt.disusedCamenity   == "pub"     ) and
       ((( passedt.tourism           ~= nil     )   and
         ( passedt.tourism           ~= ""      ))  or
        (( passedt.amenity           ~= nil     )   and
         ( passedt.amenity           ~= ""      ))  or
        (( passedt.leisure           ~= nil     )   and
         ( passedt.leisure           ~= ""      ))  or
        (( passedt.shop              ~= nil     )   and
         ( passedt.shop              ~= ""      ))  or
        (( passedt.office            ~= nil     )   and
         ( passedt.office            ~= ""      ))  or
        (( passedt.craft             ~= nil     )   and
         ( passedt.craft             ~= ""      )))) then
      passedt.disusedCamenity = nil
   end

   if ((   passedt.real_ale  ~= nil    ) and
       (   passedt.real_ale  ~= ""     ) and
       ((( passedt.amenity   == nil  )   or
         ( passedt.amenity   == ""   ))  and
        (( passedt.shop      == nil  )   or
         ( passedt.shop      == ""   ))  and
        (( passedt.tourism   == nil  )   or
         ( passedt.tourism   == ""   ))  and
        (( passedt.room      == nil  )   or
         ( passedt.room      == ""   ))  and
        (( passedt.leisure   == nil  )   or
         ( passedt.leisure   == ""   ))  and
        (( passedt.club      == nil  )   or
         ( passedt.club      == ""   )))) then
      passedt.real_ale = nil
   end

-- ----------------------------------------------------------------------------
-- If something has been tagged both as a brewery and a pub or bar, render as
-- a pub with a microbrewery.
-- ----------------------------------------------------------------------------
   if ((( passedt.amenity    == "pub"     )  or
        ( passedt.amenity    == "bar"     )) and
       (( passedt.craft      == "brewery" )  or
        ( passedt.industrial == "brewery" ))) then
      passedt.amenity  = "pub"
      passedt.microbrewery  = "yes"
      passedt.craft  = nil
      passedt.industrial  = nil
   end

-- ----------------------------------------------------------------------------
-- If a food place has a real_ale tag, also add a food tag an let the real_ale
-- tag render.
-- ----------------------------------------------------------------------------
   if ((( passedt.amenity  == "cafe"       )  or
        ( passedt.amenity  == "restaurant" )) and
       (( passedt.real_ale ~= nil          )  and
        ( passedt.real_ale ~= ""           )  and
        ( passedt.real_ale ~= "maybe"      )  and
        ( passedt.real_ale ~= "no"         )) and
       (( passedt.food     == nil          )  or
        ( passedt.food     == ""           ))) then
      passedt.food  = "yes"
   end

-- ----------------------------------------------------------------------------
-- Attempt to do something sensible with pubs (and other places that serve
-- real_ale)
-- Pubs that serve real_ale get a nice IPA, ones that don't a yellowy lager,
-- closed pubs an "X".  Food gets an F on the right, micropubs a u on the left.
-- Noncarpeted floor gets an underline, accommodation a blue "roof", and 
-- Microbrewery a "mash tun in the background".  Not all combinations exist so
-- not all are checked for.  Pubs without any other tags get the default empty 
-- glass.
--
-- Pub flags:
-- Live or dead pub?  y or n, or c (closed due to covid)
-- Real ale?          y n or d (don't know)
-- Food 	      y or d
-- Noncarpeted floor  y or d
-- Microbrewery	      y n or d
-- Micropub	      y n or d
-- Accommodation      y n or d
-- Wheelchair	      y, l, n or d
-- Beer Garden	      g (beer garden), o (outside seating), d (don't know)
-- ----------------------------------------------------------------------------
   if ((( passedt.descriptionCfloor ~= nil                 )  and
        ( passedt.descriptionCfloor ~= ""                  )) or
       (  passedt.floorCmaterial    == "brick"              ) or
       (  passedt.floorCmaterial    == "brick;concrete"     ) or
       (  passedt.floorCmaterial    == "concrete"           ) or
       (  passedt.floorCmaterial    == "grubby carpet"      ) or
       (  passedt.floorCmaterial    == "lino"               ) or
       (  passedt.floorCmaterial    == "lino;carpet"        ) or
       (  passedt.floorCmaterial    == "lino;rough_wood"    ) or
       (  passedt.floorCmaterial    == "lino;tiles;stone"   ) or
       (  passedt.floorCmaterial    == "paving_stones"      ) or
       (  passedt.floorCmaterial    == "rough_carpet"       ) or
       (  passedt.floorCmaterial    == "rough_wood"         ) or
       (  passedt.floorCmaterial    == "rough_wood;carpet"  ) or
       (  passedt.floorCmaterial    == "rough_wood;lino"    ) or
       (  passedt.floorCmaterial    == "rough_wood;stone"   ) or
       (  passedt.floorCmaterial    == "rough_wood;tiles"   ) or
       (  passedt.floorCmaterial    == "slate"              ) or
       (  passedt.floorCmaterial    == "slate;carpet"       ) or
       (  passedt.floorCmaterial    == "stone"              ) or
       (  passedt.floorCmaterial    == "stone;carpet"       ) or
       (  passedt.floorCmaterial    == "stone;rough_carpet" ) or
       (  passedt.floorCmaterial    == "stone;rough_wood"   ) or
       (  passedt.floorCmaterial    == "tiles"              ) or
       (  passedt.floorCmaterial    == "tiles;rough_wood"   )) then
      passedt.noncarpeted = "yes"
   end

   if (( passedt.micropub == "yes"   ) or
       ( passedt.pub      == "micro" )) then
      passedt.micropub = nil
      passedt.pub      = "micropub"
   end

-- ----------------------------------------------------------------------------
-- The misspelling "accomodation" (with one "m") is quite common.
-- ----------------------------------------------------------------------------
   if ((( passedt.accommodation == nil )   or
        ( passedt.accommodation == ""  ))  and
       (  passedt.accomodation  ~= nil  )  and
       (  passedt.accomodation  ~= ""   )) then
      passedt.accommodation = passedt.accomodation
      passedt.accomodation  = nil
   end
		  
-- ----------------------------------------------------------------------------
-- Next, "closed due to covid" pubs
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity               == "pub"        ) and
       (( passedt.opening_hoursCcovid19 == "off"       ) or
        ( passedt.opening_hoursCcovid19 == "closed"    ) or
        ( passedt.accessCcovid19        == "no"        ))) then
      passedt.amenity = "pub_cddddddd"
      passedt.real_ale = nil
   end

-- ----------------------------------------------------------------------------
-- Does a pub really serve food?
-- Below we check for "any food value but no".
-- Here we exclude certain food values from counting towards displaying the "F"
-- that says a pub serves food.  As far as I am concerned, sandwiches, pies,
-- or even one of Michael Gove's scotch eggs would count as "food" but a packet
-- of crisps would not.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "pub"         ) and
       (( passedt.food    == "snacks"     ) or
        ( passedt.food    == "bar_snacks" ))) then
      passedt.food = "no"
   end

-- ----------------------------------------------------------------------------
-- Main "real_ale icon selection" logic
-- Note that there's no "if pub" here, so any non-pub establishment that serves
-- real ale will get the icon (hotels, restaurants, cafes, etc.)
-- We have explicitly excluded pubs "closed for covid" above.
-- After this large "if" there is no "else" but another "if" for non-real ale
-- pubs (that does check that the thing is actually a pub).
-- ----------------------------------------------------------------------------
   if (( passedt.real_ale ~= nil     ) and
       ( passedt.real_ale ~= ""      ) and
       ( passedt.real_ale ~= "maybe" ) and
       ( passedt.real_ale ~= "no"    )) then
      if (( passedt.food ~= nil  ) and
          ( passedt.food ~= ""   ) and
          ( passedt.food ~= "no" )) then
         if ( passedt.noncarpeted == "yes"  ) then
            if ( passedt.microbrewery == "yes"  ) then
                           -- pub_yyyyy micropub unchecked (no examples yet)
               if (( passedt.accommodation ~= nil  ) and
                   ( passedt.accommodation ~= ""   ) and
                   ( passedt.accommodation ~= "no" )) then
                  passedt.amenity = "pub_yyyyydy"
                  append_wheelchair( passedt )
                           -- no beer garden appended (no examples yet)
	       else -- no accommodation
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yyyyydny"
                     append_beer_garden( passedt )
                  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yyyyydnl"
                        append_beer_garden( passedt )
                     else
                        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yyyyydnn"
                                              -- no beer garden appended (no examples yet)
                        else
                           passedt.amenity = "pub_yyyyydnd"
                           append_beer_garden( passedt )
                        end
                     end
                  end
	       end -- accommodation
            else -- no microbrewery
	       if ( passedt.pub == "micropub" ) then
                  passedt.amenity = "pub_yyyynyd"
                                              -- accommodation unchecked (no examples yet)
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               else
                  passedt.amenity = "pub_yyyynn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               end
	    end -- microbrewery
         else -- not noncarpeted
            if ( passedt.microbrewery == "yes"  ) then
               if (( passedt.accommodation ~= nil  ) and
                   ( passedt.accommodation ~= ""   ) and
                   ( passedt.accommodation ~= "no" )) then
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yyydydyy"
                                              -- no beer garden appended (no examples yet)
		  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yyydydyl"
                                              -- no beer garden appended (no examples yet)
		     else
		        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yyydydyn"
                                              -- no beer garden appended (no examples yet)
			else
                           passedt.amenity = "pub_yyydydyd"
                           append_beer_garden( passedt )
			end
		     end
		  end
	       else
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yyydydny"
                                              -- no beer garden appended (no examples yet)
                  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yyydydnl"
                        append_beer_garden( passedt )
                     else
		        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yyydydnn"
                                              -- no beer garden appended (no examples yet)
                        else
                           passedt.amenity = "pub_yyydydnd"
                           append_beer_garden( passedt )
                        end
                     end
                  end
	       end
	    else
	       if ( passedt.pub == "micropub" ) then
                  passedt.amenity = "pub_yyydnyd"
                                              -- accommodation unchecked (no examples yet)
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               else
                  passedt.amenity = "pub_yyydnn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               end
	    end
         end -- noncarpeted
      else -- no food
         if ( passedt.noncarpeted == "yes"  ) then
            if ( passedt.microbrewery == "yes"  ) then
                                              -- micropub unchecked (no examples yet)
               if (( passedt.accommodation ~= nil  ) and
                   ( passedt.accommodation ~= ""   ) and
                   ( passedt.accommodation ~= "no" )) then
                  passedt.amenity = "pub_yydyydy"
                  append_wheelchair( passedt )
                                              -- no beer garden appended (no examples yet)
	       else
	          if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yydyydny"
                                              -- no beer garden appended (no examples yet)
     		  else
	             if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yydyydnl"
                        append_beer_garden( passedt )
		     else
		        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yydyydnn"
                           append_beer_garden( passedt )
		        else
                           passedt.amenity = "pub_yydyydnd"
                           append_beer_garden( passedt )
		        end
		     end
	          end
	       end
	    else
	       if ( passedt.pub == "micropub" ) then
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yydynydy"
                                              -- no beer garden appended (no examples yet)
		  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yydynydl"
                        append_beer_garden( passedt )
	             else
			if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yydynydn"
                           append_beer_garden( passedt )
			else
                           passedt.amenity = "pub_yydynydd"
                                              -- no beer garden appended (no examples yet)
			end
	             end
		  end
	       else
                  passedt.amenity = "pub_yydynn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
	       end
	    end
         else
            if ( passedt.microbrewery == "yes"  ) then
	       if ( passedt.pub == "micropub" ) then
                           -- accommodation unchecked (no examples yet)
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yyddyydy"
                     append_beer_garden( passedt )
                  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yyddyydl"
                                             -- no beer garden appended (no examples yet)
                     else
		        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yyddyydn"
                                             -- no beer garden appended (no examples yet)
                        else
                           passedt.amenity = "pub_yyddyydd"
                                             -- no beer garden appended (no examples yet)
                        end
                     end
                  end
               else  -- not micropub
                  if (( passedt.accommodation ~= nil  ) and
                      ( passedt.accommodation ~= ""   ) and
                      ( passedt.accommodation ~= "no" )) then
		     if ( passedt.wheelchair == "yes" ) then
                        passedt.amenity = "pub_yyddynyy"
                        append_beer_garden( passedt )
                     else
		        if ( passedt.wheelchair == "limited" ) then
                           passedt.amenity = "pub_yyddynyl"
                                             -- no beer garden appended (no examples yet)
                        else
			   if ( passedt.wheelchair == "no" ) then
                              passedt.amenity = "pub_yyddynyn"
                                             -- no beer garden appended (no examples yet)
                           else
                              passedt.amenity = "pub_yyddynyd"
                              append_beer_garden( passedt )
                           end
                        end
                     end
                  else  -- no accommodation
                     passedt.amenity = "pub_yyddynn"
                     append_wheelchair( passedt )
                     append_beer_garden( passedt )
                  end -- accommodation
               end  -- micropub
	    else  -- not microbrewery
	       if ( passedt.pub == "micropub" ) then
		  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_yyddnydy"
                                             -- no beer garden appended (no examples yet)
		  else
		     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_yyddnydl"
                                             -- no beer garden appended (no examples yet)
		     else
			if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_yyddnydn"
                           append_beer_garden( passedt )
			else
                           passedt.amenity = "pub_yyddnydd"
                           append_beer_garden( passedt )
			end
		     end
		  end
               else
                  passedt.amenity = "pub_yyddnn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               end
	    end -- microbrewery
         end
      end -- food
   end -- real_ale

   if (( passedt.real_ale == "no" ) and
       ( passedt.amenity == "pub" )) then
      if (( passedt.food ~= nil  ) and
          ( passedt.food ~= ""   ) and
          ( passedt.food ~= "no" )) then
         if ( passedt.noncarpeted == "yes"  ) then
            passedt.amenity = "pub_ynyyddd"
                                              -- accommodation unchecked (no examples yet)
            append_wheelchair( passedt )
            append_beer_garden( passedt )
         else
            if (( passedt.accommodation ~= nil  ) and
                ( passedt.accommodation ~= ""   ) and
                ( passedt.accommodation ~= "no" )) then
               if ( passedt.wheelchair == "yes" ) then
                  passedt.amenity = "pub_ynydddyy"
                  append_beer_garden( passedt )
	       else
	          if ( passedt.wheelchair == "limited" ) then
                     passedt.amenity = "pub_ynydddyl"
                                              -- no beer garden appended (no examples yet)
	          else
	             if ( passedt.wheelchair == "no" ) then
                        passedt.amenity = "pub_ynydddyn"
                                             -- no beer garden appended (no examples yet)
		     else
                        passedt.amenity = "pub_ynydddyd"
                        append_beer_garden( passedt )
	             end
	          end
	       end
	    else  -- accommodation
               if ( passedt.wheelchair == "yes" ) then
                  passedt.amenity = "pub_ynydddny"
                  append_beer_garden( passedt )
	       else
	          if ( passedt.wheelchair == "limited" ) then
                     passedt.amenity = "pub_ynydddnl"
                                              -- no beer garden appended (no examples yet)
	          else
	             if ( passedt.wheelchair == "no" ) then
                        passedt.amenity = "pub_ynydddnn"
                                              -- no beer garden appended (no examples yet)
		     else
                        passedt.amenity = "pub_ynydddnd"
                        append_beer_garden( passedt )
	             end
	          end
	       end
	    end  -- accommodation
         end
      else
         if ( passedt.noncarpeted == "yes"  ) then
            if (( passedt.accommodation ~= nil  ) and
                ( passedt.accommodation ~= ""   ) and
                ( passedt.accommodation ~= "no" )) then
               passedt.amenity = "pub_yndyddy"
               append_wheelchair( passedt )
                                              -- no beer garden appended (no examples yet)
	    else
               passedt.amenity = "pub_yndyddn"
               append_wheelchair( passedt )
               append_beer_garden( passedt )
	    end
         else
            if (( passedt.accommodation ~= nil  ) and
                ( passedt.accommodation ~= ""   ) and
                ( passedt.accommodation ~= "no" )) then
               passedt.amenity = "pub_ynddddy"
                                              -- no wheelchair appended (no examples yet)
                                              -- no beer garden appended (no examples yet)
	    else
               passedt.amenity = "pub_ynddddn"
               append_wheelchair( passedt )
               append_beer_garden( passedt )
	    end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- The many and varied taggings for former pubs should have been turned into
-- disused:amenity=pub above, unless some other tag applies.
-- ----------------------------------------------------------------------------
   if ( passedt.disusedCamenity == "pub" ) then
      passedt.amenity = "pub_nddddddd"
                                                 -- no other attributes checked
   end

-- ----------------------------------------------------------------------------
-- The catch-all here is still "pub" (leaving the tag unchanged)
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "pub" ) then
      if (( passedt.food ~= nil  ) and
          ( passedt.food ~= ""   ) and
          ( passedt.food ~= "no" )) then
         if ( passedt.noncarpeted == "yes"  ) then
            if ( passedt.microbrewery == "yes"  ) then
               passedt.amenity = "pub_ydyyydd"
                                              -- no wheelchair appended (no examples yet)
                                              -- no beer garden appended (no examples yet)
	    else
               passedt.amenity = "pub_ydyyndd"
               append_wheelchair( passedt )
               append_beer_garden( passedt )
	    end
         else
            if ( passedt.microbrewery == "yes"  ) then
               if ( passedt.wheelchair == "yes" ) then
                  passedt.amenity = "pub_ydydyddy"
                                              -- no beer garden appended (no examples yet)
       	       else
                  if ( passedt.wheelchair == "limited" ) then
                     passedt.amenity = "pub_ydydyddl"
                                              -- no beer garden appended (no examples yet)
                  else
                     if ( passedt.wheelchair == "no" ) then
                        passedt.amenity = "pub_ydydyddn"
                                              -- no beer garden appended (no examples yet)
                     else
                        passedt.amenity = "pub_ydydyddd"
                        append_beer_garden( passedt )
                     end
                  end
               end
	    else
	       if ( passedt.pub == "micropub" ) then
                  if ( passedt.wheelchair == "yes" ) then
                     passedt.amenity = "pub_ydydnydy"
                                              -- no beer garden appended (no examples yet)
           	  else
                     if ( passedt.wheelchair == "limited" ) then
                        passedt.amenity = "pub_ydydnydl"
                                              -- no beer garden appended (no examples yet)
                     else
                        if ( passedt.wheelchair == "no" ) then
                           passedt.amenity = "pub_ydydnydn"
                                              -- no beer garden appended (no examples yet)
	                else
                           passedt.amenity = "pub_ydydnydd"
                           append_beer_garden( passedt )
                        end
                     end
	          end
	       else
                  passedt.amenity = "pub_ydydnn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
	       end
	    end
         end
      else -- food don't know
         if ( passedt.noncarpeted == "yes"  ) then
            if ( passedt.microbrewery == "yes"  ) then
                                              -- micropub unchecked (no examples yet)
               if (( passedt.accommodation ~= nil  ) and
                   ( passedt.accommodation ~= ""   ) and
                   ( passedt.accommodation ~= "no" )) then
                  passedt.amenity = "pub_yddyydy"
                                              -- no wheelchair appended (no examples yet)
                                              -- no beer garden appended (no examples yet)
	       else
                  passedt.amenity = "pub_yddyydn"
                  append_beer_garden( passedt )
	       end
	    else
	       if ( passedt.pub == "micropub" ) then
                  passedt.amenity = "pub_yddynyd"
                                              -- no wheelchair appended (no examples yet)
                                              -- no beer garden appended (no examples yet)
	       else
                  passedt.amenity = "pub_yddynnd"
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
	       end
	    end
	 else
            if ( passedt.microbrewery == "yes"  ) then
               if (( passedt.accommodation ~= nil  ) and
                   ( passedt.accommodation ~= ""   ) and
                   ( passedt.accommodation ~= "no" )) then
                  passedt.amenity = "pub_ydddydy"
                                              -- no wheelchair appended (no examples yet)
                                              -- no beer garden appended (no examples yet)
               else
                  passedt.amenity = "pub_ydddydn"
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               end
            else
	       if ( passedt.pub == "micropub" ) then
                  passedt.amenity = "pub_ydddnyd"
                  append_wheelchair( passedt )
                                            -- no beer garden appended (no examples yet)
               else
                  passedt.amenity = "pub_ydddnn"
                  append_accommodation( passedt )
                  append_wheelchair( passedt )
                  append_beer_garden( passedt )
               end
	    end
         end
      end
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

   if (((( passedt.healthcare == "pharmacy"                  )   or
         ( passedt.shop       == "pharmacy"                  ))  and
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
-- Show photo booths as vending machines
-- ----------------------------------------------------------------------------
   if ( passedt.amenity == "photo_booth" )  then
      passedt.amenity = "vending_machine"
      passedt.vending = "photos"
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
   if ((  passedt.shop                == "farm"   )  and
       (( passedt.name                == nil     )   or
        ( passedt.name                == ""      ))  and
       ((( passedt.produce             ~= nil    )   and
         ( passedt.produce             ~= ""     ))  or
        (  passedt.paymentChonesty_box == "yes"   ))) then
      passedt.amenity = "vending_machine"

      if (( passedt.produce == nil ) or
          ( passedt.produce == ""  )) then
         if ( passedt.foodCeggs == "yes" )  then
            passedt.produce = "eggs"
         else
            passedt.produce = "farm shop honesty box"
         end
      end

      passedt.vending = passedt.produce
      passedt.shop    = nil
   end

   if ((  passedt.shop == "eggs"  )  and
       (( passedt.name == nil    )   or
        ( passedt.name == ""     ))) then
      passedt.amenity = "vending_machine"
      passedt.vending = passedt.shop
      passedt.shop    = nil
   end

-- ----------------------------------------------------------------------------
-- Some vending machines get the thing sold as the label.
-- "farm shop honesty box" might have been assigned higher up.
-- ----------------------------------------------------------------------------
   if ((  passedt.amenity == "vending_machine"        ) and
       (( passedt.name    == nil                     )  or
        ( passedt.name    == ""                      )) and
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
-- Motorcycle parking - if "motorcycle" has been used as a subtag,
-- set main tag.  Rendering (with fee or not) is handled below.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "parking"    )  and
       ( passedt.parking == "motorcycle" )) then
      passedt.amenity = "motorcycle_parking"
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
-- Handle razed railways and old inclined_planes as dismantled.
-- dismantled, abandoned are now handled separately to disused in roads.mss
-- ----------------------------------------------------------------------------
   if ((( passedt.railwayChistoric == "rail"           )  or
        ( passedt.historic         == "inclined_plane" )  or
        ( passedt.historic         == "tramway"        )) and
       (( passedt.building         == nil              )  or
        ( passedt.building         == ""               )) and
       (( passedt.highway          == nil              )  or
        ( passedt.highway          == ""               )) and
       (( passedt.railway          == nil              )  or
        ( passedt.railway          == ""               )) and
       (( passedt.waterway         == nil              )  or
        ( passedt.waterway         == ""               ))) then
      passedt.railway = "abandoned"
   end

   if ( passedt.railway == "razed" ) then
      passedt.railway = "dismantled"
   end

-- ----------------------------------------------------------------------------
-- Railway construction
-- This is done mostly to make the HS2 show up.
-- ----------------------------------------------------------------------------
   if ( passedt.railway   == "proposed" ) then
      passedt.railway = "construction"
   end

-- ----------------------------------------------------------------------------
-- The "OpenRailwayMap" crowd prefer the less popular railway:preserved=yes
-- instead of railway=preserved (which has the advantage of still allowing
-- e.g. narrow_gauge in addition to rail).
-- ----------------------------------------------------------------------------
   if ( passedt.railwayCpreserved == "yes" ) then
      passedt.railway = "preserved"
   end

-- ----------------------------------------------------------------------------
-- Show preserved railway tunnels as tunnels.
-- ----------------------------------------------------------------------------
   if (( passedt.railway == "preserved" ) and
       ( passedt.tunnel  == "yes"       )) then
      passedt.railway = "rail"
   end

   if ((( passedt.railway == "miniature"    ) or
        ( passedt.railway == "narrow_gauge" )) and
       (  passedt.tunnel  == "yes"           )) then
      passedt.railway = "light_rail"
   end

-- ----------------------------------------------------------------------------
-- Goods Conveyors - render as miniature railway.
-- ----------------------------------------------------------------------------
   if ( passedt.man_made == "goods_conveyor" ) then
      passedt.railway = "miniature"
   end

-- ----------------------------------------------------------------------------
-- Slipways - render ways as miniature railway in addition to slipway icon
-- ----------------------------------------------------------------------------
   if ( passedt.leisure == "slipway" ) then
      passedt.railway = "miniature"
   end

-- ----------------------------------------------------------------------------
-- Other waterway access points
-- ----------------------------------------------------------------------------
   if (( passedt.waterway   == "access_point"  ) or
       ( passedt.whitewater == "put_in"        ) or
       ( passedt.whitewater == "put_in;egress" ) or
       ( passedt.canoe      == "put_in"        )) then
      passedt.amenity = "waterway_access_point"
      passedt.leisure = nil
      passedt.sport = nil
   end

-- ----------------------------------------------------------------------------
-- Sluice gates - send through as man_made, also display as building=roof.
-- Also waterfall (the dot or line is generic enough to work there too)
-- The change of waterway to weir ensures line features appear too.
-- ----------------------------------------------------------------------------
   if ((  passedt.waterway     == "sluice_gate"      ) or
       (  passedt.waterway     == "sluice"           ) or
       (( passedt.waterway     == "flow_control"    )  and
        ( passedt.flow_control == "sluice_gate"     )) or
       (  passedt.waterway     == "waterfall"        ) or
       (  passedt.natural      == "waterfall"        ) or
       (  passedt.water        == "waterfall"        ) or
       (  passedt.waterway     == "weir"             ) or
       (  passedt.waterway     == "floating_barrier" )) then
      passedt.man_made = "sluice_gate"
      passedt.building = "roof"
      passedt.waterway = "weir"
   end

-- ----------------------------------------------------------------------------
-- Historic canal
-- A former canal can, like an abandoned railway, still be a major
-- physical feature.
--
-- Also treat historic=moat in the same way, unless it has an area=yes tag.
-- Most closed ways for historic=moat appear to be linear ways, not areas.
-- ----------------------------------------------------------------------------
   if ((   passedt.historic           == "canal"           ) or
       (   passedt.historicCwaterway  == "canal"           ) or
       (   passedt.historic           == "leat"            ) or
       (   passedt.disusedCwaterway   == "canal"           ) or
       (   passedt.disused            == "canal"           ) or
       (   passedt.abandonedCwaterway == "canal"           ) or
       (   passedt.waterway           == "disused_canal"   ) or
       (   passedt.waterway           == "historic_canal"  ) or
       (   passedt.waterway           == "abandoned_canal" ) or
       (   passedt.waterway           == "former_canal"    ) or
       (   passedt.waterwayChistoric  == "canal"           ) or
       (   passedt.waterwayCabandoned == "canal"           ) or
       (   passedt.abandoned          == "waterway=canal"  ) or
       ((  passedt.historic           == "moat"           )  and
        (( passedt.natural            == nil             )   or
         ( passedt.natural            == ""              ))  and
        (( passedt.man_made           == nil             )   or
         ( passedt.man_made           == ""              ))  and
        (( passedt.waterway           == nil             )   or
         ( passedt.waterway           == ""              ))  and
        (  passedt.area               ~= "yes"            ))) then
      passedt.waterway = "derelict_canal"
      passedt.historic = nil
      passedt.area     = "no"
   end

-- ----------------------------------------------------------------------------
-- Use historical names if present for historical canals.
-- ----------------------------------------------------------------------------
   if ((  passedt.waterway      == "derelict_canal"  ) and
       (( passedt.name          == nil              )  or
        ( passedt.name          == ""               )) and
       (  passedt.nameChistoric ~= nil               ) and
       (  passedt.nameChistoric ~= ""                )) then
      passedt.name = passedt.nameChistoric
   end

   if ((  passedt.waterway      == "derelict_canal"  ) and
       (( passedt.name          == nil              )  or
        ( passedt.name          == ""               )) and
       (  passedt.historicCname ~= nil               ) and
       (  passedt.historicCname ~= ""                )) then
      passedt.name = passedt.historicCname
   end
   
-- ----------------------------------------------------------------------------
-- Display "waterway=leat" and "waterway=spillway" etc. as drain.
-- "man_made=spillway" tends to be used on areas, hence show as "natural=water".
-- ----------------------------------------------------------------------------
   if ((   passedt.waterway == "leat"        )  or
       (   passedt.waterway == "spillway"    )  or
       (   passedt.waterway == "fish_pass"   )  or
       (   passedt.waterway == "rapids"      )  or
       ((  passedt.waterway == "canal"      )   and
        (( passedt.usage    == "headrace"  )    or
         ( passedt.usage    == "spillway"  )))) then
      passedt.waterway = "drain"
   end

   if ( passedt.man_made == "spillway" ) then
      passedt.natural = "water"
      passedt.man_made = nil
   end

-- ----------------------------------------------------------------------------
-- Any remaining extant canals will be linear features, even closed loops.
-- ----------------------------------------------------------------------------
   if ( passedt.waterway == "canal" ) then
      passedt.area     = "no"
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

      if (( passedt.building == nil ) or
          ( passedt.building == ""  )) then
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
        ( passedt.castle_type == "palace"      ))) then
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
       (( passedt.amenity  == nil                )  or
        ( passedt.amenity  == ""                 )) and
       (( passedt.shop     == nil                )  or
        ( passedt.shop     == ""                 ))) then
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
   if (( passedt.bridgeCname ~= nil ) and
       ( passedt.bridgeCname ~= ""  )) then
      passedt.bridge_name = passedt.bridgeCname
      passedt.bridgeCname = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move bridge_name to name
-- ----------------------------------------------------------------------------
   if (( passedt.bridge_name ~= nil ) and
       ( passedt.bridge_name ~= ""  )) then
      passedt.name = passedt.bridge_name
      passedt.bridge_name = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move bridge:ref to bridge_ref
-- ----------------------------------------------------------------------------
   if (( passedt.bridgeCref ~= nil ) and
       ( passedt.bridgeCref ~= ""  )) then
      passedt.bridge_ref = passedt.bridgeCref
      passedt.bridgeCref = nil
   end

-- ----------------------------------------------------------------------------
-- If set, move canal_bridge_ref to bridge_ref
-- ----------------------------------------------------------------------------
   if (( passedt.canal_bridge_ref ~= nil ) and
       ( passedt.canal_bridge_ref ~= ""  )) then
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
       ( passedt.landuse    == "reservoir"             ) or
       ( passedt.landuse    == "basin"                 ) or
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
   if ((  passedt.natural   == "water"   ) and
       (( passedt.water     == "river"  )  or
        ( passedt.water     == "canal"  )  or
        ( passedt.water     == "stream" )  or
        ( passedt.water     == "ditch"  )  or
        ( passedt.water     == "lock"   )  or
        ( passedt.water     == "drain"  ))) then
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
--
-- The "man_made=power" assignment is just so that a name can be easily 
-- displayed by the rendering map style.
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

   if ((( passedt.man_made == nil        )  or
        ( passedt.man_made == ""         )) and
       (  passedt.power    == "generator" )) then
      if (( passedt.power_source     == "wind"         )  or
          ( passedt.generatorCsource == "wind"         )  or
          ( passedt.generatorCmethod == "wind_turbine" )  or
          ( passedt.plantCsource     == "wind"         )  or
          ( passedt.generatorCmethod == "wind"         )) then
         passedt.man_made = "power_wind"
      else
         passedt.man_made = "power"
      end
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
   if ((  passedt.man_made               == "monitoring_station" ) and
       (  passedt.monitoringCweather     == "yes"                ) and
       (( passedt.weatherCradar          == nil                 )  or
        ( passedt.weatherCradar          == ""                  )) and
       (( passedt.monitoringCwater_level == nil                 )  or
        ( passedt.monitoringCwater_level == ""                  ))) then
      passedt.man_made = "monitoringweather"
   end

-- ----------------------------------------------------------------------------
-- Rainfall monitoring stations
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made               == "monitoring_station" ) and
       (  passedt.monitoringCrainfall    == "yes"                ) and
       (( passedt.monitoringCweather     == nil                 )  or
        ( passedt.monitoringCweather     == ""                  )) and
       (( passedt.monitoringCwater_level == nil                 )  or
        ( passedt.monitoringCwater_level == ""                  ))) then
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
   if ((  passedt.man_made               == "monitoring_station" ) and
       (  passedt.monitoringCair_quality == "yes"                ) and
       (( passedt.monitoringCweather     == nil                 )  or
        ( passedt.monitoringCweather     == ""                  ))) then
      passedt.man_made = nil
      passedt.landuse = "industrial"
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
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
-- Camp pitches - consolidate name and ref into the name.
-- ----------------------------------------------------------------------------
   if ( passedt.tourism == "camp_pitch"  ) then
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         if (( passedt.ref ~= nil ) and
             ( passedt.ref ~= ""  )) then
            passedt.name = passedt.ref
         end
      else
         if (( passedt.ref ~= nil ) and
             ( passedt.ref ~= ""  )) then
            passedt.name = passedt.name .. " " .. passedt.ref
         end
      end
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
   if ((  passedt.information     == "board"  ) and
       (( passedt.disusedCtourism == nil     )  or
        ( passedt.disusedCtourism == ""      )) and
       (( passedt.ruinsCtourism   == nil     )  or
        ( passedt.ruinsCtourism   == ""      )) and
       (( passedt.historic        == nil     )  or
        ( passedt.historic        == ""      ))) then
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
       (( passedt.name        == nil                          )   or
        ( passedt.name        == ""                           ))  and
       (  passedt.boardCtitle ~= nil                           )  and
       (  passedt.boardCtitle ~= ""                            )) then
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

   if (( passedt.shop == "butcher;greengrocer" ) or
       ( passedt.shop == "butcher;deli"        )) then
      passedt.shop = "butcher"
   end

   if ( passedt.shop == "greengrocer;florist" ) then
      passedt.shop = "greengrocer"
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
         ( passedt.highway    ~= ""              )   and
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
-- Assign barrier=tree_row for natural=tree_row so that on raster 
-- "area" tree_rows are shown as tree rows in the "area barriers" layer.
-- ----------------------------------------------------------------------------
   if ( passedt.natural   == "tree_row" ) then
      passedt.barrier = "tree_row"
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
   if (( passedt.shop   == "newsagent"             ) or
       ( passedt.shop   == "kiosk"                 ) or
       ( passedt.shop   == "forecourt"             ) or
       ( passedt.shop   == "food"                  ) or
       ( passedt.shop   == "grocery"               ) or
       ( passedt.shop   == "grocer"                ) or
       ( passedt.shop   == "frozen_food"           ) or
       ( passedt.shop   == "convenience;alcohol"   ) or
       ( passedt.shop   == "convenience;newsagent" ) or
       ( passedt.shop   == "newsagent;alcohol"     )) then
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
   if ((  passedt.amenity   == "atm"               ) or
       (  passedt.amenity   == "fuel"              ) or
       (  passedt.amenity   == "fuel_e"            ) or
       (  passedt.amenity   == "fuel_h"            ) or
       (  passedt.amenity   == "fuel_l"            ) or
       (  passedt.amenity   == "fuel_w"            ) or
       (  passedt.amenity   == "charging_station"  ) or
       (  passedt.amenity   == "bicycle_rental"    ) or
       (  passedt.amenity   == "scooter_rental"    ) or
       (  passedt.amenity   == "vending_machine"   ) or
       (( passedt.amenity  ~= nil                 )  and
        ( passedt.amenity  ~= ""                  )  and
        ( string.match( passedt.amenity, "pub_"  ))) or
       (  passedt.amenity   == "pub"               ) or
       (  passedt.amenity   == "cafe"              ) or
       (  passedt.amenity   == "cafe_dld"          ) or
       (  passedt.amenity   == "cafe_dnd"          ) or
       (  passedt.amenity   == "cafe_dyd"          ) or
       (  passedt.amenity   == "cafe_ydd"          ) or
       (  passedt.amenity   == "cafe_yld"          ) or
       (  passedt.amenity   == "cafe_ynd"          ) or
       (  passedt.amenity   == "cafe_yyd"          ) or
       (  passedt.amenity   == "restaurant"        ) or
       (  passedt.amenity   == "restaccomm"        ) or
       (  passedt.amenity   == "doctors"           ) or
       (  passedt.amenity   == "pharmacy"          ) or
       (  passedt.amenity   == "pharmacy_l"        ) or
       (  passedt.amenity   == "pharmacy_n"        ) or
       (  passedt.amenity   == "pharmacy_y"        ) or
       (  passedt.amenity   == "parcel_locker"     ) or
       (  passedt.amenity   == "veterinary"        ) or
       (  passedt.amenity   == "animal_boarding"   ) or
       (  passedt.amenity   == "cattery"           ) or
       (  passedt.amenity   == "kennels"           ) or
       (  passedt.amenity   == "animal_shelter"    ) or
       (  passedt.animal    == "shelter"           ) or
       (( passedt.craft      ~= nil               )  and
        ( passedt.craft      ~= ""                )) or
       (( passedt.emergency  ~= nil               )  and
        ( passedt.emergency  ~= ""                )) or
       (( passedt.industrial ~= nil               )  and
        ( passedt.industrial ~= ""                )) or
       (( passedt.man_made   ~= nil               )  and
        ( passedt.man_made   ~= ""                )) or
       (( passedt.office     ~= nil               )  and
        ( passedt.office     ~= ""                )) or
       (( passedt.shop       ~= nil               )  and
        ( passedt.shop       ~= ""                )) or
       (  passedt.tourism    == "hotel"            ) or
       (  passedt.military   == "barracks"         )) then
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
             ( not string.find( passedt.name, passedt.brand, 1, true )) and
             ( not string.find( passedt.brand, passedt.name, 1, true ))) then
            passedt.name = passedt.name .. " (" .. passedt.brand .. ")"
            passedt.brand = nil
         else
            if (( passedt.operator ~= nil                                ) and
                ( passedt.operator ~= ""                                 ) and
                ( not string.find( passedt.name, passedt.operator, 1, true )) and
                ( not string.find( passedt.operator, passedt.name, 1, true ))) then
               passedt.name = passedt.name .. " (" .. passedt.operator .. ")"
               passedt.operator = nil
            end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- office=estate_agent.  There's now an icon for "shop", so use that.
-- Also letting_agent
-- ----------------------------------------------------------------------------
   if (( passedt.office  == "estate_agent"      ) or
       ( passedt.amenity == "estate_agent"      ) or
       ( passedt.shop    == "letting_agent"     ) or
       ( passedt.shop    == "council_house"     ) or
       ( passedt.office  == "letting_agent"     )) then
      passedt.shop = "estate_agent"
   end

-- ----------------------------------------------------------------------------
-- plant_nursery and lawnmower etc. to garden_centre
-- Add unnamedcommercial landuse to give non-building areas a background.
-- Usage suggests shop=nursery means plant_nursery.
-- ----------------------------------------------------------------------------
   if (( passedt.landuse == "plant_nursery"              ) or
       ( passedt.shop    == "plant_nursery"              ) or
       ( passedt.shop    == "plant_centre"               ) or
       ( passedt.shop    == "nursery"                    ) or
       ( passedt.shop    == "lawn_mower"                 ) or
       ( passedt.shop    == "lawnmowers"                 ) or
       ( passedt.shop    == "garden_furniture"           ) or
       ( passedt.shop    == "hot_tub"                    ) or
       ( passedt.shop    == "garden_machinery"           ) or
       ( passedt.shop    == "gardening"                  ) or
       ( passedt.shop    == "garden_equipment"           ) or
       ( passedt.shop    == "garden_tools"               ) or
       ( passedt.shop    == "garden"                     ) or
       ( passedt.shop    == "doityourself;garden_centre" ) or
       ( passedt.shop    == "garden_machines"            ) or
       ( passedt.shop    == "groundskeeping"             ) or
       ( passedt.shop    == "plants"                     ) or
       ( passedt.shop    == "garden_centre;interior_decoration;pet;toys" )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "garden_centre"
   end

-- ----------------------------------------------------------------------------
-- "fast_food" consolidation of lesser used tags.  
-- Also render fish and chips etc. with a unique icon.
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "fast_food" ) then
      passedt.amenity = "fast_food"
   end

   if ((  passedt.amenity == "fast_food"                            )  and
       (( passedt.cuisine == "american"                            )   or
        ( passedt.cuisine == "argentinian"                         )   or
        ( passedt.cuisine == "brazilian"                           )   or
        ( passedt.cuisine == "burger"                              )   or
        ( passedt.cuisine == "burger;chicken"                      )   or
        ( passedt.cuisine == "burger;chicken;fish_and_chips;kebab" )   or
        ( passedt.cuisine == "burger;chicken;indian;kebab;pizza"   )   or
        ( passedt.cuisine == "burger;chicken;kebab"                )   or
        ( passedt.cuisine == "burger;chicken;kebab;pizza"          )   or
        ( passedt.cuisine == "burger;chicken;pizza"                )   or
        ( passedt.cuisine == "burger;fish_and_chips"               )   or
        ( passedt.cuisine == "burger;fish_and_chips;kebab;pizza"   )   or
        ( passedt.cuisine == "burger;indian;kebab;pizza"           )   or
        ( passedt.cuisine == "burger;kebab"                        )   or
        ( passedt.cuisine == "burger;kebab;pizza"                  )   or
        ( passedt.cuisine == "burger;pizza"                        )   or
        ( passedt.cuisine == "burger;pizza;kebab"                  )   or
        ( passedt.cuisine == "burger;sandwich"                     )   or
        ( passedt.cuisine == "diner"                               )   or
        ( passedt.cuisine == "grill"                               )   or
        ( passedt.cuisine == "steak_house"                         ))) then
      passedt.amenity = "fast_food_burger"
   end

   if ((  passedt.amenity == "fast_food"               )  and
       (( passedt.cuisine == "chicken"                )   or
        ( passedt.cuisine == "chicken;burger;pizza"   )   or
        ( passedt.cuisine == "chicken;fish_and_chips" )   or
        ( passedt.cuisine == "chicken;grill"          )   or
        ( passedt.cuisine == "chicken;kebab"          )   or
        ( passedt.cuisine == "chicken;pizza"          )   or
        ( passedt.cuisine == "chicken;portuguese"     )   or
        ( passedt.cuisine == "fried_chicken"          )   or
        ( passedt.cuisine == "wings"                  ))) then
      passedt.amenity = "fast_food_chicken"
   end

   if ((  passedt.amenity == "fast_food"               )  and
       (( passedt.cuisine == "chinese"                )   or
        ( passedt.cuisine == "thai"                   )   or
        ( passedt.cuisine == "chinese;thai"           )   or
        ( passedt.cuisine == "chinese;thai;malaysian" )   or
        ( passedt.cuisine == "thai;chinese"           )   or
        ( passedt.cuisine == "asian"                  )   or
        ( passedt.cuisine == "japanese"               )   or
        ( passedt.cuisine == "japanese;sushi"         )   or
        ( passedt.cuisine == "sushi;japanese"         )   or
        ( passedt.cuisine == "japanese;korean"        )   or
        ( passedt.cuisine == "korean;japanese"        )   or
        ( passedt.cuisine == "vietnamese"             )   or
        ( passedt.cuisine == "korean"                 )   or
        ( passedt.cuisine == "ramen"                  )   or
        ( passedt.cuisine == "noodle"                 )   or
        ( passedt.cuisine == "noodle;ramen"           )   or
        ( passedt.cuisine == "malaysian"              )   or
        ( passedt.cuisine == "malaysian;chinese"      )   or
        ( passedt.cuisine == "indonesian"             )   or
        ( passedt.cuisine == "cantonese"              )   or
        ( passedt.cuisine == "chinese;cantonese"      )   or
        ( passedt.cuisine == "chinese;asian"          )   or
        ( passedt.cuisine == "oriental"               )   or
        ( passedt.cuisine == "chinese;english"        )   or
        ( passedt.cuisine == "chinese;japanese"       )   or
        ( passedt.cuisine == "sushi"                  ))) then
      passedt.amenity = "fast_food_chinese"
   end

   if ((  passedt.amenity == "fast_food"                  )  and
       (( passedt.cuisine == "coffee"                    )   or
        ( passedt.cuisine == "coffee_shop"               )   or
        ( passedt.cuisine == "coffee_shop;sandwich"      )   or
        ( passedt.cuisine == "coffee_shop;local"         )   or
        ( passedt.cuisine == "coffee_shop;regional"      )   or
        ( passedt.cuisine == "coffee_shop;cake"          )   or
        ( passedt.cuisine == "coffee_shop;sandwich;cake" )   or
        ( passedt.cuisine == "coffee_shop;breakfast"     )   or
        ( passedt.cuisine == "coffee_shop;italian"       )   or
        ( passedt.cuisine == "cake;coffee_shop"          )   or
        ( passedt.cuisine == "coffee_shop;ice_cream"     ))) then
      passedt.amenity = "fast_food_coffee"
   end

   if ((  passedt.amenity == "fast_food"                          ) and
       (( passedt.cuisine == "fish_and_chips"                    )  or
        ( passedt.cuisine == "chinese;fish_and_chips"            )  or
        ( passedt.cuisine == "fish"                              )  or
        ( passedt.cuisine == "fish_and_chips;chinese"            )  or
        ( passedt.cuisine == "fish_and_chips;indian"             )  or
        ( passedt.cuisine == "fish_and_chips;kebab"              )  or
        ( passedt.cuisine == "fish_and_chips;pizza;kebab"        )  or
        ( passedt.cuisine == "fish_and_chips;pizza;burger;kebab" )  or
        ( passedt.cuisine == "fish_and_chips;pizza"              ))) then
      passedt.amenity = "fast_food_fish_and_chips"
   end

   if ((( passedt.amenity == "fast_food"                        )  and
        ( passedt.cuisine == "ice_cream"                       )   or
        ( passedt.cuisine == "ice_cream;cake;coffee"           )   or
        ( passedt.cuisine == "ice_cream;cake;sandwich"         )   or
        ( passedt.cuisine == "ice_cream;coffee_shop"           )   or
        ( passedt.cuisine == "ice_cream;coffee;waffle"         )   or
        ( passedt.cuisine == "ice_cream;donut"                 )   or
        ( passedt.cuisine == "ice_cream;pizza"                 )   or
        ( passedt.cuisine == "ice_cream;sandwich"              )   or
        ( passedt.cuisine == "ice_cream;tea;coffee"            ))  or
       (  passedt.shop    == "ice_cream"                        )  or
       (  passedt.amenity == "ice_cream"                        )) then
      passedt.amenity = "fast_food_ice_cream"
   end

   if ((  passedt.amenity == "fast_food"            ) and
       (( passedt.cuisine == "indian"              )  or
        ( passedt.cuisine == "curry"               )  or
        ( passedt.cuisine == "nepalese"            )  or
        ( passedt.cuisine == "nepalese;indian"     )  or
        ( passedt.cuisine == "indian;nepalese"     )  or
        ( passedt.cuisine == "bangladeshi"         )  or
        ( passedt.cuisine == "indian;bangladeshi"  )  or
        ( passedt.cuisine == "bangladeshi;indian"  )  or
        ( passedt.cuisine == "indian;curry"        )  or
        ( passedt.cuisine == "indian;kebab"        )  or
        ( passedt.cuisine == "indian;kebab;burger" )  or
        ( passedt.cuisine == "indian;thai"         )  or
        ( passedt.cuisine == "curry;indian"        )  or
        ( passedt.cuisine == "pakistani"           )  or
        ( passedt.cuisine == "indian;pakistani"    )  or
        ( passedt.cuisine == "tandoori"            )  or
        ( passedt.cuisine == "afghan"              )  or
        ( passedt.cuisine == "sri_lankan"          )  or
        ( passedt.cuisine == "punjabi"             )  or
        ( passedt.cuisine == "indian;pizza"        ))) then
      passedt.amenity = "fast_food_indian"
   end

   if ((  passedt.amenity == "fast_food"             ) and
       (( passedt.cuisine == "kebab"                )  or
        ( passedt.cuisine == "kebab;pizza"          )  or
        ( passedt.cuisine == "kebab;pizza;burger"   )  or
        ( passedt.cuisine == "kebab;burger;pizza"   )  or
        ( passedt.cuisine == "kebab;burger;chicken" )  or
        ( passedt.cuisine == "kebab;burger"         )  or
        ( passedt.cuisine == "kebab;fish_and_chips" )  or
        ( passedt.cuisine == "turkish"              ))) then
      passedt.amenity = "fast_food_kebab"
   end

   if ((  passedt.amenity == "fast_food"      )  and
       (( passedt.cuisine == "pasties"       )   or
        ( passedt.cuisine == "pasty"         )   or
        ( passedt.cuisine == "cornish_pasty" )   or
        ( passedt.cuisine == "pie"           )   or
        ( passedt.cuisine == "pies"          ))) then
      passedt.amenity = "fast_food_pie"
   end

   if ((  passedt.amenity == "fast_food"                   )  and
       (( passedt.cuisine == "italian"                    )   or
        ( passedt.cuisine == "italian;pizza"              )   or
        ( passedt.cuisine == "italian_pizza"              )   or
        ( passedt.cuisine == "mediterranean"              )   or
        ( passedt.cuisine == "pasta"                      )   or
        ( passedt.cuisine == "pizza"                      )   or
        ( passedt.cuisine == "pizza;burger"               )   or
        ( passedt.cuisine == "pizza;burger;kebab"         )   or
        ( passedt.cuisine == "pizza;chicken"              )   or
        ( passedt.cuisine == "pizza;fish_and_chips"       )   or
        ( passedt.cuisine == "pizza;indian"               )   or
        ( passedt.cuisine == "pizza;italian"              )   or
        ( passedt.cuisine == "pizza;kebab"                )   or
        ( passedt.cuisine == "pizza;kebab;burger"         )   or
        ( passedt.cuisine == "pizza;kebab;burger;chicken" )   or
        ( passedt.cuisine == "pizza;kebab;chicken"        )   or
        ( passedt.cuisine == "pizza;pasta"                ))) then
      passedt.amenity = "fast_food_pizza"
   end

   if ((  passedt.amenity == "fast_food"             )  and
       (( passedt.cuisine == "sandwich"             )   or
        ( passedt.cuisine == "sandwich;bakery"      )   or
        ( passedt.cuisine == "sandwich;coffee_shop" ))) then
      passedt.amenity = "fast_food_sandwich"
   end

-- ----------------------------------------------------------------------------
-- Sundials
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "clock"   )  and
       ( passedt.display == "sundial" )) then
      passedt.amenity = "sundial"
   end

-- ----------------------------------------------------------------------------
-- Render shop=hardware stores etc. as shop=doityourself
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "hardware"             ) or
       ( passedt.shop    == "tool_hire"            ) or
       ( passedt.shop    == "equipment_hire"       ) or
       ( passedt.shop    == "tools"                ) or
       ( passedt.shop    == "hardware_rental"      ) or
       ( passedt.shop    == "builders_merchant"    ) or
       ( passedt.shop    == "builders_merchants"   ) or
       ( passedt.shop    == "timber"               ) or
       ( passedt.shop    == "fencing"              ) or
       ( passedt.shop    == "plumbers_merchant"    ) or
       ( passedt.shop    == "building_supplies"    ) or
       ( passedt.shop    == "industrial_supplies"  ) or
       ( passedt.office  == "industrial_supplies"  ) or
       ( passedt.shop    == "plant_hire"           ) or
       ( passedt.amenity == "plant_hire;tool_hire" ) or
       ( passedt.shop    == "signs"                ) or
       ( passedt.shop    == "sign"                 ) or
       ( passedt.shop    == "signwriter"           ) or
       ( passedt.craft   == "signmaker"            ) or
       ( passedt.craft   == "roofer"               ) or
       ( passedt.shop    == "roofing"              ) or
       ( passedt.craft   == "floorer"              ) or
       ( passedt.shop    == "building_materials"   ) or
       ( passedt.craft   == "builder"              )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "doityourself"
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Consolidate "lenders of last resort" as pawnbroker
-- "money_transfer" and down from there is perhaps a bit of a stretch; 
-- as there is a distinctive pawnbroker icon, so generic is used for those.
-- ----------------------------------------------------------------------------
   if (( passedt.shop == "money"              ) or
       ( passedt.shop == "money_lender"       ) or
       ( passedt.shop == "loan_shark"         ) or
       ( passedt.shop == "cash"               )) then
      passedt.shop = "pawnbroker"
   end

-- ----------------------------------------------------------------------------
-- Deli is quite popular and has its own icon
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "delicatessen" ) then
      passedt.shop = "deli"
   end

-- ----------------------------------------------------------------------------
-- Other money shops
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "money_transfer"      ) or
       ( passedt.shop    == "finance"             ) or
       ( passedt.office  == "finance"             ) or
       ( passedt.shop    == "financial"           ) or
       ( passedt.shop    == "mortgage"            ) or
       ( passedt.shop    == "financial_services"  ) or
       ( passedt.office  == "financial_services"  ) or
       ( passedt.office  == "financial_advisor"   ) or
       ( passedt.shop    == "financial_advisors"  ) or
       ( passedt.amenity == "financial_advice"    ) or
       ( passedt.amenity == "bureau_de_change"    ) or
       ( passedt.shop    == "gold_buyer"          )) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- hairdresser;beauty
-- ----------------------------------------------------------------------------
   if (( passedt.shop == "hairdresser;beauty" ) or
       ( passedt.shop == "barber"             )) then
      passedt.shop = "hairdresser"
   end

-- ----------------------------------------------------------------------------
-- sports
-- the name is usually characteristic, but try and use an icon.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "golf"              ) or
       ( passedt.shop   == "scuba_diving"      ) or
       ( passedt.shop   == "water_sports"      ) or
       ( passedt.shop   == "fishing"           ) or
       ( passedt.shop   == "fishing_tackle"    ) or
       ( passedt.shop   == "angling"           ) or
       ( passedt.shop   == "fitness_equipment" )) then
      passedt.shop = "sports"
   end

-- ----------------------------------------------------------------------------
-- e-cigarette
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "vaping"                   ) or
       ( passedt.shop   == "vape_shop"                ) or
       ( passedt.shop   == "e-cigarette;mobile_phone" )) then
      passedt.shop = "e-cigarette"
   end

-- ----------------------------------------------------------------------------
-- Various not-really-clothes things best rendered as clothes shops
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "tailor"                  ) or
       ( passedt.craft   == "tailor"                  ) or
       ( passedt.craft   == "dressmaker"              )) then
      passedt.shop = "clothes"
   end

-- ----------------------------------------------------------------------------
-- Currently handle beauty salons etc. as just generic beauty.  Also "chemist"
-- Mostly these have names that describe the business, so less need for a
-- specific icon.
-- ----------------------------------------------------------------------------
   if (( passedt.shop         == "beauty_salon"       ) or
       ( passedt.leisure      == "spa"                ) or
       ( passedt.shop         == "spa"                ) or
       ( passedt.amenity      == "spa"                ) or
       ( passedt.tourism      == "spa"                ) or
       (( passedt.club    == "health"                )  and
        (( passedt.leisure == nil                   )   or
         ( passedt.leisure == ""                    ))  and
        (( passedt.amenity == nil                   )   or
         ( passedt.amenity == ""                    ))  and
        ( passedt.name    ~= nil                     )  and
        ( passedt.name    ~= ""                      )) or
       ( passedt.shop         == "salon"              ) or
       ( passedt.shop         == "nails"              ) or
       ( passedt.shop         == "nail_salon"         ) or
       ( passedt.shop         == "nail"               ) or
       ( passedt.shop         == "chemist"            ) or
       ( passedt.shop         == "soap"               ) or
       ( passedt.shop         == "toiletries"         ) or
       ( passedt.shop         == "beauty_products"    ) or
       ( passedt.shop         == "beauty_treatment"   ) or
       ( passedt.shop         == "perfumery"          ) or
       ( passedt.shop         == "cosmetics"          ) or
       ( passedt.shop         == "tanning"            ) or
       ( passedt.shop         == "tan"                ) or
       ( passedt.shop         == "suntan"             ) or
       ( passedt.leisure      == "tanning_salon"      ) or
       ( passedt.shop         == "health_and_beauty"  ) or
       ( passedt.shop         == "beauty;hairdresser" )) then
      passedt.shop = "beauty"
   end

-- ----------------------------------------------------------------------------
-- "Non-electrical" electronics (i.e. ones for which the "electrical" icon
-- is inappropriate).
-- ----------------------------------------------------------------------------
   if (( passedt.shop  == "security"         ) or
       ( passedt.shop  == "survey"           ) or
       ( passedt.shop  == "survey_equipment" ) or       
       ( passedt.shop  == "hifi"             )) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- Computer
-- ----------------------------------------------------------------------------
   if ( passedt.shop  == "computer_repair" ) then
      passedt.shop = "computer"
   end

-- ----------------------------------------------------------------------------
-- Betting Shops etc.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "betting"             ) or
       ( passedt.amenity == "betting"             ) or
       ( passedt.shop    == "gambling"            ) or
       ( passedt.amenity == "gambling"            ) or
       ( passedt.leisure == "gambling"            ) or
       ( passedt.shop    == "lottery"             ) or
       ( passedt.amenity == "lottery"             ) or
       ( passedt.shop    == "amusements"          ) or
       ( passedt.amenity == "amusements"          ) or
       ( passedt.amenity == "amusement"           ) or
       ( passedt.leisure == "amusement_arcade"    ) or
       ( passedt.leisure == "video_arcade"        ) or
       ( passedt.leisure == "adult_gaming_centre" ) or
       ( passedt.amenity == "casino"              )) then
      passedt.shop = "bookmaker"
   end

-- ----------------------------------------------------------------------------
-- mobile_phone shops 
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "phone"                    ) or
       ( passedt.shop   == "phone_repair"             ) or
       ( passedt.shop   == "telephone"                ) or
       ( passedt.shop   == "mobile_phone_repair"      ) or
       ( passedt.shop   == "mobile_phone_accessories" ) or
       ( passedt.shop   == "mobile_phone;e-cigarette" )) then
      passedt.shop = "mobile_phone"
   end

-- ----------------------------------------------------------------------------
-- gift and other tat shops
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "souvenir"            ) or
       ( passedt.shop   == "souvenirs"           ) or
       ( passedt.shop   == "leather"             ) or
       ( passedt.shop   == "luxury"              ) or
       ( passedt.shop   == "candle"              ) or
       ( passedt.shop   == "candles"             ) or
       ( passedt.shop   == "sunglasses"          ) or
       ( passedt.shop   == "tourist"             ) or
       ( passedt.shop   == "tourism"             ) or
       ( passedt.shop   == "bag"                 ) or
       ( passedt.shop   == "handbag"             ) or
       ( passedt.shop   == "handbags"            ) or
       ( passedt.shop   == "balloon"             ) or
       ( passedt.shop   == "accessories"         ) or
       ( passedt.shop   == "beach"               ) or
       ( passedt.shop   == "surf"                ) or
       ( passedt.shop   == "magic"               ) or
       ( passedt.shop   == "joke"                ) or
       ( passedt.shop   == "party"               ) or
       ( passedt.shop   == "party_goods"         ) or
       ( passedt.shop   == "christmas"           ) or
       ( passedt.shop   == "fashion_accessories" ) or
       ( passedt.shop   == "duty_free"           ) or
       ( passedt.shop   == "crystal"             ) or
       ( passedt.shop   == "crystal_glass"       ) or
       ( passedt.shop   == "crystals"            ) or
       ( passedt.shop   == "printing_stamps"     ) or
       ( passedt.shop   == "armour"              ) or
       ( passedt.shop   == "arts_and_crafts"     )) then
      passedt.shop = "gift"
   end

-- ----------------------------------------------------------------------------
-- Various alcohol shops
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "beer"            ) or
       ( passedt.shop    == "off_licence"     ) or
       ( passedt.shop    == "off_license"     ) or
       ( passedt.shop    == "wine"            ) or
       ( passedt.shop    == "whisky"          ) or
       ( passedt.craft   == "winery"          ) or
       ( passedt.shop    == "winery"          ) or
       ( passedt.tourism == "wine_cellar"     )) then
      passedt.shop = "alcohol"
   end

   if (( passedt.shop    == "sweets"          ) or
       ( passedt.shop    == "sweet"           )) then
      passedt.shop = "confectionery"
   end

-- ----------------------------------------------------------------------------
-- Show pastry shops as bakeries
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "pastry" ) then
      passedt.shop = "bakery"
   end

-- ----------------------------------------------------------------------------
-- Fresh fish shops
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "fish" ) then
      passedt.shop = "seafood"
   end

   if (( passedt.shop    == "camera"             ) or
       ( passedt.shop    == "photo_studio"       ) or
       ( passedt.shop    == "photography"        ) or
       ( passedt.office  == "photography"        ) or
       ( passedt.shop    == "photographic"       ) or
       ( passedt.shop    == "photographer"       ) or
       ( passedt.craft   == "photographer"       )) then
      passedt.shop = "photo"
   end

-- ----------------------------------------------------------------------------
-- Various "homeware" shops.  The icon for these is a generic "room interior".
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "floor"                       ) or
       ( passedt.shop   == "flooring"                    ) or
       ( passedt.shop   == "floors"                      ) or
       ( passedt.shop   == "floor_covering"              ) or
       ( passedt.shop   == "homeware"                    ) or
       ( passedt.shop   == "homewares"                   ) or
       ( passedt.shop   == "home"                        ) or
       ( passedt.shop   == "carpet"                      ) or
       ( passedt.shop   == "carpet;bed"                  ) or
       ( passedt.shop   == "rugs"                        ) or
       ( passedt.shop   == "interior_decoration"         ) or
       ( passedt.shop   == "household"                   ) or
       ( passedt.shop   == "houseware"                   ) or
       ( passedt.shop   == "bathroom_furnishing"         ) or
       ( passedt.shop   == "paint"                       ) or
       ( passedt.shop   == "curtain"                     ) or
       ( passedt.shop   == "furnishings"                 ) or
       ( passedt.shop   == "furnishing"                  ) or
       ( passedt.shop   == "fireplace"                   ) or
       ( passedt.shop   == "lighting"                    ) or
       ( passedt.shop   == "blinds"                      ) or
       ( passedt.shop   == "window_blind"                ) or
       ( passedt.shop   == "kitchenware"                 ) or
       ( passedt.shop   == "interior_design"             ) or
       ( passedt.shop   == "interior"                    ) or
       ( passedt.shop   == "interiors"                   ) or
       ( passedt.shop   == "stoves"                      ) or
       ( passedt.shop   == "stove"                       ) or
       ( passedt.shop   == "tiles"                       ) or
       ( passedt.shop   == "tile"                        ) or
       ( passedt.shop   == "ceramics"                    ) or
       ( passedt.shop   == "windows"                     ) or
       ( passedt.craft  == "window_construction"         ) or
       ( passedt.shop   == "frame"                       ) or
       ( passedt.shop   == "framing"                     ) or
       ( passedt.shop   == "picture_framing"             ) or
       ( passedt.shop   == "picture_framer"              ) or
       ( passedt.craft  == "framing"                     ) or
       ( passedt.shop   == "frame;restoration"           ) or
       ( passedt.shop   == "bedding"                     ) or
       ( passedt.shop   == "cookware"                    ) or
       ( passedt.shop   == "glassware"                   ) or
       ( passedt.shop   == "cookery"                     ) or
       ( passedt.shop   == "catering_supplies"           ) or
       ( passedt.shop   == "catering_equipment"          ) or
       ( passedt.craft  == "upholsterer"                 ) or
       ( passedt.shop   == "doors"                       ) or
       ( passedt.shop   == "doors;glaziery"              ) or
       ( passedt.shop   == "mirrors"                     )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "homeware"
   end

-- ----------------------------------------------------------------------------
-- Other "homeware-like" shops.  These get the furniture icon.
-- Some are a bit of a stretch.
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "upholsterer"                 ) or
       ( passedt.shop   == "chair"                       ) or
       ( passedt.shop   == "luggage"                     ) or
       ( passedt.shop   == "clock"                       ) or
       ( passedt.shop   == "clocks"                      ) or
       ( passedt.shop   == "home_improvement"            ) or
       ( passedt.shop   == "decorating"                  ) or
       ( passedt.shop   == "bed;carpet"                  ) or
       ( passedt.shop   == "country_store"               ) or
       ( passedt.shop   == "equestrian"                  ) or
       ( passedt.shop   == "kitchen"                     ) or
       ( passedt.shop   == "kitchen;bathroom"            ) or
       ( passedt.shop   == "kitchen;bathroom_furnishing" ) or
       ( passedt.shop   == "bedroom"                     ) or
       ( passedt.shop   == "bathroom"                    ) or
       ( passedt.shop   == "glaziery"                    ) or
       ( passedt.craft  == "glaziery"                    ) or
       ( passedt.shop   == "glazier"                     ) or
       ( passedt.shop   == "glazing"                     ) or
       ( passedt.shop   == "stone"                       ) or
       ( passedt.shop   == "brewing"                     ) or
       ( passedt.shop   == "brewing_supplies"            ) or
       ( passedt.shop   == "gates"                       ) or
       ( passedt.shop   == "sheds"                       ) or
       ( passedt.shop   == "shed"                        ) or
       ( passedt.shop   == "ironmonger"                  ) or
       ( passedt.shop   == "furnace"                     ) or
       ( passedt.shop   == "plumbing"                    ) or
       ( passedt.shop   == "plumbing_supplies"           ) or
       ( passedt.craft  == "plumber"                     ) or
       ( passedt.craft  == "carpenter"                   ) or
       ( passedt.craft  == "decorator"                   ) or
       ( passedt.shop   == "bed"                         ) or
       ( passedt.shop   == "mattress"                    ) or
       ( passedt.shop   == "waterbed"                    ) or
       ( passedt.shop   == "glass"                       ) or
       ( passedt.shop   == "garage"                      ) or
       ( passedt.shop   == "conservatory"                ) or
       ( passedt.shop   == "conservatories"              ) or
       ( passedt.shop   == "bathrooms"                   ) or
       ( passedt.shop   == "swimming_pool"               ) or
       ( passedt.shop   == "fitted_furniture"            ) or
       ( passedt.shop   == "upholstery"                  ) or
       ( passedt.shop   == "saddlery"                    )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "furniture"
   end

-- ----------------------------------------------------------------------------
-- Shops that sell coffee etc.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "beverages"       ) or
       ( passedt.shop    == "coffee"          ) or
       ( passedt.shop    == "tea"             )) then
      passedt.shop = "coffee"
   end

-- ----------------------------------------------------------------------------
-- Copyshops
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "printing"       ) or
       ( passedt.shop    == "print"          ) or
       ( passedt.shop    == "printer"        )) then
      passedt.shop = "copyshop"
      passedt.amenity = nil
      passedt.craft = nil
      passedt.office = nil
   end

-- ----------------------------------------------------------------------------
-- This category used to be larger, but the values have been consolidated.
-- Difficult to do an icon for.
-- ----------------------------------------------------------------------------
   if ( passedt.shop    == "printer_ink" ) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- Various single food item and other food shops
-- Unnamed egg honesty boxes have been dealt with above.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "cake"            ) or
       ( passedt.shop    == "chocolate"       ) or
       ( passedt.shop    == "milk"            ) or
       ( passedt.shop    == "cheese"          ) or
       ( passedt.shop    == "cheese;wine"     ) or
       ( passedt.shop    == "wine;cheese"     ) or
       ( passedt.shop    == "dairy"           ) or
       ( passedt.shop    == "eggs"            ) or
       ( passedt.shop    == "honey"           ) or
       ( passedt.shop    == "catering"        ) or
       ( passedt.shop    == "fishmonger"      ) or
       ( passedt.shop    == "spices"          ) or
       ( passedt.shop    == "nuts"            ) or
       ( passedt.shop    == "patisserie"      )) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- fabric and wool etc.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "fabric"               ) or
       ( passedt.shop   == "linen"                ) or
       ( passedt.shop   == "household_linen"      ) or
       ( passedt.shop   == "linens"               ) or
       ( passedt.shop   == "haberdashery"         ) or
       ( passedt.shop   == "sewing"               ) or
       ( passedt.shop   == "needlecraft"          ) or
       ( passedt.shop   == "embroidery"           ) or
       ( passedt.shop   == "knitting"             ) or
       ( passedt.shop   == "wool"                 ) or
       ( passedt.shop   == "yarn"                 ) or
       ( passedt.shop   == "alteration"           ) or
       ( passedt.shop   == "textiles"             ) or
       ( passedt.shop   == "clothing_alterations" ) or
       ( passedt.craft  == "embroiderer"          )) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- health_food etc., and also "non-medical medical" and "woo" shops.
-- ----------------------------------------------------------------------------
   if (( passedt.shop       == "health_food"             ) or
       ( passedt.shop       == "health"                  ) or
       ( passedt.shop       == "organic"                 ) or
       ( passedt.shop       == "supplements"             ) or
       ( passedt.shop       == "nutrition_supplements"   ) or
       ( passedt.shop       == "dietary_supplements"     ) or
       ( passedt.shop       == "healthcare"              ) or
       ( passedt.shop       == "wellness"                ) or
       ( passedt.name       == "Holland and Barrett"     )) then
      if (( passedt.zero_waste         == "yes"                )  or
          ( passedt.zero_waste         == "only"               )  or
          ( passedt.bulk_purchase      == "yes"                )  or
          ( passedt.bulk_purchase      == "only"               )  or
          ( passedt.reusable_packaging == "yes"                )) then
         passedt.shop = "ecohealth_food"
      else
         passedt.shop = "health_food"
      end
   end

   if (( passedt.shop       == "alternative_medicine"    ) or
       ( passedt.shop       == "massage"                 ) or
       ( passedt.shop       == "herbalist"               ) or
       ( passedt.shop       == "herbal_medicine"         ) or
       ( passedt.shop       == "chinese_medicine"        ) or
       ( passedt.shop       == "new_age"                 ) or
       ( passedt.shop       == "psychic"                 ) or
       ( passedt.shop       == "alternative_health"      ) or
       ( passedt.healthcare == "alternative"             ) or
       ( passedt.shop       == "acupuncture"             ) or
       ( passedt.healthcare == "acupuncture"             ) or
       ( passedt.shop       == "aromatherapy"            ) or
       ( passedt.shop       == "meditation"              ) or
       ( passedt.shop       == "esoteric"                )) then
      passedt.shop = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- travel agents
-- the name is usually characteristic
-- ----------------------------------------------------------------------------
   if (( passedt.office == "travel_agent"  ) or
       ( passedt.shop   == "travel_agency" ) or
       ( passedt.shop   == "travel"        )) then
      passedt.shop = "travel_agent"
   end

-- ----------------------------------------------------------------------------
-- books and stationery
-- the name is often characteristic
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "comics"          ) or
       ( passedt.shop   == "comic"           ) or
       ( passedt.shop   == "anime"           ) or
       ( passedt.shop   == "maps"            ) or
       ( passedt.shop   == "books;music"     )) then
      passedt.shop = "books"
   end

   if ( passedt.shop   == "office_supplies" ) then
      passedt.shop = "stationery"
   end

-- ----------------------------------------------------------------------------
-- toys and games etc.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "model"          ) or
       ( passedt.shop   == "games"          ) or
       ( passedt.shop   == "computer_games" ) or
       ( passedt.shop   == "video_games"    ) or
       ( passedt.shop   == "hobby"          ) or
       ( passedt.shop   == "fancy_dress"    )) then
      passedt.shop = "toys"
   end

-- ----------------------------------------------------------------------------
-- Art etc.
-- ----------------------------------------------------------------------------
   if (( passedt.shop   == "craft"          ) or
       ( passedt.shop   == "art_supplies"   ) or
       ( passedt.shop   == "pottery"        ) or
       ( passedt.shop   == "art;frame"      ) or
       ( passedt.craft  == "artist"         ) or
       ( passedt.craft  == "pottery"        ) or
       ( passedt.craft  == "sculptor"       )) then
      passedt.shop  = "art"
      passedt.craft = nil
   end

-- ----------------------------------------------------------------------------
-- Treat "agricultural" as "agrarian"
-- "agrarian" is then further categories below based on other tags
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "agricultural" ) then
      passedt.shop = "agrarian"
   end

-- ----------------------------------------------------------------------------
-- pets and pet services
-- Normally the names are punningly characteristic (e.g. "Bark-in-Style" 
-- dog grooming).
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "pet;garden"              ) or
       ( passedt.shop    == "aquatic"                 ) or
       ( passedt.shop    == "aquatics"                ) or
       ( passedt.shop    == "aquarium"                ) or
       ( passedt.shop    == "pet;corn"                )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "pet"
   end

-- ----------------------------------------------------------------------------
-- Pet and animal food
-- ----------------------------------------------------------------------------
   if (((  passedt.shop     == "agrarian"                        )  and
        (( passedt.agrarian == "feed"                           )  or
         ( passedt.agrarian == "yes"                            )  or
         ( passedt.agrarian == "feed;fertilizer;seed;pesticide" )  or
         ( passedt.agrarian == "feed;seed"                      )  or
         ( passedt.agrarian == "feed;pesticide;seed"            )  or
         ( passedt.agrarian == "feed;tools"                     )  or
         ( passedt.agrarian == "feed;tools;fuel;firewood"       ))) or
       ( passedt.shop    == "pet_supplies"            ) or
       ( passedt.shop    == "pet_care"                ) or
       ( passedt.shop    == "pet_food"                ) or
       ( passedt.shop    == "animal_feed"             )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "pet_food"
   end

-- ----------------------------------------------------------------------------
-- Pet grooming
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "pet_grooming"            ) or
       ( passedt.shop    == "dog_grooming"            ) or
       ( passedt.amenity == "dog_grooming"            ) or
       ( passedt.craft   == "dog_grooming"            ) or
       ( passedt.animal  == "wellness"                )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "pet_grooming"
   end

-- ----------------------------------------------------------------------------
-- Animal boarding
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "animal_boarding"         ) or
       ( passedt.amenity == "cattery"                 ) or
       ( passedt.amenity == "kennels"                 )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity = "animal_boarding"
   end

-- ----------------------------------------------------------------------------
-- Animal shelters
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "animal_shelter"          ) or
       ( passedt.animal  == "shelter"                 )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity = "animal_shelter"
   end

-- ----------------------------------------------------------------------------
-- Car parts
-- ----------------------------------------------------------------------------
   if ((( passedt.shop    == "trade"                       )  and
        ( passedt.trade   == "car_parts"                   )) or
       (  passedt.shop    == "car_accessories"              )  or
       (  passedt.shop    == "tyres"                        )  or
       (  passedt.shop    == "automotive"                   )  or
       (  passedt.shop    == "battery"                      )  or
       (  passedt.shop    == "batteries"                    )  or
       (  passedt.shop    == "number_plate"                 )  or
       (  passedt.shop    == "number_plates"                )  or
       (  passedt.shop    == "license_plates"               )  or
       (  passedt.shop    == "car_audio"                    )  or
       (  passedt.shop    == "motor"                        )  or
       (  passedt.shop    == "motor_spares"                 )  or
       (  passedt.shop    == "motor_accessories"            )  or
       (  passedt.shop    == "car_parts;car_repair"         )  or
       (  passedt.shop    == "bicycle;car_parts"            )  or
       (  passedt.shop    == "car_parts;bicycle"            )) then
      passedt.shop = "car_parts"
   end

-- ----------------------------------------------------------------------------
-- Shopmobility
-- Note that "shop=mobility" is something that _sells_ mobility aids, and is
-- handled as shop=nonspecific for now.
-- We handle some specific cases of shop=mobility here; the rest below.
-- ----------------------------------------------------------------------------
   if ((   passedt.amenity  == "mobility"                 ) or
       (   passedt.amenity  == "mobility_equipment_hire"  ) or
       (   passedt.amenity  == "mobility_aids_hire"       ) or
       (   passedt.amenity  == "shop_mobility"            ) or
       ((  passedt.amenity  == "social_facility"         )  and
        (  passedt.social_facility == "shopmobility"     )) or
       ((( passedt.shop     == "yes"                    )   or
         ( passedt.shop     == "mobility"               )   or
         ( passedt.shop     == "mobility_hire"          )   or
         ( passedt.building == "yes"                    )   or
         ( passedt.building == "unit"                   ))  and
        (( passedt.name     == "Shopmobility"           )   or
         ( passedt.name     == "Shop Mobility"          )))) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity = "shopmobility"
   end

-- ----------------------------------------------------------------------------
-- Music
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "music;video"             ) or
       ( passedt.shop    == "records"                 ) or
       ( passedt.shop    == "record"                  )) then
      passedt.shop = "music"
   end

-- ----------------------------------------------------------------------------
-- Motorcycle
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "motorcycle_repair"            ) or
       ( passedt.shop    == "motorcycle_parts"             ) or
       ( passedt.amenity == "motorcycle_rental"            ) or
       ( passedt.shop    == "atv"                          ) or
       ( passedt.shop    == "scooter"                      )) then
      passedt.shop = "motorcycle"
   end

-- ----------------------------------------------------------------------------
-- Tattoo
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "piercing"                ) or
       ( passedt.shop    == "tattoo;piercing"         ) or
       ( passedt.shop    == "piercing;tattoo"         ) or
       ( passedt.shop    == "body_piercing"           ) or
       ( passedt.shop    == "yes;piercing"            ) or
       ( passedt.shop    == "piercings"               )) then
      passedt.shop = "tattoo"
   end

-- ----------------------------------------------------------------------------
-- Musical Instrument
-- ----------------------------------------------------------------------------
   if ( passedt.shop    == "piano" ) then
      passedt.shop = "musical_instrument"
   end

-- ----------------------------------------------------------------------------
-- Extract ski shops as outdoor shops
-- ----------------------------------------------------------------------------
   if ( passedt.shop == "ski" ) then
      passedt.shop = "outdoor"
   end

-- ----------------------------------------------------------------------------
-- Locksmith
-- ----------------------------------------------------------------------------
   if ( passedt.craft == "locksmith" ) then
      passedt.shop = "locksmith"
   end

-- ----------------------------------------------------------------------------
-- Storage Rental
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "storage"              ) or
       ( passedt.amenity == "self_storage"         ) or
       ( passedt.office  == "storage_rental"       ) or
       ( passedt.shop    == "storage"              )) then
      passedt.shop = "storage_rental"
   end

-- ----------------------------------------------------------------------------
-- car and van rental.
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity == "car_rental"                   ) or
       ( passedt.amenity == "van_rental"                   ) or
       ( passedt.amenity == "car_rental;bicycle_rental"    ) or
       ( passedt.shop    == "car_rental"                   ) or
       ( passedt.shop    == "van_rental"                   )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity    = "car_rental"
   end

-- ----------------------------------------------------------------------------
-- Nonspecific car and related shops.
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "caravan"                      ) or
       ( passedt.shop    == "motorhome"                    ) or
       ( passedt.shop    == "boat"                         ) or
       ( passedt.shop    == "truck"                        ) or
       ( passedt.shop    == "commercial_vehicles"          ) or
       ( passedt.shop    == "commercial_vehicle"           ) or
       ( passedt.shop    == "agricultural_vehicles"        ) or
       ((  passedt.shop    == "agrarian"                                           ) and
        (( passedt.agrarian == "agricultural_machinery"                           )  or
         ( passedt.agrarian == "machine_parts;agricultural_machinery;tools"       )  or
         ( passedt.agrarian == "agricultural_machinery;machine_parts;tools"       )  or
         ( passedt.agrarian == "agricultural_machinery;feed"                      )  or
         ( passedt.agrarian == "agricultural_machinery;machine_parts;tools;signs" )  or
         ( passedt.agrarian == "agricultural_machinery;machine_parts"             )  or
         ( passedt.agrarian == "agricultural_machinery;seed"                      )  or
         ( passedt.agrarian == "machine_parts;agricultural_machinery"             ))) or
       ( passedt.shop    == "tractor"                      ) or
       ( passedt.shop    == "tractors"                     ) or
       ( passedt.shop    == "tractor_repair"               ) or
       ( passedt.shop    == "tractor_parts"                ) or
       ( passedt.shop    == "van"                          ) or
       ( passedt.shop    == "truck_repair"                 ) or
       ( passedt.industrial == "truck_repair"              ) or
       ( passedt.shop    == "forklift_repair"              ) or
       ( passedt.shop    == "trailer"                      ) or
       ( passedt.amenity == "driving_school"               ) or
       ( passedt.shop    == "chandler"                     ) or
       ( passedt.shop    == "chandlery"                    ) or
       ( passedt.shop    == "ship_chandler"                ) or
       ( passedt.craft   == "boatbuilder"                  ) or
       ( passedt.shop    == "marine"                       ) or
       ( passedt.shop    == "boat_repair"                  )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "shopnonspecific"
   end

-- ----------------------------------------------------------------------------
-- Timpson and similar shops.
-- Timpson is brand:wikidata=Q7807658, but all of those are name=Timpson.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "shoe_repair"                        ) or
       ( passedt.shop    == "keys"                               ) or
       ( passedt.shop    == "key"                                ) or
       ( passedt.shop    == "cobblers"                           ) or
       ( passedt.shop    == "cobbler"                            ) or
       ( passedt.shop    == "key_cutting"                        ) or
       ( passedt.shop    == "key_cutting;shoe_repair"            ) or
       ( passedt.shop    == "shoe_repair;key_cutting"            ) or
       ( passedt.shop    == "locksmith;dry_cleaning;shoe_repair" ) or
       ( passedt.craft   == "key_cutter"                         ) or
       ( passedt.craft   == "shoe_repair"                        ) or
       ( passedt.craft   == "key_cutter;shoe_repair"             )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "shoe_repair_etc"
   end

-- ----------------------------------------------------------------------------
-- Taxi offices
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "taxi"                    ) or
       ( passedt.office  == "taxi"                    ) or
       ( passedt.office  == "minicab"                 ) or
       ( passedt.shop    == "minicab"                 ) or
       ( passedt.amenity == "minicab"                 )) then
      passedt.landuse = "unnamedcommercial"
      passedt.amenity = "taxi_office"
      passedt.shop    = nil
      passedt.office  = nil
   end

-- ----------------------------------------------------------------------------
-- Other shops that don't have a specific icon are handled here. including
-- variations.
--
-- Shops are in this list either because they tend to have a characteristic
-- name (e.g. the various card shops), they're difficult to do an icon for
-- or they're rare.
--
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "card"                    ) or
       ( passedt.shop    == "cards"                   ) or
       ( passedt.shop    == "greeting_card"           ) or
       ( passedt.shop    == "greeting_cards"          ) or
       ( passedt.shop    == "greetings_cards"         ) or
       ( passedt.shop    == "greetings"               ) or
       ( passedt.shop    == "card;gift"               ) or
       ( passedt.craft   == "cobbler"                 ) or
       ( passedt.craft   == "shoemaker"               ) or
       ( passedt.shop    == "shoemaker"               ) or
       ( passedt.shop    == "watch_repair"            ) or
       ( passedt.shop    == "cleaning"                ) or
       ( passedt.shop    == "collector"               ) or
       ( passedt.shop    == "coins"                   ) or
       ( passedt.shop    == "video"                   ) or
       ( passedt.shop    == "audio_video"             ) or
       ( passedt.shop    == "erotic"                  ) or
       ( passedt.shop    == "service"                 ) or
       ( passedt.shop    == "tobacco"                 ) or
       ( passedt.shop    == "tobacconist"             ) or
       ( passedt.shop    == "ticket"                  ) or
       ( passedt.shop    == "insurance"               ) or
       ( passedt.shop    == "gallery"                 ) or
       ( passedt.tourism == "gallery"                 ) or
       ( passedt.amenity == "gallery"                 ) or
       ( passedt.amenity == "art_gallery"             ) or
       ( passedt.shop    == "plumber"                 ) or
       ( passedt.shop    == "builder"                 ) or
       ( passedt.shop    == "builders"                ) or
       ( passedt.shop    == "trophy"                  ) or
       ( passedt.shop    == "communication"           ) or
       ( passedt.shop    == "communications"          ) or
       ( passedt.shop    == "internet"                ) or
       ( passedt.amenity == "internet_cafe"           ) or
       ( passedt.shop    == "internet_cafe"           ) or
       ( passedt.shop    == "recycling"               ) or
       ( passedt.shop    == "gun"                     ) or
       ( passedt.craft   == "gunsmith"                ) or
       ( passedt.shop    == "weapons"                 ) or
       ( passedt.shop    == "pyrotechnics"            ) or
       ( passedt.shop    == "hunting"                 ) or
       ( passedt.shop    == "military_surplus"        ) or
       ( passedt.shop    == "fireworks"               ) or
       ( passedt.shop    == "auction"                 ) or
       ( passedt.shop    == "auction_house"           ) or
       ( passedt.shop    == "auctioneer"              ) or
       ( passedt.office  == "auctioneer"              ) or
       ( passedt.shop    == "livestock"               ) or
       ( passedt.shop    == "religion"                ) or
       ( passedt.shop    == "gas"                     ) or
       ( passedt.shop    == "fuel"                    ) or
       ( passedt.shop    == "energy"                  ) or
       ( passedt.shop    == "coal_merchant"           ) or
       ( passedt.amenity == "training"                ) or
       ((( passedt.amenity  == nil                  )   or
         ( passedt.amenity  == ""                   ))  and
        (( passedt.training == "dance"              )   or
         ( passedt.training == "language"           )   or
         ( passedt.training == "performing_arts"    ))) or
       ( passedt.amenity == "tutoring_centre"         ) or
       ( passedt.office  == "tutoring"                ) or
       ( passedt.shop    == "education"               ) or
       ( passedt.shop    == "ironing"                 ) or
       ( passedt.amenity == "stripclub"               ) or
       ( passedt.amenity == "courier"                 ) or
       ( passedt.shop    == "safety_equipment"        )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "shopnonspecific"
   end

   if (( passedt.shop    == "launderette"             ) or
       ( passedt.shop    == "dry_cleaning"            ) or
       ( passedt.shop    == "dry_cleaning;laundry"    ) or
       ( passedt.shop    == "laundry;dry_cleaning"    )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop = "laundry"
   end

-- ----------------------------------------------------------------------------
-- Stonemasons etc.
-- ----------------------------------------------------------------------------
   if (( passedt.craft   == "stonemason"        ) or
       ( passedt.shop    == "gravestone"        ) or
       ( passedt.shop    == "monumental_mason"  ) or
       ( passedt.shop    == "memorials"         )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "funeral_directors"
   end

-- ----------------------------------------------------------------------------
-- Specific handling for incompletely tagged "Howdens".
-- Unfortunately there are a few of these.
-- ----------------------------------------------------------------------------
   if ((( passedt.name     == "Howdens"             )  or
        ( passedt.name     == "Howdens Joinery"     )  or
        ( passedt.name     == "Howdens Joinery Co"  )  or
        ( passedt.name     == "Howdens Joinery Co." )  or
        ( passedt.name     == "Howdens Joinery Ltd" )) and
       (( passedt.shop     == nil                   )  or
        ( passedt.shop     == ""                    )) and
       (( passedt.craft    == nil                   )  or
        ( passedt.craft    == ""                    )) and
       (( passedt.highway  == nil                   )  or
        ( passedt.highway  == ""                    )) and
       (( passedt.landuse  == nil                   )  or
        ( passedt.landuse  == ""                    )) and
       (( passedt.man_made == nil                   )  or
        ( passedt.man_made == ""                    ))) then
      passedt.shop = "trade"
   end

-- ----------------------------------------------------------------------------
-- Shops that we don't know the type of.  Things such as "hire" are here 
-- because we don't know "hire of what".
-- "wood" is here because it's used for different sorts of shops.
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "yes"                ) or
       ( passedt.craft   == "yes"                ) or
       ( passedt.shop    == "other"              ) or
       ( passedt.shop    == "hire"               ) or
       ( passedt.shop    == "rental"             ) or
       ( passedt.office  == "rental"             ) or
       ( passedt.amenity == "rental"             ) or
       ( passedt.shop    == "second_hand"        ) or
       ( passedt.shop    == "junk"               ) or
       ( passedt.shop    == "general"            ) or
       ( passedt.shop    == "general_store"      ) or
       ( passedt.shop    == "retail"             ) or
       ( passedt.shop    == "trade"              ) or
       ( passedt.shop    == "cash_and_carry"     ) or
       ( passedt.shop    == "fixme"              ) or
       ( passedt.shop    == "wholesale"          ) or
       ( passedt.shop    == "wood"               ) or
       ( passedt.shop    == "childrens"          ) or
       ( passedt.shop    == "factory_outlet"     ) or
       ( passedt.shop    == "specialist"         ) or
       ( passedt.shop    == "specialist_shop"    ) or
       ( passedt.shop    == "agrarian"           ) or
       ( passedt.shop    == "hairdresser_supply" ) or
       ( passedt.shop    == "repair"             ) or
       ( passedt.shop    == "packaging"          ) or
       ( passedt.shop    == "telecommunication"  ) or
       ( passedt.shop    == "cannabis"           ) or
       ( passedt.shop    == "hydroponics"        ) or
       ( passedt.shop    == "headshop"           ) or
       ( passedt.shop    == "skate"              ) or
       ( passedt.shop    == "ethnic"             )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "shopnonspecific"
   end

   if (( passedt.amenity     == "optician"                     ) or
       ( passedt.craft       == "optician"                     ) or
       ( passedt.office      == "optician"                     ) or
       ( passedt.shop        == "optometrist"                  ) or
       ( passedt.amenity     == "optometrist"                  ) or
       ( passedt.healthcare  == "optometrist"                  )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "optician"
   end

-- ----------------------------------------------------------------------------
-- chiropodists etc. - render as "nonspecific health".
-- Add unnamedcommercial landuse to give non-building areas a background.
--
-- Places that _sell_ mobility aids are in here.  Shopmobility handled
-- seperately.
-- ----------------------------------------------------------------------------
   if (( passedt.shop        == "hearing_aids"                 ) or
       ( passedt.healthcare  == "hearing_care"                 ) or
       ( passedt.shop        == "medical_supply"               ) or
       ( passedt.office      == "medical_supply"               ) or
       ( passedt.shop        == "mobility"                     ) or
       ( passedt.shop        == "mobility_scooter"             ) or
       ( passedt.shop        == "wheelchair"                   ) or
       ( passedt.shop        == "mobility_aids"                ) or
       ( passedt.shop        == "disability"                   ) or
       ( passedt.shop        == "chiropodist"                  ) or
       ( passedt.amenity     == "chiropodist"                  ) or
       ( passedt.healthcare  == "chiropodist"                  ) or
       ( passedt.amenity     == "chiropractor"                 ) or
       ( passedt.healthcare  == "chiropractor"                 ) or
       ( passedt.healthcare  == "department"                   ) or
       ( passedt.healthcare  == "diagnostics"                  ) or
       ( passedt.healthcare  == "dialysis"                     ) or
       ( passedt.healthcare  == "osteopath"                    ) or
       ( passedt.shop        == "osteopath"                    ) or
       ( passedt.amenity     == "physiotherapist"              ) or
       ( passedt.healthcare  == "physiotherapist"              ) or
       ( passedt.healthcare  == "physiotherapist;podiatrist"   ) or
       ( passedt.shop        == "physiotherapist"              ) or
       ( passedt.healthcare  == "physiotherapy"                ) or
       ( passedt.shop        == "physiotherapy"                ) or
       ( passedt.healthcare  == "psychotherapist"              ) or
       ( passedt.healthcare  == "therapy"                      ) or
       ( passedt.healthcare  == "podiatrist"                   ) or
       ( passedt.healthcare  == "podiatrist;chiropodist"       ) or
       ( passedt.amenity     == "podiatrist"                   ) or
       ( passedt.healthcare  == "podiatry"                     ) or
       ( passedt.amenity     == "healthcare"                   ) or
       ( passedt.amenity     == "clinic"                       ) or
       ( passedt.healthcare  == "clinic"                       ) or
       ( passedt.healthcare  == "clinic;doctor"                ) or
       ( passedt.shop        == "clinic"                       ) or
       ( passedt.amenity     == "social_facility"              ) or
       ((( passedt.amenity         == nil                    )   or
         ( passedt.amenity         == ""                     ))  and
        (( passedt.social_facility == "group_home"           )   or
         ( passedt.social_facility == "nursing_home"         )   or
         ( passedt.social_facility == "assisted_living"      )   or
         ( passedt.social_facility == "care_home"            )   or
         ( passedt.social_facility == "shelter"              )   or
         ( passedt.social_facility == "day_care"             )   or
         ( passedt.social_facility == "day_centre"           )   or
         ( passedt.social_facility == "residential_home"     ))) or
       ( passedt.amenity     == "nursing_home"                 ) or
       ( passedt.healthcare  == "nursing_home"                 ) or
       ( passedt.residential == "nursing_home"                 ) or
       ( passedt.building    == "nursing_home"                 ) or
       ( passedt.amenity     == "care_home"                    ) or
       ( passedt.residential == "care_home"                    ) or
       ( passedt.amenity     == "retirement_home"              ) or
       ( passedt.amenity     == "residential_home"             ) or
       ( passedt.residential == "residential_home"             ) or
       ( passedt.amenity     == "sheltered_housing"            ) or
       ( passedt.residential == "sheltered_housing"            ) or
       ( passedt.amenity     == "childcare"                    ) or
       ( passedt.amenity     == "childrens_centre"             ) or
       ( passedt.amenity     == "preschool"                    ) or
       ( passedt.building    == "preschool"                    ) or
       ( passedt.amenity     == "nursery"                      ) or
       ( passedt.amenity     == "nursery_school"               ) or
       ( passedt.amenity     == "health_centre"                ) or
       ( passedt.healthcare  == "health_centre"                ) or
       ( passedt.building    == "health_centre"                ) or
       ( passedt.amenity     == "medical_centre"               ) or
       ( passedt.building    == "medical_centre"               ) or
       ( passedt.healthcare  == "centre"                       ) or
       ( passedt.healthcare  == "counselling"                  ) or
       ( passedt.craft       == "counsellor"                   ) or
       ( passedt.amenity     == "hospice"                      ) or
       ( passedt.healthcare  == "hospice"                      ) or
       ( passedt.healthcare  == "cosmetic"                     ) or
       ( passedt.healthcare  == "cosmetic_surgery"             ) or
       ( passedt.healthcare  == "dentures"                     ) or
       ( passedt.shop        == "dentures"                     ) or
       ( passedt.shop        == "denture"                      ) or
       ( passedt.healthcare  == "blood_donation"               ) or
       ( passedt.healthcare  == "blood_bank"                   ) or
       ( passedt.healthcare  == "sports_massage_therapist"     ) or
       ( passedt.healthcare  == "massage"                      ) or
       ( passedt.healthcare  == "rehabilitation"               ) or
       ( passedt.healthcare  == "drug_rehabilitation"          ) or
       ( passedt.healthcare  == "medical_imaging"              ) or
       ( passedt.healthcare  == "midwife"                      ) or
       ( passedt.healthcare  == "occupational_therapist"       ) or
       ( passedt.healthcare  == "speech_therapist"             ) or
       ( passedt.healthcare  == "tattoo_removal"               ) or
       ( passedt.healthcare  == "trichologist"                 ) or
       ( passedt.healthcare  == "ocular_prosthetics"           ) or
       ( passedt.healthcare  == "audiologist"                  ) or
       ( passedt.shop        == "audiologist"                  ) or
       ( passedt.healthcare  == "hearing"                      ) or
       ( passedt.healthcare  == "mental_health"                ) or
       ( passedt.amenity     == "daycare"                      )) then
      passedt.landuse = "unnamedcommercial"
      passedt.shop    = "healthnonspecific"
   end

-- ----------------------------------------------------------------------------
-- Defibrillators etc.
-- Move these to the "amenity" key to reduce the code needed to render them.
-- Ones with an non-public, non-yes access value will be rendered less opaque,
-- like other private items such as car parks.
-- ----------------------------------------------------------------------------
   if ( passedt.emergency == "defibrillator" ) then
      passedt.amenity = "defibrillator"
      if ( passedt.indoor == "yes" ) then
         passedt.access = "customers"
      end
   end

   if ((  passedt.emergency        == "life_ring"         ) or
       (  passedt.emergency        == "lifevest"          ) or
       (  passedt.emergency        == "flotation device"  ) or
       (( passedt.emergency        == "rescue_equipment" )  and
        ( passedt.rescue_equipment == "lifering"         ))) then
      passedt.amenity = "life_ring"
   end

   if ( passedt.emergency == "fire_extinguisher" ) then
      passedt.amenity = "fire_extinguisher"
   end

   if ( passedt.emergency == "fire_hydrant" ) then
      passedt.amenity = "fire_hydrant"
   end

-- ----------------------------------------------------------------------------
-- Craft cider
-- Also remove tourism tag (we want to display brewery in preference to
-- attraction or museum).
-- ----------------------------------------------------------------------------
   if ((  passedt.craft   == "cider"    ) or
       (( passedt.craft   == "brewery" )  and
        ( passedt.product == "cider"   ))) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "craftcider"
      passedt.craft  = nil
      passedt.tourism  = nil
   end

-- ----------------------------------------------------------------------------
-- Craft breweries
-- Also remove tourism tag (we want to display brewery in preference to
-- attraction or museum).
-- ----------------------------------------------------------------------------
   if (( passedt.craft == "brewery"       ) or
       ( passedt.craft == "brewery;cider" )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "craftbrewery"
      passedt.craft  = nil
      passedt.tourism  = nil
   end

-- ----------------------------------------------------------------------------
-- Various "printer" offices
-- ----------------------------------------------------------------------------
   if (( passedt.shop    == "printers"          ) or
       ( passedt.amenity == "printer"           ) or
       ( passedt.craft   == "printer"           ) or
       ( passedt.office  == "printer"           ) or
       ( passedt.office  == "design"            ) or
       ( passedt.craft   == "printmaker"        ) or
       ( passedt.craft   == "print_shop"        )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Various crafts that should appear as at least a nonspecific office.
-- ----------------------------------------------------------------------------
   if ((( passedt.amenity == nil                       )   or
        ( passedt.amenity == ""                        ))  and
       (( passedt.shop    == nil                       )   or
        ( passedt.shop    == ""                        ))  and
       (( passedt.tourism == nil                       )   or
        ( passedt.tourism == ""                        ))  and
       (( passedt.craft   == "agricultural_engines"    )   or
        ( passedt.craft   == "atelier"                 )   or
        ( passedt.craft   == "blacksmith"              )   or
        ( passedt.craft   == "beekeeper"               )   or
        ( passedt.craft   == "bookbinder"              )   or
        ( passedt.craft   == "carpet_layer"            )   or
        ( passedt.craft   == "cabinet_maker"           )   or
        ( passedt.craft   == "caterer"                 )   or
        ( passedt.craft   == "cleaning"                )   or
        ( passedt.craft   == "clockmaker"              )   or
        ( passedt.craft   == "confectionery"           )   or
        ( passedt.craft   == "dental_technician"       )   or
        ( passedt.craft   == "engineering"             )   or
        ( passedt.craft   == "furniture"               )   or
        ( passedt.craft   == "furniture_maker"         )   or
        ( passedt.craft   == "gardener"                )   or
        ( passedt.craft   == "handicraft"              )   or
        ( passedt.craft   == "insulation"              )   or
        ( passedt.craft   == "joiner"                  )   or
        ( passedt.craft   == "metal_construction"      )   or
        ( passedt.craft   == "painter"                 )   or
        ( passedt.craft   == "plasterer"               )   or
        ( passedt.craft   == "photographic_laboratory" )   or
        ( passedt.craft   == "saddler"                 )   or
        ( passedt.craft   == "sailmaker"               )   or
        ( passedt.craft   == "scaffolder"              )   or
        ( passedt.craft   == "tiler"                   )   or
        ( passedt.craft   == "watchmaker"              ))) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "nonspecific"
      passedt.craft   = nil
   end

-- ----------------------------------------------------------------------------
-- Telephone Exchanges
-- ----------------------------------------------------------------------------
   if ((    passedt.man_made   == "telephone_exchange"  )  or
       (    passedt.amenity    == "telephone_exchange"  )  or
       ((   passedt.building   == "telephone_exchange" )   and
        ((( passedt.amenity    == nil                )     or
          ( passedt.amenity    == ""                 ))    and
         (( passedt.man_made   == nil                )     or
          ( passedt.man_made   == ""                 ))    and
         (( passedt.office     == nil                )     or
          ( passedt.office     == ""                 )))   or
        (   passedt.telecom    == "exchange"           ))) then
      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         passedt.name  = "Telephone Exchange"
      end

      passedt.office  = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- If we know that something is a building=office, and it has a name, but is
-- not already known as an amenity, office or shop, add office=nonspecific.
-- ----------------------------------------------------------------------------
   if ((  passedt.building == "office" ) and
       (  passedt.name     ~= nil      ) and
       (  passedt.name     ~= ""       ) and
       (( passedt.amenity  == nil     )  or
        ( passedt.amenity  == ""      )) and
       (( passedt.office   == nil     )  or
        ( passedt.office   == ""      )) and
       (( passedt.shop     == nil     )  or
        ( passedt.shop     == ""      ))) then
      passedt.office  = "nonspecific"
   end

-- ----------------------------------------------------------------------------
-- Offices that we don't know the type of.  
-- Add unnamedcommercial landuse to give non-building areas a background.
-- ----------------------------------------------------------------------------
   if (( passedt.office     == "company"           ) or
       ( passedt.shop       == "office"            ) or
       ( passedt.amenity    == "office"            ) or
       ( passedt.office     == "private"           ) or
       ( passedt.office     == "research"          ) or
       ( passedt.office     == "yes"               ) or
       ( passedt.commercial == "office"            )) then
      passedt.landuse = "unnamedcommercial"
      passedt.office  = "nonspecific"
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
       ( passedt.shop        == "home_care"               ) or
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
       ( passedt.shop        == "hvac"                    ) or
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
       ( passedt.shop        == "machinery"               ) or
       ( passedt.shop        == "industrial"              ) or
       ( passedt.shop        == "engineering"             ) or
       ( passedt.shop        == "construction"            ) or
       ( passedt.shop        == "water"                   ) or
       ( passedt.shop        == "pest_control"            ) or
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
      passedt.highway = "pathwide"
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
-- Masts etc.  Consolidate various sorts of masts and towers into the "mast"
-- group.  Note that this includes "tower" temporarily, and "campanile" is in 
-- here as a sort of tower (only 2 mapped in UK currently).
-- Also remove any "tourism" tags (which may be semi-valid mapping but are
-- often just "for the renderer").
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made   == "tower"    ) and
       (( passedt.towerCtype == "cooling" )  or
        ( passedt.towerCtype == "chimney" ))) then
      if (( tonumber(passedt.height) or 0 ) >  100 ) then
         passedt.man_made = "bigchimney"
      else
         passedt.man_made = "chimney"
      end
      passedt.tourism = nil
   end

   if (( passedt.man_made   == "tower"    ) and
       ( passedt.towerCtype == "lighting" )) then
      passedt.man_made = "illuminationtower"
      passedt.tourism = nil
   end

   if ((   passedt.man_made           == "tower"       ) and
       ((  passedt.towerCtype         == "defensive"  )  or
        ((( passedt.towerCtype         == nil        )   or
          ( passedt.towerCtype         == ""         ))   and
         ( passedt.towerCconstruction == "stone"     )))) then
      passedt.man_made = "defensivetower"
      passedt.tourism = nil
   end

   if (( passedt.man_made   == "tower"       ) and
       ( passedt.towerCtype == "observation" )) then
      if (( tonumber(passedt.height) or 0 ) >  100 ) then
         passedt.man_made = "bigobservationtower"
      else
         passedt.man_made = "observationtower"
      end
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Clock towers
-- ----------------------------------------------------------------------------
   if (((  passedt.man_made   == "tower"        )  and
        (( passedt.towerCtype == "clock"       )   or
         ( passedt.building   == "clock_tower" )   or
         ( passedt.amenity    == "clock"       ))) or
       ((  passedt.amenity    == "clock"        )  and
        (  passedt.support    == "tower"        ))) then
      passedt.man_made = "clocktower"
      passedt.tourism = nil
   end

   if ((  passedt.amenity    == "clock"         )  and
       (( passedt.support    == "pedestal"     )   or
        ( passedt.support    == "pole"         )   or
        ( passedt.support    == "stone_pillar" )   or
        ( passedt.support    == "plinth"       )   or
        ( passedt.support    == "column"       ))) then
      passedt.man_made = "clockpedestal"
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Aircraft control towers
-- ----------------------------------------------------------------------------
   if (((  passedt.man_made   == "tower"             )   and
        (( passedt.towerCtype == "aircraft_control" )    or
         ( passedt.service    == "aircraft_control" )))  or
       (   passedt.aeroway    == "control_tower"      )) then
      passedt.man_made = "aircraftcontroltower"
      passedt.building = "yes"
      passedt.tourism = nil
   end

   if ((( passedt.man_made   == "tower"              )   or
        ( passedt.man_made   == "monitoring_station" ))  and
       (( passedt.towerCtype == "radar"              )   or
        ( passedt.towerCtype == "weather_radar"      ))) then
      passedt.man_made = "radartower"
      passedt.building = "yes"
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- All the domes in the UK are radomes.
-- ----------------------------------------------------------------------------
   if (( passedt.man_made            == "tower"   ) and
       (( passedt.towerCconstruction == "dome"   )  or
        ( passedt.towerCconstruction == "dish"   ))) then
      passedt.man_made = "radartower"
      passedt.building = "yes"
      passedt.tourism = nil
   end

   if (( passedt.man_made   == "tower"                ) and
       ( passedt.towerCtype == "firefighter_training" )) then
      passedt.man_made = "squaretower"
      passedt.building = "yes"
      passedt.tourism = nil
   end

   if ((((  passedt.man_made    == "tower"             )  and
         (( passedt.towerCtype  == "church"           )   or
          ( passedt.towerCtype  == "square"           )   or
          ( passedt.towerCtype  == "campanile"        )   or
          ( passedt.towerCtype  == "bell_tower"       ))) or
        (   passedt.man_made    == "campanile"          )) and
       (((  passedt.amenity     == nil                 )   or
         (  passedt.amenity     == ""                  ))  or
        (   passedt.amenity     ~= "place_of_worship"   ))) then
      passedt.man_made = "churchtower"
      passedt.tourism = nil
   end

   if (((  passedt.man_made      == "tower"            ) or
        (  passedt.building      == "tower"            ) or
        (  passedt.buildingCpart == "yes"              )) and
        ((  passedt.towerCtype   == "spire"            )  or
         (  passedt.towerCtype   == "steeple"          )  or
         (  passedt.towerCtype   == "minaret"          )  or
         (  passedt.towerCtype   == "round"            )) and
       ((  passedt.amenity       == nil                 )  or
        (  passedt.amenity       == ""                  )  or
        (  passedt.amenity       ~= "place_of_worship"  ))) then
      passedt.man_made = "churchspire"
      passedt.building = "yes"
      passedt.tourism = nil
   end

   if (( passedt.man_made == "phone_mast"           ) or
       ( passedt.man_made == "radio_mast"           ) or
       ( passedt.man_made == "communications_mast"  ) or
       ( passedt.man_made == "tower"                ) or
       ( passedt.man_made == "communications_tower" ) or
       ( passedt.man_made == "transmitter"          ) or
       ( passedt.man_made == "antenna"              ) or
       ( passedt.man_made == "mast"                 )) then
      if (( tonumber(passedt.height) or 0 ) >  300 ) then
         passedt.man_made = "bigmast"
      else
         passedt.man_made = "mast"
      end
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- Drinking water and water that's not OK for drinking
-- "amenity=drinking_water" is shown as "tap_drinking.p.20.png"
-- "amenity=nondrinking_water" is shown as "tap_nondrinking.p.20.png"
--
-- First, catch any mistagged fountains:
-- ----------------------------------------------------------------------------
   if (( passedt.amenity        == "fountain" ) and
       ( passedt.drinking_water == "yes"      )) then
      passedt.amenity = "drinking_water"
   end

   if (((( passedt.man_made == "water_tap"   )   or
         ( passedt.waterway == "water_point" ))  and
        (( passedt.amenity  == nil           )   or
         ( passedt.amenity  == ""            ))) or
       (   passedt.amenity  == "water_point"   ) or
       (   passedt.amenity  == "dish_washing"  ) or
       (   passedt.amenity  == "washing_area"  ) or
       (   passedt.amenity  == "utilities"     )) then
      if ( passedt.drinking_water == "yes" ) then
         passedt.amenity = "drinking_water"
      else
         passedt.amenity = "nondrinking_water"
      end
   end

-- ----------------------------------------------------------------------------
-- man_made=maypole
-- ----------------------------------------------------------------------------
   if ((  passedt.man_made == "maypole"   ) or
       (  passedt.man_made == "may_pole"  ) or
       (  passedt.historic == "maypole"   )) then
      passedt.man_made = "maypole"
      passedt.tourism = nil
   end

-- ----------------------------------------------------------------------------
-- highway=streetlamp
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "street_lamp" ) then
      if ( passedt.lamp_type == "gaslight" ) then
         passedt.highway = "streetlamp_gas"
      else
         passedt.highway = "streetlamp_electric"
      end
   end

-- ----------------------------------------------------------------------------
-- Departure boards not associated with bus stops etc.
-- ----------------------------------------------------------------------------
   if ((( passedt.highway                       == nil                            )  or
        ( passedt.highway                       == ""                             )) and
       (( passedt.railway                       == nil                            )  or
        ( passedt.railway                       == ""                             )) and
       (( passedt.public_transport              == nil                            )  or
        ( passedt.public_transport              == ""                             )) and
       (( passedt.building                      == nil                            )  or
        ( passedt.building                      == ""                             )) and
       (( passedt.departures_board              == "realtime"                     ) or
        ( passedt.departures_board              == "timetable; realtime"          ) or
        ( passedt.departures_board              == "realtime;timetable"           ) or
        ( passedt.departures_board              == "timetable;realtime"           ) or
        ( passedt.departures_board              == "realtime_multiline"           ) or
        ( passedt.departures_board              == "realtime,timetable"           ) or
        ( passedt.departures_board              == "multiline"                    ) or
        ( passedt.departures_board              == "realtime_multiline;timetable" ) or
        ( passedt.passenger_information_display == "realtime"                     ))) then
         passedt.highway = "board_realtime"
   end

-- ----------------------------------------------------------------------------
-- If a bus stop pole exists but it's known to be disused, indicate that.
--
-- We also show bus stands as disused bus stops - they are somewhere where you
-- might expect to be able to get on a bus, but cannot.
-- ----------------------------------------------------------------------------
   if ((( passedt.disusedChighway    == "bus_stop"  )  and
        ( passedt.physically_present == "yes"       )) or
       (  passedt.highway            == "bus_stand"  ) or
       (  passedt.amenity            == "bus_stand"  )) then
      passedt.highway = "bus_stop_disused_pole"
      passedt.disusedChighway = nil
      passedt.amenity = nil

      if (( passedt.name ~= nil ) and
          ( passedt.name ~= ""  )) then
         passedt.ele = passedt.name
      end
   end

-- ----------------------------------------------------------------------------
-- Some people tag waste_basket on bus_stop.  We render just bus_stop.
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "bus_stop"     ) and
       ( passedt.amenity == "waste_basket" )) then
      passedt.amenity = nil
   end

-- ----------------------------------------------------------------------------
-- Many "naptan:Indicator" are "opp" or "adj", but some are "Stop XYZ" or
-- various other bits and pieces.  See 
-- https://taginfo.openstreetmap.org/keys/naptan%3AIndicator#values
-- We remove overly long ones.
-- Similarly, long "ref" values.
-- ----------------------------------------------------------------------------
   if (( passedt.naptanCIndicator ~= nil           ) and
       ( passedt.naptanCIndicator ~= ""            ) and
       ( string.len( passedt.naptanCIndicator) > 3 )) then
      passedt.naptanCIndicator = nil
   end

   if (( passedt.highway == "bus_stop" ) and
       ( passedt.ref     ~= nil        ) and
       ( passedt.ref     ~= ""         ) and
       ( string.len( passedt.ref) > 3  )) then
      passedt.ref = nil
   end

-- ----------------------------------------------------------------------------
-- Concatenate a couple of names for bus stops so that the most useful ones
-- are displayed.
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "bus_stop" ) then
      if (( passedt.name ~= nil ) and
          ( passedt.name ~= ""  )) then
         if (( passedt.bus_speech_output_name ~= nil                                ) and
             ( passedt.bus_speech_output_name ~= ""                                 ) and
             ( not string.find( passedt.name, passedt.bus_speech_output_name, 1, true ))) then
            passedt.name = passedt.name .. " / " .. passedt.bus_speech_output_name
         end

         if (( passedt.bus_display_name ~= nil                                ) and
             ( passedt.bus_display_name ~= ""                                 ) and
             ( not string.find( passedt.name, passedt.bus_display_name, 1, true ))) then
            passedt.name = passedt.name .. " / " .. passedt.bus_display_name
         end
      end

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         if (( passedt.ref == nil ) or
             ( passedt.ref == ""  )) then
            if (( passedt.naptanCIndicator ~= nil )  and
                ( passedt.naptanCIndicator ~= ""  )) then
               passedt.name = passedt.naptanCIndicator
            end
         else -- ref not nil
            if (( passedt.naptanCIndicator == nil ) or
                ( passedt.naptanCIndicator == ""  )) then
               passedt.name = passedt.ref
            else
               passedt.name = passedt.ref .. " " .. passedt.naptanCIndicator
            end
         end
      else -- name not nil
         if (( passedt.ref == nil ) or
             ( passedt.ref == ""  )) then
            if (( passedt.naptanCIndicator ~= nil )  and
                ( passedt.naptanCIndicator ~= ""  )) then
               passedt.name = passedt.name .. " " .. passedt.naptanCIndicator
            end
         else -- neither name nor ref nil
            if (( passedt.naptanCIndicator == nil )  or
                ( passedt.naptanCIndicator == ""  )) then
               passedt.name = passedt.name .. " " .. passedt.ref
            else -- naptanCIndicator not nil
               passedt.name = passedt.name .. " " .. passedt.ref .. " " .. passedt.naptanCIndicator
            end
         end
      end

      if (( passedt.name == nil ) or
          ( passedt.name == ""  )) then
         if (( passedt.website ~= nil ) and
             ( passedt.website ~= ""  )) then
            passedt.ele = passedt.website
         end
      else -- name not nil
         if (( passedt.website == nil ) or
             ( passedt.website == ""  )) then
            passedt.ele = passedt.name
         else -- website not nil
            passedt.ele = passedt.name .. " " .. passedt.website
         end
      end

-- ----------------------------------------------------------------------------
-- Can we set a "departures_board" value based on a "timetable" value?
-- ----------------------------------------------------------------------------
      if ((( passedt.departures_board == nil         )  or
           ( passedt.departures_board == ""          )) and
          (  passedt.timetable        == "real_time"  )) then
         passedt.departures_board = "realtime"
      end

      if ((( passedt.departures_board == nil   )  or
           ( passedt.departures_board == ""    )) and
          (  passedt.timetable        == "yes"  )) then
         passedt.departures_board = "timetable"
      end

-- ----------------------------------------------------------------------------
-- Based on the other tags that are set, 
-- let's use different symbols for bus stops
-- ----------------------------------------------------------------------------
      if (( passedt.departures_board              == "realtime"                     ) or
          ( passedt.departures_board              == "timetable; realtime"          ) or
          ( passedt.departures_board              == "realtime;timetable"           ) or
          ( passedt.departures_board              == "timetable;realtime"           ) or
          ( passedt.departures_board              == "realtime_multiline"           ) or
          ( passedt.departures_board              == "realtime,timetable"           ) or
          ( passedt.departures_board              == "multiline"                    ) or
          ( passedt.departures_board              == "realtime_multiline;timetable" ) or
          ( passedt.passenger_information_display == "realtime"                     )) then
         if (( passedt.departures_boardCspeech_output              == "yes" ) or
             ( passedt.passenger_information_displayCspeech_output == "yes" )) then
            passedt.highway = "bus_stop_speech_realtime"
         else
            passedt.highway = "bus_stop_realtime"
         end
      else
         if (( passedt.departures_board              == "timetable"        ) or
             ( passedt.departures_board              == "schedule"         ) or
             ( passedt.departures_board              == "separate"         ) or
             ( passedt.departures_board              == "paper timetable"  ) or
             ( passedt.departures_board              == "yes"              ) or
             ( passedt.passenger_information_display == "timetable"        ) or
             ( passedt.passenger_information_display == "yes"              )) then
            if (( passedt.departures_boardCspeech_output              == "yes" ) or
                ( passedt.passenger_information_displayCspeech_output == "yes" )) then
               passedt.highway = "bus_stop_speech_timetable"
            else
               passedt.highway = "bus_stop_timetable"
            end
         else
            if (( passedt.flag               == "no"  ) or
                ( passedt.pole               == "no"  ) or
                ( passedt.physically_present == "no"  ) or
                ( passedt.naptanCBusStopType == "CUS" )) then
               passedt.highway = "bus_stop_nothing"
            else
               passedt.highway = "bus_stop_pole"
            end
         end
      end
   end

-- ----------------------------------------------------------------------------
-- Names for vacant shops
-- ----------------------------------------------------------------------------
   if ((((( passedt.disusedCshop    ~= nil        )    and
          ( passedt.disusedCshop    ~= ""         ))   or
         (( passedt.disusedCamenity ~= nil        )    and
          ( passedt.disusedCamenity ~= ""         )))  and
         (  passedt.disusedCamenity ~= "fountain"   )  and
         (  passedt.disusedCamenity ~= "parking"    )  and
         (( passedt.shop            == nil         )   or
          ( passedt.shop            == ""          ))  and
         (( passedt.amenity         == nil         )   or
          ( passedt.amenity         == ""          ))) or
       (    passedt.office          == "vacant"      ) or
       (    passedt.office          == "disused"     ) or
       (    passedt.shop            == "disused"     ) or
       (    passedt.shop            == "abandoned"   ) or
       ((   passedt.shop            ~= nil          )  and
        (   passedt.shop            ~= ""           )  and
        (   passedt.opening_hours   == "closed"     ))) then
      passedt.shop = "vacant"
   end

   if ( passedt.shop == "vacant" ) then
      if ((( passedt.name     == nil )  or
           ( passedt.name     == ""  )) and
          (  passedt.old_name ~= nil  ) and
          (  passedt.old_name ~= ""   )) then
         passedt.name     = passedt.old_name
         passedt.old_name = nil
      end

      if ((( passedt.name     == nil   )  or
           ( passedt.name     == ""    )) and
          (  passedt.former_name ~= nil ) and
          (  passedt.former_name ~= ""  )) then
         passedt.name     = passedt.former_name
         passedt.former_name = nil
      end

      if (( passedt.name == nil )  or
          ( passedt.name == ""  )) then
         passedt.ref = "(vacant)"
      else
         passedt.ref = "(vacant: " .. passedt.name .. ")"
         passedt.name = nil
      end
   end

-- ----------------------------------------------------------------------------
-- Remove icon for public transport and animal field shelters and render as
-- "roof" (if they are a way).
-- "roof" isn't rendered for nodes, so this has the effect of suppressing
-- public_transport shelters and shopping_cart shelters on nodes.
-- shopping_cart, parking and animal_shelter aren't really a "shelter" type 
-- that we are interested in (for humans).  There are no field or parking 
-- shelters on nodes in GB/IE.
-- ----------------------------------------------------------------------------
   if (( passedt.amenity      == "shelter"            ) and
       (( passedt.shelter_type == "public_transport" )  or
        ( passedt.shelter_type == "field_shelter"    )  or
        ( passedt.shelter_type == "shopping_cart"    )  or
        ( passedt.shelter_type == "trolley_park"     )  or
        ( passedt.shelter_type == "parking"          )  or
        ( passedt.shelter_type == "animal_shelter"   ))) then
      passedt.amenity = nil
      if (( passedt.building == nil )  or
          ( passedt.building == ""  )) then
         passedt.building = "roof"
      end
   end

  if (( passedt.amenity      == "shelter"            ) and
      ( passedt.shelter_type == "bicycle_parking"    )) then
      passedt.amenity = "bicycle_parking"
      if (( passedt.building == nil )  or
          ( passedt.building == ""  )) then
         passedt.building = "roof"
      end
   end

-- ----------------------------------------------------------------------------
-- Prevent highway=raceway from appearing in the polygon table.
-- ----------------------------------------------------------------------------
   if ( passedt.highway == "raceway" ) then
      passedt.area = "no"
   end

-- ----------------------------------------------------------------------------
-- Drop some highway areas - "track" etc. areas wherever I have seen them are 
-- garbage.
-- "footway" (pedestrian areas) and "service" (e.g. petrol station forecourts)
-- tend to be OK.  Other options tend not to occur.
-- ----------------------------------------------------------------------------
   if ((( passedt.highway == "track"          )  or
        ( passedt.highway == "leisuretrack"   )  or
        ( passedt.highway == "gallop"         )  or
        ( passedt.highway == "residential"    )  or
        ( passedt.highway == "unclassified"   )  or
        ( passedt.highway == "tertiary"       )) and
       (  passedt.area    == "yes"             )) then
      passedt.highway = nil
   end

-- ----------------------------------------------------------------------------
-- Show traffic islands as kerbs
-- ----------------------------------------------------------------------------
   if (( passedt.areaChighway == "traffic_island" )  or
       ( passedt.landuse      == "traffic_island" )) then
      passedt.barrier = "kerb"
   end

-- ----------------------------------------------------------------------------
-- name and addr:housename
-- If a building that isn't something else has a name but no addr:housename,
-- use that there.
--
-- There are some odd combinations of "place" and "building" - we remove 
-- "place" in those cases
-- ----------------------------------------------------------------------------
   if ((  passedt.building       ~= nil   ) and
       (  passedt.building       ~= ""    ) and
       (  passedt.building       ~= "no"  ) and
       (( passedt.addrChousename == nil  )  or
        ( passedt.addrChousename == ""   )) and
       (  passedt.name           ~= nil   ) and
       (  passedt.name           ~= ""    ) and
       (( passedt.aeroway        == nil  )  or
        ( passedt.aeroway        == ""   )) and
       (( passedt.amenity        == nil  )  or
        ( passedt.amenity        == ""   )) and
       (( passedt.barrier        == nil  )  or
        ( passedt.barrier        == ""   )) and
       (( passedt.craft          == nil  )  or
        ( passedt.craft          == ""   )) and
       (( passedt.emergency      == nil  )  or
        ( passedt.emergency      == ""   )) and
       (( passedt.highway        == nil  )  or
        ( passedt.highway        == ""   )) and
       (( passedt.historic       == nil  )  or
        ( passedt.historic       == ""   )) and
       (( passedt.landuse        == nil  )  or
        ( passedt.landuse        == ""   )) and
       (( passedt.leisure        == nil  )  or
        ( passedt.leisure        == ""   )) and
       (( passedt.man_made       == nil  )  or
        ( passedt.man_made       == ""   )) and
       (( passedt.natural        == nil  )  or
        ( passedt.natural        == ""   )) and
       (( passedt.office         == nil  )  or
        ( passedt.office         == ""   )) and
       (( passedt.railway        == nil  )  or
        ( passedt.railway        == ""   )) and
       (( passedt.shop           == nil  )  or
        ( passedt.shop           == ""   )) and
       (( passedt.sport          == nil  )  or
        ( passedt.sport          == ""   )) and
       (( passedt.tourism        == nil  )  or
        ( passedt.tourism        == ""   )) and
       (( passedt.waterway       == nil  )  or
        ( passedt.waterway       == ""   ))) then
      passedt.addrChousename = passedt.name
      passedt.name  = nil
      passedt.place = nil
   end

-- ----------------------------------------------------------------------------
-- addr:unit
-- ----------------------------------------------------------------------------
   if (( passedt.addrCunit ~= nil ) and
       ( passedt.addrCunit ~= ""  )) then
      if (( passedt.addrChousenumber ~= nil ) and
          ( passedt.addrChousenumber ~= ""  )) then
         passedt.addrChousenumber = passedt.addrCunit .. ", " .. passedt.addrChousenumber
      else
         passedt.addrChousenumber = passedt.addrCunit
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
       ( passedt.accommodation ~= ""   ) and
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

   if (( passedt.inscription ~= nil ) and
       ( passedt.inscription ~= ""  )) then
       if (( passedt.ele == nil ) or
           ( passedt.ele == ""  )) then
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
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "N: " .. passedt.direction_north
      else
         passedt.ele = passedt.ele .. ", N: " .. passedt.direction_north
      end
   end

   if (( passedt.direction_northeast ~= nil ) and
       ( passedt.direction_northeast ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "NE: " .. passedt.direction_northeast
      else
         passedt.ele = passedt.ele .. ", NE: " .. passedt.direction_northeast
      end
   end

   if (( passedt.direction_east ~= nil ) and
       ( passedt.direction_east ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "E: " .. passedt.direction_east
      else
         passedt.ele = passedt.ele .. ", E: " .. passedt.direction_east
      end
   end

   if (( passedt.direction_southeast ~= nil ) and
       ( passedt.direction_southeast ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "SE: " .. passedt.direction_southeast
      else
         passedt.ele = passedt.ele .. ", SE: " .. passedt.direction_southeast
      end
   end

   if (( passedt.direction_south ~= nil ) and
       ( passedt.direction_south ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "S: " .. passedt.direction_south
      else
         passedt.ele = passedt.ele .. ", S: " .. passedt.direction_south
      end
   end

   if (( passedt.direction_southwest ~= nil ) and
       ( passedt.direction_southwest ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "SW: " .. passedt.direction_southwest
      else
         passedt.ele = passedt.ele .. ", SW: " .. passedt.direction_southwest
      end
   end

   if (( passedt.direction_west ~= nil ) and
       ( passedt.direction_west ~= ""  )) then
      if (( passedt.ele == nil ) or
          ( passedt.ele == ""  )) then
         passedt.ele = "W: " .. passedt.direction_west
      else
         passedt.ele = passedt.ele .. ", W: " .. passedt.direction_west
      end
   end

   if (( passedt.direction_northwest ~= nil ) and
       ( passedt.direction_northwest ~= ""  )) then
      if (( passedt.ele == nil ) or
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
    generic_after_place( passedt )
end -- generic_after_function()

-- ----------------------------------------------------------------------------
-- building layer
-- ----------------------------------------------------------------------------
function generic_after_building( passedt )
    if (( passedt.building ~= nil ) and
        ( passedt.building ~= ""  )) then
        Layer("building", true)
        Attribute( "class", "building_" .. passedt.building )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end
    end
end -- generic_after_building()


-- ----------------------------------------------------------------------------
-- Linear transportation layer
-- Called for ways and any relations that have been allowed to get this far
-- (routes)
--
-- First, highway processing
-- ----------------------------------------------------------------------------
function wr_after_transportation( passedt )
    if (( passedt.highway ~= nil   ) and
        ( passedt.highway ~= ""    ) and
        ( passedt.area    ~= "yes" )) then
        wr_after_highway( passedt )
    else
-- ----------------------------------------------------------------------------
-- not a highway
--
-- Linear railways
-- We ignore railway areas such as platforms here (those tagged "area=yes").  
-- They will be processed elsewhere.  These railways may be closed ways or 
-- open-ended; theyare still linear, so we won't filter based on is_closed.
-- ----------------------------------------------------------------------------
        if (( passedt.railway ~= nil   ) and
            ( passedt.railway ~= ""    ) and
            ( passedt.area    ~= "yes" )) then
            Layer("transportation", false)
            Attribute( "class", passedt.railway )
            append_name( passedt )
            AttributeBoolean( "bridge", ( passedt.bridge == "yes" ) )
            AttributeBoolean( "tunnel", ( passedt.tunnel == "yes" ) )
        else
-- ----------------------------------------------------------------------------
-- Ferry routes
-- ----------------------------------------------------------------------------
            if ( passedt.route == "ferry" ) then
                Layer("transportation", false)
                Attribute( "class", passedt.route )
                append_name( passedt )
                MinZoom( 6 )
            else
-- ----------------------------------------------------------------------------
-- aeroways
-- ----------------------------------------------------------------------------
                if (( passedt.aeroway == "runway"       ) or
                    ( passedt.aeroway == "grass_runway" ) or
                    ( passedt.aeroway == "taxiway"      )) then
                    Layer("transportation", false)
                    Attribute( "class", passedt.aeroway )
                    append_name( passedt )
                    MinZoom( 10 )
                else
-- ----------------------------------------------------------------------------
-- aerialways
-- ----------------------------------------------------------------------------
                    if (( passedt.aerialway == "cable_car"  ) or
                        ( passedt.aerialway == "gondola"    ) or
                        ( passedt.aerialway == "goods"      ) or
                        ( passedt.aerialway == "chair_lift" ) or
                        ( passedt.aerialway == "drag_lift"  ) or
                        ( passedt.aerialway == "t-bar"      ) or
                        ( passedt.aerialway == "j-bar"      ) or
                        ( passedt.aerialway == "platter"    ) or
                        ( passedt.aerialway == "rope_tow"   )) then
                        Layer("transportation", false)
                        Attribute( "class", passedt.aerialway )
                        append_name( passedt )
                        MinZoom( 11 )
-- ----------------------------------------------------------------------------
-- No else here yet
-- ----------------------------------------------------------------------------
                    end -- aerialway=cable_car etc. 11
                end -- aeroway=runway etc. 10
            end -- ferry routes 6
        end -- linear railways
    end -- linear highways
end -- wr_after_transportation( passedt )

-- ----------------------------------------------------------------------------
-- At this point we're processing a way or a relation, and we know we have a
-- non-nil, non-blank highway value, and that "area" is not set to "yes".
--
-- Highway areas (which may have "area=yes" set or closed pedestrian areas, 
-- which are implicitly areas if closed) are processed elsewhere.
-- "highway=pedestrian" are ignored here if closed, unless area=no is set.
--
-- "gallop" and "leisuretrack" are also special cases.  If "area==no", 
-- they are assumed to be linear and are rendered here, whether or not they 
-- are closed. 
-- ----------------------------------------------------------------------------
function wr_after_highway( passedt )
    if (( passedt.highway == "motorway"      ) or
        ( passedt.highway == "motorway_link" )) then
        Layer("transportation", false)
        Attribute( "class", passedt.highway )
        append_name( passedt )
        append_ref_etc( passedt )
        append_edge_etc( passedt )
        MinZoom( 3 )
    else
        if (( passedt.highway == "trunk"      ) or
            ( passedt.highway == "trunk_link" )) then
            Layer("transportation", false)
            Attribute( "class", passedt.highway )
            append_name( passedt )
            append_ref_etc( passedt )
            append_edge_etc( passedt )
            MinZoom( 6 )
        else
            if (( passedt.highway == "primary"      ) or
                ( passedt.highway == "primary_link" )) then
                Layer("transportation", false)
                Attribute( "class", passedt.highway )
                append_name( passedt )
                append_ref_etc( passedt )
                append_edge_etc( passedt )
                MinZoom( 7 )
            else
                if (( passedt.highway == "secondary"      ) or
                    ( passedt.highway == "secondary_link" )) then
                    Layer("transportation", false)
                    Attribute( "class", passedt.highway )
                    append_name( passedt )
                    append_ref_etc( passedt )
                    append_edge_etc( passedt )
                    MinZoom( 8 )
                else
                    if (( passedt.highway == "tertiary"           ) or
                        ( passedt.highway == "tertiary_link"      ) or
                        ( passedt.highway == "unclassified"       ) or
                        ( passedt.highway == "unclassified_link"  ) or
                        ( passedt.highway == "residential"        ) or
                        ( passedt.highway == "residential_link"   ) or
                        ( passedt.highway == "living_street"      ) or
                        ( passedt.highway == "living_street_link" )) then
                        Layer("transportation", false)
                        Attribute( "class", passedt.highway )
                        append_name( passedt )
                        append_ref_etc( passedt )
                        append_edge_etc( passedt )
                        MinZoom( 9 )
                    else
                        if (( passedt.highway == "unpaved"            ) or
                            ( passedt.highway == "ucrwide"            ) or
                            ( passedt.highway == "ucrnarrow"          ) or
                            ( passedt.highway == "boatwide"           ) or
                            ( passedt.highway == "boatnarrow"         ) or
                            ( passedt.highway == "rbywide"            ) or
                            ( passedt.highway == "rbynarrow"          ) or
                            ( passedt.highway == "bridlewaywide"      ) or
                            ( passedt.highway == "bridlewaynarrow"    ) or
                            ( passedt.highway == "bridlewaysteps"     ) or
                            ( passedt.highway == "intbridlewaywide"   ) or
                            ( passedt.highway == "intbridlewaynarrow" ) or
                            ( passedt.highway == "intbridlewaysteps"  ) or
                            ( passedt.highway == "badbridlewaywide"   ) or
                            ( passedt.highway == "badbridlewaynarrow" ) or
                            ( passedt.highway == "badbridlewaysteps"  ) or
                            ( passedt.highway == "footwaywide"        ) or
                            ( passedt.highway == "footwaynarrow"      ) or
                            ( passedt.highway == "footwaysteps"       ) or
                            ( passedt.highway == "intfootwaywide"     ) or
                            ( passedt.highway == "intfootwaynarrow"   ) or
                            ( passedt.highway == "intfootwaysteps"    ) or
                            ( passedt.highway == "badfootwaywide"     ) or
                            ( passedt.highway == "badfootwaynarrow"   ) or
                            ( passedt.highway == "badfootwaysteps"    ) or
                            ( passedt.highway == "service"            ) or
                            ( passedt.highway == "driveway"           ) or
                            ( passedt.highway == "steps"              ) or
                            ( passedt.highway == "road"               ) or
                            ( passedt.highway == "pathwide"           ) or
                            ( passedt.highway == "pathnarrow"         ) or
                            ( passedt.highway == "pathsteps"          ) or
                            ( passedt.highway == "intpathwide"        ) or
                            ( passedt.highway == "intpathnarrow"      ) or
                            ( passedt.highway == "intpathsteps"       ) or
                            ( passedt.highway == "badpathwide"        ) or
                            ( passedt.highway == "badpathnarrow"      ) or
                            ( passedt.highway == "badpathsteps"       ) or
                            ( passedt.highway == "construction"       ) or
                            ( passedt.highway == "ldpmtb"             ) or
                            ( passedt.highway == "ldpncn"             ) or
                            ( passedt.highway == "ldpnhn"             ) or
                            ( passedt.highway == "ldpnwn"             ) or
                            ( passedt.highway == "raceway"            )) then
                            Layer("transportation", false)
                            Attribute( "class", passedt.highway )
                            append_name( passedt )
                            append_ref_etc( passedt )
                            append_edge_etc( passedt )
                            MinZoom( 12 )
                        else
                            if ((  passedt.highway == "pedestrian"  ) and
                                (( not passedt.is_closed           )  or
                                 ( passedt.area    == "no"         ))) then
                                Layer("transportation", false)
                                Attribute( "class", passedt.highway )
                                append_name( passedt )
                                append_ref_etc( passedt )
                                append_edge_etc( passedt )
                                MinZoom( 12 )
                            else
                                if ((( passedt.highway == "leisuretrack" )  or
                                     ( passedt.highway == "gallop"       )) and
                                    (( passedt.area == "no"              )  or
                                     ( not passedt.is_closed             ))) then
                                    Layer("transportation", false)
                                    Attribute( "class", passedt.highway )
                                    append_name( passedt )
                                    append_edge_etc( passedt )
                                    MinZoom( 12 )
                                else
                                    if (( passedt.highway == "platform" ) and
                                        ( not passedt.is_closed         )) then
                                        Layer("transportation", false)
                                        Attribute( "class", passedt.highway )
                                        append_name( passedt )
                                        MinZoom( 14 )
-- ----------------------------------------------------------------------------
-- No other linear highways to consider
-- ----------------------------------------------------------------------------
                                    end -- linear platform 14
                                end -- linear gallop / leisuretrack 12
                            end -- linear pedestrian 12
                        end -- unpaved etc. 12
                    end -- tertiary etc. 9
                end -- secondary 9
            end -- primary 7
        end -- trunk 6
    end -- motorway 3
end -- wr_after_highway( passedt )


function append_edge_etc( passedt )
-- ----------------------------------------------------------------------------
-- If there is a sidewalk, set "edge" to "sidewalk"
-- ----------------------------------------------------------------------------
    if (( passedt.sidewalk == "both"            ) or 
        ( passedt.sidewalk == "left"            ) or 
        ( passedt.sidewalk == "mapped"          ) or 
        ( passedt.sidewalk == "separate"        ) or 
        ( passedt.sidewalk == "right"           ) or 
        ( passedt.sidewalk == "shared"          ) or 
        ( passedt.sidewalk == "yes"             ) or
        ( passedt.sidewalkCboth == "separate"   ) or 
        ( passedt.sidewalkCboth == "yes"        ) or
        ( passedt.sidewalkCleft == "segregated" ) or
        ( passedt.sidewalkCleft == "separate"   ) or 
        ( passedt.sidewalkCleft == "yes"        ) or
        ( passedt.sidewalkCright == "segregated" ) or 
        ( passedt.sidewalkCright == "separate"  ) or 
        ( passedt.sidewalkCright == "yes"       ) or
        ( passedt.footway  == "separate"        ) or 
        ( passedt.footway  == "yes"             ) or
        ( passedt.shoulder == "both"            ) or
        ( passedt.shoulder == "left"            ) or 
        ( passedt.shoulder == "right"           ) or 
        ( passedt.shoulder == "yes"             ) or
        ( passedt.hard_shoulder == "yes"        ) or
        ( passedt.cycleway == "track"           ) or
        ( passedt.cycleway == "opposite_track"  ) or
        ( passedt.cycleway == "yes"             ) or
        ( passedt.cycleway == "separate"        ) or
        ( passedt.cycleway == "sidewalk"        ) or
        ( passedt.cycleway == "sidepath"        ) or
        ( passedt.cycleway == "segregated"      ) or
        ( passedt.segregated == "yes"           ) or
        ( passedt.segregated == "right"         )) then
        Attribute("edge", "sidewalk")
    else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk but there is a verge, set "edge" to "verge"
-- ----------------------------------------------------------------------------
        if (( passedt.verge == "both"     ) or
            ( passedt.verge == "left"     ) or
            ( passedt.verge == "separate" ) or
            ( passedt.verge == "right"    ) or
            ( passedt.verge == "yes"      )) then
            Attribute("edge", "verge")
        else
-- ----------------------------------------------------------------------------
-- If there is not a sidewalk or verge but it is a long ford, set "edge" to "ford"
-- ----------------------------------------------------------------------------
            if ( passedt.ford == "yes" ) then
                Attribute("edge", "ford")
            end  -- ford
        end -- verge
    end -- sidewalk

-- ----------------------------------------------------------------------------
-- In addition to sidewalks and verges, is it a bridge or a tunnel?
-- ----------------------------------------------------------------------------
    AttributeBoolean( "bridge", ( passedt.bridge == "yes" ) )
    AttributeBoolean( "tunnel", ( passedt.tunnel == "yes" ) )

-- ----------------------------------------------------------------------------
-- In addition to sidewalks and verges, is an access overlay needed?
-- ----------------------------------------------------------------------------
    if ( passedt.access == "no" ) then   
        Attribute("access", "no")
    else
        if ( passedt.access == "destination" ) then   
            Attribute("access", "destination")
        end -- access=destination
    end -- access=no

-- ----------------------------------------------------------------------------
-- In addition to sidewalks and verges, is a oneway overlay needed?
-- ----------------------------------------------------------------------------
    if (( passedt.oneway ~= nil )   and
        ( passedt.oneway ~= ""  ))  then
        Attribute( "oneway", passedt.oneway )
    end
end -- append_edge_etc( passedt )


-- ----------------------------------------------------------------------------
-- linear waterway layer
-- ----------------------------------------------------------------------------
function way_after_waterway( passedt )
    if (( passedt.waterway ~= nil ) and
        ( passedt.waterway ~= ""  )) then
        Layer("waterway", false)
        Attribute("class", passedt.waterway)
        Attribute( "name", Find( "name" ) )
        AttributeBoolean( "bridge", ( passedt.bridge == "yes" ) )
        AttributeBoolean( "tunnel", ( passedt.tunnel == "yes" ) )

        if (( passedt.waterway == "river"          ) or
            ( passedt.waterway == "canal"          ) or
            ( passedt.waterway == "derelict_canal" )) then
            MinZoom( 11 )
        else
            if (( passedt.waterway == "stream"   ) or
                ( passedt.waterway == "drain"    ) or
                ( passedt.waterway == "intriver" ) or
                ( passedt.waterway == "intstream" )) then
                MinZoom( 12 )
            else
                if ( passedt.waterway == "ditch" ) then
                    MinZoom( 13 )
                else
                    if ( passedt.waterway == "weir" ) then
                        MinZoom( 14 )
-- ------------------------------------------------------------------------------
-- No "else" here yet
-- ------------------------------------------------------------------------------
                    end -- weir
                end  -- ditch
            end -- stream etc.
        end -- river etc.
    end -- linear waterways

end -- way_after_waterway( passedt )

-- ----------------------------------------------------------------------------
-- linearbarrier layer
-- This layer includes barriers (fences, walls) and other barrier-like features
-- (cutlines, valleys) that aren't in another linear layer such as 
-- transportation or waterway.
--
-- hedges are only written to this if they're not closed.
-- hedges around some other area type (e.g. "landuse=farmland") have already been
-- changed to "hedgeline" above.
-- area hedges will be handled in "render_barrier_land1( passedt )" below
--
-- For more on the hedge logic (shared with raster) see 
-- https://www.openstreetmap.org/user/SomeoneElse/diary/401631
-- ----------------------------------------------------------------------------
function way_after_linearbarrier( passedt )
    if ((  passedt.barrier == "wall"        ) or
        (( passedt.barrier == "hedge"      )  and
         ( not passedt.is_closed           )) or
        (  passedt.barrier == "hedgeline"   ) or
        (  passedt.barrier == "fence"       ) or
        (  passedt.barrier == "kerb"        ) or
        (  passedt.barrier == "pitchline"   ) or
        (  passedt.barrier == "gate"        ) or
        (  passedt.barrier == "stile"       ) or
        (  passedt.barrier == "cattle_grid" ) or
        (  passedt.barrier == "ford"        ) or
        (  passedt.barrier == "tree_row"    )) then
        Layer( "linearbarrier", false )
        Attribute( "class", "barrier_" .. passedt.barrier )
	append_name( passedt )
        MinZoom( 13 )
    else
        if ((  passedt.man_made == "breakwater" ) or
            (  passedt.man_made == "groyne"     ) or
            (( passedt.man_made == "pier"      )  and
             ( not passedt.is_closed           ))) then
            Layer( "linearbarrier", false )
            Attribute( "class", "man_made_" .. passedt.man_made )
	    append_name( passedt )
            MinZoom( 11 )
        else
            if (( passedt.man_made == "cutline" ) or
                ( passedt.man_made == "levee"   )) then
                Layer( "linearbarrier", false )
                Attribute( "class", "man_made_" .. passedt.man_made )
	        append_name( passedt )
                MinZoom( 13 )
            else
                if ( passedt.man_made == "embankment" ) then
                    Layer( "linearbarrier", false )
                    Attribute( "class", "man_made_" .. passedt.man_made )
	            append_name( passedt )
                    MinZoom( 14 )
                else
                    if ( passedt.waterway == "dam" ) then
                        Layer( "linearbarrier", false )
                        Attribute( "class", "waterway_" .. passedt.waterway )
	                append_name( passedt )
                        MinZoom( 12 )
                    else
                         generic_linearbarrier_historic( passedt )
                    end -- waterway=dam 12
                end -- man_made=embankment 13
            end -- man_made=cutline 13
        end -- man_made=breakwater etc. 11
    end -- barrier=wall etc. 13
end -- way_after_linearbarrier()

function generic_linearbarrier_historic( passedt )
    if (( passedt.historic == "citywalls"    ) or
        ( passedt.historic == "castle_walls" )) then
        Layer( "linearbarrier", false )
        Attribute( "class", "historic_" .. passedt.historic )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 13 )
    else
        if ( passedt.natural == "valley" ) then
            Layer( "linearbarrier", false )
            Attribute( "class", "natural_" .. passedt.natural )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                Attribute( "name", passedt.name )
            end

            MinZoom( 10 )
        else
            if ( passedt.natural == "cliff" ) then
                Layer( "linearbarrier", false )
                Attribute( "class", "natural_" .. passedt.natural )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                    Attribute( "name", passedt.name )
                end

                MinZoom( 12 )
            end  -- natural=cliff etc. 12
        end  -- natural=valley 11
    end  -- historic=citywalls 13
end -- generic_linearbarrier_historic()


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

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

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

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 9 )
    else
        if (( passedt.amenity == "holy_spring"                ) or
            ( passedt.amenity == "holy_well"                  ) or
            ( passedt.amenity == "watering_place"             )) then
            Layer( "land1", true )
            Attribute( "class", "amenity_" .. passedt.amenity )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            MinZoom( 13 )
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
                ( passedt.amenity == "police"                     ) or
                ( passedt.amenity == "post_box"                   ) or
                ( passedt.amenity == "post_office"                ) or
                ( passedt.amenity == "biergarten"                 ) or
                ( passedt.amenity == "boatyard"                   ) or
                ( passedt.amenity == "tourismstation"             ) or
                ( passedt.amenity == "recycling"                  ) or
                ( passedt.amenity == "recyclingcentre"            ) or
                ( passedt.amenity == "restaurant"                 ) or
                ( passedt.amenity == "restaccomm"                 ) or
                ( passedt.amenity == "fast_food"                  ) or
                ( passedt.amenity == "fast_food_burger"           ) or
                ( passedt.amenity == "fast_food_chicken"          ) or
                ( passedt.amenity == "fast_food_chinese"          ) or
                ( passedt.amenity == "fast_food_coffee"           ) or
                ( passedt.amenity == "fast_food_fish_and_chips"   ) or
                ( passedt.amenity == "fast_food_ice_cream"        ) or
                ( passedt.amenity == "fast_food_indian"           ) or
                ( passedt.amenity == "fast_food_kebab"            ) or
                ( passedt.amenity == "fast_food_pie"              ) or
                ( passedt.amenity == "fast_food_pizza"            ) or
                ( passedt.amenity == "fast_food_sandwich"         ) or
                ( passedt.amenity == "telephone"                  ) or
                ( passedt.amenity == "boothtelephonered"          ) or
                ( passedt.amenity == "boothtelephoneblack"        ) or
                ( passedt.amenity == "boothtelephonewhite"        ) or
                ( passedt.amenity == "boothtelephoneblue"         ) or
                ( passedt.amenity == "boothtelephonegreen"        ) or
                ( passedt.amenity == "boothtelephonegrey"         ) or
                ( passedt.amenity == "boothtelephonegold"         ) or
                ( passedt.amenity == "boothdefibrillator"         ) or
                ( passedt.amenity == "boothlibrary"               ) or
                ( passedt.amenity == "boothbicyclerepairstation"  ) or
                ( passedt.amenity == "boothatm"                   ) or
                ( passedt.amenity == "boothinformation"           ) or
                ( passedt.amenity == "boothartwork"               ) or
                ( passedt.amenity == "boothmuseum"                ) or
                ( passedt.amenity == "boothdisused"               ) or
                ( passedt.amenity == "public_bookcase"            ) or
                ( passedt.amenity == "bicycle_repair_station"     ) or
                ( passedt.amenity == "sundial"                    ) or
                ( passedt.amenity == "shopmobility"               ) or
                ( passedt.amenity == "emergency_phone"            ) or
                ( passedt.amenity == "theatre"                    ) or
                ( passedt.amenity == "toilets"                    ) or
                ( passedt.amenity == "toilets_free_m"             ) or
                ( passedt.amenity == "toilets_free_w"             ) or
                ( passedt.amenity == "toilets_pay"                ) or
                ( passedt.amenity == "toilets_pay_m"              ) or
                ( passedt.amenity == "toilets_pay_w"              ) or
                ( passedt.amenity == "shower"                     ) or
                ( passedt.amenity == "shower_free_m"              ) or
                ( passedt.amenity == "shower_free_w"              ) or
                ( passedt.amenity == "shower_pay"                 ) or
                ( passedt.amenity == "shower_pay_m"               ) or
                ( passedt.amenity == "shower_pay_w"               ) or
                ( passedt.amenity == "musical_instrument"         ) or
                ( passedt.amenity == "drinking_water"             ) or
                ( passedt.amenity == "nondrinking_water"          ) or
                ( passedt.amenity == "fountain"                   ) or
                ( passedt.amenity == "prison"                     ) or
                ( passedt.amenity == "veterinary"                 ) or
                ( passedt.amenity == "animal_boarding"            ) or
                ( passedt.amenity == "animal_shelter"             ) or
                ( passedt.amenity == "car_wash"                   ) or
                ( passedt.amenity == "car_rental"                 ) or
                ( passedt.amenity == "compressed_air"             ) or
                ( passedt.amenity == "defibrillator"              ) or
                ( passedt.amenity == "life_ring"                  ) or 
                ( passedt.amenity == "fire_extinguisher"          ) or
                ( passedt.amenity == "fire_hydrant"               ) or
                ( passedt.amenity == "bbq"                        ) or
                ( passedt.amenity == "waterway_access_point"      ) or
                ( passedt.amenity == "pub"                        ) or
                ( passedt.amenity == "pub_yyyyydyy"               ) or
                ( passedt.amenity == "pub_yyyyydyl"               ) or
                ( passedt.amenity == "pub_yyyyydyn"               ) or
                ( passedt.amenity == "pub_yyyyydyd"               ) or
                ( passedt.amenity == "pub_yyyyydnyg"              ) or
                ( passedt.amenity == "pub_yyyyydnyo"              ) or
                ( passedt.amenity == "pub_yyyyydnyd"              ) or
                ( passedt.amenity == "pub_yyyyydnlg"              ) or
                ( passedt.amenity == "pub_yyyyydnlo"              ) or
                ( passedt.amenity == "pub_yyyyydnld"              ) or
                ( passedt.amenity == "pub_yyyyydnn"               ) or
                ( passedt.amenity == "pub_yyyyydndg"              ) or
                ( passedt.amenity == "pub_yyyyydndo"              ) or
                ( passedt.amenity == "pub_yyyyydndd"              ) or
                ( passedt.amenity == "pub_yyyynydyg"              ) or
                ( passedt.amenity == "pub_yyyynydyo"              ) or
                ( passedt.amenity == "pub_yyyynydyd"              ) or
                ( passedt.amenity == "pub_yyyynydlg"              ) or
                ( passedt.amenity == "pub_yyyynydlo"              ) or
                ( passedt.amenity == "pub_yyyynydld"              ) or
                ( passedt.amenity == "pub_yyyynydng"              ) or
                ( passedt.amenity == "pub_yyyynydno"              ) or
                ( passedt.amenity == "pub_yyyynydnd"              ) or
                ( passedt.amenity == "pub_yyyynyddg"              ) or
                ( passedt.amenity == "pub_yyyynyddo"              ) or
                ( passedt.amenity == "pub_yyyynyddd"              ) or
                ( passedt.amenity == "pub_yyyynnyyg"              ) or
                ( passedt.amenity == "pub_yyyynnyyo"              ) or
                ( passedt.amenity == "pub_yyyynnyyd"              ) or
                ( passedt.amenity == "pub_yyyynnylg"              ) or
                ( passedt.amenity == "pub_yyyynnylo"              ) or
                ( passedt.amenity == "pub_yyyynnyld"              ) or
                ( passedt.amenity == "pub_yyyynnyng"              ) or
                ( passedt.amenity == "pub_yyyynnyno"              ) or
                ( passedt.amenity == "pub_yyyynnynd"              ) or
                ( passedt.amenity == "pub_yyyynnydg"              ) or
                ( passedt.amenity == "pub_yyyynnydo"              ) or
                ( passedt.amenity == "pub_yyyynnydd"              ) or
                ( passedt.amenity == "pub_yyyynnnyg"              ) or
                ( passedt.amenity == "pub_yyyynnnyo"              ) or
                ( passedt.amenity == "pub_yyyynnnyd"              ) or
                ( passedt.amenity == "pub_yyyynnnlg"              ) or
                ( passedt.amenity == "pub_yyyynnnlo"              ) or
                ( passedt.amenity == "pub_yyyynnnld"              ) or
                ( passedt.amenity == "pub_yyyynnnng"              ) or
                ( passedt.amenity == "pub_yyyynnnno"              ) or
                ( passedt.amenity == "pub_yyyynnnnd"              ) or
                ( passedt.amenity == "pub_yyyynnndg"              ) or
                ( passedt.amenity == "pub_yyyynnndo"              ) or
                ( passedt.amenity == "pub_yyyynnndd"              ) or
                ( passedt.amenity == "pub_yyydydyy"               ) or
                ( passedt.amenity == "pub_yyydydyl"               ) or
                ( passedt.amenity == "pub_yyydydyn"               ) or
                ( passedt.amenity == "pub_yyydydydg"              ) or
                ( passedt.amenity == "pub_yyydydydo"              ) or
                ( passedt.amenity == "pub_yyydydydd"              ) or
                ( passedt.amenity == "pub_yyydydny"               ) or
                ( passedt.amenity == "pub_yyydydnlg"              ) or
                ( passedt.amenity == "pub_yyydydnlo"              ) or
                ( passedt.amenity == "pub_yyydydnld"              ) or
                ( passedt.amenity == "pub_yyydydnn"               ) or
                ( passedt.amenity == "pub_yyydydndg"              ) or
                ( passedt.amenity == "pub_yyydydndo"              ) or
                ( passedt.amenity == "pub_yyydydndd"              ) or
                ( passedt.amenity == "pub_yyydnydyg"              ) or
                ( passedt.amenity == "pub_yyydnydyo"              ) or
                ( passedt.amenity == "pub_yyydnydyd"              ) or
                ( passedt.amenity == "pub_yyydnydlg"              ) or
                ( passedt.amenity == "pub_yyydnydlo"              ) or
                ( passedt.amenity == "pub_yyydnydld"              ) or
                ( passedt.amenity == "pub_yyydnydng"              ) or
                ( passedt.amenity == "pub_yyydnydno"              ) or
                ( passedt.amenity == "pub_yyydnydnd"              ) or
                ( passedt.amenity == "pub_yyydnyddg"              ) or
                ( passedt.amenity == "pub_yyydnyddo"              ) or
                ( passedt.amenity == "pub_yyydnyddd"              ) or
                ( passedt.amenity == "pub_yyydnnyyg"              ) or
                ( passedt.amenity == "pub_yyydnnyyo"              ) or
                ( passedt.amenity == "pub_yyydnnyyd"              ) or
                ( passedt.amenity == "pub_yyydnnylg"              ) or
                ( passedt.amenity == "pub_yyydnnylo"              ) or
                ( passedt.amenity == "pub_yyydnnyld"              ) or
                ( passedt.amenity == "pub_yyydnnyng"              ) or
                ( passedt.amenity == "pub_yyydnnyno"              ) or
                ( passedt.amenity == "pub_yyydnnynd"              ) or
                ( passedt.amenity == "pub_yyydnnydg"              ) or
                ( passedt.amenity == "pub_yyydnnydo"              ) or
                ( passedt.amenity == "pub_yyydnnydd"              ) or
                ( passedt.amenity == "pub_yyydnnnyg"              ) or
                ( passedt.amenity == "pub_yyydnnnyo"              ) or
                ( passedt.amenity == "pub_yyydnnnyd"              ) or
                ( passedt.amenity == "pub_yyydnnnlg"              ) or
                ( passedt.amenity == "pub_yyydnnnlo"              ) or
                ( passedt.amenity == "pub_yyydnnnld"              ) or
                ( passedt.amenity == "pub_yyydnnnng"              ) or
                ( passedt.amenity == "pub_yyydnnnno"              ) or
                ( passedt.amenity == "pub_yyydnnnnd"              ) or
                ( passedt.amenity == "pub_yyydnnndg"              ) or
                ( passedt.amenity == "pub_yyydnnndo"              ) or
                ( passedt.amenity == "pub_yyydnnndd"              ) or
                ( passedt.amenity == "pub_yydyydyy"               ) or
                ( passedt.amenity == "pub_yydyydyl"               ) or
                ( passedt.amenity == "pub_yydyydyn"               ) or
                ( passedt.amenity == "pub_yydyydyd"               ) or
                ( passedt.amenity == "pub_yydyydny"               ) or
                ( passedt.amenity == "pub_yydyydnlg"              ) or
                ( passedt.amenity == "pub_yydyydnlo"              ) or
                ( passedt.amenity == "pub_yydyydnld"              ) or
                ( passedt.amenity == "pub_yydyydnng"              ) or
                ( passedt.amenity == "pub_yydyydnno"              ) or
                ( passedt.amenity == "pub_yydyydnnd"              ) or
                ( passedt.amenity == "pub_yydyydndg"              ) or
                ( passedt.amenity == "pub_yydyydndo"              ) or
                ( passedt.amenity == "pub_yydyydndd"              ) or
                ( passedt.amenity == "pub_yydynydy"               ) or
                ( passedt.amenity == "pub_yydynydlg"              ) or
                ( passedt.amenity == "pub_yydynydlo"              ) or
                ( passedt.amenity == "pub_yydynydld"              ) or
                ( passedt.amenity == "pub_yydynydng"              ) or
                ( passedt.amenity == "pub_yydynydno"              ) or
                ( passedt.amenity == "pub_yydynydnd"              ) or
                ( passedt.amenity == "pub_yydynydd"               ) or
                ( passedt.amenity == "pub_yydynnyyg"              ) or
                ( passedt.amenity == "pub_yydynnyyo"              ) or
                ( passedt.amenity == "pub_yydynnyyd"              ) or
                ( passedt.amenity == "pub_yydynnylg"              ) or
                ( passedt.amenity == "pub_yydynnylo"              ) or
                ( passedt.amenity == "pub_yydynnyld"              ) or
                ( passedt.amenity == "pub_yydynnyng"              ) or
                ( passedt.amenity == "pub_yydynnyno"              ) or
                ( passedt.amenity == "pub_yydynnynd"              ) or
                ( passedt.amenity == "pub_yydynnydg"              ) or
                ( passedt.amenity == "pub_yydynnydo"              ) or
                ( passedt.amenity == "pub_yydynnydd"              ) or
                ( passedt.amenity == "pub_yydynnnyg"              ) or
                ( passedt.amenity == "pub_yydynnnyo"              ) or
                ( passedt.amenity == "pub_yydynnnyd"              ) or
                ( passedt.amenity == "pub_yydynnnlg"              ) or
                ( passedt.amenity == "pub_yydynnnlo"              ) or
                ( passedt.amenity == "pub_yydynnnld"              ) or
                ( passedt.amenity == "pub_yydynnnng"              ) or
                ( passedt.amenity == "pub_yydynnnno"              ) or
                ( passedt.amenity == "pub_yydynnnnd"              ) or
                ( passedt.amenity == "pub_yydynnndg"              ) or
                ( passedt.amenity == "pub_yydynnndo"              ) or
                ( passedt.amenity == "pub_yydynnndd"              ) or
                ( passedt.amenity == "pub_yyddyydyg"              ) or
                ( passedt.amenity == "pub_yyddyydyo"              ) or
                ( passedt.amenity == "pub_yyddyydyd"              ) or
                ( passedt.amenity == "pub_yyddyydl"               ) or
                ( passedt.amenity == "pub_yyddyydn"               ) or
                ( passedt.amenity == "pub_yyddyydd"               ) or
                ( passedt.amenity == "pub_yyddynyyg"              ) or
                ( passedt.amenity == "pub_yyddynyyo"              ) or
                ( passedt.amenity == "pub_yyddynyyd"              ) or
                ( passedt.amenity == "pub_yyddynyl"               ) or
                ( passedt.amenity == "pub_yyddynyn"               ) or
                ( passedt.amenity == "pub_yyddynydg"              ) or
                ( passedt.amenity == "pub_yyddynydo"              ) or
                ( passedt.amenity == "pub_yyddynydd"              ) or
                ( passedt.amenity == "pub_yyddynnyg"              ) or
                ( passedt.amenity == "pub_yyddynnyo"              ) or
                ( passedt.amenity == "pub_yyddynnyd"              ) or
                ( passedt.amenity == "pub_yyddynnlg"              ) or
                ( passedt.amenity == "pub_yyddynnlo"              ) or
                ( passedt.amenity == "pub_yyddynnld"              ) or
                ( passedt.amenity == "pub_yyddynnng"              ) or
                ( passedt.amenity == "pub_yyddynnno"              ) or
                ( passedt.amenity == "pub_yyddynnnd"              ) or
                ( passedt.amenity == "pub_yyddynndg"              ) or
                ( passedt.amenity == "pub_yyddynndo"              ) or
                ( passedt.amenity == "pub_yyddynndd"              ) or
                ( passedt.amenity == "pub_yyddnydy"               ) or
                ( passedt.amenity == "pub_yyddnydl"               ) or
                ( passedt.amenity == "pub_yyddnydng"              ) or
                ( passedt.amenity == "pub_yyddnydno"              ) or
                ( passedt.amenity == "pub_yyddnydnd"              ) or
                ( passedt.amenity == "pub_yyddnyddg"              ) or
                ( passedt.amenity == "pub_yyddnyddo"              ) or
                ( passedt.amenity == "pub_yyddnyddd"              ) or
                ( passedt.amenity == "pub_yyddnnyyg"              ) or
                ( passedt.amenity == "pub_yyddnnyyo"              ) or
                ( passedt.amenity == "pub_yyddnnyyd"              ) or
                ( passedt.amenity == "pub_yyddnnylg"              ) or
                ( passedt.amenity == "pub_yyddnnylo"              ) or
                ( passedt.amenity == "pub_yyddnnyld"              ) or
                ( passedt.amenity == "pub_yyddnnyng"              ) or
                ( passedt.amenity == "pub_yyddnnyno"              ) or
                ( passedt.amenity == "pub_yyddnnynd"              ) or
                ( passedt.amenity == "pub_yyddnnydg"              ) or
                ( passedt.amenity == "pub_yyddnnydo"              ) or
                ( passedt.amenity == "pub_yyddnnydd"              ) or
                ( passedt.amenity == "pub_yyddnnnyg"              ) or
                ( passedt.amenity == "pub_yyddnnnyo"              ) or
                ( passedt.amenity == "pub_yyddnnnyd"              ) or
                ( passedt.amenity == "pub_yyddnnnlg"              ) or
                ( passedt.amenity == "pub_yyddnnnlo"              ) or
                ( passedt.amenity == "pub_yyddnnnld"              ) or
                ( passedt.amenity == "pub_yyddnnnng"              ) or
                ( passedt.amenity == "pub_yyddnnnno"              ) or
                ( passedt.amenity == "pub_yyddnnnnd"              ) or
                ( passedt.amenity == "pub_yyddnnndg"              ) or
                ( passedt.amenity == "pub_yyddnnndo"              ) or
                ( passedt.amenity == "pub_yyddnnndd"              ) or
                ( passedt.amenity == "pub_ynyydddyg"              ) or
                ( passedt.amenity == "pub_ynyydddyo"              ) or
                ( passedt.amenity == "pub_ynyydddyd"              ) or
                ( passedt.amenity == "pub_ynyydddlg"              ) or
                ( passedt.amenity == "pub_ynyydddlo"              ) or
                ( passedt.amenity == "pub_ynyydddld"              ) or
                ( passedt.amenity == "pub_ynyydddng"              ) or
                ( passedt.amenity == "pub_ynyydddno"              ) or
                ( passedt.amenity == "pub_ynyydddnd"              ) or
                ( passedt.amenity == "pub_ynyyddddg"              ) or
                ( passedt.amenity == "pub_ynyyddddo"              ) or
                ( passedt.amenity == "pub_ynyyddddd"              ) or
                ( passedt.amenity == "pub_ynydddyyg"              ) or
                ( passedt.amenity == "pub_ynydddyyo"              ) or
                ( passedt.amenity == "pub_ynydddyyd"              ) or
                ( passedt.amenity == "pub_ynydddyl"               ) or
                ( passedt.amenity == "pub_ynydddyn"               ) or
                ( passedt.amenity == "pub_ynydddydg"              ) or
                ( passedt.amenity == "pub_ynydddydo"              ) or
                ( passedt.amenity == "pub_ynydddydd"              ) or
                ( passedt.amenity == "pub_ynydddnyg"              ) or
                ( passedt.amenity == "pub_ynydddnyo"              ) or
                ( passedt.amenity == "pub_ynydddnyd"              ) or
                ( passedt.amenity == "pub_ynydddnl"               ) or
                ( passedt.amenity == "pub_ynydddnn"               ) or
                ( passedt.amenity == "pub_ynydddndg"              ) or
                ( passedt.amenity == "pub_ynydddndo"              ) or
                ( passedt.amenity == "pub_ynydddndd"              ) or
                ( passedt.amenity == "pub_yndyddyy"               ) or
                ( passedt.amenity == "pub_yndyddyl"               ) or
                ( passedt.amenity == "pub_yndyddyn"               ) or
                ( passedt.amenity == "pub_yndyddyd"               ) or
                ( passedt.amenity == "pub_yndyddnyg"              ) or
                ( passedt.amenity == "pub_yndyddnyo"              ) or
                ( passedt.amenity == "pub_yndyddnyd"              ) or
                ( passedt.amenity == "pub_yndyddnlg"              ) or
                ( passedt.amenity == "pub_yndyddnlo"              ) or
                ( passedt.amenity == "pub_yndyddnld"              ) or
                ( passedt.amenity == "pub_yndyddnng"              ) or
                ( passedt.amenity == "pub_yndyddnno"              ) or
                ( passedt.amenity == "pub_yndyddnnd"              ) or
                ( passedt.amenity == "pub_yndyddndg"              ) or
                ( passedt.amenity == "pub_yndyddndo"              ) or
                ( passedt.amenity == "pub_yndyddndd"              ) or
                ( passedt.amenity == "pub_ynddddy"                ) or
                ( passedt.amenity == "pub_ynddddnyg"              ) or
                ( passedt.amenity == "pub_ynddddnyo"              ) or
                ( passedt.amenity == "pub_ynddddnyd"              ) or
                ( passedt.amenity == "pub_ynddddnlg"              ) or
                ( passedt.amenity == "pub_ynddddnlo"              ) or
                ( passedt.amenity == "pub_ynddddnld"              ) or
                ( passedt.amenity == "pub_ynddddnng"              ) or
                ( passedt.amenity == "pub_ynddddnno"              ) or
                ( passedt.amenity == "pub_ynddddnnd"              ) or
                ( passedt.amenity == "pub_ynddddndg"              ) or
                ( passedt.amenity == "pub_ynddddndo"              ) or
                ( passedt.amenity == "pub_ynddddndd"              ) or
                ( passedt.amenity == "pub_ydyyydd"                ) or
                ( passedt.amenity == "pub_ydyynddyg"              ) or
                ( passedt.amenity == "pub_ydyynddyo"              ) or
                ( passedt.amenity == "pub_ydyynddyd"              ) or
                ( passedt.amenity == "pub_ydyynddlg"              ) or
                ( passedt.amenity == "pub_ydyynddlo"              ) or
                ( passedt.amenity == "pub_ydyynddld"              ) or
                ( passedt.amenity == "pub_ydyynddng"              ) or
                ( passedt.amenity == "pub_ydyynddno"              ) or
                ( passedt.amenity == "pub_ydyynddnd"              ) or
                ( passedt.amenity == "pub_ydyyndddg"              ) or
                ( passedt.amenity == "pub_ydyyndddo"              ) or
                ( passedt.amenity == "pub_ydyyndddd"              ) or
                ( passedt.amenity == "pub_ydydyddy"               ) or
                ( passedt.amenity == "pub_ydydyddl"               ) or
                ( passedt.amenity == "pub_ydydyddn"               ) or
                ( passedt.amenity == "pub_ydydydddg"              ) or
                ( passedt.amenity == "pub_ydydydddo"              ) or
                ( passedt.amenity == "pub_ydydydddd"              ) or
                ( passedt.amenity == "pub_ydydnydy"               ) or
                ( passedt.amenity == "pub_ydydnydl"               ) or
                ( passedt.amenity == "pub_ydydnydn"               ) or
                ( passedt.amenity == "pub_ydydnyddg"              ) or
                ( passedt.amenity == "pub_ydydnyddo"              ) or
                ( passedt.amenity == "pub_ydydnyddd"              ) or
                ( passedt.amenity == "pub_ydydnnyyg"              ) or
                ( passedt.amenity == "pub_ydydnnyyo"              ) or
                ( passedt.amenity == "pub_ydydnnyyd"              ) or
                ( passedt.amenity == "pub_ydydnnyl"               ) or
                ( passedt.amenity == "pub_ydydnnyng"              ) or
                ( passedt.amenity == "pub_ydydnnyno"              ) or
                ( passedt.amenity == "pub_ydydnnynd"              ) or
                ( passedt.amenity == "pub_ydydnnydg"              ) or
                ( passedt.amenity == "pub_ydydnnydo"              ) or
                ( passedt.amenity == "pub_ydydnnydd"              ) or
                ( passedt.amenity == "pub_ydydnnnyg"              ) or
                ( passedt.amenity == "pub_ydydnnnyo"              ) or
                ( passedt.amenity == "pub_ydydnnnyd"              ) or
                ( passedt.amenity == "pub_ydydnnnlg"              ) or
                ( passedt.amenity == "pub_ydydnnnlo"              ) or
                ( passedt.amenity == "pub_ydydnnnld"              ) or
                ( passedt.amenity == "pub_ydydnnnng"              ) or
                ( passedt.amenity == "pub_ydydnnnno"              ) or
                ( passedt.amenity == "pub_ydydnnnnd"              ) or
                ( passedt.amenity == "pub_ydydnnndg"              ) or
                ( passedt.amenity == "pub_ydydnnndo"              ) or
                ( passedt.amenity == "pub_ydydnnndd"              ) or
                ( passedt.amenity == "pub_yddyydy"                ) or
                ( passedt.amenity == "pub_yddyydng"               ) or
                ( passedt.amenity == "pub_yddyydno"               ) or
                ( passedt.amenity == "pub_yddyydnd"               ) or
                ( passedt.amenity == "pub_yddynndyg"              ) or
                ( passedt.amenity == "pub_yddynndyo"              ) or
                ( passedt.amenity == "pub_yddynndyd"              ) or
                ( passedt.amenity == "pub_yddynndlg"              ) or
                ( passedt.amenity == "pub_yddynndlo"              ) or
                ( passedt.amenity == "pub_yddynndld"              ) or
                ( passedt.amenity == "pub_yddynndng"              ) or
                ( passedt.amenity == "pub_yddynndno"              ) or
                ( passedt.amenity == "pub_yddynndnd"              ) or
                ( passedt.amenity == "pub_yddynnddg"              ) or
                ( passedt.amenity == "pub_yddynnddo"              ) or
                ( passedt.amenity == "pub_yddynnddd"              ) or
                ( passedt.amenity == "pub_ydddydy"                ) or
                ( passedt.amenity == "pub_ydddydnyg"              ) or
                ( passedt.amenity == "pub_ydddydnyo"              ) or
                ( passedt.amenity == "pub_ydddydnyd"              ) or
                ( passedt.amenity == "pub_ydddydnl"               ) or
                ( passedt.amenity == "pub_ydddydnn"               ) or
                ( passedt.amenity == "pub_ydddydndg"              ) or
                ( passedt.amenity == "pub_ydddydndo"              ) or
                ( passedt.amenity == "pub_ydddydndd"              ) or
                ( passedt.amenity == "pub_ydddnydy"               ) or
                ( passedt.amenity == "pub_ydddnydl"               ) or
                ( passedt.amenity == "pub_ydddnydn"               ) or
                ( passedt.amenity == "pub_ydddnydd"               ) or
                ( passedt.amenity == "pub_ydddnnyyg"              ) or
                ( passedt.amenity == "pub_ydddnnyyo"              ) or
                ( passedt.amenity == "pub_ydddnnyyd"              ) or
                ( passedt.amenity == "pub_ydddnnylg"              ) or
                ( passedt.amenity == "pub_ydddnnylo"              ) or
                ( passedt.amenity == "pub_ydddnnyld"              ) or
                ( passedt.amenity == "pub_ydddnnyn"               ) or
                ( passedt.amenity == "pub_ydddnnydg"              ) or
                ( passedt.amenity == "pub_ydddnnydo"              ) or
                ( passedt.amenity == "pub_ydddnnydd"              ) or
                ( passedt.amenity == "pub_ydddnnnyg"              ) or
                ( passedt.amenity == "pub_ydddnnnyo"              ) or
                ( passedt.amenity == "pub_ydddnnnyd"              ) or
                ( passedt.amenity == "pub_ydddnnnlg"              ) or
                ( passedt.amenity == "pub_ydddnnnlo"              ) or
                ( passedt.amenity == "pub_ydddnnnld"              ) or
                ( passedt.amenity == "pub_ydddnnnng"              ) or
                ( passedt.amenity == "pub_ydddnnnno"              ) or
                ( passedt.amenity == "pub_ydddnnnnd"              ) or
                ( passedt.amenity == "pub_ydddnnndg"              ) or
                ( passedt.amenity == "pub_ydddnnndo"              ) or
                ( passedt.amenity == "pub_ydddnnndd"              ) or
                ( passedt.amenity == "pub_cddddddd"               ) or
                ( passedt.amenity == "pub_nddddddd"               )) then
                Layer( "land1", true )
                Attribute( "class", "amenity_" .. passedt.amenity )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                    Attribute( "name", passedt.name )
                end

                MinZoom( 14 )
            else
                render_shop_land1( passedt )
            end -- amenity=shelter etc. 14
        end -- amenity=holy_well etc. 1e
    end -- amenity=parking etc. 9
end -- render_amenity_land1()

function render_shop_land1( passedt )
    if (( passedt.shop == "supermarket"        ) or
        ( passedt.shop == "department_store"   ) or
        ( passedt.shop == "ecosupermarket"     ) or
        ( passedt.shop == "alcohol"            ) or
        ( passedt.shop == "antiques"           ) or
        ( passedt.shop == "art"                ) or
        ( passedt.shop == "bakery"             ) or
        ( passedt.shop == "beauty"             ) or
        ( passedt.shop == "bicycle"            ) or
        ( passedt.shop == "bookmaker"          ) or
        ( passedt.shop == "books"              ) or
        ( passedt.shop == "butcher"            ) or
        ( passedt.shop == "car"                ) or
        ( passedt.shop == "car_parts"          ) or
        ( passedt.shop == "car_repair"         ) or
        ( passedt.shop == "catalogue"          ) or
        ( passedt.shop == "charity"            ) or
        ( passedt.shop == "clothes"            ) or
        ( passedt.shop == "coffee"             ) or
        ( passedt.shop == "computer"           ) or
        ( passedt.shop == "confectionery"      ) or
        ( passedt.shop == "convenience"        ) or
        ( passedt.shop == "copyshop"           ) or
        ( passedt.shop == "deli"               ) or
        ( passedt.shop == "discount"           ) or
        ( passedt.shop == "doityourself"       ) or
        ( passedt.shop == "e-cigarette"        ) or
        ( passedt.shop == "ecoconv"            ) or
        ( passedt.shop == "ecogreengrocer"     ) or
        ( passedt.shop == "ecohealth"          ) or
        ( passedt.shop == "electrical"         ) or
        ( passedt.shop == "electronics"        ) or
        ( passedt.shop == "estate_agent"       ) or
        ( passedt.shop == "farm"               ) or
        ( passedt.shop == "florist"            ) or
        ( passedt.shop == "funeral_directors"  ) or
        ( passedt.shop == "furniture"          ) or
        ( passedt.shop == "garden_centre"      ) or
        ( passedt.shop == "gift"               ) or
        ( passedt.shop == "greengrocer"        ) or
        ( passedt.shop == "hairdresser"        ) or
        ( passedt.shop == "health_food"        ) or
        ( passedt.shop == "healthnonspecific"  ) or
        ( passedt.shop == "homeware"           ) or
        ( passedt.shop == "jewellery"          ) or
        ( passedt.shop == "laundry"            ) or
        ( passedt.shop == "locksmith"          ) or
        ( passedt.shop == "mobile_phone"       ) or
        ( passedt.shop == "motorcycle"         ) or
        ( passedt.shop == "music"              ) or
        ( passedt.shop == "musical_instrument" ) or
        ( passedt.shop == "optician"           ) or
        ( passedt.shop == "outdoor"            ) or
        ( passedt.shop == "pawnbroker"         ) or
        ( passedt.shop == "pet"                ) or
        ( passedt.shop == "pet_food"           ) or
        ( passedt.shop == "pet_grooming"       ) or
        ( passedt.shop == "photo"              ) or
        ( passedt.shop == "seafood"            ) or
        ( passedt.shop == "shoe_repair_etc"    ) or
        ( passedt.shop == "shoes"              ) or
        ( passedt.shop == "shopnonspecific"    ) or
        ( passedt.shop == "sports"             ) or
        ( passedt.shop == "stationery"         ) or
        ( passedt.shop == "storage_rental"     ) or
        ( passedt.shop == "tattoo"             ) or
        ( passedt.shop == "toys"               ) or
        ( passedt.shop == "travel_agent"       )) then
        Layer( "land1", true )
        Attribute( "class", "shop_" .. passedt.shop )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
            Attribute( "name", passedt.name )
        end

        MinZoom( 14 )
    else
        if ( passedt.shop == "vacant" ) then
            Layer( "land1", true )
            Attribute( "class", "shop_" .. passedt.shop )

            if (( passedt.ref ~= nil ) and
                ( passedt.ref ~= ""  )) then
                Attribute( "name", passedt.ref )
            end

            MinZoom( 14 )
        else
            render_man_made_land1( passedt )
        end -- shop=vacant 14
    end -- shop=supermarket etc. 14
end -- render_shop_land1()

-- ----------------------------------------------------------------------------
-- man_made=pier is only written to land1 if it is a closed area.
-- ----------------------------------------------------------------------------
function render_man_made_land1( passedt )
    if ((  passedt.man_made == "bigmast"  ) or
        (( passedt.man_made == "pier"    )  and
         ( passedt.is_closed             ))) then
        Layer( "land1", true )
        Attribute( "class", "man_made_" .. passedt.man_made )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
            Attribute( "name", passedt.name )
        end

        MinZoom( 11 )
    else
        if ( passedt.man_made == "bigchimney" ) then
            Layer( "land1", true )
            Attribute( "class", "man_made_" .. passedt.man_made )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                Attribute( "name", passedt.name )
            end

            MinZoom( 12 )
        else
            if ( passedt.man_made == "bigobservationtower" ) then
                Layer( "land1", true )
                Attribute( "class", "man_made_" .. passedt.man_made )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                    Attribute( "name", passedt.name )
                end

                MinZoom( 13 )
            else
-- ----------------------------------------------------------------------------
-- These are all extracted at zoom 14 but may not get displayed until 
-- higher zoom levels.
-- ----------------------------------------------------------------------------
                if (( passedt.man_made == "chimney"                  ) or
                    ( passedt.man_made == "lighthouse"               ) or
                    ( passedt.man_made == "mast"                     ) or
                    ( passedt.man_made == "power_wind"               ) or
                    ( passedt.man_made == "ventilation_shaft"        ) or
                    ( passedt.man_made == "water_tower"              ) or
                    ( passedt.man_made == "windsock"                 ) or
                    ( passedt.man_made == "cross"                    ) or
                    ( passedt.man_made == "flagpole"                 ) or
                    ( passedt.man_made == "maypole"                  ) or
                    ( passedt.man_made == "aircraftcontroltower"     ) or
                    ( passedt.man_made == "churchspire"              ) or
                    ( passedt.man_made == "churchtower"              ) or
                    ( passedt.man_made == "clockpedestal"            ) or
                    ( passedt.man_made == "clocktower"               ) or
                    ( passedt.man_made == "defensivetower"           ) or
                    ( passedt.man_made == "footwear_decontamination" ) or
                    ( passedt.man_made == "illuminationtower"        ) or
                    ( passedt.man_made == "militarybunker"           ) or
                    ( passedt.man_made == "mineshaft"                ) or
                    ( passedt.man_made == "monitoringearthquake"     ) or
                    ( passedt.man_made == "monitoringrainfall"       ) or
                    ( passedt.man_made == "monitoringky"             ) or
                    ( passedt.man_made == "monitoringwater"          ) or
                    ( passedt.man_made == "monitoringweather"        ) or
                    ( passedt.man_made == "mounting_block"           ) or
                    ( passedt.man_made == "observationtower"         ) or
                    ( passedt.man_made == "radartower"               ) or
                    ( passedt.man_made == "squaretower"              ) or
                    ( passedt.man_made == "watermill"                ) or
                    ( passedt.man_made == "windmill"                 ) or
                    ( passedt.man_made == "survey_point"             ) or
                    ( passedt.man_made == "water_well"               ) or
                    ( passedt.man_made == "cairn"                    ) or
                    ( passedt.man_made == "flagpole_red"             ) or
                    ( passedt.man_made == "sluice_gate"              ) or
                    ( passedt.man_made == "boundary_stone"           ) or
                    ( passedt.man_made == "power"                    ) or
                    ( passedt.man_made == "power_wind"               )) then
                    Layer( "land1", true )
                    Attribute( "class", "man_made_" .. passedt.man_made )

                    if (( passedt.name ~= nil ) and
                        ( passedt.name ~= ""  )) then
                        Attribute( "name", passedt.name )
                    end

                    if (( passedt.ele ~= nil ) and
                        ( passedt.ele ~= ""  )) then
                        Attribute( "ele", passedt.ele )
                    end

                    MinZoom( 14 )
                else
-- ----------------------------------------------------------------------------
-- man_made == "markeraerial" and "lcn_ref" get written through with "ref"
-- in the name, but are still extracted at zoom 14.
-- ----------------------------------------------------------------------------
                    if (( passedt.man_made == "markeraerial" ) or
                        ( passedt.man_made == "lcn_ref"      )) then
                        Layer( "land1", true )
                        Attribute( "class", "man_made_" .. passedt.man_made )

                        if (( passedt.ref ~= nil ) and
                            ( passedt.ref ~= ""  )) then
                            Attribute( "name", passedt.ref )
                        end

                        MinZoom( 14 )
                    else
                        render_office_land1( passedt )
                    end -- man_made=markeraerial etc. 14
                end -- man_made=chimney etc. 14
            end -- man_made=bigobservationtower 13
        end -- man_made=bigchimney 12
    end -- man_made=bigmast 11
end -- render_man_made_land1()

function render_office_land1( passedt )
    if (( passedt.office == "craftbrewery" ) or
        ( passedt.office == "craftcider"   ) or
        ( passedt.office == "nonspecific"  )) then
        Layer( "land1", true )
        Attribute( "class", "office_" .. passedt.office )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
            Attribute( "name", passedt.name )
        end

        MinZoom( 14 )
    else
        render_highway_land1( passedt )
    end -- office=craftbrewery etc. 16
end -- render_office_land1()

-- ----------------------------------------------------------------------------
-- highway=pedestrian and highway=platform are only written to land1 if they're
-- closed areas.
-- All closed highway=pedestrian and highway=platform are assumed to be areas, 
-- regardless of any area tag.  There are some "area=no" examples, but this seem
-- to be mistaggings.
-- Closed highway=pathnarrow and highway=service are assumed to be areas, 
-- only if area=yes tag.
-- ----------------------------------------------------------------------------
function render_highway_land1( passedt )
    if (((  passedt.highway == "pedestrian"  )  and
         (  passedt.area    ~= "no"          )  and
         (  passedt.is_closed                )) or
        ((( passedt.highway == "service"    )   or
          ( passedt.highway == "pathnarrow" ))  and
         (  passedt.area    == "yes"         )  and
         (  passedt.is_closed                ))) then
        Layer( "land1", true )
        Attribute( "class", "highway_" .. passedt.highway )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
            Attribute( "name", passedt.name )
        end

        MinZoom( 12 )
    else
        if (( passedt.highway == "board_realtime"            ) or
            ( passedt.highway == "bus_stop_nothing"          ) or
            ( passedt.highway == "bus_stop_pole"             ) or
            ( passedt.highway == "bus_stop_disused_pole"     ) or
            ( passedt.highway == "bus_stop_timetable"        ) or
            ( passedt.highway == "bus_stop_realtime"         ) or
            ( passedt.highway == "bus_stop_speech_timetable" ) or
            ( passedt.highway == "bus_stop_speech_realtime"  ) or
            ( passedt.highway == "traffic_signals"           ) or
            ( passedt.highway == "streetlamp_electric"       ) or
            ( passedt.highway == "streetlamp_gas"            ) or
            ( passedt.highway == "crossing"                  ) or
            ( passedt.highway == "milestone"                 ) or
            ( passedt.highway == "mini_roundabout"           )) then
            Layer( "land1", true )
            Attribute( "class", "highway_" .. passedt.highway )
            append_name( passedt )

            if (( passedt.ele ~= nil ) and
                ( passedt.ele ~= ""  )) then
                Attribute( "ele", passedt.ele )
            end

            MinZoom( 14 )
        else
            if (( passedt.highway == "platform" ) and
                ( passedt.is_closed             )) then
                Layer( "land1", true )
                Attribute( "class", "highway_" .. passedt.highway )
                append_ref_etc( passedt )
                MinZoom( 14 )
            else
                render_railway_land1( passedt )
            end -- highway=platform 14
        end -- highway=board_realtime etc. 14
    end -- highway=pedestrian 12
end -- render_highway_land1()

function render_railway_land1( passedt )
    if ( passedt.railway == "station" ) then
        Layer( "land1", true )
        Attribute( "class", "railway_" .. passedt.railway )
        append_name( passedt )
        MinZoom( 11 )
    else
        if (( passedt.railway == "halt"      ) or
            ( passedt.railway == "tram_stop" )) then
            Layer( "land1", true )
            Attribute( "class", "railway_" .. passedt.railway )
            append_name( passedt )
            MinZoom( 12 )
        else
            if ((( passedt.railway == "platform"        )  and
                 ( passedt.is_closed                    )) or
                (  passedt.railway == "subway_entrance"  )) then
                Layer( "land1", true )
                Attribute( "class", "railway_" .. passedt.railway )
                append_name( passedt )
                MinZoom( 14 )
            else
                render_aerialway_land1( passedt )
            end -- railway=platform 14
        end -- railway=halt 12
    end -- railway=station 11
end -- render_railway_land1()

function render_aerialway_land1( passedt )
    if ( passedt.aerialway == "station" ) then
        Layer( "land1", true )
        Attribute( "class", "aerialway_" .. passedt.aerialway )
        append_name( passedt )
        MinZoom( 12 )
    else
        render_historic_land1( passedt )
    end -- aerialway=station 12
end -- render_aerialway_land1()

function render_historic_land1( passedt )
    if (( passedt.historic == "archaeological_site"      ) or
        ( passedt.historic == "battlefield"              ) or
        ( passedt.historic == "historicarchcastle"       ) or
        ( passedt.historic == "historicarchmotte"        ) or
        ( passedt.historic == "historiccrannog"          ) or
        ( passedt.historic == "historicfortification"    ) or
        ( passedt.historic == "historichillfort"         ) or
        ( passedt.historic == "historicpromontoryfort"   ) or
        ( passedt.historic == "historicringfort"         ) or
        ( passedt.historic == "historictumulus"          ) or
        ( passedt.historic == "manor"                    ) or
        ( passedt.historic == "monastery"                ) or
        ( passedt.historic == "palaeontological_site"    ) or
        ( passedt.historic == "castle"                   ) or
        ( passedt.historic == "church"                   ) or
        ( passedt.historic == "city_gate"                ) or
        ( passedt.historic == "dovecote"                 ) or
        ( passedt.historic == "folly"                    ) or
        ( passedt.historic == "historicchurchtower"      ) or
        ( passedt.historic == "historicdefensivetower"   ) or
        ( passedt.historic == "historicmegalithtomb"     ) or
        ( passedt.historic == "historicobservationtower" ) or
        ( passedt.historic == "historicroundtower"       ) or
        ( passedt.historic == "historicsquaretower"      ) or
        ( passedt.historic == "historicstandingstone"    ) or
        ( passedt.historic == "historicstone"            ) or
        ( passedt.historic == "historicstonecircle"      ) or
        ( passedt.historic == "historicstonerow"         ) or
        ( passedt.historic == "martello_tower"           ) or
        ( passedt.historic == "massrock"                 ) or
        ( passedt.historic == "naturalstone"             ) or
        ( passedt.historic == "oghamstone"               ) or
        ( passedt.historic == "pinfold"                  ) or
        ( passedt.historic == "runestone"                ) or
        ( passedt.historic == "aircraft"                 ) or
        ( passedt.historic == "aircraft_wreck"           ) or
        ( passedt.historic == "bunker"                   ) or
        ( passedt.historic == "cannon"                   ) or
        ( passedt.historic == "cross"                    ) or
        ( passedt.historic == "ice_house"                ) or
        ( passedt.historic == "kiln"                     ) or
        ( passedt.historic == "memorial"                 ) or
        ( passedt.historic == "memorialbench"            ) or
        ( passedt.historic == "memorialcross"            ) or
        ( passedt.historic == "memorialgrave"            ) or
        ( passedt.historic == "memorialobelisk"          ) or
        ( passedt.historic == "memorialpavementplaque"   ) or
        ( passedt.historic == "memorialplaque"           ) or
        ( passedt.historic == "memorialplate"            ) or
        ( passedt.historic == "memorialsculpture"        ) or
        ( passedt.historic == "memorialstatue"           ) or
        ( passedt.historic == "memorialstone"            ) or
        ( passedt.historic == "mill"                     ) or
        ( passedt.historic == "monument"                 ) or
        ( passedt.historic == "ship"                     ) or
        ( passedt.historic == "stocks"                   ) or
        ( passedt.historic == "tank"                     ) or
        ( passedt.historic == "tomb"                     ) or
        ( passedt.historic == "warmemorial"              ) or
        ( passedt.historic == "water_pump"               ) or
        ( passedt.historic == "watermill"                ) or
        ( passedt.historic == "well"                     ) or
        ( passedt.historic == "windmill"                 ) or
        ( passedt.historic == "wreck"                    ) or
        ( passedt.historic == "mineshaft"                ) or
        ( passedt.historic == "nonspecific"              )) then
        Layer( "land1", true )
        Attribute( "class", "historic_" .. passedt.historic )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 14 )
    else
        render_landuse_land1( passedt )
    end -- historic=archaeological_site etc. 14
end -- render_historic_land1()

function render_landuse_land1( passedt )
    if (( passedt.landuse == "forest"          ) or
        ( passedt.landuse == "farmland"        )) then
        Layer( "land1", true )
        Attribute( "class", "landuse_" .. passedt.landuse )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

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

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            MinZoom( 9 )
        else
            if (( passedt.landuse == "village_green"          ) or
                ( passedt.landuse == "quarry"                 ) or
                ( passedt.landuse == "historicquarry"         )) then
                Layer( "land1", true )
                Attribute( "class", "landuse_" .. passedt.landuse )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                     Attribute( "name", passedt.name )
                end

                MinZoom( 10 )
            else
                if ( passedt.landuse == "garages" ) then
                    Layer( "land1", true )
                    Attribute( "class", "landuse_" .. passedt.landuse )

                    if (( passedt.name ~= nil ) and
                        ( passedt.name ~= ""  )) then
                        Attribute( "name", passedt.name )
                    end

                    MinZoom( 11 )
                else
                    if ( passedt.landuse == "vineyard" ) then
                        Layer( "land1", true )
                        Attribute( "class", "landuse_" .. passedt.landuse )

                        if (( passedt.name ~= nil ) and
                            ( passedt.name ~= ""  )) then
                            Attribute( "name", passedt.name )
                        end

                        MinZoom( 12 )
                    else
                        if ( passedt.landuse == "conservation" ) then
                            Layer( "land1", true )
                            Attribute( "class", "landuse_" .. passedt.landuse )

                            if (( passedt.name ~= nil ) and
                                ( passedt.name ~= ""  )) then
                                  Attribute( "name", passedt.name )
                            end

                            MinZoom( 13 )
                        else
                            if ( passedt.landuse == "industrialbuilding" ) then
                                Layer( "land1", true )
                                Attribute( "class", "landuse_" .. passedt.landuse )

                                if (( passedt.name ~= nil ) and
                                    ( passedt.name ~= ""  )) then
                                    Attribute( "name", passedt.name )
                                end

                                MinZoom( 14 )
                            else
                                render_leisure_land1( passedt )
                            end -- landuse=industrialbuilding
                        end -- landuse=conservation 13
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

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 6 )
    else
        if ((  passedt.leisure == "common"            ) or
            (  passedt.leisure == "park"              ) or
            (  passedt.leisure == "recreation_ground" ) or
            (  passedt.leisure == "garden"            ) or
            (  passedt.leisure == "golfgreen"         ) or
            (  passedt.leisure == "golf_course"       ) or
            (  passedt.leisure == "sports_centre"     ) or
            (  passedt.leisure == "stadium"           ) or
            (  passedt.leisure == "pitch"             ) or
            (( passedt.leisure == "track"            )  and
             ( passedt.area    ~= "no"               )  and
             ( passedt.is_closed                     ))) then
            Layer( "land1", true )
            Attribute( "class", "leisure_" .. passedt.leisure )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            MinZoom( 9 )
        else
            if (( passedt.leisure == "playground" ) or
                ( passedt.leisure == "schoolyard" )) then
                Layer( "land1", true )
                Attribute( "class", "leisure_" .. passedt.leisure )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                     Attribute( "name", passedt.name )
                end

                MinZoom( 12 )
            else
                if ( passedt.leisure == "swimming_pool" ) then
                    Layer( "land1", true )
                    Attribute( "class", "leisure_" .. passedt.leisure )

                    if (( passedt.name ~= nil ) and
                        ( passedt.name ~= ""  )) then
                         Attribute( "name", passedt.name )
                    end

                    MinZoom( 13 )
                else
                    if (( passedt.leisure == "leisurenonspecific" ) or
                        ( passedt.leisure == "bandstand"          ) or
                        ( passedt.leisure == "bleachers"          ) or
                        ( passedt.leisure == "fitness_station"    ) or
                        ( passedt.leisure == "picnic_table"       ) or
                        ( passedt.leisure == "slipway"            ) or
                        ( passedt.leisure == "bird_hide"          ) or
                        ( passedt.leisure == "hunting_stand"      ) or
                        ( passedt.leisure == "grouse_butt"        )) then
                        Layer( "land1", true )
                        Attribute( "class", "leisure_" .. passedt.leisure )

                        if (( passedt.name ~= nil ) and
                            ( passedt.name ~= ""  )) then
                             Attribute( "name", passedt.name )
                        end

                        MinZoom( 14 )
                    else
                        render_military_land1( passedt )
                    end -- leisure=leisurenonspecific 14
                end -- leisure=swimming_pool etc. 13
            end -- leisure=playground etc.  12
        end -- leisure=common etc. 9
    end -- leisure=nature_reserve 6
end -- render_leisure_land1()

function render_military_land1( passedt )
    if ( passedt.military == "barracks" ) then
        Layer( "land1", true )
        Attribute( "class", "military_" .. passedt.military )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 9 )
    else
        render_natural_land1( passedt )
    end
end -- render_military_land1()

function render_natural_land1( passedt )
    if ( passedt.natural == "desert" ) then
        Layer( "land1", true )
        Attribute( "class", "natural_" .. passedt.natural )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 7 )
    else
        if (( passedt.natural == "wood"         ) or
            ( passedt.natural == "broadleaved"  ) or
            ( passedt.natural == "needleleaved" ) or
            ( passedt.natural == "mixedleaved"  ) or
            ( passedt.natural == "bigprompeak"  )) then
            Layer( "land1", true )
            Attribute( "class", "natural_" .. passedt.natural )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            if (( passedt.ele ~= nil ) and
                ( passedt.ele ~= ""  )) then
                 Attribute( "ele", passedt.ele )
            end

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
                ( passedt.natural == "scrub"         ) or
                ( passedt.natural == "bigpeak"       )) then
                Layer( "land1", true )
                Attribute( "class", "natural_" .. passedt.natural )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                     Attribute( "name", passedt.name )
                end

                if (( passedt.ele ~= nil ) and
                    ( passedt.ele ~= ""  )) then
                     Attribute( "ele", passedt.ele )
                end

                MinZoom( 9 )
            else
                if (( passedt.natural == "peak"    ) or
                    ( passedt.natural == "saddle"  ) or
                    ( passedt.natural == "volcano" )) then
                    Layer( "land1", true )
                    Attribute( "class", "natural_" .. passedt.natural )

                    if (( passedt.name ~= nil ) and
                        ( passedt.name ~= ""  )) then
                        Attribute( "name", passedt.name )
                    end

                    if (( passedt.ele ~= nil ) and
                        ( passedt.ele ~= ""  )) then
                        Attribute( "ele", passedt.ele )
                    end

                    MinZoom( 10 )
                else
                    if (( passedt.natural == "wetland"  ) or
                        ( passedt.natural == "reef"     ) or
                        ( passedt.natural == "reefsand" ) or
                        ( passedt.natural == "hill"     )) then
                        Layer( "land1", true )
                        Attribute( "class", "natural_" .. passedt.natural )

                        if (( passedt.name ~= nil ) and
                            ( passedt.name ~= ""  )) then
                            Attribute( "name", passedt.name )
                        end

                        if (( passedt.ele ~= nil ) and
                            ( passedt.ele ~= ""  )) then
                            Attribute( "ele", passedt.ele )
                        end

                        MinZoom( 12 )
                    else
                        if (( passedt.natural == "bay"    ) or
                            ( passedt.natural == "spring" )) then
                            Layer( "land1", true )
                            Attribute( "class", "natural_" .. passedt.natural )

                            if (( passedt.name ~= nil ) and
                                ( passedt.name ~= ""  )) then
                                Attribute( "name", passedt.name )
                            end

                            MinZoom( 13 )
                        else
                            if (( passedt.natural == "cave_entrance" ) or
                                ( passedt.natural == "sinkhole"      ) or
                                ( passedt.natural == "climbing"      ) or
                                ( passedt.natural == "rock"          ) or
                                ( passedt.natural == "tree"          ) or
                                ( passedt.natural == "shrub"         )) then
                                Layer( "land1", true )
                                Attribute( "class", "natural_" .. passedt.natural )

                                if (( passedt.name ~= nil ) and
                                    ( passedt.name ~= ""  )) then
                                    Attribute( "name", passedt.name )
                                end

                                MinZoom( 14 )
                            else
                                render_barrier_land1( passedt )
                            end -- cave_entrance etc. 14
                        end -- bay etc. 13
                    end -- wetland etc. 12
                end -- peak etc. 10
            end -- beach etc. 9
        end -- wood 8
    end -- desert 7
end -- render_natural_land1()

-- ----------------------------------------------------------------------------
-- hedges are only written to this if they're closed hedge areas.
-- hedges around some other area type (e.g. "landuse=farmland") have already been
-- changed to "hedgeline" above and will have been written out as linear
-- barriers already
-- ----------------------------------------------------------------------------
function render_barrier_land1( passedt )
    if ((  passedt.barrier == "cattle_grid"     ) or
        (  passedt.barrier == "cycle_barrier"   ) or
        (  passedt.barrier == "gate"            ) or
        (  passedt.barrier == "gate_locked"     ) or
        (  passedt.barrier == "horse_stile"     ) or
        (  passedt.barrier == "kissing_gate"    ) or
        (  passedt.barrier == "dog_gate_stile"  ) or
        (  passedt.barrier == "stepping_stones" ) or
        (  passedt.barrier == "stile"           ) or
        (  passedt.barrier == "block"           ) or
        (  passedt.barrier == "bollard"         ) or
        (  passedt.barrier == "lift_gate"       ) or
        (  passedt.barrier == "toll_booth"      ) or
        (  passedt.barrier == "door"            ) or
        (( passedt.barrier == "hedge"          )  and
         ( passedt.is_closed                   ))) then
        Layer( "land1", true )
        Attribute( "class", "barrier_" .. passedt.barrier )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 14 )
    else
        render_waterway_land1( passedt )
    end -- barrier=cattle_grid etc. 15
end -- render_barrier_land1()

function render_waterway_land1( passedt )
    if ( passedt.waterway == "lock_gate" ) then
        Layer( "land1", true )
        Attribute( "class", "waterway_" .. passedt.waterway )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 14 )
    else
        render_power_land1( passedt )
    end -- waterway=lock_gate 14
end -- render_waterway_land1()

function render_power_land1( passedt )
    if (( passedt.power == "station"   ) or
        ( passedt.power == "generator" )) then
        Layer( "land1", true )
        Attribute( "class", "power_" .. passedt.power )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 9 )
    else
        if ( passedt.power == "substation" ) then
            Layer( "land1", true )
            Attribute( "class", "power_" .. passedt.power )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

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

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 9 )
    else
        if (( passedt.tourism == "camp_site"    ) or
            ( passedt.tourism == "caravan_site" ) or
            ( passedt.tourism == "picnic_site"  ) or
            ( passedt.tourism == "theme_park"   ) or
            ( passedt.tourism == "alpine_hut"   )) then
            Layer( "land1", true )
            Attribute( "class", "tourism_" .. passedt.tourism )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            MinZoom( 12 )
        else
            if (( passedt.tourism == "viewpoint"                  ) or
                ( passedt.tourism == "information"                ) or
                ( passedt.tourism == "informationncndudgeon"      ) or
                ( passedt.tourism == "informationncnmccoll"       ) or
                ( passedt.tourism == "informationncnmills"        ) or
                ( passedt.tourism == "informationncnrowe"         ) or
                ( passedt.tourism == "informationncnunknown"      ) or
                ( passedt.tourism == "informationpnfs"            ) or
                ( passedt.tourism == "informationoffice"          ) or
                ( passedt.tourism == "informationboard"           ) or
                ( passedt.tourism == "informationear"             ) or
                ( passedt.tourism == "informationplaque"          ) or
                ( passedt.tourism == "informationpublictransport" ) or
                ( passedt.tourism == "informationroutemarker"     ) or
                ( passedt.tourism == "informationsign"            ) or
                ( passedt.tourism == "informationmarker"          ) or
                ( passedt.tourism == "militarysign"               ) or
                ( passedt.tourism == "chalet"                     ) or
                ( passedt.tourism == "museum"                     ) or
                ( passedt.tourism == "aquarium"                   ) or
                ( passedt.tourism == "advertising_column"         ) or
                ( passedt.tourism == "artwork"                    ) or
                ( passedt.tourism == "singlechalet"               ) or
                ( passedt.tourism == "motel"                      ) or
                ( passedt.tourism == "hotel"                      ) or
                ( passedt.tourism == "hostel"                     ) or
                ( passedt.tourism == "bed_and_breakfast"          ) or
                ( passedt.tourism == "guest_house"                ) or
                ( passedt.tourism == "tourism_guest_dynd"         ) or
                ( passedt.tourism == "tourism_guest_nydn"         ) or
                ( passedt.tourism == "tourism_guest_nynn"         ) or
                ( passedt.tourism == "tourism_guest_yddd"         ) or
                ( passedt.tourism == "tourism_guest_ynnn"         ) or
                ( passedt.tourism == "tourism_guest_ynyn"         ) or
                ( passedt.tourism == "tourism_guest_yynd"         ) or
                ( passedt.tourism == "tourism_guest_yyyn"         ) or
                ( passedt.tourism == "tourism_guest_yyyy"         ) or
                ( passedt.tourism == "camp_pitch"                 )) then
                Layer( "land1", true )
                Attribute( "class", "tourism_" .. passedt.tourism )

                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                     Attribute( "name", passedt.name )
                end

                if (( passedt.ele ~= nil ) and
                    ( passedt.ele ~= ""  )) then
                     Attribute( "ele", passedt.ele )
                end

                MinZoom( 14 )
            else
                render_aeroway_land1( passedt )
            end -- tourism=viewpoint
        end -- tourism=camp_site etc. 12
    end -- tourism=zoo 9
end -- render_tourism_land1()

function render_aeroway_land1( passedt )
    if (( passedt.aeroway == "grass_runway" ) or
        ( passedt.aeroway == "runway"       )) then
        Layer( "land1", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 10 )
    else
        if (( passedt.aeroway == "apron"   ) or
            ( passedt.aeroway == "taxiway" )) then
            Layer( "land1", true )
            Attribute( "class", "aeroway_" .. passedt.aeroway )

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

            MinZoom( 12 )
        else
            if (( passedt.aeroway == "helipad" ) or
                ( passedt.aeroway == "gate"    )) then
                Layer( "land1", true )
                Attribute( "class", "aeroway_" .. passedt.aeroway )

                if (( passedt.ref ~= nil ) and
                    ( passedt.ref ~= ""  )) then
                     Attribute( "name", passedt.ref )
                end

                MinZoom( 14 )
-- ------------------------------------------------------------------------------
--            else
-- At this point we've done all thing "landuse" processing for things that might 
-- be in the "land1" layer, including displaying names and/or icons for them.
-- The call to "generic_after_poi()" below displays things that should also have
-- a name and/or an icon, but don't have an area fill or outline.
--                generic_after_poi( passedt )
-- ------------------------------------------------------------------------------
            end -- aeroway=helipad etc. 14
        end -- aeroway=apron 12
    end -- aeroway=grass_runway etc. 10
end -- render_aeroway_land1()

-- ----------------------------------------------------------------------------
-- land2 layer
-- ----------------------------------------------------------------------------
function generic_after_land2( passedt )
    if (( passedt.natural == "intermittentwater" ) or
        ( passedt.natural == "flood_prone"       )) then
        Layer( "land2", true )
        Attribute( "class", "natural_" .. passedt.natural )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

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
                if (( passedt.name ~= nil ) and
                    ( passedt.name ~= ""  )) then
                     Attribute( "name", passedt.name )
                end
            end

            MinZoom( 9 )
        else
            if (( passedt.landuse == "unnamedquarry"          ) or
                ( passedt.landuse == "unnamedhistoricquarry"  )) then
                Layer( "land2", true )
                Attribute( "class", "landuse_" .. passedt.landuse )
                MinZoom( 10 )
            else
                if ( passedt.landuse == "harbour" ) then
                    Layer( "land2", true )
                    Attribute( "class", "landuse_" .. passedt.landuse )

                    if (( passedt.name ~= nil ) and
                        ( passedt.name ~= ""  )) then
                         Attribute( "name", passedt.name )
                    end

                    MinZoom( 13 )
                else
                    render_leisure_land2( passedt )
                end -- landuse=harbour 13
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

            if (( passedt.name ~= nil ) and
                ( passedt.name ~= ""  )) then
                 Attribute( "name", passedt.name )
            end

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

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

        MinZoom( 12 )
    else
        render_boundary_land2( passedt )
    end -- aeroway=aerodrome 12
end -- render_aeroway_land2()

function render_boundary_land2( passedt )
    if ( passedt.boundary == "national_park" ) then
        Layer( "land2", true )
        Attribute( "class", "boundary_" .. passedt.boundary )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
             Attribute( "name", passedt.name )
        end

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
    if (( passedt.amenity ~= nil ) and
        ( passedt.amenity ~= ""  )) then
        LayerAsCentroid( "poi" )
        Attribute( "class","amenity_" .. passedt.amenity )
        append_name( passedt )
        MinZoom( 14 )
    else
        if (( passedt.shop ~= nil ) and
            ( passedt.shop ~= ""  )) then
            LayerAsCentroid( "poi" )
            Attribute( "class","shop_" .. passedt.shop )
            append_name( passedt )
            MinZoom( 14 )
        else
            if (( passedt.tourism ~= nil ) and
                ( passedt.tourism ~= ""  )) then
                LayerAsCentroid( "poi" )
                Attribute( "class", "tourism_" .. passedt.tourism )
                append_name( passedt )
                MinZoom( 14 )
-- ------------------------------------------------------------------------------
-- No else here yet
-- ------------------------------------------------------------------------------
            end -- tourism
        end -- shop
    end -- amenity
end -- generic_after_poi()

function generic_after_place( passedt )
    if (( passedt.place == "country" ) or
        ( passedt.place == "state"   )) then
        LayerAsCentroid( "place" )
        append_name( passedt )
        Attribute( "class", passedt.place )
-- ------------------------------------------------------------------------------
-- No minzoom for country or state
-- ------------------------------------------------------------------------------
    else
        if (( passedt.capital == "yes" ) and
            ( passedt.place   ~= nil   ) and
            ( passedt.place   ~= ""    )) then
                LayerAsCentroid( "place" )
                append_name( passedt )
                Attribute( "class", "capital" )
                MinZoom( 3 )
        else
            if ( passedt.place == "city" ) then
                LayerAsCentroid( "place" )
                append_name( passedt )
                Attribute( "class", passedt.place )
                MinZoom( 5 )
            else
                if ( passedt.place == "town" ) then
                    LayerAsCentroid( "place" )
                    append_name( passedt )
                    Attribute( "class", passedt.place )
                    MinZoom( 8 )
                else
                    if (( passedt.place == "suburb"  ) or
                        ( passedt.place == "village" )) then
                        LayerAsCentroid( "place" )
                        append_name( passedt )
                        Attribute( "class", passedt.place )
                        MinZoom( 11 )
                    else
                        if (( passedt.place == "hamlet"            ) or
                            ( passedt.place == "locality"          ) or
                            ( passedt.place == "neighbourhood"     ) or
                            ( passedt.place == "isolated_dwelling" ) or
                            ( passedt.place == "farm"              )) then
                            LayerAsCentroid( "place" )
                            append_name( passedt )
                            Attribute( "class", passedt.place )
                            MinZoom( 13 )
-- ------------------------------------------------------------------------------
-- There is no catch-all on place - 
-- we only extract what we expect to want to process.
-- ------------------------------------------------------------------------------
                        end -- hamlet
                    end -- suburb
                end -- town
            end -- city
        end -- capital
    end -- country
end -- generic_after_place()

function append_name( passedt )
    if (( passedt.name ~= nil )   and
        ( passedt.name ~= ""  ))  then
        Attribute( "name", passedt.name )
    end
end -- function append_name( passedt )


function append_ref_etc( passedt )
    if (( passedt.ref ~= nil )   and
        ( passedt.ref ~= ""  ))  then
        Attribute( "ref", passedt.ref )
        AttributeNumeric( "ref_len", string.len( passedt.ref ))
    end
end -- function append_ref_etc( passedt )


