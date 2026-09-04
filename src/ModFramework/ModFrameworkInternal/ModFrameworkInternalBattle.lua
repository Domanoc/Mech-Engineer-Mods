------------------------------------------------------------------------------
--- INTERNAL BATTLE FUNCTIONS ------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Battle.
---@class ModFrameworkInternalBattle
local Battle = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalBattlePrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the internal functions for the Engineering tab.
local Engineering = require("ModFrameworkInternalEngineering")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Settings functions.
local Settings = require("ModFrameworkSettings")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

---The list of allies during a battle
---@type game_obj_ally[]
local battleAllies = {}

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


---If we add new mod weapons we need to recreate the sound tables.
---Else we will be hit with an out of range error when the weapon is used.
---So we get the stored amount of weapons from the database,
---and recreate the 2 sound tables.
---
---Used in the create function of obj_battle_map.lua
---@param obj_battle_map game_obj_battle_map the reference to the "obj_battle_map"
function Battle.FixAudioTable(obj_battle_map)
	local obj_database = Common.GetObjDatabase()
	local weaponCount = #obj_database.weapon_stat

	--recreate: main_data_sound
	local mainDataSound = {}
	for i = 1, weaponCount, 1 do
		mainDataSound[i] = {}
		for j = 1, 2, 1 do
			mainDataSound[i][j] = 0.0
		end
	end

	--recreate: weapon_data_sound
	local weaponDataSound = {}
	for i = 1, weaponCount, 1 do
		weaponDataSound[i] = {}
		for j = 1, 4, 1 do
			weaponDataSound[i][j] = 0.0
		end
	end

	--return the new sound tables
	obj_battle_map.main_data_sound = mainDataSound
    obj_battle_map.weapon_data_sound = weaponDataSound
	--We update main_sounds_amount as some mods,
	--use this a a starting point to update the sound table.
	--Amount seems to based on a 0 based index so 1 less that the amount_of_weapons
	obj_battle_map.main_sounds_amount = #mainDataSound - 1
end

---Updates the modded weapons with the modded range if applicable.
---
---Used in the battle_going_start function of obj_battle_map.lua
---@param q game_obj_battle_map the battle map reference
function Battle.SetWeaponRange(q)
	for _, mech in ipairs(q.mech_id) do 					--Loop all the mechs
		if (mech ~= -4 and mech ~= 0) then 					--Filter nil values
			for _, weapon in ipairs(mech.mass_gun_id) do 	--loop all the weapons of the mech
				if (weapon ~= -4) then 						--Filter nil values
					Engineering.SetWeaponRange(weapon)
				end
			end
		end
	end
end

---Updates the modded weapons with the modded homing power if applicable.
---
---Used in the battle_going_start function of obj_battle_map.lua
---@param q game_obj_battle_map the battle map reference
function Battle.SetWeaponHoming(q)
	for _, mech in ipairs(q.mech_id) do 					--Loop all the mechs
		if (mech ~= -4 and mech ~= 0) then 					--Filter nil values
			for _, weapon in ipairs(mech.mass_gun_id) do 	--loop all the weapons of the mech
				if (weapon ~= -4) then 						--Filter nil values
					Engineering.SetWeaponHoming(weapon)
				end
			end
		end
	end
end

---Creates the default control groups at the start of a battle
function Battle.SetDefaultControlGroups()
	local keys = Types.VirtualKeys
	Storage.BattleControlGroups = {
		{ VirtualKey = keys.BackQuote, Units = { 1,2,3,4,5,6,7,8 } },
		{ VirtualKey = keys.Number_1, Units = { 1 } },
		{ VirtualKey = keys.Number_2, Units = { 2 } },
		{ VirtualKey = keys.Number_3, Units = { 3 } },
		{ VirtualKey = keys.Number_4, Units = { 4 } },
		{ VirtualKey = keys.Number_5, Units = { 5 } },
		{ VirtualKey = keys.Number_6, Units = { 6 } },
		{ VirtualKey = keys.Number_7, Units = { 7 } },
		{ VirtualKey = keys.Number_8, Units = { 8 } },
	}
end

---Reset the ally mech internal list
function Battle.ResetAllyList()
	battleAllies = {}
end

---Register the ally mech to the internal list
---@param q game_obj_ally The ally mech to register.
function Battle.RegisterAlly(q)
	table.insert(battleAllies, q)
end

---Overrides the selection method with the rts style one.
---
---Used in the step_before_ai function of obj_ally.lua
---@param q game_obj_ally The mech.
function Battle.OverrideSelection(q)
	local isRTSSelectionStyleEnabled = Settings.GetBooleanSettingValue("RTSSelectionStyle")
	if (isRTSSelectionStyleEnabled == false) then
		return
	end
	q.selected = q.OverrideSelected
end

---Overrides the unit selection logic.
function Battle.OverrideUnitSelections()
	for _, ally in ipairs(battleAllies) do
		if (instance_exists(ally) == true) then
			Private.OverrideUnitSelection(ally)
		end
	end
end

---Overrides the unit selection logic per mech.
---@param q game_obj_ally The mech.
function Private.OverrideUnitSelection(q)
	local isCtrlPressed = keyboard_check(Types.VirtualKeys.Ctrl)
	local isShiftPressed = keyboard_check(Types.VirtualKeys.Shift)

	for _, group in ipairs(Storage.BattleControlGroups) do
		local isGroupPressed = keyboard_check_pressed(group.VirtualKey)
		local isUnitInGroup = Private.IsUnitInControlGroup(q.number, group.Units)

		if (isGroupPressed == true
			and isCtrlPressed == true) then
			if (q.OverrideSelected) then
				Private.AddUnitToControlGroup(q.number, group.Units)
			else
				group.Units = Private.RemoveUnitFromControlGroup(q.number, group.Units)
			end
		elseif (isGroupPressed == true) then
			if (isUnitInGroup == true) then
				q.OverrideSelected = true
			elseif (isShiftPressed == false) then
				q.OverrideSelected = false
			end
		end
	end
end

---Checks if the unit is part of the control group
---@param unit number The unit that is matched.
---@param group number[] The control group units.
---@return boolean found True if found, false otherwise.
function Private.IsUnitInControlGroup(unit, group)
	for _, value in ipairs(group) do
		if (unit == value) then
			return true
		end
	end
	return false
end

---Add a unit to the control group.
---@param unit number The unit that is matched.
---@param group number[] The control group units.
function Private.AddUnitToControlGroup(unit, group)
	local isPartOf = Private.IsUnitInControlGroup(unit, group)
	if (isPartOf == true) then
		return
	end
	table.insert(group, unit)
end

---Remove a unit from the control group.
---@param unit number The unit that is matched.
---@param group number[] The control group units.
---@return number[] group The modified group.
function Private.RemoveUnitFromControlGroup(unit, group)
	local newGroup = {}
	for _, value in ipairs(group) do
		if (unit ~= value) then
			table.insert(newGroup, value)
		end
	end
	return newGroup
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL BATTLE ---------------------------------------------------
------------------------------------------------------------------------------

return Battle