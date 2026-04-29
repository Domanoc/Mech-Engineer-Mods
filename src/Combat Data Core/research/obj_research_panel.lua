
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath()

	--load needed types
	local researchIcons = Mod.Types.ResearchIcons
	local researchConditions = Mod.Types.ResearchConditions
	local componentTypes = Mod.Types.ComponentTypes

	local dataCore = Mod.Research.AddResearch({
		ReferenceName = "CDC_DataCore",
		Position = 130,
		Condition = researchConditions.Researching,
		RequiredDays = 4,
		RequiredStaff = 0,
		ResearchIcon = researchIcons.Research,
		Description = {
			LocalizedDefaultValue = "DATA CORE:#The main AI is working on unlocking the combat data core. When completed it grants additional research options."
		},
		SpritePath = modFilepath.."sprites\\data_core_research.png",
		UnlockedComponents = {}
	})

	local deepDataCore = Mod.Research.AddResearch({
		ReferenceName = "CDC_DeepDataCore",
		Position = 131,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 18,
		RequiredStaff = 0,
		ResearchIcon = researchIcons.Research,
		Description = {
			LocalizedDefaultValue = "DATA CORE:#The main AI is working on unlocking the next layer of the combat data core. When completed it grants additional research options."
		},
		SpritePath = modFilepath.."sprites\\deep_data_core_research.png",
		UnlockedComponents = {}
	})

	local finalDataCore = Mod.Research.AddResearch({
		ReferenceName = "CDC_FinalDataCore",
		Position = 142,
		PrerequisiteResearchResNumber = deepDataCore,
		RequiredDays = 22,
		RequiredStaff = 0,
		ResearchIcon = researchIcons.Research,
		Description = {
			LocalizedDefaultValue = "DATA CORE:#The main AI is working on unlocking the last layer of the combat data core. When completed it grants additional research options."
		},
		SpritePath = modFilepath.."sprites\\final_data_core_research.png",
		UnlockedComponents = {}
	})

	local novaUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_NovaMech", ComponentType = componentTypes.Mech }
	})
	local novaResearch = Mod.Research.AddResearch({
		ReferenceName = "CDC_NovaResearch",
		Position = 140,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 4,
		RequiredStaff = 120,
		ResearchIcon = researchIcons.Production,
		Description = {
			LocalizedDefaultValue = "NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats."
		},
		SpritePath = modFilepath.."sprites\\nova_research.png",
		UnlockedComponents = novaUnlocks
	})

	local sentinelUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_SentinelMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_SentinelResearch",
		Position = 132,
		PrerequisiteResearchResNumber = deepDataCore,
		RequiredDays = 6,
		RequiredStaff = 160,
		ResearchIcon = researchIcons.Production,
		Description = {
			LocalizedDefaultValue = "NEW MECH: SENTINEL#4 guns, 5 armor, 90 impact resistance, 80 water resistance. Armored assault mech with plenty of auxiliary slots."
		},
		SpritePath = modFilepath.."sprites\\sentinel_research.png",
		UnlockedComponents = sentinelUnlocks
	})

	local behemothUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_BehemothMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_BehemothResearch",
		Position = 143,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 6,
		RequiredStaff = 160,
		ResearchIcon = researchIcons.Production,
		Description = {
			LocalizedDefaultValue = "NEW MECH: BEHEMOTH#14 guns, 5 armor, 95 impact resistance, 95 water resistance. A massive armored assault mech with plenty of slots."
		},
		SpritePath = modFilepath.."sprites\\behemoth_research.png",
		UnlockedComponents = behemothUnlocks
	})

	local echoUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_EchoMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_EchoResearch",
		Position = 141,
		PrerequisiteResearchResNumber = novaResearch,
		RequiredDays = 6,
		RequiredStaff = 120,
		ResearchIcon = researchIcons.Production,
		Description = {
			LocalizedDefaultValue = "NEW MECH: ECHO#3 guns, 3 armor, 30 impact resistance, 20 water resistance. A armored mech with high mobility."
		},
		SpritePath = modFilepath.."sprites\\echo_research.png",
		UnlockedComponents = echoUnlocks
	})

	local highTechSolenoidUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_HighTechSolenoid", ComponentType = componentTypes.Solenoid }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_HighTechSolenoidResearch",
		Position = 133,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 2,
		RequiredStaff = 120,
		ResearchIcon = researchIcons.Volcano,
		Description = {
			 LocalizedDefaultValue = "HIGH TECH SOLENOID#Using advanced metallurgy processes we can create a better solenoid for our thermonuclear reactors. Granting them better cooling characteristics."
		},
		SpritePath = modFilepath.."sprites\\high_tech_solenoid_research.png",
		UnlockedComponents = highTechSolenoidUnlocks
	})

	local howitzerUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_Howitzer", ComponentType = componentTypes.Weapon }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_HowitzerResearch",
		Position = 120,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 2,
		RequiredStaff = 40,
		ResearchIcon = researchIcons.Damage,
		Description = {
			LocalizedDefaultValue = "HOWITZER#A large 240mm artillery weapon repurposed for use in direct fire." 
		},
		SpritePath = modFilepath.."sprites\\howitzer_research.png",
		UnlockedComponents = howitzerUnlocks
	})

	local laserPulseCannonUnlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "CDC_LaserPulseCannon", ComponentType = componentTypes.Weapon }
	})
	Mod.Research.AddResearch({
		ReferenceName = "CDC_LaserPulseCannonResearch",
		Position = 144,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 8,
		RequiredStaff = 160,
		ResearchIcon = researchIcons.Damage,
		Description = {
			LocalizedDefaultValue = "AUXILIARY POWER UNIT#Able to provide portable power for high energy draw weapons without overloading the reactor connections. Enabling the production of the EXTENDED RANGE LASER PULSE CANNON." 
		},
		SpritePath = modFilepath.."sprites\\laser_pulse_cannon_research.png",
		UnlockedComponents = laserPulseCannonUnlocks
	})
end

---if activated = true
---@param q any
function step(q)
end

---if activated = true
---@param q any
function draw(q)
end