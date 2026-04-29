
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
    --Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
    --THIS BREAKS BACKWARDS COMPATIBILITY
    --mods that assume there is an empty record to write to instead of creating there own will crash
    --I still think this option is better as the previous method is still fragile as there are not an unlimited number of free empty slots.
    --passing the limit would have thrown the same error
    Internal.Research.FixResearchPanelList()
end

---if activated = true
---@param q game_obj_research_panel
function step(q)
end

---if activated = true
---@param q game_obj_research_panel
function draw(q)
end