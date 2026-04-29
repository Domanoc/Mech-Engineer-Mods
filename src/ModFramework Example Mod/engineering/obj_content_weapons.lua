
---One time script when the game is started
---@param q game_obj_content_weapons
function create(q)--one time script when save is loaded
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
	local baseWeapons = Mod.Types.BaseWeapons

	--We can retrieve the data of a modded component that was added by the framework, even if it was made by another mod.
	--however if loading one from another mod, that mod has to be before this mod in the load order.
	local example_weapon = Mod.Common.GetModdedComponent("example_weapon", componentTypes.Weapon)

	--We need to check for nil since a the component we searched for might not have existed.
	if(example_weapon ~= nil) then
		--example on how to add 2 weapons, one is +sized
		Mod.Engineering.AddWeapon(example_weapon.ResourceNumber, false)
		Mod.Engineering.AddWeapon(example_weapon.ResourceNumber, true)
	end

	--If we want to add a base weapon we can use the Mod.Types.BaseWeapons references to add the correct one
	Mod.Engineering.AddWeapon(baseWeapons.SIX_BARRELED_GUN, false)
	Mod.Engineering.AddWeapon(baseWeapons.ROCKET_SYSTEM, false)
	Mod.Engineering.AddWeapon(baseWeapons.TANK_GUN, false)
	Mod.Engineering.AddWeapon(baseWeapons.MISSILE_LAUNCHER, false)
	Mod.Engineering.AddWeapon(baseWeapons.HIGH_POWER_IMPULSE_LASER, false)
	Mod.Engineering.AddWeapon(baseWeapons.RAPID_FIRING_LASER, false)
	Mod.Engineering.AddWeapon(baseWeapons.FLAMETHROWER, false)
	Mod.Engineering.AddWeapon(baseWeapons.MASS_ACCELERATOR , false)
	Mod.Engineering.AddWeapon(baseWeapons.TESLA_CANNON, false)
	Mod.Engineering.AddWeapon(baseWeapons.PLASMA_ACCELERATOR, false)
	Mod.Engineering.AddWeapon(baseWeapons.TOXIN_SPRAYER, false)
	Mod.Engineering.AddWeapon(baseWeapons.PARTICLE_EMITTER, false)
end