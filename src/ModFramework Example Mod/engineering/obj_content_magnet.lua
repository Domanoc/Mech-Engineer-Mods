
---One time script when the game is started
---@param q game_obj_content_magnet
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFramework")

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--load needed types
	local baseMagnets = Mod.Types.BaseMagnets

	--If we want to add a base magnet we can use the Mod.Types.BaseMagnets references to add the correct one
	Mod.Engineering.AddMagnet(baseMagnets.Curved)
	Mod.Engineering.AddMagnet(baseMagnets.Curved)
	Mod.Engineering.AddMagnet(baseMagnets.Horizontal)
	Mod.Engineering.AddMagnet(baseMagnets.Horizontal)
	Mod.Engineering.AddMagnet(baseMagnets.Vertical)
	Mod.Engineering.AddMagnet(baseMagnets.Vertical)
end