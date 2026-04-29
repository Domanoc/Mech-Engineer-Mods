------------------------------------------------------------------------------
--- DATABASE FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Database.
---@type ModFrameworkDatabase
local Database = {}

---Access to the private functions in this file.
---@class ModFrameworkDatabasePrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Adds a new mech to the games obj_database
---@param mechData MechCreationData dataset for adding a new mech
function Database.AddMech(mechData)
	local component = Common.GetModdedComponent(mechData.ReferenceName, Types.ComponentTypes.Mech)
	if (component ~= nil) then
		local newName = string.sub(mechData.ReferenceName.."_"..tostring(irandom_range(1000, 10000000)), 1, -3)
		local message = "Trying to add a new component, but the reference name was already used.\n"
		message = message.."Please provide a reference name that is unique, consider adding a prefix or suffix referencing your mod to prevent other mods from using the same name.\n\n"
		message = message.."Debug info:\nName given: "..mechData.ReferenceName.."\nGenerated name: "..newName
		Common.ShowError(message)
		mechData.ReferenceName = newName
	end

	local obj_database = Common.GetObjDatabase()

	--Copy the array to the working set
	local mech_stat = obj_database.mech_stat
	local mechIndex = #mech_stat + 1
	local mech = ds_map_create()

	--ENGINEERING PRICE
	ds_map_add(mech, "price_metallite",	mechData.PriceMetallite)
	ds_map_add(mech, "price_bjorn",		mechData.PriceBjorn)
	ds_map_add(mech, "price_munilon",	mechData.PriceMunilon)
	ds_map_add(mech, "price_skalaknit",	mechData.PriceSkalaknit)
	ds_map_add(mech, "price_staff",		mechData.PriceStaff)
	ds_map_add(mech, "days",			mechData.ProductionDays)

	--RESISTANCES
	ds_map_add(mech, "heat_resist",		mechData.HeatResist)
	ds_map_add(mech, "impact_resist",	mechData.ImpactResist)
	ds_map_add(mech, "current_resist",	mechData.CurrentResist)

	--STATS
	ds_map_add(mech, "hp", 				1000)  --1000 is the default for all mechs, not sure if the game does something with this value
	ds_map_add(mech, "armor",			mechData.PassiveArmor)
	ds_map_add(mech, "weight",			mechData.Weight)
	ds_map_add(mech, "speed",			mechData.Speed)
	ds_map_add(mech, "reload_time",		mechData.ReloadTime)
	ds_map_add(mech, "battle_time",		mechData.BattleTime)

	--MODULE CELLS
	Private.AddCells(mech, mechData.MechCells)

	--SPRITES
	--small sprite
	local smallSpriteIndex = Common.AddSprite(mechData.SpriteSmall, 0, false, false, 23, 49)
	ds_map_add(mech, "sprite_small", smallSpriteIndex)
	--big sprite
	ds_map_add(mech, "sprite_big", Common.AddSprite(mechData.SpriteBig, 0, false, false, 200, 343))
	--battle sprite
	ds_map_add(mech, "sprite_battle", Common.AddSprite(mechData.SpriteBattle, 2, true, false, 25, 25))
	--dead sprite
	ds_map_add(mech, "sprite_battle_dead", Common.AddSprite(mechData.SpriteBattleDead, 1, true, false, 25, 25))

	--Melee
	if (mechData.HasMelee) then
		if(mechData.SpriteMeleeVertical == nil) then
			local message = "Trying add a melee function to the mech. But the vertical melee sprite is missing.\n"
			message = message.."Please check the spritePath for 'SpriteMeleeVertical'.\n"
			message = message.."Debug info:\nMech reference name: "..mechData.ReferenceName
			Common.ShowError(message)
		end
		if(mechData.SpriteMeleeHorizontal == nil) then
			local message = "Trying add a melee function to the mech. But the horizontal melee sprite is missing.\n"
			message = message.."Please check the spritePath for 'SpriteMeleeHorizontal'.\n"
			message = message.."Debug info:\nMech reference name: "..mechData.ReferenceName
			Common.ShowError(message)
		end

		ds_map_add(mech, "melee_option", mechData.HasMelee)
		--melee vertical sprite
		ds_map_add(mech, "sprite_battle_melee_ver", Common.AddSprite(mechData.SpriteMeleeVertical, 7, true, false, 25, 25))
		--melee horizontal sprite
		ds_map_add(mech, "sprite_battle_melee_hor", Common.AddSprite(mechData.SpriteMeleeHorizontal, 7, true, false, 25, 25))
	end

	--Add the map the the list
	mech_stat[mechIndex] = mech

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ReferenceName = mechData.ReferenceName,
		ComponentType = Types.ComponentTypes.Mech,
		ComponentSize = mechData.ComponentSize,
		DatabaseIndex = mechIndex,
		ResourceNumber = mechIndex - 1,
		IsResearched = mechData.IsResearched,
		CanBeConstructed = mechData.CanBeConstructed,
		GiveFreeItem = mechData.GiveFreeItem,
		SpriteIndex = smallSpriteIndex,
	}
	table.insert(Storage.ModdedComponentList, moddedComponent)

	--return new data
	obj_database.mech_stat = mech_stat
