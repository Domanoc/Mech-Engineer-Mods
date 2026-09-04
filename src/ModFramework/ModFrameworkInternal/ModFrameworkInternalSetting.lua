------------------------------------------------------------------------------
--- INTERNAL SETTINGS FUNCTIONS ----------------------------------------------
------------------------------------------------------------------------------

---Access to the internal functions for the Settings.
---@class ModFrameworkInternalSave
local InternalSettings = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalSavePrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the json converter
local lunaJson = require("lunajson")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Settings functions.
local Settings = require("ModFrameworkSettings")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

InternalSettings.RegisterBooleanSetting = Settings.RegisterBooleanSetting
InternalSettings.UpdateBooleanSetting = Settings.UpdateBooleanSetting
InternalSettings.GetBooleanSettingValue = Settings.GetBooleanSettingValue

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---The name of the setting that is waiting for a key.
---@type string?
local WaitingForKey = nil

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Adds the mod setting data to the save file
function InternalSettings.SaveData()
	local obj_content_hangar = Common.GetObjContentHangar()
	local json = lunaJson.encode(Storage.ModSettingData)
	ds_grid_set(obj_content_hangar.data_map_level, 0, 0, json)
end

---Loads the mod setting data from the save file back into storage
function InternalSettings.LoadData()
	local obj_content_hangar = Common.GetObjContentHangar()
	local json = ds_grid_get(obj_content_hangar.data_map_level, 0, 0)
	local ok, jsonData = pcall(lunaJson.decode, json)
	if not ok then
		--We cannot parse the data so we will parse an empty set
		jsonData = {}
	end

	---@cast jsonData JsonModSettingData[]
	Private.ParseModSettingData(jsonData)
end

---Parse the json data and set a valid dataset to storage.
---The result will be a mix of valid json data and the default values if needed.
---@param jsonData JsonModSettingData[] The Json data that gets parsed.
function Private.ParseModSettingData(jsonData)
	---@type ModSettingData[]
	local parsedData = {}

	for _, defaults in ipairs(Storage.ModDefaultData) do
		local modName = defaults.ModName
		---@type ModSettingData
		local parsedModSetting = {
			ModName = modName,
			SettingsData = {}
		}

		local modData = Private.FindModInJsonData(modName, jsonData)
		if (modData ~= nil) then
			--When we find json data we apply the parsed data
			local parsedSettings = Private.ParseSettingDataJson(modData.SettingsData, defaults.DefaultSettingsData)
			parsedModSetting.SettingsData = parsedSettings
		else
			--When there is no json data we create a copy of the default values
			for _, default in ipairs(defaults.DefaultSettingsData) do
				---@type SettingData
				local setting = {
					SettingsName = default.SettingsName,
					SettingsValue = default.SettingsValue
				}
				table.insert(parsedModSetting.SettingsData, setting)
			end
		end

		--Add the setting to the return
		table.insert(parsedData, parsedModSetting)
	end

	Storage.ModSettingData = parsedData
end

---Parse the json setting data and return a valid setting dataset.
---@param jsonData JsonSettingData[] The Json data that gets parsed.
---@param defaults DefaultSettingData[] The default setting values.
---@return SettingData[] parsedData The parsed data for the settings, has the values from the json when valid, the defaults otherwise.
function Private.ParseSettingDataJson(jsonData, defaults)
	---@type SettingData[]
	local parsedData = {}

	for _, default in ipairs(defaults) do
		local settingName = default.SettingsName
		---@type SettingData
		local parsedSetting = {
			SettingsName = settingName,
			SettingsValue = default.SettingsValue
		}

		local jsonSetting = Private.FindSettingInJsonData(settingName, jsonData, default)
		if (jsonSetting ~= nil) then
			--A valid value was found so override the default value
			parsedSetting.SettingsValue = jsonSetting.SettingsValue
		end

		--Add the setting to the return
		table.insert(parsedData, parsedSetting)
	end

	--Return the updated defaults
	return parsedData
end

---Finds the settings data by mod name in the json data.
---@param name string The name of the mod.
---@param jsonData JsonModSettingData[] The json data that will be searched.
---@return JsonModSettingData? value The value if found, nil otherwise.
function Private.FindModInJsonData(name, jsonData)
	for _, value in ipairs(jsonData) do
		if (value.ModName == name) then
			return value
		end
	end
	return nil
end

---Finds the setting by name in the json data.
---@param name string The name of the setting.
---@param jsonData JsonSettingData[] The json data that will be searched.
---@param default DefaultSettingData The default data to compare against.
---@return SettingData? value The value if found, nil otherwise.
function Private.FindSettingInJsonData(name, jsonData, default)
	for _, jsonValue in ipairs(jsonData) do
		--TODO: Check if value is in an allowed range
		if (jsonValue.SettingsName == name and
			jsonValue.SettingsValue ~= nil and
			type(jsonValue.SettingsValue) == default.SettingType) then

			---@type SettingData SettingData
			local value = {
				SettingsName = jsonValue.SettingsName,
				SettingsValue = jsonValue.SettingsValue
			}
			return value
		end
	end
	return nil
