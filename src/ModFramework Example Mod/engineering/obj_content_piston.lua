
---One time script when the game is started
---@param q game_obj_content_piston
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
	local basePistons = Mod.Types.BasePistons

	--If we want to add a base piston we can use the Mod.Types.BasePistons references to add the correct one
	Mod.Engineering.AddPiston(basePistons.LowPressure)
	Mod.Engineering.AddPiston(basePistons.LowPressure)
	Mod.Engineering.AddPiston(basePistons.HighPressure)
	Mod.Engineering.AddPiston(basePistons.HighPressure)
end