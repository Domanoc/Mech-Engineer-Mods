
---Check if the ModFramework can be found
function CheckForModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
	if isLoaded ~= true then
		local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check an correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
	end
end

---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Check if the ModFramework can be found
	CheckForModFramework()
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath()

	--load needed types
	local mechModules = Mod.Types.MechModules
	local componentSizes = Mod.Types.ComponentSizes
	local weaponTypes = Mod.Types.WeaponTypes

	Mod.Common.GenerateLocalizationFiles()

	------------------------------------------------------------------------------
	--- MECHS --------------------------------------------------------------------
	------------------------------------------------------------------------------
	Mod.Database.AddMech({
		ReferenceName =	   "CDC_NovaMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   400,
		PriceBjorn = 	   200,
		PriceMunilon =     320,
		PriceSkalaknit =   220,
		PriceStaff = 	   245,
		ProductionDays =   4,
		HeatResist = 	   20,
		ImpactResist =     15,
		CurrentResist =    40,
		HasMelee = 	   	   true,
		PassiveArmor =     2,
		Weight = 		   65,
		Speed = 		   0.4,
		ReloadTime = 	   3,
		BattleTime = 	   3,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 25} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 18} --reactor
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 11} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 11} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 16} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 16} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 18} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 18} --motor 6
			,{ModuleType = mechModules.Weapon, 	X =  14, Y = 20} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -14, Y = 20} --Weapon 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 21} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 21} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 27} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 27} --aux 4
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 27} --aux 5
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 27} --aux 6
			,{ModuleType = mechModules.Aux, 	X =   0, Y = 33} --aux 7
		},
		SpriteSmall = 			modFilepath.."sprites\\nova_small.png",
		SpriteBig = 			modFilepath.."sprites\\nova_big.png",
		SpriteBattle = 		  	modFilepath.."sprites\\nova_battle.png",
		SpriteBattleDead = 	  	modFilepath.."sprites\\nova_dead.png",
		SpriteMeleeVertical = 	modFilepath.."sprites\\nova_melee_vertical.png",
		SpriteMeleeHorizontal = modFilepath.."sprites\\nova_melee_horizontal.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_SentinelMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   1050,
		PriceBjorn = 	   730,
		PriceMunilon =     1030,
		PriceSkalaknit =   880,
		PriceStaff = 	   325,
		ProductionDays =   6,
		HeatResist = 	   25,
		ImpactResist =     90,
		CurrentResist =    80,
		HasMelee = 	   	   true,
		PassiveArmor =     5,
		Weight = 		   70,
		Speed = 		   0.2,
		ReloadTime = 	   4,
		BattleTime = 	   5,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 32} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 24} --reactor
			,{ModuleType = mechModules.Motor, 	X =   8, Y =  6} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -8, Y =  6} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   8, Y = 11} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -8, Y = 11} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 16} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 16} --motor 6
			,{ModuleType = mechModules.Weapon, 	X =  14, Y = 22} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -14, Y = 22} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =   7, Y = 41} --Weapon 3
			,{ModuleType = mechModules.Weapon, 	X =  -7, Y = 41} --Weapon 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 22} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 22} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 35} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 35} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 29} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 29} --aux 6
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 33} --aux 7
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 33} --aux 8
		},
		SpriteSmall = 			modFilepath.."sprites\\sentinel_small.png",
		SpriteBig = 			modFilepath.."sprites\\sentinel_big.png",
		SpriteBattle = 		  	modFilepath.."sprites\\sentinel_battle.png",
		SpriteBattleDead = 	  	modFilepath.."sprites\\sentinel_dead.png",
		SpriteMeleeVertical = 	modFilepath.."sprites\\sentinel_melee_vertical.png",
		SpriteMeleeHorizontal = modFilepath.."sprites\\sentinel_melee_horizontal.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_BehemothMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   4130,
		PriceBjorn = 	   1460,
		PriceMunilon =     2300,
		PriceSkalaknit =   2020,
		PriceStaff = 	   600,
		ProductionDays =   8,
		HeatResist = 	   45,
		ImpactResist =     95,
		CurrentResist =    95,
		HasMelee = 	   	   true,
		PassiveArmor =     10,
		Weight = 		   108,
		Speed = 		   0.1,
		ReloadTime = 	   3,
		BattleTime = 	   12,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 30} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 22} --reactor
			,{ModuleType = mechModules.Motor, 	X =   7, Y =  5} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -7, Y =  5} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   7, Y =  9} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -7, Y =  9} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 13} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 13} --motor 6
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 17} --motor 7
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 17} --motor 8
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 27} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 27} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 27} --Weapon 3
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 27} --Weapon 4
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 21} --Weapon 5
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 21} --Weapon 6
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 21} --Weapon 7
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 21} --Weapon 8
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 15} --Weapon 9
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 15} --Weapon 10
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 15} --Weapon 11
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 15} --Weapon 12
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 36} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 36} --aux 2
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 36} --aux 3
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 36} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 31} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 31} --aux 6
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 26} --aux 7
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 26} --aux 8
		},
		SpriteSmall = 			modFilepath.."sprites\\behemoth_small.png",
		SpriteBig = 			modFilepath.."sprites\\behemoth_big.png",
		SpriteBattle = 		  	modFilepath.."sprites\\behemoth_battle.png",
		SpriteBattleDead = 	  	modFilepath.."sprites\\behemoth_dead.png",
		SpriteMeleeVertical = 	modFilepath.."sprites\\behemoth_melee_vertical.png",
		SpriteMeleeHorizontal = modFilepath.."sprites\\behemoth_melee_horizontal.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_EchoMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   620,
		PriceBjorn = 	   275,
		PriceMunilon =     520,
		PriceSkalaknit =   400,
		PriceStaff = 	   265,
		ProductionDays =   5,
		HeatResist = 	   20,
		ImpactResist =     30,
		CurrentResist =    20,
		HasMelee = 	   	   false,
		PassiveArmor =     3,
		Weight = 		   80,
		Speed = 		   0.4,
		ReloadTime = 	   2,
		BattleTime = 	   4,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 29} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 22} --reactor
			,{ModuleType = mechModules.Motor, 	X =   9, Y =  7} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -9, Y =  7} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   6, Y = 12} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -6, Y = 12} --motor 4
			,{ModuleType = mechModules.Motor, 	X =  13, Y = 15} --motor 5
			,{ModuleType = mechModules.Motor, 	X = -13, Y = 15} --motor 6
			,{ModuleType = mechModules.Motor, 	X =   0, Y = 16} --motor 7
			,{ModuleType = mechModules.Weapon, 	X =  13, Y = 28} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -13, Y = 28} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =   7, Y = 35} --Weapon 3
			,{ModuleType = mechModules.Aux, 	X =   7, Y = 19} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -7, Y = 19} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 24} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 24} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   5, Y = 29} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -5, Y = 29} --aux 6
		},
		SpriteSmall = 			modFilepath.."sprites\\echo_small.png",
		SpriteBig = 			modFilepath.."sprites\\echo_big.png",
		SpriteBattle = 		  	modFilepath.."sprites\\echo_battle.png",
		SpriteBattleDead = 	  	modFilepath.."sprites\\echo_dead.png"
	})

	------------------------------------------------------------------------------
	--- SOLENOIDS ----------------------------------------------------------------
	------------------------------------------------------------------------------

	Mod.Database.AddSolenoid({
		ReferenceName = "CDC_HighTechSolenoid",
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    150,
		PriceBjorn = 	    150,
		PriceMunilon =      200,
		PriceSkalaknit =    25,
		PriceStaff = 	    70,
		ProductionDays =    4,
		Power = 		    3,
		Induction = 	    1,
		Sprite = 		    modFilepath.."sprites\\high_tech_solenoid.png"
	})

	------------------------------------------------------------------------------
	--- WEAPONS ------------------------------------------------------------------
	------------------------------------------------------------------------------

	Mod.Database.AddWeapon({
		Name = 			    "CDC_Howitzer",
		Description = {
			LocalizedDefaultValue = "240-MM HOWITZER GUN"
		},
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    200,
		PriceBjorn = 	    50,
		PriceMunilon =      30,
		PriceSkalaknit =    60,
		PriceStaff = 	    45,
		ProductionDays =    4,
		WeaponType =	    weaponTypes.Kinetic,
		FireRate =		    25,
		Weight = 		    48,
		Accuracy = 		    1.5,
		EnergyCost = 		5,
		Damage = 		    80,
		Penetration = 	    15,
		ProjectileSpeed =   18,
		IsEnergyBuffed =    false,
		BlueLength =        0,
		SpriteSmall =       modFilepath.."sprites\\howitzer_small.png",
		SpriteBig = 	    modFilepath.."sprites\\howitzer_big.png",
		SpriteHuge = 	    modFilepath.."sprites\\howitzer_huge.png",
	})

	Mod.Database.AddWeapon({
		Name = 			    "CDC_LaserPulseCannon",
		Description = {
			LocalizedDefaultValue = "EXTENDED RANGE LASER PULSE CANNON#Uses an internal power unit to provide most of the energy. Can be boosted by providing additional power."
		},
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    250,
		PriceBjorn = 	    245,
		PriceMunilon =      500,
		PriceSkalaknit =    130,
		PriceStaff = 	    110,
		ProductionDays =    8,
		WeaponType =	    weaponTypes.Energy,
		FireRate =		    600,
		Weight = 		    80,
		Accuracy = 		    0,
		EnergyCost = 		10,
		Damage = 		    40,
		Penetration = 	    5,
		ProjectileSpeed =   0,
		IsEnergyBuffed =    false,
		BlueLength =        2000,
		SpriteSmall =       modFilepath.."sprites\\laser_pulse_cannon_small.png",
		SpriteBig = 	    modFilepath.."sprites\\laser_pulse_cannon_big.png",
		SpriteHuge = 	    modFilepath.."sprites\\laser_pulse_cannon_huge.png",
	})

