
---One time script when the game is started
---construction table in the engineering menu
---module's id is in "cur_item"
---most submenus are inside obj_small_holder
---@param q game_obj_big_holder
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
end

---saves mech blueprint event. uses "data/f_mech_construction_slot"
---@param q game_obj_big_holder
function save_mech(q)
end

---loads mech blueprint event. uses "data/f_mech_construction_slot"
---@param q game_obj_big_holder
function load_mech(q)
end

---Triggers when the left mouse button is pressed
---@param q game_obj_big_holder
function activate_menu(q)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_mech
function draw_mechs(q,cur_item)
	for _, weapon in ipairs(cur_item.mass_gun_id) do
		if (weapon ~= -4) then --Filter nil values
			Internal.Engineering.SetWeaponRange(weapon)
			Internal.Engineering.SetWeaponHoming(weapon)
		end
	end

	Internal.Engineering.PartialMechEngineering(cur_item)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_reactor
function draw_reactors(q,cur_item)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_weapon
function draw_weapons(q,cur_item)
	Internal.Engineering.SetWeaponRange(cur_item)
	Internal.Engineering.SetWeaponHoming(cur_item)
end