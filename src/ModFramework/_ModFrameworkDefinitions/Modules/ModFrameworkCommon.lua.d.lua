---@meta

---Access to the Common functions.
---@class ModFrameworkCommon
local Common = {}

---Generates Localization files based on the values requested by the registered components.
function Common.GenerateLocalizationFiles() end

---Gets the filepath to the mod folder.
---@return string? filepath The filepath to the mod folder or nil if the mod was not found.
function Common.GetModPath() end

---Gets the filepath to the mod folder.
---@param name string The name of the mod folder.
---@return string? filepath The filepath to the mod folder or nil if the mod was not found.
function Common.GetModPathByName(name) end

---Checks if this is a game loaded from a save. 
---@return boolean isLoadedGame True if this is a game loaded from a save, false otherwise.
function Common.IsLoadedGame() end

---Selects the string based on the games current language setting.
---@param section LocalizationSections The section for the localized string.
---@param key string The key for the localized string.
---@param default LocalizedString The default return value if not found.
---@return string value The found string or the default value.
function Common.GetLocalizedString(section, key, default) end

---Gets the phrase number for a given voice.
---@param voice PilotVoices The voice type.
---@return number phraseNumber The corresponding phrase number.
function Common.GetPhraseNumber(voice) end

---Get the index for a pilot template.
---@param name string The name for the pilot template to look for.
---@return number? index The index if found nil otherwise.
function Common.GetPilotTemplateIndex(name) end

---Gets the modded component.
---@param name string The name of the component.
---@param type GameComponentType The type of component.
---@return ModdedComponent? item The modded component if found, nil otherwise.
function Common.GetModdedComponent(name, type) end

---Gets the modded components based on the search criteria.
---@param searchCriteria ModdedComponentSearchCriteria[] The components to search for.
---@return ModdedComponent[] components The components found, or and empty list.
function Common.GetModdedComponents(searchCriteria) end

---Gets the modded research item.
---@param name string The name of the research item.
---@return ModdedResearch? item The modded research item if found, nil otherwise.
function Common.GetModdedResearch(name) end

---Gets the reference for "obj_database"
---@return game_obj_database obj_database The reference for "obj_database"
function Common.GetObjDatabase() end

---Gets the reference for "obj_component_shop"
---@return game_obj_component_shop obj_component_shop The reference for "obj_component_shop"
function Common.GetObjComponentShop() end

---Gets the reference for "obj_component"
---@return game_obj_component obj_component The reference for "obj_component"
function Common.GetObjComponent() end

---Gets the reference for "obj_weapon_test"
---@return game_obj_weapon_test obj_weapon_test The reference for "obj_weapon_test"
function Common.GetObjWeaponTest() end

---Gets the reference for "obj_research_panel"
---@return game_obj_research_panel obj_research_panel The reference for "obj_research_panel"
function Common.GetObjResearchPanel() end

---Gets the reference for "obj_content_cabins"
---@return game_obj_content_cabins obj_content_cabins The reference for "obj_content_cabins"
function Common.GetObjContentCabins() end

---Gets the reference for "obj_content_motors"
---@return game_obj_content_motors obj_content_motors The reference for "obj_content_motors"
function Common.GetObjContentMotors() end

---Gets the reference for "obj_content_mechs"
---@return game_obj_content_mechs obj_content_mechs The reference for "obj_content_mechs"
function Common.GetObjContentMechs() end

---Gets the reference for "obj_content_weapons"
---@return game_obj_content_weapons obj_content_weapons The reference for "obj_content_weapons"
function Common.GetObjContentWeapons() end

---Gets the reference for "obj_content_reactor"
---@return game_obj_content_reactor obj_content_reactor The reference for "obj_content_reactor"
function Common.GetObjContentReactor() end

---Gets the reference for "obj_content_piston"
---@return game_obj_content_piston obj_content_piston The reference for "obj_content_piston"
function Common.GetObjContentPiston() end

---Gets the reference for "obj_content_injector"
---@return game_obj_content_injector obj_content_injector The reference for "obj_content_injector"
function Common.GetObjContentInjector() end