--	local nova_mech_index = AddMech({
--		price_metallite = 400,
--		price_bjorn = 	  200,
--		price_munilon =   320,
--		price_skalaknit = 220,
--		price_staff = 	  245,
--		production_days = 4,
--		heat_resist = 	  20,
--		impact_resist =   15,
--		current_resist =  40,
--		has_melee = 	  1,
--		passive_armor =   2,
--		weight = 		  65,
--		speed = 		  0.4,
--		reload_time = 	  3,
--		battle_time = 	  3,
--		mech_cells = {
--			{moduleType = modules.motor, 	x =   7, y =  6} --motor 1
--			,{moduleType = modules.motor, 	x =  -7, y =  6} --motor 2
--			,{moduleType = modules.motor, 	x =   7, y = 11} --motor 3
--			,{moduleType = modules.motor, 	x =  -7, y = 11} --motor 4
--			,{moduleType = modules.motor, 	x =   7, y = 16} --motor 5
--			,{moduleType = modules.motor, 	x =  -7, y = 16} --motor 6
--			,{moduleType = modules.reactor, x =   0, y = 18} --reactor
--			,{moduleType = modules.gun, 	x =  14, y = 20} --gun 1
--			,{moduleType = modules.gun, 	x = -14, y = 20} --gun 2
--			,{moduleType = modules.cabin, 	x =   0, y = 25} --cabin
--			,{moduleType = modules.aux, 	x =   6, y = 21} --aux 1
--			,{moduleType = modules.aux, 	x =  -6, y = 21} --aux 2
--			,{moduleType = modules.aux, 	x =   6, y = 27} --aux 3
--			,{moduleType = modules.aux, 	x =  -6, y = 27} --aux 4
--			,{moduleType = modules.aux, 	x =  11, y = 27} --aux 5
--			,{moduleType = modules.aux, 	x = -11, y = 27} --aux 6
--			,{moduleType = modules.aux, 	x =   0, y = 33} --aux 7
--		},
--		sprite_small = 			  current_file_path.."sprites/nova_small.png",
--		sprite_big = 			  current_file_path.."sprites/nova_big.png",
--		sprite_battle = 		  current_file_path.."sprites/nova_battle.png",
--		sprite_battle_dead = 	  current_file_path.."sprites/nova_dead.png",
--		sprite_battle_melee_ver = current_file_path.."sprites/nova_melee_vertical.png",
--		sprite_battle_melee_hor = current_file_path.."sprites/nova_melee_horizontal.png"
--	});
--	variable_global_set(unique_mod_prefix.."nova_mech_index", nova_mech_index);