end

---Adds the Cell data to the ds_map of the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cells MechCell[] the cell data array for the mech
function Private.AddCells(mech, cells)
	local auxCount = 0
	local weaponCount = 0

	for i = 1, #cells, 1 do
		local cell = cells[i]
		Private.AddCell(mech, i, cell)

		if(cell.ModuleType == Types.MechModules.Aux) then
			auxCount = auxCount + 1
		end
		if(cell.ModuleType == Types.MechModules.Weapon) then
			weaponCount = weaponCount + 1
		end
	end

	if (weaponCount > 12) then
		local message = "Trying add more than 12 weapons to a mech.\n"
		message = message.."Adding more than 12 weapons will result in the game crashing when the mech enters combat.\n"
		message = message.."Debug info:\nWeapon count: "..weaponCount
		Common.ShowError(message)
	end

	ds_map_add(mech, "number_of_aux",	  auxCount)
	ds_map_add(mech, "number_of_weapons", weaponCount)
	ds_map_add(mech, "number_of_cells",   #cells)
end

---Adds a new cell to the ds_map for the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cell_num number the number of the newly added cell
---@param cell MechCell the data for the cell
function Private.AddCell(mech, cell_num, cell)
	ds_map_add(mech, "cell_"..cell_num, 	cell.ModuleType)
	ds_map_add(mech, "cell_x_"..cell_num, 	cell.X)
	ds_map_add(mech, "cell_y_"..cell_num, 	cell.Y)
end

---Add a new weapon to the games obj_database
---@param weaponData WeaponCreationData
function Database.AddWeapon(weaponData)
	local component = Common.GetModdedComponent(weaponData.ReferenceName, Types.ComponentTypes.Weapon)
	if (component ~= nil) then
		local newName = string.sub(weaponData.ReferenceName.."_"..tostring(irandom_range(1000, 10000000)), 1, -3)
		local message = "Trying to add a new component, but the reference name was already used.\n"
		message = message.."Please provide a reference name that is unique, consider adding a prefix or suffix referencing your mod to prevent other mods from using the same name.\n\n"
		message = message.."Debug info:\nName given: "..weaponData.ReferenceName.."\nGenerated name: "..newName
		Common.ShowError(message)
		weaponData.ReferenceName = newName
	end

	local obj_database = Common.GetObjDatabase()

	--Copy the array to the working set
	local weapon_stat = obj_database.weapon_stat
	local weaponIndex = #weapon_stat + 1
	local weapon = ds_map_create()

	--ENGINEERING PRICE
	ds_map_add(weapon, "price_metallite",	weaponData.PriceMetallite)
	ds_map_add(weapon, "price_bjorn",		weaponData.PriceBjorn)
	ds_map_add(weapon, "price_munilon",		weaponData.PriceMunilon)
	ds_map_add(weapon, "price_skalaknit",	weaponData.PriceSkalaknit)
	ds_map_add(weapon, "price_staff",		weaponData.PriceStaff)
	ds_map_add(weapon, "days",				weaponData.ProductionDays)

	--STATS
	ds_map_add(weapon, "hp",				1000)	--a default value the game doesn't seem to use.
	ds_map_add(weapon, "number",			3)		--doesn't seem to do anything
	ds_map_add(weapon, "type",				weaponData.WeaponType)
	ds_map_add(weapon, "start_fire_speed",	weaponData.FireRate)
	ds_map_add(weapon, "start_weight",		weaponData.Weight)
	ds_map_add(weapon, "start_accuracy",	weaponData.Accuracy)
	ds_map_add(weapon, "start_energy",		weaponData.EnergyCost)
	ds_map_add(weapon, "start_damage",		weaponData.Damage)
	ds_map_add(weapon, "start_penetration",	weaponData.Penetration)
	ds_map_add(weapon, "start_speed",		weaponData.ProjectileSpeed)
	ds_map_add(weapon, "energy_buffed",		weaponData.IsEnergyBuffed)

	--SPRITES
	--small sprite
	local smallSpriteIndex = Common.AddSprite(weaponData.SpriteSmall, 0, false, false, 0, 0)
	ds_map_add(weapon, "sprite", smallSpriteIndex)
	--huge sprite
	local hugeSpriteIndex = Common.AddSprite(weaponData.SpriteHuge, 0, false, false, 199, 134)
	--big sprite
	local bigSpriteIndex = Common.AddSprite(weaponData.SpriteBig, 0, false, false, 199, 134)
	--merge the big and huge sprites
	Common.MergeSprite(bigSpriteIndex, hugeSpriteIndex)
	ds_map_add(weapon, "sprite_big", bigSpriteIndex)

	--Add the map the the list
	weapon_stat[weaponIndex] = weapon

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ReferenceName = weaponData.ReferenceName,
		ComponentType = Types.ComponentTypes.Weapon,
		ComponentSize = weaponData.ComponentSize,
		DatabaseIndex = weaponIndex,
		ResourceNumber = weaponIndex - 1,
		IsResearched = weaponData.IsResearched,
		CanBeConstructed = weaponData.CanBeConstructed,
		GiveFreeItem = weaponData.GiveFreeItem,
		SpriteIndex = smallSpriteIndex,
		WeaponData = {
			Description = Common.GetLocalizedString("WeaponDescription", weaponData.ReferenceName, weaponData.Description),
			BlueLength = weaponData.BlueLength,
		},
	}
	table.insert(Storage.ModdedComponentList, moddedComponent)

	--return new data
	obj_database.weapon_stat = weapon_stat
