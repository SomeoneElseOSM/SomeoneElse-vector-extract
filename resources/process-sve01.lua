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
              "canoe", "climbing", "craft", "disused:amenity", "disused:military", "disused:railway", "emergency", 
              "entrance", "ford", "golf", "harbour", "historic", 
              "healthcare", "highway", "information", 
              "landuse", "lcn_ref", "leisure", "man_made", "marker", 
              "military", "natural", "ncn_milepost", 
              "office", "pipeline", "pitch", "place", 
              "place_of_worship", "playground", "power", "railway", "shop", 
              "sport", "tourism", "tunnel", "was:amenity", "waterway", "whitewater", "zoo" }

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
    nodet.way_area = 0

    update_table( nodet )
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

    if ( wayt.is_closed ) then
        wayt.way_area = Area()
    else
        wayt.way_area = 0
    end

    update_table( wayt )
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
    fix_corridors_t( wayt )

-- ----------------------------------------------------------------------------
-- Consolidate some rare highway types into ones we can display.
-- ----------------------------------------------------------------------------
    process_golf_tracks_t( wayt )

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
-- Dam areas.  Extract as an explicit area feature.
-- ----------------------------------------------------------------------------
   if ((  wayt.waterway == "dam" ) and
       (  wayt.is_closed         ) and
       (( wayt.building == nil  )  or
        ( wayt.building == ""   ))) then
        wayt.waterway = "damarea"
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
--
-- If something is a runway and is a closed way we can assume that what has
-- been mapped is the outline of the area of the linear runway (because
-- although "circular runways" are a concept -
-- https://en.wikipedia.org/wiki/Endless_runway - they are not not a thing
-- right now.  However, closed circular taxiways are very much a thing, and
-- so we also check the "area" tag there.  Unless area=yes is explicitly set,
-- we assume that a taxiway is linear.
-- ----------------------------------------------------------------------------
    if ((  not wayt.is_closed              ) and
        (( wayt.aeroway == "grass_runway" )  or
         ( wayt.aeroway == "runway"       )  or
         ( wayt.aeroway == "taxiway"      ))) then
        wayt.aeroway = nil
    end

    if (( wayt.aeroway == "taxiway"  ) and
        ( wayt.area    ~= "yes"      )) then
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
    if (( Find("type") == "route"    ) or
        ( Find("type") == "boundary" )) then
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

    if ( relationt.is_closed ) then
        relationt.way_area = Area()
    else
        relationt.way_area = 0
    end

    update_table( relationt )
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

      if (((  relationt.network == "iwn"          ) or
           (  relationt.network == "nwn"          ) or
           (  relationt.network == "rwn"          ) or
           (  relationt.network == "lwn"          ) or
           (  relationt.network == "lwn;lcn"      ) or
           (  relationt.network == "lwn;lcn;lhn"  )) and
          ((( relationt.name    ~= nil           )   and
            ( relationt.name    ~= ""            ))  or
           (( relationt.colour  ~= nil           )   and
            ( relationt.colour  ~= ""            )))) then
         if ((( relationt.name   == nil )  or
              ( relationt.name   == ""  )) and
             (( relationt.colour ~= nil )  and
              ( relationt.colour ~= ""  ))) then
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
          ((( relationt.state   == nil            )   or
            ( relationt.state   == ""             ))  or
           (( relationt.state   ~= "proposed"     )   and
            ( relationt.state   ~= "construction" )   and
            ( relationt.state   ~= "abandoned"    )))) then
         relationt.highway = "ldpncn"

         if ( relationt.ref == "N/A" ) then
            relationt.ref = nil
         end

         if (( relationt.name ~= nil                 ) and
             ( relationt.name ~= ""                  ) and
             ( relationt.ref  == "NB"                ) and
             ( string.match( relationt.name, "Loop" ))) then
            relationt.ref = relationt.ref .. " (loop)"
         end

         if (( relationt.ref ~= nil ) and
             ( relationt.ref ~= ""  )) then
            relationt.name = relationt.ref
         end

         if (( relationt.network == "rcn"       )  and
             ( relationt.name    ~= "NB"        )  and
             ( relationt.name    ~= "NB (loop)" )) then
            if (( relationt.name == nil )  or
                ( relationt.name == ""  )) then
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

         if (( relationt.name == nil ) or
             ( relationt.name == ""  )) then
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
             (  relationt.name        ~= ""      ) and
             (( relationt.nameCsigned == "no"   )  or
              ( relationt["name:absent"] == "yes"  )  or
              ( relationt.unsigned    == "yes"  )  or
              ( relationt.unsigned    == "name" ))) then
            relationt.name = nil
            relationt.nameCsigned = nil
            relationt.highway = nil
         end -- no name

         if ((  relationt.ref        ~= nil     ) and
             (  relationt.ref        ~= ""      ) and
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
-- Dam areas.  Extract as an explicit area feature.
-- ----------------------------------------------------------------------------
   if ((  relationt.waterway == "dam" ) and
       (  relationt.is_closed         ) and
       (( relationt.building == nil  )  or
        ( relationt.building == ""   ))) then
        relationt.waterway = "damarea"
   end

-- ----------------------------------------------------------------------------
-- (end of the relation-specific code)
--
-- Linear transportation layer
-- ----------------------------------------------------------------------------
    wr_after_transportation( relationt )

-- ----------------------------------------------------------------------------
-- Actually writing out most other nodes (and polygons) is done 
-- in "generic_after_function"
-- 
-- Linear features should have been handled above.
-- ----------------------------------------------------------------------------
    generic_after_function( relationt )
end  -- relation_function()

function update_table( passedt )
    passedt.LPG = Find("LPG")
    passedt["abandoned:amenity"] = Find("abandoned:amenity")
    passedt["abandoned:railway"] = Find("abandoned:railway")
    passedt["abandoned:waterway"] = Find("abandoned:waterway")
    passedt.access = Find("access")
    passedt["access:bicycle"] = Find("access:bicycle")
    passedt["access:covid19"] = Find("access:covid19")
    passedt["access:foot"] = Find("access:foot")
    passedt["access:horse"] = Find("access:horse")
    passedt.accommodation = Find("accommodation")
    passedt["addr:housename"] = Find("addr:housename")
    passedt["addr:housenumber"] = Find("addr:housenumber")
    passedt["addr:unit"] = Find("addr:unit")
    passedt["admin:ref"] = Find("admin:ref")
    passedt.admin_ref = Find("admin_ref")
    passedt.advertising = Find("advertising")
    passedt.aerialway = Find("aerialway")
    passedt["aerodrome:type"] = Find("aerodrome:type")
    passedt.aeroway = Find("aeroway")
    passedt.agrarian = Find("agrarian")
    passedt["aircraft:model"] = Find("aircraft:model")
    passedt.airmark = Find("airmark")
    passedt.amenity = Find("amenity")
    passedt["amenity:disused"] = Find("amenity:disused")
    passedt.animal = Find("animal")
    passedt.archaeological_site = Find("archaeological_site")
    passedt.area = Find("area")
    passedt["area:highway"] = Find("area:highway")
    passedt.attraction = Find("attraction")
    passedt.barrier = Find("barrier")
    passedt.basin = Find("basin")
    passedt.beer_garden = Find("beer_garden")
    passedt.bench = Find("bench")
    passedt.bicycle = Find("bicycle")
    passedt["board:title"] = Find("board:title")
    passedt.board_type = Find("board_type")
    passedt.booth = Find("booth")
    passedt.boundary = Find("boundary")
    passedt.brand = Find("brand")
    passedt.bridge = Find("bridge")
    passedt["bridge:name"] = Find("bridge:name")
    passedt["bridge:ref"] = Find("bridge:ref")
    passedt.bridge_name = Find("bridge_name")
    passedt.bridge_ref = Find("bridge_ref")
    passedt.building = Find("building")
    passedt["building:part"] = Find("building:part")
    passedt["building:ruins"] = Find("building:ruins")
    passedt["building:type"] = Find("building:type")
    passedt.bulk_purchase = Find("bulk_purchase")
    passedt.bus_display_name = Find("bus_display_name")
    passedt.bus_speech_output_name = Find("bus_speech_output_name")
    passedt.business = Find("business")
    passedt.canal_bridge_ref = Find("canal_bridge_ref")
    passedt.canoe = Find("canoe")
    passedt.capital = Find("capital")
    passedt.castle_type = Find("castle_type")
    passedt.climbing = Find("climbing")
    passedt["closed:amenity"] = Find("closed:amenity")
    passedt["closed:shop"] = Find("closed:shop")
    passedt.club = Find("club")
    passedt.colour = Find("colour")
    passedt.company = Find("company")
    passedt.consulate = Find("consulate")
    passedt.covered = Find("covered")
    passedt.craft = Find("craft")
    passedt.crossing = Find("crossing")
    passedt.cuisine = Find("cuisine")
    passedt.cycleway = Find("cycleway")
    passedt["dance:teaching"] = Find("dance:teaching")
    passedt.defensive_works = Find("defensive_works")
    passedt["demolished:amenity"] = Find("demolished:amenity")
    passedt.denomination = Find("denomination")
    passedt.departures_board = Find("departures_board")
    passedt["departures_board:speech_output"] = Find("departures_board:speech_output")
    passedt["description:floor"] = Find("description:floor")
    passedt.designation = Find("designation")
    passedt.diplomatic = Find("diplomatic")
    passedt.direction_east = Find("direction_east")
    passedt.direction_north = Find("direction_north")
    passedt.direction_northeast = Find("direction_northeast")
    passedt.direction_northwest = Find("direction_northwest")
    passedt.direction_south = Find("direction_south")
    passedt.direction_southeast = Find("direction_southeast")
    passedt.direction_southwest = Find("direction_southwest")
    passedt.direction_west = Find("direction_west")
    passedt.disused = Find("disused")
    passedt["disused:aeroway"] = Find("disused:aeroway")
    passedt["disused:amenity"] = Find("disused:amenity")
    passedt["disused:building"] = Find("disused:building")
    passedt["disused:highway"] = Find("disused:highway")
    passedt["disused:landuse"] = Find("disused:landuse")
    passedt["disused:man_made"] = Find("disused:man_made")
    passedt["disused:military"] = Find("disused:military")
    passedt["disused:pub"] = Find("disused:pub")
    passedt["disused:railway"] = Find("disused:railway")
    passedt["disused:shop"] = Find("disused:shop")
    passedt["disused:tourism"] = Find("disused:tourism")
    passedt["disused:waterway"] = Find("disused:waterway")
    passedt.dog_gate = Find("dog_gate")
    passedt.drinking_water = Find("drinking_water")
    passedt.ele = Find("ele")
    passedt.embankment = Find("embankment")
    passedt.embassy = Find("embassy")
    passedt.emergency = Find("emergency")
    passedt.entrance = Find("entrance")
    passedt.est_width = Find("est_width")
    passedt.farmland = Find("farmland")
    passedt.fee = Find("fee")
    passedt.female = Find("female")
    passedt.fence_type = Find("fence_type")
    passedt.flag = Find("flag")
    passedt.flood_prone = Find("flood_prone")
    passedt["floor:material"] = Find("floor:material")
    passedt.flow_control = Find("flow_control")
    passedt.food = Find("food")
    passedt["food:eggs"] = Find("food:eggs")
    passedt.foot = Find("foot")
    passedt["foot:physical"] = Find("foot:physical")
    passedt.footway = Find("footway")
    passedt.ford = Find("ford")
    passedt["former:amenity"] = Find("former:amenity")
    passedt.former_amenity = Find("former_amenity")
    passedt.fortification_type = Find("fortification_type")
    passedt["fuel:H2"] = Find("fuel:H2")
    passedt["fuel:LH2"] = Find("fuel:LH2")
    passedt["fuel:diesel"] = Find("fuel:diesel")
    passedt["fuel:electricity"] = Find("fuel:electricity")
    passedt["fuel:lpg"] = Find("fuel:lpg")
    passedt.gambling = Find("gambling")
    passedt.gate = Find("gate")
    passedt["generator:method"] = Find("generator:method")
    passedt["generator:source"] = Find("generator:source")
    passedt.geological = Find("geological")
    passedt.geological = Find("geological")
    passedt.golf = Find("golf")
    passedt.government = Find("government")
    passedt.guide_type = Find("guide_type")
    passedt.harbour = Find("harbour")
    passedt.hard_shoulder = Find("hard_shoulder")
    passedt.hazard = Find("hazard")
    passedt.hazard_prone = Find("hazard_prone")
    passedt.hazard_type = Find("hazard_type")
    passedt.healthcare = Find("healthcare")
    passedt["healthcare:speciality"] = Find("healthcare:speciality")
    passedt.height = Find("height")
    passedt.highway = Find("highway")
    passedt.highway_authority_ref = Find("highway_authority_ref")
    passedt.highway_ref = Find("highway_ref")
    passedt.historic = Find("historic")
    passedt["historic:amenity"] = Find("historic:amenity")
    passedt["historic:civilization"] = Find("historic:civilization")
    passedt["historic:name"] = Find("historic:name")
    passedt["historic:railway"] = Find("historic:railway")
    passedt["historic:waterway"] = Find("historic:waterway")
    passedt.horse = Find("horse")
    passedt.hunting_stand = Find("hunting_stand")
    passedt.iata = Find("iata")
    passedt.icao = Find("icao")
    passedt.indoor = Find("indoor")
    passedt.industrial = Find("industrial")
    passedt.informal = Find("informal")
    passedt.information = Find("information")
    passedt.inscription = Find("inscription")
    passedt.intermittent = Find("intermittent")
    passedt.is_sidepath = Find("is_sidepath")
    passedt["is_sidepath:of"] = Find("is_sidepath:of")
    passedt["is_sidepath:of:name"] = Find("is_sidepath:of:name")
    passedt["is_sidepath:of:ref"] = Find("is_sidepath:of:ref")
    passedt.junction = Find("junction")
    passedt.ladder = Find("ladder")
    passedt.lamp_type = Find("lamp_type")
    passedt.landcover = Find("landcover")
    passedt.landmark = Find("landmark")
    passedt.landuse = Find("landuse")
    passedt.layer = Find("layer")
    passedt.lcn_ref = Find("lcn_ref")
    passedt.leaf_type = Find("leaf_type")
    passedt.leisure = Find("leisure")
    passedt.level = Find("level")
    passedt.loc_ref = Find("loc_ref")
    passedt.location = Find("location")
    passedt.lock_name = Find("lock_name")
    passedt.lock_ref = Find("lock_ref")
    passedt.locked = Find("locked")
    passedt.male = Find("male")
    passedt.man_made = Find("man_made")
    passedt.marker = Find("marker")
    passedt.maxwidth = Find("maxwidth")
    passedt.meadow = Find("meadow")
    passedt.megalith_type = Find("megalith_type")
    passedt.memorial = Find("memorial")
    passedt["memorial:type"] = Find("memorial:type")
    passedt.microbrewery = Find("microbrewery")
    passedt.micropub = Find("micropub")
    passedt.military = Find("military")
    passedt["monitoring:air_quality"] = Find("monitoring:air_quality")
    passedt["monitoring:rainfall"] = Find("monitoring:rainfall")
    passedt["monitoring:seismic_activity"] = Find("monitoring:seismic_activity")
    passedt["monitoring:sky_brightness"] = Find("monitoring:sky_brightness")
    passedt["monitoring:water_flow"] = Find("monitoring:water_flow")
    passedt["monitoring:water_level"] = Find("monitoring:water_level")
    passedt["monitoring:water_velocity"] = Find("monitoring:water_velocity")
    passedt["monitoring:weather"] = Find("monitoring:weather")
    passedt.motor_vehicle = Find("motor_vehicle")
    passedt.munro = Find("munro")
    passedt.name = Find("name")
    passedt["name:absent"] = Find("name:absent")
    passedt["name:en"] = Find("name:en")
    passedt["name:historic"] = Find("name:historic")
    passedt["name:left"] = Find("name:left")
    passedt["name:right"] = Find("name:right")
    passedt["name:signed"] = Find("name:signed")
    passedt["naptan:BusStopType"] = Find("naptan:BusStopType")
    passedt["naptan:Indicator"] = Find("naptan:Indicator")
    passedt.natural = Find("natural")
    passedt.ncn_milepost = Find("ncn_milepost")
    passedt.network = Find("network")
    passedt.noncarpeted = Find("noncarpeted")
    passedt.obstacle = Find("obstacle")
    passedt.office = Find("office")
    passedt.official_ref = Find("official_ref")
    passedt["old:amenity"] = Find("old:amenity")
    passedt.old_amenity = Find("old_amenity")
    passedt.old_name = Find("old_name")
    passedt.oneway = Find("oneway")
    passedt.opening_hours = Find("opening_hours")
    passedt["opening_hours:covid19"] = Find("opening_hours:covid19")
    passedt.operator = Find("operator")
    passedt["operator:type"] = Find("operator:type")
    passedt.outdoor_seating = Find("outdoor_seating")
    passedt.outlet = Find("outlet")
    passedt.overgrown = Find("overgrown")
    passedt.parking = Find("parking")
    passedt.passenger_information_display = Find("passenger_information_display")
    passedt["passenger_information_display:speech_output"] = Find("passenger_information_display:speech_output")
    passedt["payment:honesty_box"] = Find("payment:honesty_box")
    passedt.peak = Find("peak")
    passedt.physically_present = Find("physically_present")
    passedt.pipeline = Find("pipeline")
    passedt.pitch = Find("pitch")
    passedt.place = Find("place")
    passedt.place_of_worship = Find("place_of_worship")
    passedt["plant:source"] = Find("plant:source")
    passedt.playground = Find("playground")
    passedt.pole = Find("pole")
    passedt.power = Find("power")
    passedt.power_source = Find("power_source")
    passedt.produce = Find("produce")
    passedt.prominence = Find("prominence")
    passedt.protect_class = Find("protect_class")
    passedt.protection_title = Find("protection_title")
    passedt.prow_ref = Find("prow_ref")
    passedt.pub = Find("pub")
    passedt.public_transport = Find("public_transport")
    passedt.railway = Find("railway")
    passedt["railway:historic"] = Find("railway:historic")
    passedt["railway:miniature"] = Find("railway:miniature")
    passedt["railway:preserved"] = Find("railway:preserved")
    passedt["razed:amenity"] = Find("razed:amenity")
    passedt.real_ale = Find("real_ale")
    passedt.recycling_type = Find("recycling_type")
    passedt.reef = Find("reef")
    passedt.ref = Find("ref")
    passedt["ref:signed"] = Find("ref:signed")
    passedt.religion = Find("religion")
    passedt["removed:amenity"] = Find("removed:amenity")
    passedt.rescue_equipment = Find("rescue_equipment")
    passedt.reusable_packaging = Find("reusable_packaging")
    passedt.route = Find("route")
    passedt["ruined:building"] = Find("ruined:building")
    passedt.ruins = Find("ruins")
    passedt["ruins:building"] = Find("ruins:building")
    passedt["ruins:man_made"] = Find("ruins:man_made")
    passedt["ruins:tourism"] = Find("ruins:tourism")
    passedt.sac_scale = Find("sac_scale")
    passedt.school = Find("school")
    passedt.scramble = Find("scramble")
    passedt["seamark:rescue_station:category"] = Find("seamark:rescue_station:category")
    passedt["seamark:type"] = Find("seamark:type")
    passedt.segregated = Find("segregated")
    passedt.service = Find("service")
    passedt.shop = Find("shop")
    passedt.shoulder = Find("shoulder")
    passedt.sidewalk = Find("sidewalk")
    passedt["sidewalk:both"] = Find("sidewalk:both")
    passedt["sidewalk:left"] = Find("sidewalk:left")
    passedt["sidewalk:right"] = Find("sidewalk:right")
    passedt.site_type = Find("site_type")
    passedt.small_electric_vehicle = Find("small_electric_vehicle")
    passedt.social_facility = Find("social_facility")
    passedt.species = Find("species")
    passedt.sport = Find("sport")
    passedt.station = Find("station")
    passedt.status = Find("status")
    passedt.support = Find("support")
    passedt.surface = Find("surface")
    passedt.sustrans_ref = Find("sustrans_ref")
    passedt.taxon = Find("taxon")
    passedt.telephone_kiosk = Find("telephone_kiosk")
    passedt.theatre = Find("theatre")
    passedt["theatre:type"] = Find("theatre:type")
    passedt.tidal = Find("tidal")
    passedt.timetable = Find("timetable")
    passedt.tomb = Find("tomb")
    passedt.tourism = Find("tourism")
    passedt["tower:construction"] = Find("tower:type")
    passedt["tower:type"] = Find("tower:type")
    passedt.tpuk_ref = Find("tpuk_ref")
    passedt.trade = Find("trade")
    passedt.trail_visibility = Find("trail_visibility")
    passedt.tunnel = Find("tunnel")
    passedt["tunnel:name"] = Find("tunnel:name")
    passedt.tunnel_name = Find("tunnel_name")
    passedt.type = Find("type")
    passedt.underground = Find("underground")
    passedt.unsigned = Find("unsigned")
    passedt.usage = Find("usage")
    passedt.utility = Find("utility")
    passedt.vending = Find("vending")
    passedt.vending_machine = Find("vending_machine")
    passedt.verge = Find("verge")
    passedt["verge:both"] = Find("verge:both")
    passedt["verge:left"] = Find("verge:left")
    passedt["verge:right"] = Find("verge:right")
    passedt.visibility = Find("visibility")
    passedt["volcano:status"] = Find("volcano:status")
    passedt.wall = Find("wall")
    passedt["was:aeroway"] = Find("was:aeroway")
    passedt["was:amenity"] = Find("was:amenity")
    passedt["was:landuse"] = Find("was:landuse")
    passedt["was:railway"] = Find("was:railway")
    passedt["was:shop"] = Find("was:shop")
    passedt["was:waterway"] = Find("was:waterway")
    passedt.water = Find("water")
    passedt["watermill:disused"] = Find("watermill:disused")
    passedt.waterway = Find("waterway")
    passedt["waterway:abandoned"] = Find("waterway:abandoned")
    passedt["waterway:historic"] = Find("waterway:historic")
    passedt["weather:radar"] = Find("weather:radar")
    passedt.website = Find("website")
    passedt.wetland = Find("wetland")
    passedt.wheelchair = Find("wheelchair")
    passedt.whitewater = Find("whitewater")
    passedt.width = Find("width")
    passedt["windmill:disused"] = Find("windmill:disused")
    passedt.zero_waste = Find("zero_waste")
    passedt.zoo = Find("zoo")
end  -- function update_table( passedt )

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
    fix_invalid_layer_values_t( passedt )

-- ----------------------------------------------------------------------------
-- Treat "was:" as "disused:"
-- ----------------------------------------------------------------------------
   treat_was_as_disused_t( passedt )

-- ----------------------------------------------------------------------------
-- Before processing footways, turn certain corridors into footways
--
-- Note that https://wiki.openstreetmap.org/wiki/Key:indoor defines
-- indoor=corridor as a closed way.  highway=corridor is not documented there
-- but is used for corridors.  We'll only process layer or level 0 (or nil)
-- ----------------------------------------------------------------------------
   fix_corridors_t( passedt )

-- ----------------------------------------------------------------------------
-- If there are different names on each side of the street, we create one name
-- containing both.
-- If "name" does not exist but "name:en" does, use that.
-- ----------------------------------------------------------------------------
   set_name_left_right_en_t( passedt )

-- ----------------------------------------------------------------------------
-- Move refs to consider as "official" to official_ref
-- ----------------------------------------------------------------------------
   set_official_ref_t( passedt )

-- ----------------------------------------------------------------------------
-- "Sabristas" sometimes add dubious names to motorway junctions.  Don't show
-- them if they're not signed.
-- ----------------------------------------------------------------------------
   suppress_unsigned_motorway_junctions_t( passedt )

-- ----------------------------------------------------------------------------
-- Move unsigned road refs to the name, in brackets.
-- ----------------------------------------------------------------------------
   suppress_unsigned_road_refs_t( passedt )

-- ----------------------------------------------------------------------------
-- Consolidate more values for extraction / display
-- ----------------------------------------------------------------------------
   consolidate_lua_01_t( passedt )

-- ----------------------------------------------------------------------------
-- Send driveways through to the vector rendering code as 
-- a specific highway type (raster does not do this)
-- ----------------------------------------------------------------------------
   if (( passedt.highway == "service"  ) and
       ( passedt.service == "driveway" )) then
      passedt.highway  = "driveway"
   end

-- ----------------------------------------------------------------------------
-- Consolidate more values for extraction / display
-- ----------------------------------------------------------------------------
   consolidate_lua_02_t( passedt )

-- ----------------------------------------------------------------------------
-- Here the raster code has "Use unclassified_sidewalk to indicate sidewalk"
-- We don't do that here because we write an "edge" value through.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Consolidate more values for extraction / display
-- ----------------------------------------------------------------------------
   consolidate_lua_03_t( passedt )

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
-- Consolidate more values for extraction / display
-- ----------------------------------------------------------------------------
   consolidate_lua_04_t( passedt )

end -- generic_before_function()

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
        append_name( passedt )

        if (( passedt["addr:housenumber"] ~= nil )   and
            ( passedt["addr:housenumber"] ~= ""  ))  then
            Attribute( "housenumber", passedt["addr:housenumber"] )
        end

        if (( passedt["addr:housename"] ~= nil )   and
            ( passedt["addr:housename"] ~= ""  ))  then
            Attribute( "housename", passedt["addr:housename"] )
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
            MinZoom( 6 )
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
        end -- linear railways 6
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
        ( passedt["sidewalk:both"] == "separate"   ) or 
        ( passedt["sidewalk:both"] == "yes"        ) or
        ( passedt["sidewalk:left"] == "segregated" ) or
        ( passedt["sidewalk:left"] == "separate"   ) or 
        ( passedt["sidewalk:left"] == "yes"        ) or
        ( passedt["sidewalk:right"] == "segregated" ) or 
        ( passedt["sidewalk:right"] == "separate"  ) or 
        ( passedt["sidewalk:right"] == "yes"       ) or
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
        if (( passedt.verge       == "both"     ) or
            ( passedt.verge       == "left"     ) or
            ( passedt.verge       == "separate" ) or
            ( passedt.verge       == "right"    ) or
            ( passedt.verge       == "yes"      ) or
            ( passedt["verge:both"]  == "separate" ) or
            ( passedt["verge:both"]  == "yes"      ) or
            ( passedt["verge:left"]  == "separate" ) or
            ( passedt["verge:left"]  == "yes"      ) or
            ( passedt["verge:right"] == "separate" ) or
            ( passedt["verge:right"] == "yes"      )) then
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
                    if (( passedt.waterway == "weir"     ) or
                        ( passedt.waterway == "pipeline" )) then
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
    if ((   passedt.barrier == "wall"        ) or
        ((  passedt.barrier == "hedge"      )  and
         (  not passedt.is_closed           )) or
        (   passedt.barrier == "hedgeline"   ) or
        (   passedt.barrier == "fence"       ) or
        (   passedt.barrier == "kerb"        ) or
        (   passedt.barrier == "pitchline"   ) or
        (   passedt.barrier == "gate"        ) or
        (   passedt.barrier == "gate_locked" ) or
        (   passedt.barrier == "lift_gate"   ) or
        (   passedt.barrier == "stile"       ) or
        (   passedt.barrier == "cattle_grid" ) or
        ((  passedt.barrier == "ford"       )  and
         (( passedt.highway == nil         )   or
          ( passedt.highway == ""          ))) or
        (   passedt.barrier == "tree_row"    )) then
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
        append_name( passedt )
        MinZoom( 13 )
    else
        if ( passedt.natural == "valley" ) then
            Layer( "linearbarrier", false )
            Attribute( "class", "natural_" .. passedt.natural )
            append_name( passedt )
            MinZoom( 10 )
        else
            if ( passedt.natural == "cliff" ) then
                Layer( "linearbarrier", false )
                Attribute( "class", "natural_" .. passedt.natural )
                append_name( passedt )
                MinZoom( 12 )
            else
                generic_linearbarrier_power( passedt )
            end  -- natural=cliff etc. 12
        end  -- natural=valley 11
    end  -- historic=citywalls 13
end -- generic_linearbarrier_historic()

function generic_linearbarrier_power( passedt )
    if (( passedt.power == "line"       ) or
        ( passedt.power == "minor_line" )) then
        Layer( "linearbarrier", false )
        Attribute( "class", "power_" .. passedt.power )
        MinZoom( 14 )
    end -- power=line etc.
end -- generic_linearbarrier_power()

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
    if (( passedt.natural == "water"             ) or
        ( passedt.natural == "intermittentwater" ) or
        ( passedt.natural == "glacier"           )) then
        Layer( "land1", true )
        Attribute( "class", "natural_" .. passedt.natural )

        if ( passedt.way_area > 31700000 ) then
            minzoom = 5
        else
            if ( passedt.way_area > 18135601 ) then
                minzoom = 6
            else
                if ( passedt.way_area > 14763745 ) then
                    minzoom = 7
                else
                    minzoom = 8
                end
            end
        end

        MinZoom( minzoom )

        LayerAsCentroid( "land1" )
        Attribute( "class", "natural_" .. passedt.natural )
        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
        append_name( passedt )
        MinZoom( minzoom )
    else
        render_amenity_land1( passedt )
    end
end -- generic_after_land1()

function render_amenity_land1( passedt )
    if (( passedt.amenity == "parking"              ) or
        ( passedt.amenity == "parking_pay"          ) or
        ( passedt.amenity == "parking_freedisabled" ) or
        ( passedt.amenity == "parking_paydisabled"  )) then
        if ( math.floor( passedt.way_area ) > 0 ) then
            Layer( "land1", true )
            Attribute( "class", "amenity_" .. passedt.amenity )
            MinZoom( 9 )
        end

        LayerAsCentroid( "land1" )
        Attribute( "class", "amenity_" .. passedt.amenity )
        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
        append_name( passedt )

        if (( passedt.access ~= nil ) and
            ( passedt.access ~= ""  )) then
            Attribute( "access", passedt.access )
        end

        MinZoom( 9 )
    else
        if (( passedt.amenity == "university"           ) or
            ( passedt.amenity == "college"              ) or
            ( passedt.amenity == "school"               ) or
            ( passedt.amenity == "hospital"             ) or
            ( passedt.amenity == "kindergarten"         )) then
            Layer( "land1", true )
            Attribute( "class", "amenity_" .. passedt.amenity )
            MinZoom( 9 )

            LayerAsCentroid( "land1" )
            Attribute( "class", "amenity_" .. passedt.amenity )
            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
            append_name( passedt )
            MinZoom( 9 )
        else
            if (( passedt.amenity == "holy_spring"                ) or
                ( passedt.amenity == "holy_well"                  ) or
                ( passedt.amenity == "watering_place"             )) then
                Layer( "land1", true )
                Attribute( "class", "amenity_" .. passedt.amenity )
                append_name( passedt )
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
                    append_name( passedt )
                    MinZoom( 14 )
                else
-- ----------------------------------------------------------------------------
-- Some amenities are extracted with an access value as well.
-- ----------------------------------------------------------------------------
                    if (( passedt.amenity == "bicycle_rental"             ) or
                        ( passedt.amenity == "scooter_rental"             ) or
                        ( passedt.amenity == "bicycle_parking"            ) or
                        ( passedt.amenity == "bicycle_parking_pay"        ) or
                        ( passedt.amenity == "motorcycle_parking"         ) or
                        ( passedt.amenity == "motorcycle_parking_pay"     )) then
                        Layer( "land1", true )
                        Attribute( "class", "amenity_" .. passedt.amenity )

                        if (( passedt.access ~= nil ) and
                            ( passedt.access ~= ""  )) then
                            Attribute( "access", passedt.access )
                        end

                        append_name( passedt )
                        MinZoom( 14 )
                    else
                        render_shop_land1( passedt )
                    end -- amenity=bicycle_rental etc. 14
                end -- amenity=shelter etc. 14
            end -- amenity=holy_well etc. 1e
        end -- amenity=university etc. 9
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
        append_name( passedt )
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
        append_name( passedt )
        MinZoom( 11 )
    else
        if ( passedt.man_made == "bigchimney" ) then
            Layer( "land1", true )
            Attribute( "class", "man_made_" .. passedt.man_made )
            append_name( passedt )
            MinZoom( 12 )
        else
            if ( passedt.man_made == "bigobservationtower" ) then
                Layer( "land1", true )
                Attribute( "class", "man_made_" .. passedt.man_made )
                append_name( passedt )
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
                    ( passedt.man_made == "power_wind"               ) or
                    ( passedt.man_made == "golfballwasher"           ) or
                    ( passedt.man_made == "outfall"                  )) then
                    Layer( "land1", true )
                    Attribute( "class", "man_made_" .. passedt.man_made )
		    append_name( passedt )

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
        append_name( passedt )
        MinZoom( 14 )
    else
        render_highway_land1( passedt )
    end -- office=craftbrewery etc. 16
