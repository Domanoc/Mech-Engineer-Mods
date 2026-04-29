
---One time script when the game is started
---@param q game_obj_content_injector
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFramework")

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--load needed types
	local baseInjectors = Mod.Types.BaseInjectors

	--If we want to add a base injector we can use the Mod.Types.BaseInjectors references to add the correct one
	Mod.Engineering.AddInjector(baseInjectors.LowPressure)
	Mod.Engineering.AddInjector(baseInjectors.LowPressure)
	Mod.Engineering.AddInjector(baseInjectors.HighPressure)
	Mod.Engineering.AddInjector(baseInjectors.HighPressure)
end