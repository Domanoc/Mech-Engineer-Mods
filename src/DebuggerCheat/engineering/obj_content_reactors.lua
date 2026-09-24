
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
---@param q game_obj_content_reactor
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if (Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--load needed types
	local baseReactors = Mod.Types.BaseReactors

	--If we want to add a base reactor we can use the Mod.Types.BaseMechs references to add the correct one
	Mod.Engineering.AddReactor(baseReactors.Combustion)
	Mod.Engineering.AddReactor(baseReactors.Combustion)
	Mod.Engineering.AddReactor(baseReactors.Fission)
	Mod.Engineering.AddReactor(baseReactors.Fission)
	Mod.Engineering.AddReactor(baseReactors.Fusion)
	Mod.Engineering.AddReactor(baseReactors.Fusion)
end