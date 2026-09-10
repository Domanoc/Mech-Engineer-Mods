---@meta

---Access to the functions for the Hangar tab.
---@class ModFrameworkHangar
local Hangar = {}

---Add a new pilot to the hangar.
---@param pilotData PilotCreationData The dataset for adding a new pilot.
function Hangar.AddPilot(pilotData) end

---Removes the default mechs that a new save starts with.
function Hangar.RemoveStartingMechs() end

return Hangar
