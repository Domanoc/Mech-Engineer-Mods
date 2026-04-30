---@meta

---Access to the functions for the Research tab.
---@class ModFrameworkResearch
local Research = {}

---Adds a research item to the tech tree.
---@param researchData ResearchCreationData The dataset for the new research item.
---@return number? resNumber The number for the research as found in the debug view (F6) of the research screen (upper left white number).
function Research.AddResearch(researchData) end

---Move a research to a new position in the tree, this keeps any present links.
---@param resNumber number The number for the research as found in the debug view (F6) of the research screen (upper left white number).
---@param position ResearchPosition The position number on the research tree where to move the research to.
function Research.MoveResearch(resNumber, position) end

---Change the prerequisite of a research to a new target.
---@param resNumber number The number for the research that gets its prerequisite changed.
---@param newPrerequisiteResNumber number The res number of the research that gets set as prerequisite.
function Research.ChangePrerequisite(resNumber, newPrerequisiteResNumber) end

---Remove all unlock links (that unlock other researches on completion) on a given research.
---@param resNumber number The res number of the research that has its links cleared.
function Research.ClearUnlockLinks(resNumber) end

---Add unlocks to an existing research.
---@param resNumber number The res number to add unlocks to.
---@param unlock ModdedComponent? The component that are unlocked by this research, if a nil value is provided no action is taken.
function Research.AddUnlock(resNumber, unlock) end

---Sets all uncompleted research to unlock the next day.
---
---Recommended use in the draw_top_menu function of obj_database.lua
function Research.UnlockAllResearch() end

return Research