--	local sentinel_mech_index = AddMech({
--		price_metallite = 1050,
--		price_bjorn = 	  730,
--		price_munilon =   1030,
--		price_skalaknit = 880,
--		price_staff = 	  325,
--		production_days = 6,
--		heat_resist = 	  25,
--		impact_resist =   90,
--		current_resist =  80,
--		has_melee = 	  1,
--		passive_armor =   5,
--		weight = 		  70,
--		speed = 		  0.2,
--		reload_time = 	  4,
--		battle_time = 	  5,
--		mech_cells = {
--			{moduleType = modules.motor, 	x =   8, y =  6} --motor 1
--			,{moduleType = modules.motor, 	x =  -8, y =  6} --motor 2
--			,{moduleType = modules.motor, 	x =   8, y = 11} --motor 3
--			,{moduleType = modules.motor, 	x =  -8, y = 11} --motor 4
--			,{moduleType = modules.motor, 	x =   7, y = 16} --motor 5
--			,{moduleType = modules.motor, 	x =  -7, y = 16} --motor 6
--			,{moduleType = modules.reactor, x =   0, y = 24} --reactor
--			,{moduleType = modules.gun, 	x =  14, y = 22} --gun 1
--			,{moduleType = modules.gun, 	x = -14, y = 22} --gun 2
--			,{moduleType = modules.gun, 	x =   7, y = 41} --gun 3
--			,{moduleType = modules.gun, 	x =  -7, y = 41} --gun 4
--			,{moduleType = modules.cabin, 	x =   0, y = 32} --cabin
--			,{moduleType = modules.aux, 	x =   6, y = 22} --aux 1
--			,{moduleType = modules.aux, 	x =  -6, y = 22} --aux 2
--			,{moduleType = modules.aux, 	x =   6, y = 35} --aux 3
--			,{moduleType = modules.aux, 	x =  -6, y = 35} --aux 4
--			,{moduleType = modules.aux, 	x =   6, y = 29} --aux 5
--			,{moduleType = modules.aux, 	x =  -6, y = 29} --aux 6
--			,{moduleType = modules.aux, 	x =  11, y = 33} --aux 7
--			,{moduleType = modules.aux, 	x = -11, y = 33} --aux 8
--		},
--		sprite_small = 			  current_file_path.."sprites/sentinel_small.png",
--		sprite_big = 			  current_file_path.."sprites/sentinel_big.png",
--		sprite_battle = 		  current_file_path.."sprites/sentinel_battle.png",
--		sprite_battle_dead = 	  current_file_path.."sprites/sentinel_dead.png",
--		sprite_battle_melee_ver = current_file_path.."sprites/sentinel_melee_vertical.png",
--		sprite_battle_melee_hor = current_file_path.."sprites/sentinel_melee_horizontal.png"
--	});
--	variable_global_set(unique_mod_prefix.."sentinel_mech_index", sentinel_mech_index);

