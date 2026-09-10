------------------------------------------------------------------------------
--- HANGAR FUNCTIONS -----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Hangar tab.
---@type ModFrameworkHangar
local Hangar = {}

---Access to the private functions in this file.
---@class ModFrameworkHangarPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Add a new pilot to the hangar.
---@param pilotData PilotCreationData The dataset for adding a new pilot.
function Hangar.AddPilot(pilotData)
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

---Removes the default mechs that a new save starts with.
function Hangar.RemoveStartingMechs()
    --We need to check if the this start is a new game or from a loaded save
	if (Common.IsLoadedGame()) then
		--Since we don't want to change things on a loaded game we return
		return
	end

    Storage.RemoveStarterMechs = true
end

------------------------------------------------------------------------------
--- EXPORT HANGAR ------------------------------------------------------------
------------------------------------------------------------------------------

return Hangar