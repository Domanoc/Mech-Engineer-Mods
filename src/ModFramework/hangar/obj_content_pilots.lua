
---One time script when the game is started
---@param q game_obj_content_pilots
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
end

---inside the pilots menu
---@param q game_obj_content_pilots
function step_activated(q)
	Internal.Hangar.PilotClickListener()
end

---Triggers per frame per visible pilot that is drawn.
---Triggers before draw
---@param q game_obj_pilot_item
function draw_pilot(q)
end

---Triggers per frame
---@param q game_obj_content_pilots
function draw(q)
end