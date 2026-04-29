------------------------------------------------------------------------------
--- INTERNAL ENGINEERING FUNCTIONS -------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Engineering tab.
---@class ModFrameworkInternalEngineering
local Engineering = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

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

------------------------------------------------------------------------------
--- EXPORT INTERNAL ENGINEERING ----------------------------------------------
------------------------------------------------------------------------------

return Engineering