end -- render_office_land1()

-- ----------------------------------------------------------------------------
-- highway=pedestrian and highway=platform are only written to land1 if they're
-- closed areas.
-- All closed highway=pedestrian and highway=platform are assumed to be areas, 
-- regardless of any area tag.  There are some "area=no" examples, but these
-- seem to be mistaggings.
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
        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
        append_name( passedt )
        MinZoom( 12 )
    else
        if ( passedt.highway == "ford" ) then
            Layer( "land1", true )
            Attribute( "class", "highway_" .. passedt.highway )
            append_name( passedt )
            MinZoom( 14 )
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
                if ( passedt.highway == "motorway_junction" ) then
                    Layer( "land1", true )
                    Attribute( "class", "highway_" .. passedt.highway )
                    append_name( passedt )
                    append_ref_etc( passedt )
                    MinZoom( 10 )
                else
                    if (( passedt.highway == "platform" ) and
                        ( passedt.is_closed             )) then
                        Layer( "land1", true )
                        Attribute( "class", "highway_" .. passedt.highway )
                        append_ref_etc( passedt )
                        MinZoom( 14 )
                    else
                        render_railway_land1( passedt )
                    end -- highway=platform ref 14
                end -- highway=motorway_junction name and ref  14
            end -- highway=board_realtime etc. name and ele 14
        end -- highway=ford name 14
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
                (  passedt.railway == "subway_entrance"  ) or
                (  passedt.railway == "level_crossing"   )) then
                Layer( "land1", true )
                Attribute( "class", "railway_" .. passedt.railway )
                append_name( passedt )
                MinZoom( 14 )
            else
