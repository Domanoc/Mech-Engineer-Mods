------------------------------------------------------------------------------
--- GLOBAL MODFRAMEWORK FUNCTIONS --------------------------------------------
------------------------------------------------------------------------------

---@class ModFramework the main ModFramework module
local ModFramework = {}

------------------------------------------------------------------------------

local Common = require("ModFrameworkCommon")
---Access to the Common functions.
ModFramework.Common = Common

local Database = require("ModFrameworkDatabase")
---Access to the functions for the Database.
ModFramework.Database = Database

local Engineering = require("ModFrameworkEngineering")
---Access to the functions for the Engineering tab.
ModFramework.Engineering = Engineering

local Hanger = require("ModFrameworkHanger")
---Access to the functions for the Hanger tab.
ModFramework.Hanger = Hanger

local Production = require("ModFrameworkProduction")
---Access to the functions for the Production tab.
ModFramework.Production = Production

local Research = require("ModFrameworkResearch")
---Access to the functions for the Research tab.
ModFramework.Research = Research

local Types = require("ModFrameworkTypes")
---Access to Types used by the framework.
ModFramework.Types = Types

------------------------------------------------------------------------------
--- EXPORT MODFRAMEWORK ------------------------------------------------------
------------------------------------------------------------------------------

return ModFramework