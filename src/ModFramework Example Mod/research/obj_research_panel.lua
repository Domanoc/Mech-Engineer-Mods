
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFramework")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath()

	--load needed types
	local researchIcons = Mod.Types.ResearchIcons
	local researchConditions = Mod.Types.ResearchConditions
	local componentTypes = Mod.Types.ComponentTypes
	local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

	--When we want a research to include an unlock we need to include the references.
	--An component that is added as research unlock will, add a copy on completion and or unlock the production of item based on this setting.
	--With this function we can get our modded components that we made in "obj_database.lua".
	local unlocks = Mod.Common.GetModdedComponents({
		{ ReferenceName = "example_mech", ComponentType = componentTypes.Mech },
		{ ReferenceName = "example_solenoid", ComponentType = componentTypes.Solenoid }
	})
	
	--We can create a new research and as a return value we get the new res number to create links with.
	local exampleResearchResNumber = Mod.Research.AddResearch({
		ReferenceName = "example_research_1",					--the name of the research, used to find its reference
		Position = 40,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
			baseResearchResNumbers.FIRST_GENERATION_ENGINE,
		Condition = researchConditions.Opened,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 10,										--the required available staff to start the research
		ResearchIcon = researchIcons.Research,					--the info on what icon to use
		Description = {											--the description text for the research
			--Data that represents a string that will be localized. Its recommended to be in english for code readability
			--The other actual values will be pulled from the mods localization files
			--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
			LocalizedDefaultValue = "Example Research 1:#Text that will explain what this unlocks."
		},
		SpritePath = 											--path to the sprite used for the research
			modFilepath.."sprites\\example_research.png",
		UnlockedComponents = unlocks							--the components that are unlocked by this research
	})

	--We can use the previous research return to set it as a prerequisite for a new research.
	Mod.Research.AddResearch({
		ReferenceName = "example_research_2",					--the name of the research, used to find its reference
		Position = 31,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
			exampleResearchResNumber,
		Condition = researchConditions.Closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 10,										--the required available staff to start the research
		ResearchIcon = researchIcons.Survival,					--the info on what icon to use
		Description = {											--the description text for the research
			--Data that represents a string that will be localized. Its recommended to be in english for code readability
			--The other actual values will be pulled from the mods localization files
			--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
			LocalizedDefaultValue = "Example Research 2:#Text that will explain what this unlocks."
		},
		SpritePath = 											--path to the sprite used for the research
			modFilepath.."sprites\\example_research.png",
		UnlockedComponents = {}									--the components that are unlocked by this research
	})

	--We can retrieve the data of a research that was added by the framework, even if it was made by another mod.
	--However if loading one from another mod, that mod has to be before this mod in the load order.
	local example2 = Mod.Common.GetModdedResearch("example_research_2")

	--We can search for a single component to add as an unlock to an existing research
	local unlock = Mod.Common.GetModdedComponent("example_weapon", componentTypes.Weapon)
	--The existing research can be a base research or one from another mod.
	--However if adding one to a research from another mod that mod has to be before this mod in the load order.
	Mod.Research.AddUnlock(baseResearchResNumbers.TANK_GUN, unlock)

	--We can move any research to a new position and it will keep its links.
	Mod.Research.MoveResearch(baseResearchResNumbers.ROCKET_LAUNCH, 0)

	--We can relink a research to a new prerequisite research.
	Mod.Research.ChangePrerequisite(baseResearchResNumbers.PROCESSOR_PROGRAMS, baseResearchResNumbers.REPAIR_SHOP)

	--We can clear the links a research has to make it easier to rearrange the tech tree.
	Mod.Research.ClearUnlockLinks(baseResearchResNumbers.NEW_MECH_PLATE)
end

---if activated = true
---@param q any
function step(q)
end

---if activated = true
---@param q any
function draw(q)
end