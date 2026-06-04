------------------------------------------------------------------------------
--- HANGER FUNCTIONS -----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Hanger tab.
---@class ModFrameworkInternalHanger
local Hanger = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalHangerPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Settings functions.
local Settings = require("ModFrameworkSettings")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Adds all the pilots in the queue
function Hanger.ProcessPilotDataQueue()
    local obj_weapon_test = Common.GetObjWeaponTest()

	--We check if the ini has been loaded
	if (obj_weapon_test.load_ini == false) then
		return
	end

    for _, pilotData in ipairs(Storage.PilotDataQueue) do
        Private.AddPilotFromQueue(pilotData)
    end
    --clear queue
    Storage.PilotDataQueue = {}
end

---Add a new pilot to the hanger
---@param pilotData LocalizedPilotCreationData dataset for adding a new pilot
function Private.AddPilotFromQueue(pilotData)
	local obj_content_pilots = Common.GetObjContentPilots()

	--Copy the array to the working set
	local list_pilot = obj_content_pilots.list_pilot

	local arraySize = #list_pilot
	local itemIndex = arraySize + 1
    local templateData = Private.GetPilotTemplateData(pilotData.Template)
	local addedPilot = Private.AddPilotItemInstance()
	addedPilot.my_num = arraySize
    --optional set values
    addedPilot.stat_name = Private.SetPilotName(templateData, pilotData.Name)
    addedPilot.level = Private.SetPilotLevel(templateData, pilotData.Level)
    addedPilot.level_ex = Private.SetPilotLevelExperience(templateData, pilotData.LevelExperience)
    addedPilot.original_stat_skill = Private.SetPilotSkill(templateData, pilotData.Skill)
    addedPilot.original_stat_reaction = Private.SetPilotReaction(templateData, pilotData.Reaction)
    addedPilot.original_stat_vitality = Private.SetPilotVitality(templateData, pilotData.Vitality)
    addedPilot.original_stat_stress_resistance = Private.SetPilotStressResistance(templateData, pilotData.StressResistance)
    --voice
    local soundIndex = Private.SetPilotVoice(templateData, pilotData.Voice)
    addedPilot.my_snd_index = soundIndex
    addedPilot.phrase_number = Common.GetPhraseNumber(soundIndex)
    --pilot data values
    addedPilot.text_work_exp = pilotData.WorkExperience
    addedPilot.stat_age = pilotData.Age
    addedPilot.cyborg = pilotData.IsCyborg
    --template data values
    addedPilot.pilot_number = templateData.Index
    addedPilot.pilot_sprite = templateData.Sprite
    addedPilot.stat_missions = 0
    addedPilot.stat_stasis = 0
    addedPilot.created = true
	list_pilot[itemIndex] = addedPilot

	--return new data
	obj_content_pilots.list_pilot = list_pilot
	obj_content_pilots.number_of_items = #list_pilot
end

---Gets the correct data template from obj_database
---@param template number|PilotNames the reference for the sprite
---@return PilotDsMap templateData the dataset for the template
function Private.GetPilotTemplateData(template)
    local obj_database = Common.GetObjDatabase()
    ---@type number
    local index = 1

    if (type(template) == "number") then
        index = template
    else
        for key, pilot in pairs(obj_database.pilot_stat) do
            local name = ds_map_find_value(pilot, "name")
            if (name == template) then
                index = key
            end
        end
    end

    local dsMap = obj_database.pilot_stat[index]

    ---@type PilotDsMap
    local templateData = {
        Index = index - 1,
        SoundIndex = ds_map_find_value(dsMap, "sound_index"),
        PhraseNumber = ds_map_find_value(dsMap, "phrase_num"),
        Sprite = ds_map_find_value(dsMap, "sprite"),
        Name = ds_map_find_value(dsMap, "name"),
        Level = ds_map_find_value(dsMap, "level"),
        LevelExperience = ds_map_find_value(dsMap, "level_ex"),
        Skill = ds_map_find_value(dsMap, "stat_skill"),
        Reaction = ds_map_find_value(dsMap, "stat_reaction"),
        Vitality = ds_map_find_value(dsMap, "stat_vitality"),
        StressResistance = ds_map_find_value(dsMap, "stat_stress_resistance"),
    }
    return templateData
