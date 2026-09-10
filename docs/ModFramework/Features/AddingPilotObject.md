# ModFramework - Adding a pilot object

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_content_hangar.lua" in the create function, for when adding items to a new game.

## Code example
```lua
---One time script when the game is started
---@param q game_obj_content_hangar
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if (Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new pilots on loaded saves we return the function here.
		return
	end

	--Adding pilots requires that the ini is loaded so the framework queues the add calls for later
	--By adding pilots here you can add them to the roster for a new game

	--example of a fully modded pilot
	Mod.Hangar.AddPilot({
		Template = "FREEZ", 		--this wil determine the used sprite and the missing optional values.
		Age = 22,					--the age of the pilot
		IsCyborg = false,			--if true the pilot is a cyborg
		WorkExperience = {			--the text for the work experience
			--Data that represents a string that will be localized. Its recommended to be in english for code readability
			--The other actual values will be pulled from the mods localization files
			--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
			LocalizedString = { LocalizedDefaultValue = "Example work experience text for pilot 1." },
			--We need to set a reference name so the framework can resolve the localization
			ReferenceName = "example_pilot_1"
		},
		Name = "JOHN",				--the name of the pilot
		Voice = "male_scottish", 	--the voice used
		Level = 0,					--the level of the pilot
		LevelExperience = 10,		--the amount of experience in the current level
		Reaction = 77,				--the reaction stat of the pilot (0-100)
		Skill = 77,					--the skill stat of the pilot (0-100)
		Vitality = 77,				--the vitality stat of the pilot (0-100)
		StressResistance = 77,		--the resistance stat stat of the pilot (0-100)
	})

	--Not all fields are required so you can make one with a more limited set of data
	--Missing data will be provided by the template
	Mod.Hangar.AddPilot({
		Template = "ELLEN", 		--this wil determine the used sprite and the missing optional values.
		Age = 40,					--the age of the pilot
		IsCyborg = false,			--if true the pilot is a cyborg
		WorkExperience = {			--the text for the work experience
			--Data that represents a string that will be localized. Its recommended to be in english for code readability
			--The other actual values will be pulled from the mods localization files
			--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
			LocalizedString = { LocalizedDefaultValue = "Example of a reused work experience text." },
			--We need to set a reference name so the framework can resolve the localization
			ReferenceName = "example_pilot_reuse"
		},
	})

	--Instead of a template name we can provide the index for new pilot template
	local emoticon = Mod.Common.GetPilotTemplateIndex("EMOTICON")
	if (emoticon ~= nil) then
		Mod.Hangar.AddPilot({
			Template = emoticon, 	--this wil determine the used sprite and the missing optional values.
			Age = 666,				--the age of the pilot
			IsCyborg = false,		--if true the pilot is a cyborg
			WorkExperience = {		--the text for the work experience
				--Data that represents a string that will be localized. Its recommended to be in english for code readability
				--The other actual values will be pulled from the mods localization files
				--Use the GenerateLocalizationFiles() function to generate the mods localization files in development
				LocalizedString = { LocalizedDefaultValue = "Example of a reused work experience text." },
				--We can reuse a previous localized reference if the value is the same
				ReferenceName = "example_pilot_reuse"
			},
		})
	end
end
```

## Notes
This can also be used in other places. Depending on you mods requirements.   
This object has [localization](../Localization.md) support.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)