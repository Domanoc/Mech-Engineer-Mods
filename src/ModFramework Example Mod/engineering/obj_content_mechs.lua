
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
    local ok, mod = pcall(require, "ModFramework")
    if (not ok or isLoaded ~= true) then
        local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check and correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
    end
    return mod
end

---One time script when the game is started
---@param q game_obj_content_mechs
---@param v_modid string
function create(q,v_modid) -- one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if (Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--We can remove all existing mechs
	Mod.Engineering.RemoveMechs()

	--load needed types
	local componentTypes = Mod.Types.ComponentTypes
	local baseMechs = Mod.Types.BaseMechs

	--We can retrieve the data of a modded component that was added by the framework, even if it was made by another mod.
	--however if loading one from another mod, that mod has to be before this mod in the load order.
	local example_mech = Mod.Common.GetModdedComponent("example_mech", componentTypes.Mech)

	--We need to check for nil since a the component we searched for might not have existed.
	if (example_mech ~= nil) then
		--example on how to add 2 mechs
		Mod.Engineering.AddMech(example_mech.ResourceNumber, "example_mech")
		Mod.Engineering.AddMech(example_mech.ResourceNumber, "example_mech")
	end

	--If we want to add a base mech we can use the Mod.Types.BaseMechs references to add the correct one
	Mod.Engineering.AddMech(baseMechs.Miner, "Extra Miner")
	Mod.Engineering.AddMech(baseMechs.Castle, "Extra Castle")
	Mod.Engineering.AddMech(baseMechs.Plate, "Extra Plate")
	Mod.Engineering.AddMech(baseMechs.Holo, "Extra Holo")
	Mod.Engineering.AddMech(baseMechs.Quadro, "Extra Quadro")
	Mod.Engineering.AddMech(baseMechs.Tentacle, "Extra Tentacle")
	Mod.Engineering.AddMech(baseMechs.Triangle, "Extra Triangle")
end