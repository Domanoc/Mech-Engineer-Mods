
---One time script when the game is started
---@param q game_obj_pilot_item
---@param v_modid string
function create(q, v_modid)
	--Does not get triggered
end

---Triggers only when a new game starts
---ini file loads here to get stats from balance file, loading ini files inside create event breaks "load game" code
---@param q game_obj_pilot_item
function load_stats(q)
end

---Triggers on every pilot creation and on loading from a saved game
---ini file loads here to get translation, loading ini files inside create event breaks "load game" code
---@param q game_obj_pilot_item
function load_text(q)
	Internal = require("ModFrameworkInternal")
end

---before the code that changes stats when new day arrives
---@param q game_obj_pilot_item
function new_day_stats_start(q)
end

---after the code that changes stats when new day arrives
---@param q game_obj_pilot_item
function new_day_stats_end(q)
end

---every game tick during battle while mech is still alive
---@param q game_obj_pilot_item
function during_battle(q)
end

---draw call when the pilots hangar is open on the pilot tab
---@param q game_obj_pilot_item
function draw(q)
end
