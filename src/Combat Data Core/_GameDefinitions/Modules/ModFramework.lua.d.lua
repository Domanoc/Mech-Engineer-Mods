---@meta

---@class ModFramework the main ModFramework module
local ModFramework = {}

------------------------------------------------------------------------------

---@type ModFrameworkCommon
local Common = {}
---Access to the Common functions.
ModFramework.Common = Common

---@type ModFrameworkDatabase
local Database = {}
---Access to the functions for the Database.
ModFramework.Database = Database

---@type ModFrameworkEngineering
local Engineering = {}
---Access to the functions for the Engineering tab.
ModFramework.Engineering = Engineering

---@type ModFrameworkHanger
local Hanger = {}
---Access to the functions for the Hanger tab.
ModFramework.Hanger = Hanger

---@type ModFrameworkProduction
local Production = {}
---Access to the functions for the Production tab.
ModFramework.Production = Production

---@type ModFrameworkResearch
local Research = {}
---Access to the functions for the Research tab.
ModFramework.Research = Research

---@type ModFrameworkTypes
local Types = {}
---Access to Types used by the framework.
ModFramework.Types = Types

------------------------------------------------------------------------------
--- EXPORT MODFRAMEWORK ------------------------------------------------------
------------------------------------------------------------------------------

return ModFramework