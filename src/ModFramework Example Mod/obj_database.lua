
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
    local ok, mod = pcall(require, "ModFramework")
    if (not ok or isLoaded ~= true) then
        local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check and correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
    end
    return mod
end

---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	--An example for creating mod settings.
	--Settings need to be registered before they can be used.
	--The mod should expect that the setting value can change during runtime.
	--Settings can be changed by the user in the mod settings menu, and the defaults can be overridden by the user.
	Mod.Settings.RegisterBooleanSetting("example_setting_a", false, { LocalizedDefaultValue = "Description for Setting A" })
	Mod.Settings.RegisterBooleanSetting("example_setting_b", true, { LocalizedDefaultValue = "Description for Setting B" })
	Mod.Settings.RegisterBooleanSetting("example_setting_c", false, { LocalizedDefaultValue = "Description for Setting C" })
	Mod.Settings.RegisterBooleanSetting("example_setting_d", true, { LocalizedDefaultValue = "Description for Setting D" })

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath()

	--load needed types
	local mechModules = Mod.Types.MechModules
	local componentSizes = Mod.Types.ComponentSizes
	local weaponTypes = Mod.Types.WeaponTypes

	--An example for creating a modded mech
	Mod.Database.AddMech({
		ReferenceName =    "example_mech",		 --The reference name of the mech, used to find its references
		ComponentSize =    componentSizes.Large, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	   false,				 --Set to true if its pre researched, else false.
		CanBeConstructed = true,				 --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	   true,				 --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =   1000,				 --The amount of metallite needed to produce this mech
		PriceBjorn = 	   1000,				 --The amount of bjorn needed to produce this mech
		PriceMunilon =     1000,				 --The amount of munilon needed to produce this mech
		PriceSkalaknit =   1000,				 --The amount of skalaknit needed to produce this mech
		PriceStaff = 	   10,					 --The amount of staff needed to produce this mech
		ProductionDays =   2,					 --The amount of days it takes to produce this mech
		HeatResist = 	   10,					 --The heat resist value of the mech
		ImpactResist =     10,					 --The impact resist value of the mech
		CurrentResist =    10,					 --The current resist value of the mech
		HasMelee = 	   	   true,				 --Indicates if the mech can use a melee weapon, if true the sprites for vertical and horizontal are expected
		PassiveArmor =     0,					 --The amount of passive armor the mech has
		Weight = 		   60,					 --The base weight of the mech
		Speed = 		   0.4,					 --The base speed of the mech
		ReloadTime = 	   3,					 --The base reload time of the mech
		BattleTime = 	   3,					 --The base battle time of the mech (the length of time it has ammo reserves for to shoot)
		MechCells = {
			{ModuleType = mechModules.Cabin, 	X =   0, Y = 22}, --cabin, the game is design for mechs to have only 1 cabin. adding more might result in issues	or unexpected behavior
			{ModuleType = mechModules.Reactor, 	X =   0, Y = 15}, --reactor, the game is design for mechs to have only 1 reactor. adding more might result in issues	or unexpected behavior
			{ModuleType = mechModules.Motor, 	X =   5, Y =  4}, --motor 1, you can add more motors.
			{ModuleType = mechModules.Motor, 	X =  -5, Y =  4}, --motor 2
			{ModuleType = mechModules.Motor, 	X =   5, Y =  9}, --motor 3
			{ModuleType = mechModules.Motor, 	X =  -5, Y =  9}, --motor 4
			{ModuleType = mechModules.Weapon, 	X =  10, Y = 16}, --gun 1, you can add a maximum of 12 guns, the game throws errors when a mech has more
			{ModuleType = mechModules.Weapon, 	X = -10, Y = 16}, --gun 2
			{ModuleType = mechModules.Aux, 		X =   6, Y = 23}, --aux 1, you can add more auxiliary slots.
			{ModuleType = mechModules.Aux, 		X =  -6, Y = 23}, --aux 2
		},
		SpritePathProduction = 		modFilepath.."sprites\\example_mech_production.png", 		--The filepath for the mech's production sprite. Used on the production tab. (expected 46x49 pixels)
		SpritePathBig = 			modFilepath.."sprites\\example_mech_big.png",				--The filepath for the mech's big sprite. Used in the engineering tab. (expected 398x343 pixels)
		SpritePathBattle = 		  	modFilepath.."sprites\\example_mech_battle.png",			--The filepath for the mech's battle sprite sheet. Used in while in battle. (expected 100x50 pixels, 2 frames)
		SpritePathDestroyed = 	  	modFilepath.."sprites\\example_mech_destroyed.png",			--The filepath for the mech's destroyed sprite. Used in while in destroyed battle. (expected 50x50 pixels)
		SpritePathMeleeVertical = 	modFilepath.."sprites\\example_mech_melee_vertical.png",    --The filepath for the mech's vertical melee sprite sheet. Used in while in melee combat. (expected 350x50 pixels, 7 frames). optional if the mech has no melee.
		SpritePathMeleeHorizontal = modFilepath.."sprites\\example_mech_melee_horizontal.png"   --The filepath for the mech's horizontal melee sprite sheet. Used in while in melee combat. (expected 350x50 pixels, 7 frames). optional if the mech has no melee.
	})

	--An example for creating a modded weapon
	Mod.Database.AddWeapon({
		ReferenceName = 	"example_weapon",	  --The reference name of the weapon, used to find its references
		Description = {							  --the description text for a weapon. used when the weapon is added to the main slot in engineering.
			--Data that represents a string that will be localized. Its recommended to be in english for code readability
			--The other actual values will be pulled from the mods localization files
			--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
			LocalizedDefaultValue = "Description text for this weapon."
		},
		ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    false,				  --Set to true if its pre researched, else false.
		CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =    1000,				  --The amount of metallite needed to produce this weapon
		PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this weapon
		PriceMunilon =      1000,				  --The amount of munilon needed to produce this weapon
		PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this weapon
		PriceStaff = 	    10,					  --The amount of staff needed to produce this weapon
		ProductionDays =    2,					  --The amount of days it takes to produce this weapon
		WeaponType =	    weaponTypes.Kinetic,  --the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
		FireRate =		    400,				  --the base fire rate. higher values offer a faster rate, 600 with full fire speed points will fill the fire speed bar completely
		Weight = 		    48,					  --the base weight of the weapon
		Accuracy = 		    5.0,				  --the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
		EnergyCost = 		5,					  --the base energy cost of the weapon
		Damage = 		    10,					  --the base damage value of the weapon
		Penetration = 	    1,					  --the base penetration value of the weapon
		ProjectileSpeed =   24,					  --the base projectile speed of the weapon
		IsEnergyBuffed =    false,				  --whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
		BlueLength =        0,					  --the range of a blue weapon, default is 750
		SpritePathProduction =	modFilepath.."sprites\\example_weapon_production.png",	--The filepath for the weapon's production sprite. Used on the production tab. (expected 56x24 pixels)
		SpritePathBig =			modFilepath.."sprites\\example_weapon_big.png",			--The filepath for the weapon's big sprite. Used on the engineering tab. (expected 796x134 pixels, 2 frames)
	})

	--An example for creating a modded solenoid
	Mod.Database.AddSolenoid({
		ReferenceName = "example_solenoid",		  --The reference name of the solenoid, used to find its references
		ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    false,				  --Set to true if its pre researched, else false.
		CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =    1000,				  --The amount of metallite needed to produce this solenoid
		PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this solenoid
		PriceMunilon =      1000,				  --The amount of munilon needed to produce this solenoid
		PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this solenoid
		PriceStaff = 	    10,					  --The amount of staff needed to produce this solenoid
		ProductionDays =    2,					  --The amount of days it takes to produce this solenoid
		Power = 		    2,					  --the power value of the solenoid, lower numbers give more heat resist on reactor
		Induction = 	    0.75,				  --the induction value of the solenoid, any deviation from 1 gives worse energy stats
		SpritePath = 		modFilepath.."sprites\\example_solenoid.png" --The filepath for the solenoid sprite. (expected 37x33 pixels)
	})

	--An example for creating a modded pilot template
	Mod.Database.AddPilotTemplate({
		Name = "EMOTICON",		 --The name of the pilot, also used as a value to lookup the reference, Recommended to use full uppercase as this is what the game does.
		Level = 1,				 --The level of the pilot.
		LevelExperience = 0,	 --The amount of experience in the current level.
		Skill = 42,				 --The skill stat of the pilot (0-100).
		Reaction = 30,			 --The reaction stat of the pilot (0-100).
		Vitality = 10,			 --The vitality stat of the pilot (0-100).
		StressResistance = 5,	 --The stress resistance stat of the pilot (0-100).
		Voice = "male_hispanic", --The voice used by the pilot.
		SpritePath = modFilepath.."sprites\\example_pilot.png" --The filepath for the pilot sprite sheet. (expected 184x46 pixels, 4 frames)
	})

	--An example for creating a custom component.
	--This is used when you need a component button in the shop that isn't linked to a standard game component.
	--It will handle the shop position, description and cost.
	--The result trigger needs to be done by the mod creator.
	Mod.Database.AddCustomComponent({
		ReferenceName = 	"example_custom_component", --The reference name of the custom component, used to find its references
		ComponentSize =     componentSizes.Small, 		--The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    false,				  		--Set to true if its pre researched, else false.
		PriceMetallite =    1000,				  		--The amount of metallite needed to produce this custom component
		PriceBjorn = 	    1000,				  		--The amount of bjorn needed to produce this custom component
		PriceMunilon =      1000,				  		--The amount of munilon needed to produce this custom component
		PriceSkalaknit =    1000,				  		--The amount of skalaknit needed to produce this custom component
		PriceStaff = 	    10,					  		--The amount of staff needed to produce this custom component
		ProductionDays =    2,					  		--The amount of days it takes to produce this custom component
		SpritePath = 		modFilepath.."sprites\\example_custom.png", --The filepath for the custom component sprite. (expected 48x48 pixels)
		ShopDescription = {
			--Add the lines that should be displayed in the shop description
			--We can add a maximum of 10 lines. More will overflow the shop window.
			--The label supports localization
			{ Label = { LocalizedDefaultValue = "CUSTOM ITEM" }, Value = 1 },
			{ Label = { LocalizedDefaultValue = "SOME STAT NAME" }, Value = 0.45 },
		}
	})

	--We can remove the starting mechs. This will only apply for new games.
	Mod.Hangar.RemoveStartingMechs()
end

---saving system deletes the file and creates new one before saving new info
---@param q any
function save_game_pre_event(q)
end

---@param q game_obj_database
function save_game_post_event(q)
end

---@param q game_obj_database
function load_game_pre_event(q)
end

---Called after the game is loaded
---@param q game_obj_database
function load_game_post_event(q)
end

---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	--Here are some functions to help with testing
	--Its recommended to remove these before releasing your mod
	local keys = Mod.Types.VirtualKeys
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all Research.")
		Mod.Research.UnlockAllResearch()
    end
	if keyboard_check_pressed(keys.F10) then
		Mod.Common.ShowMessage("Unlocking all components.")
		Mod.Production.UnlockAllShopComponents()
    end
	if keyboard_check_pressed(keys.F11) then
		--Debugger breakpoint
    end

	--The value of a setting can be retrieved like this
	local example_setting_a_value = Mod.Settings.GetBooleanSettingValue("example_setting_a")
	--We can then for example use it to toggle a feature
	if (example_setting_a_value == true) then
		--We can for example show some debug information when toggled.
		Mod.Common.DrawDebugCursor({{ Label = "Show the setting value", Value = example_setting_a_value }})
	end
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end