--	local behemoth_mech_index = AddMech({
--		price_metallite = 4130,
--		price_bjorn = 	  1460,
--		price_munilon =   2300,
--		price_skalaknit = 2020,
--		price_staff = 	  600,
--		production_days = 8,
--		heat_resist = 	  45,
--		impact_resist =   95,
--		current_resist =  95,
--		has_melee = 	  1,
--		passive_armor =   10,
--		weight = 		  108,
--		speed = 		  0.1,
--		reload_time = 	  3,
--		battle_time = 	  12,
--		mech_cells = {
--			{moduleType = modules.motor, 	x =   7, y =  5} --motor 1
--			,{moduleType = modules.motor, 	x =  -7, y =  5} --motor 2
--			,{moduleType = modules.motor, 	x =   7, y =  9} --motor 3
--			,{moduleType = modules.motor, 	x =  -7, y =  9} --motor 4
--			,{moduleType = modules.motor, 	x =   7, y = 13} --motor 5
--			,{moduleType = modules.motor, 	x =  -7, y = 13} --motor 6
--			,{moduleType = modules.motor, 	x =   7, y = 17} --motor 7
--			,{moduleType = modules.motor, 	x =  -7, y = 17} --motor 8
--			,{moduleType = modules.reactor, x =   0, y = 22} --reactor
--			,{moduleType = modules.gun, 	x =  15, y = 27} --gun 1
--			,{moduleType = modules.gun, 	x = -15, y = 27} --gun 2
--			,{moduleType = modules.gun, 	x =  24, y = 27} --gun 3
--			,{moduleType = modules.gun, 	x = -24, y = 27} --gun 4
--			,{moduleType = modules.gun, 	x =  15, y = 21} --gun 5
--			,{moduleType = modules.gun, 	x = -15, y = 21} --gun 6
--			,{moduleType = modules.gun, 	x =  24, y = 21} --gun 7
--			,{moduleType = modules.gun, 	x = -24, y = 21} --gun 8
--			,{moduleType = modules.gun, 	x =  15, y = 15} --gun 9
--			,{moduleType = modules.gun, 	x = -15, y = 15} --gun 10
--			,{moduleType = modules.gun, 	x =  24, y = 15} --gun 11
--			,{moduleType = modules.gun, 	x = -24, y = 15} --gun 12
--			,{moduleType = modules.cabin, 	x =   0, y = 30} --cabin
--			,{moduleType = modules.aux, 	x =   6, y = 36} --aux 1
--			,{moduleType = modules.aux, 	x =  -6, y = 36} --aux 2
--			,{moduleType = modules.aux, 	x =  11, y = 36} --aux 3
--			,{moduleType = modules.aux, 	x = -11, y = 36} --aux 4
--			,{moduleType = modules.aux, 	x =   6, y = 31} --aux 5
--			,{moduleType = modules.aux, 	x =  -6, y = 31} --aux 6
--			,{moduleType = modules.aux, 	x =  11, y = 26} --aux 7
--			,{moduleType = modules.aux, 	x = -11, y = 26} --aux 8
--		},
--		sprite_small = 			  current_file_path.."sprites/behemoth_small.png",
--		sprite_big = 			  current_file_path.."sprites/behemoth_big.png",
--		sprite_battle = 		  current_file_path.."sprites/behemoth_battle.png",
--		sprite_battle_dead = 	  current_file_path.."sprites/behemoth_dead.png",
--		sprite_battle_melee_ver = current_file_path.."sprites/behemoth_melee_vertical.png",
--		sprite_battle_melee_hor = current_file_path.."sprites/behemoth_melee_horizontal.png"
--	});
--	variable_global_set(unique_mod_prefix.."behemoth_mech_index", behemoth_mech_index);

