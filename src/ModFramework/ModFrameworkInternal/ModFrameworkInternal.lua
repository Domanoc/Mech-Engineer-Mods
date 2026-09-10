------------------------------------------------------------------------------
--- INTERNAL MODFRAMEWORK FUNCTIONS ------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
---@class ModFrameworkInternal
local Internal = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
Internal.Common = Common

local Types = require("ModFrameworkTypes")
---Access to Types used by the framework.
Internal.Types = Types

local Storage = require("ModFrameworkStorage")
---Access to the Storage of mod framework variables.
Internal.Storage = Storage

------------------------------------------------------------------------------

local Battle = require("ModFrameworkInternalBattle")
---Access to the internal functions for the Battle.
Internal.Battle = Battle

local ComponentShop = require("ModFrameworkInternalComponentShop")
---Access to the functions for the Component shop.
Internal.ComponentShop = ComponentShop

local Engineering = require("ModFrameworkInternalEngineering")
---Access to the internal functions for the Engineering tab.
Internal.Engineering = Engineering

local Hangar = require("ModFrameworkInternalHangar")
---Access to the internal functions for the Hangar tab.
Internal.Hangar = Hangar

local Production = require("ModFrameworkInternalProduction")
---Access to the internal functions for the Production tab.
Internal.Production = Production

local Research = require("ModFrameworkInternalResearch")
---Access to the internal functions for the Research tab.
Internal.Research = Research

local Settings = require("ModFrameworkInternalSetting")
---Access to the internal Settings functions.
Internal.Settings = Settings

local Debug = require("ModFrameworkInternalDebug")
---Access to the internal functions for the Debugger.
Internal.Debug = Debug

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Registers the framework and loaded mods.
function Internal.RegisterFramework()
	local keys = {}
	for k in pairs(mod_info) do
		table.insert(keys, k)
	end
	table.sort(keys)
	for _, index in ipairs(keys) do
		local path = mod_info[index]
		local loadOrderId = tonumber(index:match("^(%d+)"))

		if (loadOrderId ~= nil) then
			local normalizedPath = path:gsub("/","\\"):gsub("@","")
			local root = normalizedPath:match("^(.-\\mods\\)")
			local modFolder = normalizedPath:match("\\mods\\([^\\]+)")
			local modPath = root..modFolder.."\\"

			---@type ModRegistration
			local mod = {
				LoadOrderId = loadOrderId,
				ModName = modFolder,
				Path = modPath,
			}
			Storage.ModRegistrations[loadOrderId] = mod

			if (modFolder == "ModFramework" and loadOrderId ~= 1) then
				Common.ShowError("The ModFramework was not first in the mod load order. This can lead to issues.")
			end
		end
	end

	local normalizedPath = variable_global_get("language_file"):gsub("/","\\")
	local language = normalizedPath:match("^.+\\(.+)$")
	if (language == "chs.ini") then
		--both support the same language so we set it to the default to prevent duplication in framework localization
		language = "loc_chinese.ini"
	end
	Storage.SelectedLanguage = language

	--Set a variable that mods can check before trying to load the framework
	variable_global_set("IsModFrameworkLoaded", true)
end

------------------------------------------------------------------------------
--- EXPORT MODFRAMEWORK INTERNALS --------------------------------------------
------------------------------------------------------------------------------

return Internal