
---One time script when the game is started
---@param q game_obj_content_cabins
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
	local baseCabins = Mod.Types.BaseCabins

	--If we want to add a base cabin we can use the Mod.Types.BaseCabins references to add the correct one
	Mod.Engineering.AddCabin(baseCabins.Cabin_0)
	Mod.Engineering.AddCabin(baseCabins.Cabin_0)
	Mod.Engineering.AddCabin(baseCabins.Cabin_1)
	Mod.Engineering.AddCabin(baseCabins.Cabin_1)
	Mod.Engineering.AddCabin(baseCabins.Cabin_2)
	Mod.Engineering.AddCabin(baseCabins.Cabin_2)
	Mod.Engineering.AddCabin(baseCabins.Cabin_3)
	Mod.Engineering.AddCabin(baseCabins.Cabin_3)
	Mod.Engineering.AddCabin(baseCabins.Cabin_4)
	Mod.Engineering.AddCabin(baseCabins.Cabin_4)
	Mod.Engineering.AddCabin(baseCabins.Cabin_5)
	Mod.Engineering.AddCabin(baseCabins.Cabin_5)
end