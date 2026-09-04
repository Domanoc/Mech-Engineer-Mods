------------------------------------------------------------------------------
--- INTERNAL ENGINEERING FUNCTIONS -------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Engineering tab.
---@class ModFrameworkInternalEngineering
local Engineering = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalEngineeringPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Settings functions.
local Settings = require("ModFrameworkSettings")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Loads the needed engineering sprites.
---
---Used in the create function of obj_database.lua
function Engineering.LoadMenuSprites()
	local modPath = Common.GetModPathByName("ModFramework")
	Storage.SpritePartialMechButton = Common.AddSprite(modPath.."sprites\\PartialMech.png", 2, false, false, 0, 0)
end

---Give the option to start a partial construction of a mech, 
---when you don't have the required amount of staff to complete it.
---@param currentMech game_obj_big_holder_mech The mech being checked.
function Engineering.PartialMechEngineering(currentMech)
	local partialEngineering = Settings.GetBooleanSettingValue("PartialEngineering")
	if (partialEngineering == false) then
		return
	end

	local module_eng_move_cost = 8
	local res_staff = variable_global_get("res_staff")
	local isMechValid = Private.ValidateMech(currentMech)
	local staffCost = Private.GetMechEngineeringCost(currentMech)
	local canPartialAssemble = res_staff < staffCost and res_staff > module_eng_move_cost and isMechValid

	if (canPartialAssemble == true) then
		Private.DrawPartialMechButton(currentMech)
	end
end

---Draw the button to do the partial engineering.
---@param currentMech game_obj_big_holder_mech The mech being partially engineered.
function Private.DrawPartialMechButton(currentMech)
	local hitBoxX = 1378
	local hitBoxY = 762
	local hitBoxWidth = 46
	local hitBoxHeight = 46

	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local isButtonDown = 0
	if (mx > hitBoxX and
		mx < hitBoxX + hitBoxWidth and
		my > hitBoxY and
		my < hitBoxY + hitBoxHeight) then
		isButtonDown = 1
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			Private.PartiallyEngineerMech(currentMech)
		end
	end

	draw_sprite_ext(Storage.SpritePartialMechButton, isButtonDown, 1374, 760, 2, 2, 0, 16777215, 1)

	local maxAffordableStaff = Private.GetMaxAffordableEngineeringCost()

	draw_set_halign(1)
	draw_set_color(make_colour_rgb(218, 172, 57))
	draw_text_transformed(1398, 820, string.format("%g", maxAffordableStaff), 2, 2, 0)
end

---Update the mech and staff to do the partial engineering.
---@param currentMech game_obj_big_holder_mech The mech being partially engineered.
function Private.PartiallyEngineerMech(currentMech)
	local module_eng_move_cost = 8
	local res_staff = variable_global_get("res_staff")
	local res_staff_back = variable_global_get("res_staff_back")
	local maxAffordableStaff = Private.GetMaxAffordableEngineeringCost()

	res_staff = res_staff - maxAffordableStaff
	res_staff_back = res_staff_back + maxAffordableStaff
	variable_global_set("res_staff", res_staff)
	variable_global_set("res_staff_back", res_staff_back)

	local newChange = {}
	for _, value in ipairs(currentMech.mech_change_id) do
		if ((value == 1 or value == true) and
			maxAffordableStaff > 0) then
			value = false
			maxAffordableStaff = maxAffordableStaff - module_eng_move_cost
		end
		table.insert(newChange, value)
	end
	currentMech.mech_change_id = newChange
end

---Checks if a mech is valid to be constructed.
---@param currentMech game_obj_big_holder_mech The mech being checked.
---@return boolean valid True if a valid mech, false otherwise.
function Private.ValidateMech(currentMech)
	--Has reactor
	if (currentMech.have_reactor == false) then
		return false
	end

	--Has cabin
	if (currentMech.have_cabin == false) then
		return false
	end

	--Has at least one weapon
	if (currentMech.have_gun == false) then
		return false
	end

	--Is not overweight
	if currentMech.stat_weight > currentMech.stat_max_weight then
		return false
	end

	return true
end

---Get the cost of engineers to complete the mech.
---@param currentMech game_obj_big_holder_mech The mech being checked.
---@return number cost The engineer cost for the mech.
function Private.GetMechEngineeringCost(currentMech)
	local module_eng_move_cost = 8
	return currentMech.num_of_modules * module_eng_move_cost
end

---Get the max amount of staff that can be used to do a partial construction.
function Private.GetMaxAffordableEngineeringCost()
	local module_eng_move_cost = 8
	local res_staff = variable_global_get("res_staff")
	local maxAffordableStaff = math.floor(res_staff / module_eng_move_cost) * module_eng_move_cost
	return maxAffordableStaff
end

---Use in the draw_weapons function of obj_big_holder.lua
---
---Use in the draw_mechs function of obj_big_holder.lua
---
---Use in the battle_going_start function of obj_battle_map.lua
---
---Updates the given weapon with the modded range if applicable
---@param weapon game_obj_big_holder_weapon the weapon to update
function Engineering.SetWeaponRange(weapon)
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.ResourceNumber == weapon.weapon_number and
			component.ComponentType == Types.ComponentTypes.Weapon and
			component.WeaponData ~= nil) then
			weapon.blue_length = component.WeaponData.BlueLength
			return
		end
	end
end

---Use in the draw_weapons function of obj_big_holder.lua
---
---Use in the draw_mechs function of obj_big_holder.lua
---
---Use in the battle_going_start function of obj_battle_map.lua
---
---Updates the given weapon with the modded homing power if applicable
---@param weapon game_obj_big_holder_weapon the weapon to update
function Engineering.SetWeaponHoming(weapon)
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.ResourceNumber == weapon.weapon_number and
			component.ComponentType == Types.ComponentTypes.Weapon and
			component.WeaponData ~= nil) then
			if (component.WeaponData.HomingPower ~= nil) then
				weapon.homing_power = component.WeaponData.HomingPower
			end
			return
		end
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL ENGINEERING ----------------------------------------------
------------------------------------------------------------------------------

return Engineering