end

------------------------------------------------------------------------------
--- SETTINGS MENU ------------------------------------------------------------
------------------------------------------------------------------------------

---Loads the needed menu sprites, so we can draw the settings menu.
---
---Used in the create function of obj_database.lua
function InternalSettings.LoadMenuSprites()
	local modPath = Common.GetModPathByName("ModFramework")
	Storage.SpriteSettingsMenu = Common.AddSprite(modPath.."sprites\\ModFrameworkMenu.png", 1, false, false, 0, 0)
	Storage.SpriteSettingsMenuBackground = Common.AddSprite(modPath.."sprites\\ModFrameworkSettingsMenuBackground.png", 1, false, false, 0, 0)
	Storage.SpriteSettingsMenuLabel = Common.AddSprite(modPath.."sprites\\Label.png", 3, false, false, 0, 0)
	Storage.SpriteSaveDefaultsButton = Common.AddSprite(modPath.."sprites\\SaveDefaultsButton.png", 2, false, false, 0, 0)
	Storage.SpriteKeyBindButton = Common.AddSprite(modPath.."sprites\\KeyBindButton.png", 3, false, false, 0, 0)
	Storage.SpriteSettingsMenuButton = asset_get_index("spr_button_medium")
	Storage.SpriteSettingsMenuSwitch = asset_get_index("spr_circuits_switcher")

	Storage.SettingsMenuTitleText = Common.GetLocalizedString("SettingsMenu", "SettingsMenu", { LocalizedDefaultValue = "MOD SETTINGS MENU" })
end

---Draws the settings menu and buttons.
function InternalSettings.DrawMenu()
	local modSettingCount = #Storage.ModSettingData
	if (modSettingCount < 1) then
		return
	end

	local obj_button_engineering = Common.GetObjButtonEngineering()
	local game_obj_big_holder = Common.GetObjBigHolder()

	if (obj_button_engineering.activated == true and
		game_obj_big_holder.cur_item == 0) then

		Private.DrawButtonMenu()
		Private.DrawOpenMenuButton()

		Private.DrawSettingsMenu()
	else
		Storage.IsSettingsMenuOpen = false
		WaitingForKey = nil
	end
end

---Draws the menu and title for the settings menu button.
function Private.DrawButtonMenu()
	local menuX = 1434
	local menuY = 160
	local textOffsetX = 170
	local textOffsetY = 18

	draw_sprite_ext(Storage.SpriteSettingsMenu, 0, menuX, menuY, 2, 2, 0, 16777215, 1)

	draw_set_color(make_colour_rgb(218, 172, 57))
	draw_set_halign(1)
	draw_text_transformed(menuX + textOffsetX, menuY + textOffsetY, Storage.SettingsMenuTitleText, 2, 2, 0)
end

---Draws the settings menu button.
function Private.DrawOpenMenuButton()
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local sprite = Storage.SpriteSettingsMenuButton
	local buttonX = 1572
	local buttonY = 224
	local buttonWidth = 54
	local buttonHeight = 34
	local subImage = 0

	if (Storage.IsSettingsMenuOpen == true) then
		subImage = 3
	end

	if (mx > buttonX and
		mx < (buttonX + buttonWidth) and
		my > buttonY and
		my < (buttonY + buttonHeight)) then
		if (Storage.IsSettingsMenuOpen == false) then
			subImage = subImage + 1
		end

		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			Storage.IsSettingsMenuOpen = not Storage.IsSettingsMenuOpen
			subImage = subImage + 1
		end
	end

	draw_sprite_ext(sprite, subImage, buttonX, buttonY, 2, 2, 0, 16777215, 1)
end

---Draws the mod settings menu for the current selected settings
function Private.DrawSettingsMenu()
	if (Storage.IsSettingsMenuOpen == false) then
		WaitingForKey = nil
		return
	end
	local modSettingCount = #Storage.ModSettingData
	if (modSettingCount < 1) then
		return
	end

	local SelectedModSettings = Storage.ModSettingData[Storage.CurrentSettingsMenuIndex]
	local titleY = 224
	local pageButtonsY = 231
	local startSettingsY = 284
	local settingsHeight = 45

	--Draw the background
	draw_sprite_ext(Storage.SpriteSettingsMenuBackground, 0, 574, 210, 2, 2, 0, 16777215, 1)

	if (modSettingCount > 1) then
		Private.DrawPageButton(Storage.SpriteShopButtonLeft, 588, pageButtonsY, Private.PreviousMod)
		Private.DrawPageButton(Storage.SpriteShopButtonRight, 618, pageButtonsY, Private.NextMod)
	end
	Private.DrawLabel(650, titleY, SelectedModSettings.ModName, 47)
	Private.SaveDefaultsButton(1332, titleY, Private.SaveAsDefaults)

	local i = 0
	for _, setting in ipairs(SelectedModSettings.SettingsData) do
		local y = startSettingsY + (i * settingsHeight)
		if (type(setting.SettingsValue) == "boolean") then
			Private.AddBooleanSetting(y, setting, SelectedModSettings.ModName)
		elseif (type(setting.SettingsValue) == "number") then
			Private.AddKeyBindSetting(y, setting, SelectedModSettings.ModName)
		end
		i = i + 1
	end
