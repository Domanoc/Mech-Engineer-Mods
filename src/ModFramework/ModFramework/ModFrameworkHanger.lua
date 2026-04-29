------------------------------------------------------------------------------
--- HANGER FUNCTIONS -----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Hanger tab.
---@type ModFrameworkHanger
local Hanger = {}

---Access to the private functions in this file.
---@class ModFrameworkHangerPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Add a new pilot to the hanger
---@param pilotData PilotCreationData dataset for adding a new pilot
function Hanger.AddPilot(pilotData)
    ---@type LocalizedPilotCreationData
    local localizedPilotData = {
        Template = pilotData.Template,
        WorkExperience = Common.GetLocalizedString("PilotWorkExperience", pilotData.WorkExperience.ReferenceName, pilotData.WorkExperience.LocalizedString),
        Age = pilotData.Age,
        IsCyborg = pilotData.IsCyborg,
        Name = pilotData.Name,
        Voice = pilotData.Voice,
        Level = pilotData.Level,
        LevelExperience = pilotData.LevelExperience,
        Skill = pilotData.Skill,
        Reaction = pilotData.Reaction,
        Vitality = pilotData.Vitality,
        StressResistance = pilotData.StressResistance,
    }

    table.insert(Storage.PilotDataQueue, localizedPilotData)
end

------------------------------------------------------------------------------
--- EXPORT HANGER ------------------------------------------------------------
------------------------------------------------------------------------------

return Hanger