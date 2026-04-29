------------------------------------------------------------------------------
--- STORAGE ------------------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
---@class ModFrameworkStorage
local Storage = {}

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---A list of the registered mods.
---@type ModRegistration[]
Storage.ModRegistrations = {}

------------------------------------------------------------------------------
--- LOCALIZATION -------------------------------------------------------------
------------------------------------------------------------------------------

---@type boolean Flag indicating where to generate the localization files
Storage.GenerateLocalization = false

---@type string The language file setting that is selected, example "loc_english.ini"
Storage.SelectedLanguage = "loc_english.ini"

---@type string[] The known Localizations files, example "loc_english.ini"
Storage.KnownLocalizations = {
    "loc_english.ini",
    "loc_french.ini",
    "loc_german.ini",
    "loc_polish.ini",
    "loc_portuguese_brazil.ini",
    "loc_russian.ini",
    "loc_spanish.ini",
    "loc_chinese.ini",
    "loc_italian.ini",
    "japanese.ini",
}

------------------------------------------------------------------------------
--- REFERENCE LISTS ----------------------------------------------------------
------------------------------------------------------------------------------

---A list of the modded components.
---@type ModdedComponent[]
Storage.ModdedComponentList = {}

---We keep a list of all the researches the game has active.
---@type game_obj_research[]
Storage.LoadedResearchList = {}

---We keep a list of the modded researches.
---@type ModdedResearch[]
Storage.ModdedResearchList = {}

---The queue for pilots to be added
---@type LocalizedPilotCreationData[]
Storage.PilotDataQueue = {}

------------------------------------------------------------------------------
--- COMPONENT SHOP -----------------------------------------------------------
------------------------------------------------------------------------------

---We track what the next framework custom component type will be
---@type number
Storage.NextCustomComponentType = 1000

---We keep a list of the all shop components.
---@type game_obj_component[]
Storage.AllShopComponents = {}

---We keep a list of the shop weapon components by type.
---@class WeaponsComponents
---@field Kinetic game_obj_component[] kinetic weapons
---@field Missile game_obj_component[] missile weapons
---@field Energy game_obj_component[] energy weapons
---@field Thermal game_obj_component[] thermal weapons
local WeaponsComponents = {
    Kinetic = {},
    Missile = {},
    Energy = {},
    Thermal = {}
}
Storage.WeaponsComponents = WeaponsComponents

---We keep a list of the shop reactor components by type.
---@class ReactorComponents
---@field Combustion game_obj_component[] combustion reactors
---@field Fission game_obj_component[] fission reactors
---@field Fusion game_obj_component[] fusion reactors
local ReactorComponents = {
    Combustion = {},
    Fission = {},
    Fusion = {},
}
Storage.ReactorComponents = ReactorComponents

---The reference list where additional weapon indicators need to be displayed
---@type WeaponIndicatorLocation[]
Storage.WeaponIndicators = {}

---The reference to the left button
---@type number
Storage.SpriteShopButtonLeft = -1

---The reference to the right button
---@type number
Storage.SpriteShopButtonRight = -1

---The reference to original icon for the robot engineer
---@type number
Storage.SpriteShopRobotOriginal = -1

---The reference to compressed icon for the robot engineer
---@type number
Storage.SpriteShopRobotCompressed = -1

---Flag indicating if the shop icons need to be updated
---@type boolean
Storage.IsShopUpdateNeeded = true

------------------------------------------------------------------------------
--- EXPORT STORAGE -----------------------------------------------------------
------------------------------------------------------------------------------

return Storage