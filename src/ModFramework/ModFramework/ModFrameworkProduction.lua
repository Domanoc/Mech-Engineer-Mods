------------------------------------------------------------------------------
--- PRODUCTION FUNCTIONS -----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Production tab.
---@type ModFrameworkProduction
local Production = {}

---Access to the private functions in this file.
---@class ModFrameworkProductionPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")

------------------------------------------------------------------------------
--- DEBUG HELPER FUNCTIONS ---------------------------------------------------
------------------------------------------------------------------------------

---Unlocks all shop components on the next day.
---
---Recommended use in the draw_top_menu function of obj_database.lua
function Production.UnlockAllShopComponents()
	for _, component in pairs(Storage.AllShopComponents) do
		component.researched = true
	end

    Storage.IsShopUpdateNeeded = true
end

------------------------------------------------------------------------------
--- EXPORT PRODUCTION --------------------------------------------------------
------------------------------------------------------------------------------

return Production