end

---Add a boolean setting to the settings menu.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is added.
---@param modName string The name of the mod.
function Private.AddBooleanSetting(startY, setting, modName)
	local startX = 614
	local switchOffsetY = 18
	local subImage = 0
	if setting.SettingsValue == false then
		subImage = 1
	end

	draw_sprite_ext(Storage.SpriteSettingsMenuSwitch, subImage, startX, startY + switchOffsetY, 2, 2, 0, 16777215, 1)

	local description = Private.GetSettingsDescription(modName, setting.SettingsName)
	local switchWidth = 36
	local LabelX = startX + switchWidth
	Private.DrawLabel(LabelX, startY, description, 51)
	Private.BooleanButtonHandler(startX, startY, setting)
end

---Handles the boolean button operation for the setting.
---@param startX number The starting x position.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is set by the button.
function Private.BooleanButtonHandler(startX, startY, setting)
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local buttonOffsetX = 34
	local buttonWidth = 64
	local buttonHeight = 36
	local buttonMinX = startX - buttonOffsetX
	local buttonMaxX = startX + buttonWidth - buttonOffsetX
	local buttonMinY = startY
	local buttonMaxY = startY + buttonHeight

	if (mx > buttonMinX and
		mx < buttonMaxX and
		my > buttonMinY and
		my < buttonMaxY) then
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			setting.SettingsValue = not setting.SettingsValue
		end
	end
end

---Add a key bind setting to the settings menu.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is added.
---@param modName string The name of the mod.
function Private.AddKeyBindSetting(startY, setting, modName)
	local startX = 596
	local keyCode = setting.SettingsValue
	---@cast keyCode number
	local keyName = Private.GetVirtualKeyName(keyCode)
	local description = Private.GetSettingsDescription(modName, setting.SettingsName)
	local buttonWidth = 54
	local LabelX = startX + buttonWidth

	local keyLabelOffsetX = 14
	local keyLabelX = Private.DrawLabel(LabelX, startY, description, 34)
	keyLabelX = keyLabelX + keyLabelOffsetX
	Private.DrawLabel(keyLabelX, startY, keyName, 15)
	Private.KeyBindButtonHandler(startX, startY, setting)
end

---Handles the boolean button operation for the setting.
---@param startX number The starting x position.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is set by the button.
function Private.KeyBindButtonHandler(startX, startY, setting)
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local buttonWidth = 39
	local buttonHeight = 39
	local buttonMinX = startX
	local buttonMaxX = startX + buttonWidth
	local buttonMinY = startY
	local buttonMaxY = startY + buttonHeight
	local subImage = 0

	if (mx > buttonMinX and
		mx < buttonMaxX and
		my > buttonMinY and
		my < buttonMaxY) then
		subImage = 1
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			WaitingForKey = setting.SettingsName
		end
	end

	local keyPress = GetKeyPress()
	if (WaitingForKey == setting.SettingsName and
		keyPress ~= nil) then
		setting.SettingsValue = keyPress
		WaitingForKey = nil
	end

	if (WaitingForKey == setting.SettingsName) then
		subImage = 2
	end

	draw_sprite(Storage.SpriteKeyBindButton, subImage, startX, startY)
end

---Draws a settings label
---@param startX number The starting x position.
---@param startY number The starting y position.
---@param label string The label text to draw.
---@param maxSegments number The max amount of segments to use.
---@return number endX The ending position for x.
function Private.DrawLabel(startX, startY, label, maxSegments)
	local textOffsetY = 4
	local subImage = 0
	local scaling = 2
	local textWidth = string_width(label) * 2 --2x scaling
	local padding = 20
	local segmentWidth = 14
	local segmentAmount = math.ceil((textWidth + (padding * 2)) / segmentWidth) - 1
	local maxTextWidth = (maxSegments * segmentWidth) - padding

	--Set the limit
	if segmentAmount > maxSegments then
		segmentAmount = maxSegments
	end

	--Change scaling if needed
	if (textWidth > maxTextWidth) then
		scaling = (scaling * maxTextWidth) / textWidth
	end

	for i = 0, segmentAmount, 1 do
		if (i == segmentAmount) then
			subImage = 2
		elseif i > 0 then
			subImage = 1
		end

		local x = startX + (i * segmentWidth)
		draw_sprite_ext(Storage.SpriteSettingsMenuLabel, subImage, x, startY, 2, 2, 0, 16777215, 1)
	end

	draw_set_color(make_colour_rgb(218, 172, 57))
	draw_set_halign(0)
	draw_text_transformed(startX + padding, startY + textOffsetY, label, scaling, scaling, 0)

	return startX + (segmentAmount * segmentWidth) + segmentWidth