-- ----------------------------------------------------------------------------
-- railway=turntable are a bit of a special case - they are all assumed to be
-- area features, and so are written here.
-- ----------------------------------------------------------------------------
                if ( passedt.railway == "turntable" ) then
                    Layer( "land1", true )
                    Attribute( "class", "railway_" .. passedt.railway )
                    append_name( passedt )
                    MinZoom( 14 )
                else
                    render_aerialway_land1( passedt )
                end -- railway=turntable 14
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
-- ----------------------------------------------------------------------------
-- For each of these we write out the area as "historic landuse" and then a 
-- separate named (if possible) "historic=blah" at the centroid.
-- ----------------------------------------------------------------------------
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
        ( passedt.historic == "milk_churn_stand"         ) or
        ( passedt.historic == "mill"                     ) or
        ( passedt.historic == "monument"                 ) or
        ( passedt.historic == "ship"                     ) or
        ( passedt.historic == "stocks"                   ) or
        ( passedt.historic == "tank"                     ) or
        ( passedt.historic == "tomb"                     ) or
        ( passedt.historic == "warmemorial"              ) or
        ( passedt.historic == "water_crane"              ) or
        ( passedt.historic == "water_pump"               ) or
        ( passedt.historic == "watermill"                ) or
        ( passedt.historic == "well"                     ) or
        ( passedt.historic == "windmill"                 ) or
        ( passedt.historic == "wreck"                    ) or
        ( passedt.historic == "mineshaft"                ) or
        ( passedt.historic == "nonspecific"              )) then
        Layer( "land1", true )
        Attribute( "class", "landuse_historic" )
        MinZoom( 14 )

        LayerAsCentroid( "land1" )
        Attribute( "class", "historic_" .. passedt.historic )
        append_name( passedt )
        MinZoom( 14 )
    else
        render_landuse_land1( passedt )
    end -- historic=archaeological_site etc. 14