end

---Create a new pilot instance
---@return game_obj_pilot_item objPilotItem the new obj_pilot_item instance
function Private.AddPilotItemInstance()
	local obj_pilot_item = Common.GetObjPilotItem()
	return instance_create_depth(0, 0, 0, obj_pilot_item)
end

------------------------------------------------------------------------------
--- PILOT MOVER --------------------------------------------------------------
------------------------------------------------------------------------------

---Listens for the input combination (shift+left mouse button)
---When the input combination on the correct coordinates it will:
---Move a pilot into a free mech.
---Move the pilot back to the hangar.
function Hanger.PilotClickListener()
	local quickMovePilots = Settings.GetBooleanSettingValue("QuickMovePilots")
	if (quickMovePilots == false) then
		return
	end

	local obj_content_hangar = Common.GetObjContentHanger()
	local obj_content_pilots = Common.GetObjContentPilots()
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local minListY = 340
	local maxListY = 1020
	local pilotBoxHeight = 154
	local pilotBoxWidth = 144

	for _, pilot in ipairs(obj_content_pilots.list_pilot) do
		if(instance_exists(pilot) == true) then
			local minX = pilot.x
			local maxX = pilot.x + pilotBoxWidth
			local minY = pilot.y
			local maxY = pilot.y + pilotBoxHeight

			if (mx > minX and
				mx < maxX and
				my > minY and
				my < maxY and
				my > minListY and
				my < maxListY and
				pilot.deleted == false) then

				if (mouse_check_button_pressed(Types.MouseButtons.Left) and
					keyboard_check(Types.VirtualKeys.Shift)) then
					Private.PlacePilotIntoMech(pilot, obj_content_pilots)
					return
				end
			end
		end
	end

	for _, mech in ipairs(obj_content_hangar.list_mech) do
		if (instance_exists(mech) == true) then
			if (mech ~= -4 and mech.cur_item ~= 0) then
				local pilot = mech.cur_item
				---@cast mech game_obj_mech_item
				---@cast pilot game_obj_pilot_item 

				local minX = pilot.x
				local maxX = pilot.x + pilotBoxWidth
				local minY = pilot.y
				local maxY = pilot.y + pilotBoxHeight

				if (mx > minX and
					mx < maxX and
					my > minY and
					my < maxY) then

					if (mouse_check_button_pressed(Types.MouseButtons.Left) and
						keyboard_check(Types.VirtualKeys.Shift)) then
						Private.PlacePilotIntoHanger(mech, pilot)
						return
					end
				end
			end
		end
	end
end

---Place the given pilot in the first available mech.
---If there are no free mechs do nothing.
---@param pilot game_obj_pilot_item The pilot.
---@param obj_content_pilots game_obj_content_pilots The hanger.
function Private.PlacePilotIntoMech(pilot, obj_content_pilots)
	local mech = Private.FindAvailableMech()
	if mech == nil then
		return
	end

	local numberOfItems = obj_content_pilots.number_of_items
	local newListPilot = {}

	--Update the pilots list
	local i = 0
	for _, value in ipairs(obj_content_pilots.list_pilot) do
		if (pilot.my_num ~= value.my_num) then
			value.my_num = i
			table.insert(newListPilot, value)
			i = i + 1
		end
	end

	--Update the pilot
	pilot.my_num = i
	pilot.my_mech = mech
	pilot.item_pos = 2
	pilot.deleted = true
	pilot.hover = true
	table.insert(newListPilot, pilot)

	--Update the mech receiving the pilot
	mech.cur_item = pilot
	mech.cur_item_type = 13
	mech.new_item = pilot
	mech.new_item_type = 13

	--return the updated values
	obj_content_pilots.list_pilot = newListPilot
	obj_content_pilots.number_of_items = numberOfItems - 1