end

---Draws the save as defaults button and listens for mouse left button press.
---@param x number The x coordinate where to draw.
---@param y number The y coordinate where to draw.
---@param func fun() The action on mouse left button press.
function Private.SaveDefaultsButton(x, y, func)
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local isButtonDown = 0
	if mx > x and mx < x + 38 and my > y and my < y + 38 then
		isButtonDown = 1
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	end
	draw_sprite(Storage.SpriteSaveDefaultsButton, isButtonDown, x, y)
end

---Draws a button and listens for mouse left button press.
---@param image number The index of the image.
---@param x number The x coordinate where to draw.
---@param y number The y coordinate where to draw.
---@param func fun() The action on mouse left button press.
function Private.DrawPageButton(image, x, y, func)
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local isButtonDown = 0
	if (mx > x and mx < x + 22 and my > y and my < y + 24) then
		isButtonDown = 1
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	end
	draw_sprite(image, isButtonDown, x, y)
end

---Select the previous mod settings.
function Private.PreviousMod()
	Storage.CurrentSettingsMenuIndex = Storage.CurrentSettingsMenuIndex - 1
	if (Storage.CurrentSettingsMenuIndex < 1) then
		Storage.CurrentSettingsMenuIndex = #Storage.ModSettingData
	end
	WaitingForKey = nil
end

---Select the next mod settings.
function Private.NextMod()
	Storage.CurrentSettingsMenuIndex = Storage.CurrentSettingsMenuIndex + 1
	if (Storage.CurrentSettingsMenuIndex > #Storage.ModSettingData) then
		Storage.CurrentSettingsMenuIndex = 1
	end
	WaitingForKey = nil
end

---Save the settings as the default settings.
function Private.SaveAsDefaults()
	local SelectedModSettings = Storage.ModSettingData[Storage.CurrentSettingsMenuIndex]
	local settingsPath = Common.GetModSettingsPathByName(SelectedModSettings.ModName)

	ini_open(settingsPath)
	for _, setting in ipairs(SelectedModSettings.SettingsData) do
		ini_write_string("ModSettings", setting.SettingsName, tostring(setting.SettingsValue))
	end
	ini_close()
end

---Get the description for the given setting.
---@param modName string The name of the mod.
---@param settingsName string The name of the setting.
---@return string description The description for the setting when found, or an empty string.
function Private.GetSettingsDescription(modName, settingsName)
	local settings = Private.GetModDefaultSettings(modName)
	if (settings == nil) then
		local message = "Trying to get a settings description for a mod setting but it failed.\n"
		message = message.."Check if the setting was correctly registered. \n\n"
		message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName
		Common.ShowError(message)
		return ""
	end

	for _, setting in ipairs(settings.DefaultSettingsData) do
		if (setting.SettingsName == settingsName) then
			return setting.Description
		end
	end

	local message = "Trying to get a settings description for a mod setting but it failed.\n"
	message = message.."Check if the setting was correctly registered. \n\n"
	message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName
	Common.ShowError(message)
	return ""
end

---Gets the mod default settings.
---@param modName string The mod name to look for.
---@return DefaultModSettingData? value The value if found, nil otherwise.
function Private.GetModDefaultSettings(modName)
	for _, value in ipairs(Storage.ModDefaultData) do
		if (value.ModName == modName) then
			return value
		end
	end

	return nil
end

---Finds the name for a given virtual key code.
---@param key number The virtual key code to lookup
---@return string name The name of the key if found, "unknown" otherwise.
function Private.GetVirtualKeyName(key)
	local keys = Types.VirtualKeys

	for name, value in pairs(keys) do
		if (key == value) then
			return name
		end
	end

	return "Unknown"
end

---Search for a keypress that was made
---@return number? virtualKey The virtual key press that was found or nil if non was found.
function GetKeyPress()
	local keys = Types.VirtualKeys

	for _, value in pairs(keys) do
		if (value == keys.Escape) then
			--The game uses the escape and we don't want to double map to it.
		elseif (keyboard_check_pressed(value)) then
			return value
		end
	end

	return nil
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL SETTINGS -------------------------------------------------
------------------------------------------------------------------------------

return InternalSettings