end

---Add a new solenoid to the games obj_database
---@param solenoidData SolenoidCreationData
function Database.AddSolenoid(solenoidData)
	local component = Common.GetModdedComponent(solenoidData.ReferenceName, Types.ComponentTypes.Solenoid)
	if (component ~= nil) then
		local newName = string.sub(solenoidData.ReferenceName.."_"..tostring(irandom_range(1000, 10000000)), 1, -3)
		local message = "Trying to add a new component, but the reference name was already used.\n"
		message = message.."Please provide a reference name that is unique, consider adding a prefix or suffix referencing your mod to prevent other mods from using the same name.\n\n"
		message = message.."Debug info:\nName given: "..solenoidData.ReferenceName.."\nGenerated name: "..newName
		Common.ShowError(message)
		solenoidData.ReferenceName = newName
	end
	local obj_database = Common.GetObjDatabase()

	--Copy the array to the working set
	local solenoid_stat = obj_database.solenoid_stat
	local solenoidIndex = #solenoid_stat + 1
	local solenoid = ds_map_create()

	--ENGINEERING PRICE
	ds_map_add(solenoid, "price_metallite",	solenoidData.PriceMetallite)
	ds_map_add(solenoid, "price_bjorn",		solenoidData.PriceBjorn)
	ds_map_add(solenoid, "price_munilon",	solenoidData.PriceMunilon)
	ds_map_add(solenoid, "price_skalaknit",	solenoidData.PriceSkalaknit)
	ds_map_add(solenoid, "price_staff",		solenoidData.PriceStaff)
	ds_map_add(solenoid, "days",			solenoidData.ProductionDays)

	--STATS
	ds_map_add(solenoid, "hp",				1000)	--doesn't seem to do anything
	ds_map_add(solenoid, "power",			solenoidData.Power)
	ds_map_add(solenoid, "induction",		solenoidData.Induction)
	ds_map_add(solenoid, "weight",			2)		--cant find an effect on the reactor so i left it at the same value as a regular solenoid
	ds_map_add(solenoid, "type",			1)		--As far as i can see there is only type 1 for solenoids

	--SPRITE
	local spriteIndex = Common.AddSprite(solenoidData.Sprite, 0, false, false, 0, 0)
	ds_map_add(solenoid, "sprite", spriteIndex)

	--Add the map the the list
	solenoid_stat[solenoidIndex] = solenoid

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ReferenceName = solenoidData.ReferenceName,
		ComponentType = Types.ComponentTypes.Solenoid,
		ComponentSize = solenoidData.ComponentSize,
		DatabaseIndex = solenoidIndex,
		ResourceNumber = solenoidIndex - 1,
		IsResearched = solenoidData.IsResearched,
		CanBeConstructed = solenoidData.CanBeConstructed,
		GiveFreeItem = solenoidData.GiveFreeItem,
		SpriteIndex = spriteIndex,
	}
	table.insert(Storage.ModdedComponentList, moddedComponent)

	--return new data
	obj_database.solenoid_stat = solenoid_stat