end

---Place the given pilot back into the hanger and clear the mech.
---@param mech game_obj_mech_item The mech containing the pilot.
---@param pilot game_obj_pilot_item The pilot.
function Private.PlacePilotIntoHanger(mech, pilot)
	local obj_content_pilots = Common.GetObjContentPilots()
	local numberOfItems = obj_content_pilots.number_of_items
	local list_pilot = obj_content_pilots.list_pilot

	--Update the pilot
	pilot.my_num = numberOfItems
	pilot.my_mech = -4
	pilot.item_pos = 0
	pilot.deleted = false
	pilot.hover = false
	list_pilot[numberOfItems + 1] = pilot

	--Update the mech receiving the pilot
	mech.cur_item = 0
	mech.cur_item_type = 0
	mech.new_item = 0
	mech.new_item_type = 0

	obj_content_pilots.list_pilot = list_pilot
	obj_content_pilots.number_of_items = numberOfItems + 1
end

---Find a available mech for a pilot.
---@return game_obj_mech_item? mech The mech when available, nil otherwise.
function Private.FindAvailableMech()
	local obj_content_hangar = Common.GetObjContentHanger()

	for _, mech in ipairs(obj_content_hangar.list_mech) do
		if (mech ~= -4 and
			mech.cur_item == 0) then
			---@cast mech game_obj_mech_item
			return mech
		end
	end

	return nil
end

------------------------------------------------------------------------------
--- OPTIONAL SETTERS ---------------------------------------------------------
------------------------------------------------------------------------------

---Sets the optional name if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param name string? the optional value for name
---@return string name the name for the pilot
function Private.SetPilotName(templateData, name)
    if (name ~= nil) then
        return name
    end
    return templateData.Name
end

---Sets the optional level if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param level number? the optional value for level
---@return number level the name for the pilot
function Private.SetPilotLevel(templateData, level)
    if (level ~= nil) then
        return level
    end
    return templateData.Level
end

---Sets the optional level experience if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param levelExperience number? the optional given level experience
---@return number LevelExperience the level experience for the pilot
function Private.SetPilotLevelExperience(templateData, levelExperience)
    if (levelExperience ~= nil) then
        return levelExperience
    end
    return templateData.LevelExperience
end

---Sets the optional skill if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param skill number? the optional given skill
---@return number skill the skill for the pilot
function Private.SetPilotSkill(templateData, skill)
    if (skill ~= nil) then
        return skill
    end
    return templateData.Skill
end

---Sets the optional reaction if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param reaction number? the optional given reaction
---@return number reaction the reaction for the pilot
function Private.SetPilotReaction(templateData, reaction)
    if (reaction ~= nil) then
        return reaction
    end
    return templateData.Reaction
end

---Sets the optional vitality if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param vitality number? the optional given vitality
---@return number vitality the vitality for the pilot
function Private.SetPilotVitality(templateData, vitality)
    if (vitality ~= nil) then
        return vitality
    end
    return templateData.Vitality
end

---Sets the optional stress resistance if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param stressResistance number? the optional given stress resistance
---@return number stressResistance the stress resistance for the pilot
function Private.SetPilotStressResistance(templateData, stressResistance)
    if (stressResistance ~= nil) then
        return stressResistance
    end
    return templateData.StressResistance
end

---Sets the optional voice if set else uses the template data
---@param templateData PilotDsMap the dataset for the template
---@param voice string? the optional value for voice
---@return string voice the voice for the pilot
function Private.SetPilotVoice(templateData, voice)
    if (voice ~= nil) then
        return voice
    end
    return templateData.SoundIndex
end

------------------------------------------------------------------------------
--- EXPORT HANGER ------------------------------------------------------------
------------------------------------------------------------------------------

return Hanger