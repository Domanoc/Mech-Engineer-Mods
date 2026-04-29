
---One time script when the game is started
---@param q game_obj_content_safety
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
	local baseSafety = Mod.Types.BaseSafety

	--If we want to add a base safety we can use the Mod.Types.BaseSafety references to add the correct one
	Mod.Engineering.AddSafety(baseSafety)
	Mod.Engineering.AddSafety(baseSafety)
end