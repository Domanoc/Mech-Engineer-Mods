
---One time script when the game is started
---@param q game_obj_battle_map
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.Battle.FixAudioTable(q)
end

---Triggers when the extraction countdown is happening
---Triggers every interval of 5%
---@param q game_obj_battle_map
function map_progression(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map
function creating_map_start(q)
	Internal.Battle.ResetAllyList()
	Internal.Battle.SetDefaultControlGroups()
end

---Triggers once per mech that is going into the battle
---@param q game_obj_battle_map
---@param q_pm any obj_ally(mech in the battle)
---@param q_om any obj_mech_item(mech card, contains IDs of all components and settings)
function creating_phy_mechs(q,q_pm,q_om)
end

---One time trigger before the battle start
---@param q game_obj_battle_map
function creating_map_middle(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map
function drawing_surf_gen_map(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map
function creating_map_end(q)
end

---when battle ends, mechs dead. for regular scout maps
---@param q any
function battle_end_scout_mechs_dead(q)
end

---when battle ends, mechs win. for regular scout maps
---@param q any
function battle_end_scout_win(q)
end

---@param q any
function battle_retreat(q)
end

---Triggers every frame of the battle even when the battle is paused
---@param q game_obj_battle_map
function battle_going_start(q)
	Internal.Battle.SetWeaponRange(q)
	Internal.Battle.SetWeaponHoming(q)
end

---Triggers every unpaused frame of the battle
---Triggers after battle_going_start
---@param q game_obj_battle_map
function battle_logic(q)
end

---Triggers every unpaused frame of the battle
---Triggers after battle_logic
---@param q game_obj_battle_map
function battle_end(q)
end

---Triggers every frame of the battle even when the battle is paused
---Triggers after battle_end
---@param q game_obj_battle_map
function battle_going_end(q)
end

---Triggers every frame
---Triggers after battle_going_end
---@param q game_obj_battle_map
function draw(q)
end

---Triggers every frame
---Triggers after draw
---@param q game_obj_battle_map
function draw_end(q)
	Internal.Battle.OverrideUnitSelections()
end