end -- render_historic_land1()

function render_landuse_land1( passedt )
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- 
-- The same display code can interpret "both features" without having to read
-- it from a separate layer.
-- ----------------------------------------------------------------------------
    if (( passedt.landuse == "forest"          ) or
        ( passedt.landuse == "farmland"        )) then
        Layer( "land1", true )
        Attribute( "class", "landuse_" .. passedt.landuse )
        MinZoom( 8 )

        LayerAsCentroid( "land1" )
        Attribute( "class", "landuse_" .. passedt.landuse )
        append_name( passedt )
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

            if ( passedt.way_area > 141284 ) then
                minzoom = 9
            else
                if ( passedt.way_area > 71668 ) then
                    minzoom = 10
                else
                    if ( passedt.way_area > 12853 ) then
                        minzoom = 11
                    else
                        if ( passedt.way_area > 2584 ) then
                            minzoom = 12
                        else
                            minzoom = 13
                        end
                    end
                end
            end

            MinZoom( minzoom )

            LayerAsCentroid( "land1" )
            Attribute( "class", "landuse_" .. passedt.landuse )
            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
            append_name( passedt )
            MinZoom( minzoom )
        else
            if (( passedt.landuse == "village_green"          ) or
                ( passedt.landuse == "quarry"                 ) or
                ( passedt.landuse == "historicquarry"         )) then
                Layer( "land1", true )
                Attribute( "class", "landuse_" .. passedt.landuse )
                MinZoom( 10 )

                LayerAsCentroid( "land1" )
                Attribute( "class", "landuse_" .. passedt.landuse )
                AttributeNumeric( "way_area", math.floor( passedt.way_area ))
                append_name( passedt )
                MinZoom( 10 )
            else
