
---One time script when the game is started
---@param q game_obj_content_motors
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
	local baseMotors = Mod.Types.BaseMotors

	--If we want to add a base motor we can use the Mod.Types.BaseMotors references to add the correct one
	Mod.Engineering.AddMotor(baseMotors.Combustion_1)
	Mod.Engineering.AddMotor(baseMotors.Combustion_1)
	Mod.Engineering.AddMotor(baseMotors.Combustion_2)
	Mod.Engineering.AddMotor(baseMotors.Combustion_2)
	Mod.Engineering.AddMotor(baseMotors.Electric_1)
	Mod.Engineering.AddMotor(baseMotors.Electric_1)
	Mod.Engineering.AddMotor(baseMotors.Electric_1)
	Mod.Engineering.AddMotor(baseMotors.Combustion_3)
	Mod.Engineering.AddMotor(baseMotors.Combustion_3)
	Mod.Engineering.AddMotor(baseMotors.Electric_2)
	Mod.Engineering.AddMotor(baseMotors.Electric_2)
	Mod.Engineering.AddMotor(baseMotors.Electric_3)
	Mod.Engineering.AddMotor(baseMotors.Electric_3)
end