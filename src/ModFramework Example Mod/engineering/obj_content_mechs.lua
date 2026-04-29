
---One time script when the game is started
---@param q game_obj_content_mechs
---@param v_modid string
function create(q,v_modid) -- one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--load needed types
	local componentTypes = Mod.Types.ComponentTypes
	local baseMechs = Mod.Types.BaseMechs

	--We can retrieve the data of a modded component that was added by the framework, even if it was made by another mod.
	--however if loading one from another mod, that mod has to be before this mod in the load order.
	local example_mech = Mod.Common.GetModdedComponent("example_mech", componentTypes.Mech)

	--We need to check for nil since a the component we searched for might not have existed.
	if(example_mech ~= nil) then
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