-- ----------------------------------------------------------------------------
-- These are considered by the code "not large" landuse areas and get the name
-- written as part of the name feature.
-- ----------------------------------------------------------------------------
                if ( passedt.landuse == "garages" ) then
                    Layer( "land1", true )
                    Attribute( "class", "landuse_" .. passedt.landuse )
                    append_name( passedt )
                    MinZoom( 11 )
                else
                    if ( passedt.landuse == "vineyard" ) then
                        Layer( "land1", true )
                        Attribute( "class", "landuse_" .. passedt.landuse )
                        append_name( passedt )
                        MinZoom( 12 )
                    else
                        if ( passedt.landuse == "conservation" ) then
                            Layer( "land1", true )
                            Attribute( "class", "landuse_" .. passedt.landuse )
                            MinZoom( 13 )

                            LayerAsCentroid( "land1" )
                            Attribute( "class", "landuse_" .. passedt.landuse )
                            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
                            append_name( passedt )
                            MinZoom( 13 )
                        else
                            if ( passedt.landuse == "industrialbuilding" ) then
                                Layer( "land1", true )
                                Attribute( "class", "landuse_" .. passedt.landuse )
                                append_name( passedt )
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
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- 
-- The same display code can interpret "both features" without having to read
-- it from a separate layer.
-- ----------------------------------------------------------------------------
    if ( passedt.leisure == "nature_reserve" ) then
        Layer( "land1", true )
        Attribute( "class", "leisure_" .. passedt.leisure )

        if ( passedt.way_area > 282314432 ) then
            minzoom = 6
        else
            if ( passedt.way_area > 9514089 ) then
                minzoom = 7
            else
                if ( passedt.way_area > 1357096 ) then
                    minzoom = 8
                else
                    minzoom = 9
                end
            end
        end

        MinZoom( minzoom )

        if (( passedt.name ~= nil ) and
            ( passedt.name ~= ""  )) then
            LayerAsCentroid( "land1" )
            Attribute( "class", "leisure_" .. passedt.leisure )
            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
            Attribute( "name", passedt.name )
            MinZoom( minzoom )
        end
    else
        if ((  passedt.leisure == "common"            ) or
            (  passedt.leisure == "dog_park"          ) or
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

            if ( passedt.way_area > 141284 ) then
                minzoom = 9
            else
                if ( passedt.way_area > 71668 ) then
                    minzoom = 10
                else
                    if ( passedt.way_area > 12853 ) then
                        minzoom = 11
                    else
                        if ( passedt.way_area > 2584 ) then
                            minzoom = 12
                        else
                            minzoom = 13
                        end
                    end
                end
            end

            MinZoom( minzoom )

            LayerAsCentroid( "land1" )
            Attribute( "class", "leisure_" .. passedt.leisure )
            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
            append_name( passedt )
            MinZoom( minzoom )
        else
            if (( passedt.leisure == "playground" ) or
                ( passedt.leisure == "schoolyard" )) then
                Layer( "land1", true )
                Attribute( "class", "leisure_" .. passedt.leisure )
                MinZoom( 12 )

                LayerAsCentroid( "land1" )
                Attribute( "class", "leisure_" .. passedt.leisure )
                append_name( passedt )
                MinZoom( 12 )
            else
                if ( passedt.leisure == "swimming_pool" ) then
                    Layer( "land1", true )
                    Attribute( "class", "leisure_" .. passedt.leisure )
                    MinZoom( 13 )

                    LayerAsCentroid( "land1" )
                    Attribute( "class", "leisure_" .. passedt.leisure )
                    append_name( passedt )
                    MinZoom( 13 )
                else
-- ----------------------------------------------------------------------------
-- Actually, we don't expect leisure=leisurenonspecific will have a fill at 
-- all, but write out a polygon just in case.
-- ----------------------------------------------------------------------------
                    if ( passedt.leisure == "leisurenonspecific" ) then
                        Layer( "land1", true )
                        Attribute( "class", "leisure_" .. passedt.leisure )
                        MinZoom( 14 )

                        if (( passedt.name ~= nil ) and
                            ( passedt.name ~= ""  )) then
                            LayerAsCentroid( "land1" )
                            Attribute( "class", "leisure_" .. passedt.leisure )
                            Attribute( "name", passedt.name )
                            MinZoom( 14 )
                        end
                    else
-- ----------------------------------------------------------------------------
-- These are considered by the code "not large" landuse areas and get the name
-- written as part of the name feature.
-- ----------------------------------------------------------------------------
                        if (( passedt.leisure == "bandstand"          ) or
                            ( passedt.leisure == "bleachers"          ) or
                            ( passedt.leisure == "fitness_station"    ) or
                            ( passedt.leisure == "picnic_table"       ) or
                            ( passedt.leisure == "slipway"            ) or
                            ( passedt.leisure == "bird_hide"          ) or
                            ( passedt.leisure == "hunting_stand"      ) or
                            ( passedt.leisure == "grouse_butt"        )) then
                            Layer( "land1", true )
                            Attribute( "class", "leisure_" .. passedt.leisure )
                            append_name( passedt )
                            MinZoom( 14 )
                        else
                            render_military_land1( passedt )
                        end -- leisure=bandstand etc. 14
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
        append_name( passedt )
        MinZoom( 9 )
    else
        render_natural_land1( passedt )
    end
end -- render_military_land1()

function render_natural_land1( passedt )
    if ( passedt.natural == "desert" ) then
        Layer( "land1", true )
        Attribute( "class", "natural_" .. passedt.natural )
        append_name( passedt )
        MinZoom( 7 )
    else
        if (( passedt.natural == "wood"         ) or
            ( passedt.natural == "broadleaved"  ) or
            ( passedt.natural == "needleleaved" ) or
            ( passedt.natural == "mixedleaved"  ) or
            ( passedt.natural == "bigprompeak"  )) then
            Layer( "land1", true )
            Attribute( "class", "natural_" .. passedt.natural )
            MinZoom( 8 )

            LayerAsCentroid( "land1" )
            Attribute( "class", "natural_" .. passedt.natural )
            AttributeNumeric( "way_area", math.floor( passedt.way_area ))
            append_name( passedt )

            if (( passedt.ele ~= nil ) and
                ( passedt.ele ~= ""  )) then
                 Attribute( "ele", passedt.ele )
            end

            MinZoom( 8 )
        else
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- 
-- The same display code can interpret "both features" without having to read
-- it from a separate layer.
-- ----------------------------------------------------------------------------
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

                if ( passedt.way_area > 141284 ) then
                    minzoom = 9
                else
                    if ( passedt.way_area > 71668 ) then
                        minzoom = 10
                    else
                        if ( passedt.way_area > 12853 ) then
                            minzoom = 11
                        else
                            if ( passedt.way_area > 2584 ) then
                                minzoom = 12
                            else
                                minzoom = 13
                            end
                        end
                    end
                end

                MinZoom( minzoom )

                LayerAsCentroid( "land1" )
                Attribute( "class", "natural_" .. passedt.natural )
                Attribute( "name", passedt.name )
                MinZoom( minzoom )
            else
                if ( passedt.natural == "bigpeak" ) then
                    Layer( "land1", true )
                    Attribute( "class", "natural_" .. passedt.natural )
                    append_name( passedt )

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
                        append_name( passedt )

                        if (( passedt.ele ~= nil ) and
                            ( passedt.ele ~= ""  )) then
                            Attribute( "ele", passedt.ele )
                        end

                        MinZoom( 10 )
                    else
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- ----------------------------------------------------------------------------
                        if (( passedt.natural == "wetland"  ) or
                            ( passedt.natural == "reef"     ) or
                            ( passedt.natural == "reefsand" )) then
                            Layer( "land1", true )
                            Attribute( "class", "natural_" .. passedt.natural )
                            MinZoom( 12 )

                            if (( passedt.name ~= nil ) and
                                ( passedt.name ~= ""  )) then
                                LayerAsCentroid( "land1" )
                                Attribute( "class", "natural_" .. passedt.natural )
                                Attribute( "name", passedt.name )
                                MinZoom( 12 )
                            end
                        else
                            if ( passedt.natural == "hill" ) then
                                Layer( "land1", true )
                                Attribute( "class", "natural_" .. passedt.natural )
                                append_name( passedt )

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
                                    append_name( passedt )
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
                                        append_name( passedt )
                                        MinZoom( 14 )
                                    else
                                        render_barrier_land1( passedt )
                                    end -- cave_entrance etc. 14
                                end -- bay etc. 13
                            end -- hill 12
                        end -- wetland etc. 12
                    end -- peak etc. 10
                end -- bigpeak 10
            end -- beach etc. 9
        end -- wood 8
    end -- desert 7
end -- render_natural_land1()

-- ----------------------------------------------------------------------------
-- hedges are only written to this if they're closed hedge areas.
-- hedges around some other area type (e.g. "landuse=farmland") have been
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
        append_name( passedt )
        MinZoom( 14 )
    else
        render_waterway_land1( passedt )
    end -- barrier=cattle_grid etc. 15
end -- render_barrier_land1()

function render_waterway_land1( passedt )
    if ( passedt.waterway == "damarea" ) then
        Layer( "land1", true )
        Attribute( "class", "waterway_" .. passedt.waterway )
        MinZoom( 10 )

        LayerAsCentroid( "land1" )
        Attribute( "class", "waterway_" .. passedt.waterway )
        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
        append_name( passedt )
        MinZoom( 10 )
    else
        if ( passedt.waterway == "lock_gate" ) then
            Layer( "land1", true )
            Attribute( "class", "waterway_" .. passedt.waterway )
            append_name( passedt )
            MinZoom( 14 )
        else
            render_power_land1( passedt )
        end -- waterway=lock_gate 14
    end -- waterway=damarea 10
end -- render_waterway_land1()

function render_power_land1( passedt )
    if (( passedt.power == "station"   ) or
        ( passedt.power == "generator" )) then
        Layer( "land1", true )
        Attribute( "class", "power_" .. passedt.power )
        append_name( passedt )
        MinZoom( 9 )
    else
        if ( passedt.power == "substation" ) then
            Layer( "land1", true )
            Attribute( "class", "power_" .. passedt.power )
            append_name( passedt )
            MinZoom( 12 )
        else
            if (( passedt.power == "tower" ) or
                ( passedt.power == "pole"  )) then
                Layer( "land1", true )
                Attribute( "class", "power_" .. passedt.power )
                MinZoom( 14 )
            else
                render_tourism_land1( passedt )
            end -- power=tower etc. 14
        end -- power=substation 12
    end -- power=generator 9
end -- render_power_land1()

function render_tourism_land1( passedt )
    if ( passedt.tourism == "attraction" ) then
        Layer( "land1", true )
        Attribute( "class", "tourism_" .. passedt.tourism )
        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
        append_name( passedt )
        MinZoom( 9 )
    else
-- ----------------------------------------------------------------------------
-- Some zoom 12 tourist things tend to be just points, so we don't extract the
-- centroid separately ...
-- ----------------------------------------------------------------------------
        if (( passedt.tourism == "picnic_site"  ) or
            ( passedt.tourism == "theme_park"   ) or
            ( passedt.tourism == "alpine_hut"   )) then
            Layer( "land1", true )
            Attribute( "class", "tourism_" .. passedt.tourism )
            append_name( passedt )
            MinZoom( 12 )
        else
-- ----------------------------------------------------------------------------
-- ... but some can be large areas, so to do extract the centroid separately ...
-- -----------------------------------------------------------------------------
            if (( passedt.tourism == "camp_site"    ) or
                ( passedt.tourism == "caravan_site" )) then
                Layer( "land1", true )
                Attribute( "class", "tourism_" .. passedt.tourism )
                append_name( passedt )
                MinZoom( 12 )

                LayerAsCentroid( "land1" )
                Attribute( "class", "tourism_" .. passedt.tourism )
                AttributeNumeric( "way_area", math.floor( passedt.way_area ))
                append_name( passedt )
                MinZoom( 12 )
            else
-- ----------------------------------------------------------------------------
-- Most zoom 14 tourist things tend to be just points, so we don't extract the
-- centroid separately ...
-- ----------------------------------------------------------------------------
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
                    ( passedt.tourism == "zoo"                        ) or
                    ( passedt.tourism == "advertising_column"         ) or
                    ( passedt.tourism == "artwork"                    ) or
                    ( passedt.tourism == "singlechalet"               ) or
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
                    append_name( passedt )

                    if (( passedt.ele ~= nil ) and
                        ( passedt.ele ~= ""  )) then
                         Attribute( "ele", passedt.ele )
                    end

                    MinZoom( 14 )
                else
-- ----------------------------------------------------------------------------
-- ... but some can be large areas, so to do extract the centroid separately ...
-- ----------------------------------------------------------------------------
                    if (( passedt.tourism == "motel"                      ) or
                        ( passedt.tourism == "hotel"                      )) then
                        Layer( "land1", true )
                        Attribute( "class", "tourism_" .. passedt.tourism )
                        MinZoom( 14 )

                        LayerAsCentroid( "land1" )
                        Attribute( "class", "tourism_" .. passedt.tourism )
                        AttributeNumeric( "way_area", math.floor( passedt.way_area ))
                        append_name( passedt )

                        if (( passedt.ele ~= nil ) and
                            ( passedt.ele ~= ""  )) then
                             Attribute( "ele", passedt.ele )
                        end

                        MinZoom( 14 )
                    else
                        render_aeroway_land1( passedt )
                    end -- tourism=hotel etc. 14
                 end -- tourism=viewpoint etc. 14
            end -- tourism=camp_site etc. 12
       end -- tourism=picnic_site etc. 12
    end -- tourism=zoo 9
end -- render_tourism_land1()

function render_aeroway_land1( passedt )
    if (( passedt.aeroway == "grass_runway" ) or
        ( passedt.aeroway == "runway"       )) then
        Layer( "land1", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        append_name( passedt )
        MinZoom( 10 )
    else
        if (( passedt.aeroway == "apron"   ) or
            ( passedt.aeroway == "taxiway" )) then
            Layer( "land1", true )
            Attribute( "class", "aeroway_" .. passedt.aeroway )
            append_name( passedt )
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
    if ( passedt.natural == "flood_prone" ) then
        Layer( "land2", true )
        Attribute( "class", "natural_" .. passedt.natural )
        append_name( passedt )
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
            ( passedt.landuse == "unnamedothercemetery"      )) then
            Layer( "land2", true )
            Attribute( "class", "landuse_" .. passedt.landuse )
            MinZoom( 9 )
        else
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- 
-- The same display code can interpret "both features" without having to read
-- it from a separate layer.
-- ----------------------------------------------------------------------------
            if ( passedt.landuse == "military" ) then
                Layer( "land2", true )
                Attribute( "class", "landuse_" .. passedt.landuse )
                MinZoom( 9 )

                LayerAsCentroid( "land2" )
                Attribute( "class", "landuse_" .. passedt.landuse )
                AttributeNumeric( "way_area", math.floor( passedt.way_area ))
                append_name( passedt )
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
                        append_name( passedt )
                        MinZoom( 13 )
                    else
                        render_leisure_land2( passedt )
                    end -- landuse=harbour 13
                end -- landuse=unnamedquarry 10
            end -- landuse=military 10
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
            append_name( passedt )
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
-- ----------------------------------------------------------------------------
-- For large landuse areas we write the polygon out without the name, and then
-- the name on just the centroid.
-- 
-- The same display code can interpret "both features" without having to read
-- it from a separate layer.
-- ----------------------------------------------------------------------------
    if (( passedt.aeroway == "aerodrome"       ) or
        ( passedt.aeroway == "large_aerodrome" )) then
        Layer( "land2", true )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        MinZoom( 12 )

        LayerAsCentroid( "land2" )
        Attribute( "class", "aeroway_" .. passedt.aeroway )
        append_name( passedt )
        MinZoom( 12 )
    else
        render_boundary_land2( passedt )
    end -- aeroway=aerodrome 12
end -- render_aeroway_land2()

function render_boundary_land2( passedt )
    if (( passedt.boundary == "national_park" ) and
        ( passedt.is_closed                   )) then
        Layer( "land2", true )
        Attribute( "class", "boundary_" .. passedt.boundary )
        MinZoom( 6 )

        LayerAsCentroid( "land2" )
        Attribute( "class", "boundary_" .. passedt.boundary )
        append_name( passedt )
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


