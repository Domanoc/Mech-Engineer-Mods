
---One time script when the game is started
---@param q game_obj_content_solenoid
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
	local componentTypes = Mod.Types.ComponentTypes
	local baseSolenoids = Mod.Types.BaseSolenoids

	--We can retrieve the data of a modded component that was added by the framework, even if it was made by another mod.
	--however if loading one from another mod, that mod has to be before this mod in the load order.
	local example_solenoid = Mod.Common.GetModdedComponent("example_solenoid", componentTypes.Solenoid)

	--We need to check for nil since a the component we searched for might not have existed.
	if(example_solenoid ~= nil) then
		--example on how to add 2 solenoids
		Mod.Engineering.AddSolenoid(example_solenoid.ResourceNumber)
		Mod.Engineering.AddSolenoid(example_solenoid.ResourceNumber)
	end

	--If we want to add a base solenoid we can use the Mod.Types.BaseSolenoids references to add the correct one
	Mod.Engineering.AddSolenoid(baseSolenoids.BrownSolenoid)
	Mod.Engineering.AddSolenoid(baseSolenoids.BlueSolenoid)
end