end

---Add a new pilot template to the games obj_database
---@param pilotData PilotTemplateData the dataset for creating a new pilot template
function Database.AddPilotTemplate(pilotData)
	local duplicate = Common.GetPilotTemplateIndex(pilotData.Name)
	if (duplicate ~= nil) then
		local newName = string.sub(pilotData.Name.."_"..tostring(irandom_range(1000, 10000000)), 1, -3)
		local message = "Trying to add a new pilot template, but the reference name was already used.\n"
		message = message.."Please provide a reference name that is unique.\n\n"
		message = message.."Debug info:\nName given: "..pilotData.Name.."\nGenerated name: "..newName
		Common.ShowError(message)
		pilotData.Name = newName
	end

	local obj_database = Common.GetObjDatabase()

	--Copy the array to the working set
	local pilot_stat = obj_database.pilot_stat
	local pilotIndex = #pilot_stat + 1
	local pilot = ds_map_create()
	local sprite = Common.AddSprite(pilotData.Sprite, 4, false, false, 23, 23)

	ds_map_add(pilot, "hp",						1000);									  --doesn't seem to do anything
	ds_map_add(pilot, "type",					1);										  --Seems to be a default value
	ds_map_add(pilot, "name",					pilotData.Name);						  --the name of the pilot
	ds_map_add(pilot, "level",					pilotData.Level);						  --the level of the pilot
	ds_map_add(pilot, "level_ex",				pilotData.LevelExperience); 			  --the amount of experience in the current level
	ds_map_add(pilot, "stat_skill",				pilotData.Skill);						  --the skill stat of the pilot (0-100)
	ds_map_add(pilot, "stat_reaction",			pilotData.Reaction);					  --the reaction stat of the pilot (0-100)
	ds_map_add(pilot, "stat_vitality",			pilotData.Vitality);					  --the vitality stat of the pilot (0-100)
	ds_map_add(pilot, "stat_stress_resistance",	pilotData.StressResistance);			  --the stress resistance stat of the pilot (0-100)
	ds_map_add(pilot, "sound_index",			pilotData.Voice);						  --the voice used by the pilot
	ds_map_add(pilot, "phrase_num",				Common.GetPhraseNumber(pilotData.Voice)); --the voice used by the pilot
	ds_map_add(pilot, "sprite",					sprite);								  --the sprite sheet for the pilot

	--Add the map the the list
	pilot_stat[pilotIndex] = pilot

	--return new data
	obj_database.pilot_stat = pilot_stat
end

---Add a new custom component to the games obj_database
---@param componentData CustomComponentCreationData
function Database.AddCustomComponent(componentData)
	local componentType = Private.GetNextCustomComponentType()

	local spriteIndex = Common.AddSprite(componentData.Sprite, 0, false, false, 0, 0)

	---@type ModdedComponent
	local moddedComponent = {
		ReferenceName = componentData.ReferenceName,
		ComponentType = componentType,
		ComponentSize = componentData.ComponentSize,
		DatabaseIndex = 1,
		ResourceNumber = 1,
		IsResearched = componentData.IsResearched,
		CanBeConstructed = true, --The purpose of a custom component is the shop listing, so default true.
		GiveFreeItem = false, --We cant tell what the adding should do on custom items so false.
		SpriteIndex = spriteIndex,
		CustomData = {
			PriceMetallite = componentData.PriceMetallite,
			PriceBjorn = componentData.PriceBjorn,
			PriceMunilon = componentData.PriceMunilon,
			PriceSkalaknit = componentData.PriceSkalaknit,
			PriceStaff = componentData.PriceStaff,
			ProductionDays = componentData.ProductionDays,
			ShopDescription = componentData.ShopDescription
		}
	}
	table.insert(Storage.ModdedComponentList, moddedComponent)
end

---Gets the next custom component type
---@return number componentType the provided type that can be used
function Private.GetNextCustomComponentType()
	local next = Storage.NextCustomComponentType
	Storage.NextCustomComponentType = Storage.NextCustomComponentType + 1
	return next
end

------------------------------------------------------------------------------
--- EXPORT DATABASE ----------------------------------------------------------
------------------------------------------------------------------------------

return Database