--	local echo_mech_index = AddMech({
--		price_metallite = 620,
--		price_bjorn = 	  275,
--		price_munilon =   520,
--		price_skalaknit = 400,
--		price_staff = 	  265,
--		production_days = 5,
--		heat_resist = 	  20,
--		impact_resist =   30,
--		current_resist =  20,
--		has_melee = 	  0,
--		passive_armor =   3,
--		weight = 		  80,
--		speed = 		  0.4,
--		reload_time = 	  2,
--		battle_time = 	  4,
--		mech_cells = {
--			{moduleType = modules.motor, 	x =   9, y =  7} --motor 1
--			,{moduleType = modules.motor, 	x =  -9, y =  7} --motor 2
--			,{moduleType = modules.motor, 	x =   6, y = 12} --motor 3
--			,{moduleType = modules.motor, 	x =  -6, y = 12} --motor 4
--			,{moduleType = modules.motor, 	x =  13, y = 15} --motor 5
--			,{moduleType = modules.motor, 	x = -13, y = 15} --motor 6
--			,{moduleType = modules.motor, 	x =   0, y = 16} --motor 7
--			,{moduleType = modules.reactor, x =   0, y = 22} --reactor
--			,{moduleType = modules.gun, 	x =  13, y = 28} --gun 1
--			,{moduleType = modules.gun, 	x = -13, y = 28} --gun 2
--			,{moduleType = modules.gun, 	x =   7, y = 35} --gun 3
--			,{moduleType = modules.cabin, 	x =   0, y = 29} --cabin
--			,{moduleType = modules.aux, 	x =   7, y = 19} --aux 1
--			,{moduleType = modules.aux, 	x =  -7, y = 19} --aux 2
--			,{moduleType = modules.aux, 	x =   6, y = 24} --aux 3
--			,{moduleType = modules.aux, 	x =  -6, y = 24} --aux 4
--			,{moduleType = modules.aux, 	x =   5, y = 29} --aux 5
--			,{moduleType = modules.aux, 	x =  -5, y = 29} --aux 6
--		},
--		sprite_small = 			  current_file_path.."sprites/echo_small.png",
--		sprite_big = 			  current_file_path.."sprites/echo_big.png",
--		sprite_battle = 		  current_file_path.."sprites/echo_battle.png",
--		sprite_battle_dead = 	  current_file_path.."sprites/echo_dead.png",
--	});
--	variable_global_set(unique_mod_prefix.."echo_mech_index", echo_mech_index);

