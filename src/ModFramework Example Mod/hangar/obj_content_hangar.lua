
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

---every game tick if we are in the hangar menu and battle is not active
---@param q game_obj_content_hangar
function step_activated(q)
end

---when all conditions are met to spawn a giant (red sword)
---@param q game_obj_content_hangar
function spawn_giant_red(q)
end

---when all conditions are met to spawn a giant (gold sword)
---@param q game_obj_content_hangar
function spawn_giant_gold(q)
end

---when all conditions are met to launch a nuke
---@param q game_obj_content_hangar
function nuke_landed(q)
end

---check when placing city
---@param q game_obj_content_hangar
function place_city(q,q_p)
end

---skip day button
---if not defending city
---@param q game_obj_content_hangar
function skip_day_start(q)
end

---if not defending city
---@param q game_obj_content_hangar
function skip_day_end(q)
end

---after battle info
---@param q game_obj_content_hangar
function draw_battle_log(q)
end

---@param q game_obj_content_hangar
function draw_calendar(q)
end

---@param q game_obj_content_hangar
function draw_map(q)
end

---@param q game_obj_content_hangar
function draw_personal(q)
end

---@param q game_obj_content_hangar
function draw_battle_windowed(q)
end

---@param q game_obj_content_hangar
function draw_battle_fullscreen(q)
end

---player won the game
---@param q game_obj_fui_render
function win_true(q)
end

---winning animation after collecting the last part
---@param q game_obj_fui_render
function win_animation(q)
end