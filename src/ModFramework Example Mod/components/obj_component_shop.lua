
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
---@param q game_obj_component_shop
function create(q)
    --load the mod framework as a global for use within this file
	Mod = GetModFramework()
end

---Triggers when item is selected in the component shop. Used to update price information.
---@param q game_obj_component_shop
function update_prices(q)
end

---Triggers when a component production completes.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 The number of the hangar to check to check. Note you need to increase the value by 1 to get the correct Hangar slot.
function done(q, i)
    --load needed types
	local hangarIndexes = Mod.Types.HangarIndexes

    local hangarSlot = i + 1
    local hangar = q.hanger_mass[hangarSlot]
	local componentType = hangar[hangarIndexes.component_type]
	local component = Mod.Common.GetCustomComponentByType(componentType)

    --Check if we found a component and if the name matches the custom component we made
    if (component ~= nil and
        component.ReferenceName == "example_custom_component") then
        --The Staff used by the construction is already returned.
        --You only need to add whatever mod logic you need for this custom component
        --Example: Giving non standard things like pilots

        local emoticon = Mod.Common.GetPilotTemplateIndex("EMOTICON")
        if (emoticon ~= nil) then
            Mod.Hangar.AddPilot({
                Template = emoticon, 	--this wil determine the used sprite and the missing optional values.
                Age = 0,				--the age of the pilot
                IsCyborg = true,		--if true the pilot is a cyborg
                Name = "MR SMILE",      --the name of the pilot
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
end

---Draw triggers when item is selected in the component shop.
---@param q game_obj_component_shop
---@param cur_item_type number
function draw_item_text(q, cur_item_type)
end