--	local high_tech_solenoid_index = AddSolenoid({
--		price_metallite = 150,
--		price_bjorn = 	  150,
--		price_munilon =   200,
--		price_skalaknit = 25,
--		price_staff = 	  70,
--		production_days = 4,
--		power = 		  3,
--		induction = 	  1,
--		sprite = 		  current_file_path.."sprites/high_tech_solenoid.png"
--	});
--	variable_global_set(unique_mod_prefix.."high_tech_solenoid_index", high_tech_solenoid_index);

--	local howitzer_weapon_index = AddWeapon({
--		price_metallite =  200,
--		price_bjorn = 	   50,
--		price_munilon =    30,
--		price_skalaknit =  60,
--		price_staff = 	   45,
--		production_days =  4,
--		weapon_type = 	   weapon_types.white,
--		fire_rate = 	   25,
--		weight = 		   48,
--		accuracy = 		   1.5,
--		energy = 		   5,
--		damage = 		   80,
--		penetration = 	   15,
--		projectile_speed = 18,
--		energy_buffed =    0,
--		sprite_small =     current_file_path.."sprites/howitzer_small.png",
--		sprite_big = 	   current_file_path.."sprites/howitzer_big.png",
--		sprite_huge = 	   current_file_path.."sprites/howitzer_huge.png"
--	});
--	variable_global_set(unique_mod_prefix.."howitzer_weapon_index", howitzer_weapon_index);

--	local laser_pulse_cannon_weapon_index = AddWeapon({
--		price_metallite =  250,
--		price_bjorn = 	   245,
--		price_munilon =    500,
--		price_skalaknit =  130,
--		price_staff = 	   110,
--		production_days =  8,
--		weapon_type = 	   weapon_types.blue,
--		fire_rate = 	   600,
--		weight = 		   80,
--		accuracy = 		   0,
--		energy = 		   10,
--		damage = 		   40,
--		penetration = 	   5,
--		projectile_speed = 0,
--		energy_buffed =    0,
--		sprite_small =     current_file_path.."sprites/laser_pulse_cannon_small.png",
--		sprite_big = 	   current_file_path.."sprites/laser_pulse_cannon_big.png",
--		sprite_huge = 	   current_file_path.."sprites/laser_pulse_cannon_huge.png"
--	});
--	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_weapon_range", 2000);
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
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end