---Gets the reference for "obj_content_kernel"
---@return game_obj_content_kernel obj_content_kernel The reference for "obj_content_kernel"
function Common.GetObjContentKernel() end

---Gets the reference for "obj_content_safety"
---@return game_obj_content_safety obj_content_safety The reference for "obj_content_safety"
function Common.GetObjContentSafety() end

---Gets the reference for "obj_content_magnet"
---@return game_obj_content_magnet obj_content_magnet The reference for "obj_content_magnet"
function Common.GetObjContentMagnet() end

---Gets the reference for "obj_content_solenoid"
---@return game_obj_content_solenoid obj_content_solenoid The reference for "obj_content_solenoid"
function Common.GetObjContentSolenoid() end

---Gets the reference for "obj_content_pilots"
---@return game_obj_content_pilots obj_content_pilots The reference for "obj_content_pilots"
function Common.GetObjContentPilots() end

---With this function you can add a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---
---Use this instead of calling sprite_add directly to prevent crashes when incorrect sprite data is passed.
---@param filepath string The filepath of the file to add.
---@param numberOfImages number Use to indicate the number of sub-images.
---@param removeback boolean Indicates whether to make all pixels with the background color (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges if transparent.
---@param xOrig number Indicate the x position of the origin in the sprite.
---@param yOrig number Indicate the y position of the origin in the sprite.
---@return number spriteIndex The index for the loaded sprite.
function Common.AddSprite(filepath, numberOfImages, removeback, smooth, xOrig, yOrig) end

---This function will merge the sprite indexed in "secondSpriteIndex" with that which is indexed in "firstSpriteIndex". 
---The images themselves are NOT merged together, but rather the image indices are merged, 
---with the sub images from sprite "secondSpriteIndex" appended onto those of sprite "firstSpriteIndex", ie: they are added on at the end. Note that if the sprites are different sizes, 
---then the appended sprites are stretched to fit the image size for "firstSpriteIndex".
---
---Use this instead of calling sprite_merge directly to prevent crashes when incorrect sprite data is passed.
---@param firstSpriteIndex number The index for the sprite to merge.
---@param secondSpriteIndex number The index for the sprite to merge.
function Common.MergeSprite(firstSpriteIndex, secondSpriteIndex) end

---This function will delete a sprite from the game, freeing any memory that was reserved for it.
---
---Use this instead of calling sprite_delete directly to prevent crashes when incorrect sprite data is passed.
---@param spriteIndex number The index for the sprite to delete.
function Common.DeleteSprite(spriteIndex) end

---With this function you can replace a sprite with a new image, loading from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---
---Use this instead of calling sprite_replace directly to prevent crashes when incorrect sprite data is passed.
---@param spriteIndex number the index for the sprite that will be replaced 
---@param filepath string The filepath of the file to add.
---@param numberOfImages number Use to indicate the number of sub-images.
---@param removeback boolean Indicates whether to make all pixels with the background color (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges if transparent.
---@param xOrig number Indicate the x position of the origin in the sprite.
---@param yOrig number Indicate the y position of the origin in the sprite.
function Common.ReplaceSprite(spriteIndex, filepath, numberOfImages, removeback, smooth, xOrig, yOrig) end

---A debug helper function:
---Prints a message box with the value.
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging.
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice.
---@param value string|number|boolean The value to show.
function Common.ShowMessage(value) end

---A debug helper function:
---Prints a message box with the error message.
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging.
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice.
---@param message string The error message to show.
function Common.ShowError(message) end

---A debug helper function:
---Prints a message box with the key and values of the GameMaker struct or table.
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging.
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice.
---@param ref any The GameMaker struct reference or table reference.
function Common.DumpObjToMessage(ref) end

---A debug helper function:
---Prints a message box with the key and values of the GameMaker ds_map.
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging.
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice.
---@param ds_map ds_map The reference to the ds_map.
function Common.DsmapToMessage(ds_map) end

---A debug helper function:
---Prints a message box with the key and values of the GameMaker struct as a field definitions.
---This was used to convert GameMaker objects into a lua class definition.
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging.
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice.
---@param ref any The GameMaker struct reference.
function Common.ToClassTypeMessage(ref) end

return Common
