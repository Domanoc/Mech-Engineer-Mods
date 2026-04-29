------------------------------------------------------------------------------
--- RESEARCH FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------

---Access to the internal functions for the Research tab.
---@class ModFrameworkInternalResearch
local Research = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalResearchPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")
---Access to the functions for the Engineering tab.
local Engineering = require("ModFrameworkEngineering")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Use in the create function of obj_research_panel.lua
---
---Fixes the empty references in the mres table
function Research.FixResearchPanelList()
	local obj_research_panel = Common.GetObjResearchPanel()

    --Copy the array to the working set
    local mres = obj_research_panel.mres
    local newMres = {};

    --the mres has a lot of empty entries we will remove them to reduce modding complexity
    for i = 1, 44, 1 do
        table.insert(newMres, mres[i])
    end

    --return the updated table
    obj_research_panel.mres = newMres;
end

local isResearchFixed = false
---Use in the draw_top_menu function of obj_database.lua
---
---In the event the mod is added to an existing save the newly added mod research is all defaulted to 0 days remaining and condition 0 (closed).
---To fix this we need to validate the research states to see if its a valid state through gameplay or if its a state from loading into an existing save
function Research.FixModdedResearch()
	local obj_weapon_test = Common.GetObjWeaponTest()
	local isIniLoaded = obj_weapon_test.load_ini

	--We can only fix the research after all the loading is done. so we can piggyback on the load flag for obj_weapon_test
	if(obj_weapon_test.load_ini == false or isResearchFixed == true) then
		return
	end

	for _, moddedResearch in ipairs(Storage.ModdedResearchList) do
		local research = Storage.LoadedResearchList[moddedResearch.Index]

		if(moddedResearch.InitialCondition ~= Types.ResearchConditions.Closed and research.condition == Types.ResearchConditions.Closed) then
			--special condition since this modded research item is set to condition other than closed on mod load we need force it back to initial condition if it was closed.
			--all other states should be fine: 
			--condition 1: it would mean the player stopped the research from continuing.
			--condition 2: it would mean the player started the research.
			--condition 3: it is already been completed.

			research.condition = moddedResearch.InitialCondition
			research.require_days = research.require_days_max
		elseif(research.condition == Types.ResearchConditions.Closed and research.require_days ~= research.require_days_max) then
			--Condition 0 (closed) -> research has never been started/unlocked it should have the default require_days values

			research.require_days = research.require_days_max
		elseif(research.condition == Types.ResearchConditions.Opened and research.require_days == 0)  then
			--Condition 1 (opened) -> it should have days remaining between 1 and require_days_max, 0 should be excluded as it would have moved to the condition 3
			--We only care about the case where require_days is at 0 since this would indicate a newly added research that was set to opened because the linked research was completed before.

			research.require_days = research.require_days_max
		end

		--condition 2 (researching) -> should be a valid state, we can't conclude if the number of days remaining is correct other than it should be less or equal to the max value.
		--condition 3 (researched) -> require_days should be 0
		--both these conditions shouldn't need our attention as they are most likely part of normal gameplay
	end

	--we only need to run this once so we set the flag to true
	isResearchFixed = true
end

---Use in the create function of obj_research.lua
---
---Used to store the games research items for later use.
---@param item game_obj_research the research item to be stored
function Research.StoreResearchReference(item)
	table.insert(Storage.LoadedResearchList, item)
end

---Use in the research_done function of obj_research.lua
---
---Processes the completion event for the modded research
---@param completedResearch game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number for the research as found in the debug (F6) of the research screen (upper left white number)
function Research.ProcessResearchCompletion(completedResearch, res_number)
	for _, research in ipairs(Storage.ModdedResearchList) do
		if(research.ResNumber == res_number) then
			Private.ProcessResearchUnlocks(completedResearch, research.UnlockedComponents)
		end
	end
end

---Processes the unlocks and gives the free items if applicable
---@param completedResearch game_obj_research the full reference to the game_research_item that is completed
---@param unlockedComponents ModdedComponent[] the components that are unlocked
function Private.ProcessResearchUnlocks(completedResearch, unlockedComponents)
	for _, component in ipairs(unlockedComponents) do
		if(component.ComponentType == Types.ComponentTypes.Mech) then
			Private.ProcessMechUnlock(component, completedResearch.give_item)
		elseif (component.ComponentType == Types.ComponentTypes.Weapon) then
			Private.ProcessWeaponUnlock(component, completedResearch.give_item)
		elseif (component.ComponentType == Types.ComponentTypes.Solenoid) then
			Private.ProcessSolenoidUnlock(component, completedResearch.give_item)
		end
	end

	--set to false as the items are now given
	completedResearch.give_item = false
end

---Processes the unlock for a mech type
---@param component ModdedComponent the mech component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessMechUnlock(component, giveItem)
	if (component.ShopComponent ~= nil) then
		component.ShopComponent.researched = true --activates the shop component
	end

	if (giveItem == true and component.GiveFreeItem) then
		Engineering.AddMech(component.ResourceNumber)
	end
end

---Processes the unlock for a weapon type
---@param component ModdedComponent the weapon component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessWeaponUnlock(component, giveItem)
	if (component.ShopComponent ~= nil) then
		component.ShopComponent.researched = true --activates the shop component
	end

	if (giveItem == true and component.GiveFreeItem) then
		Engineering.AddWeapon(component.ResourceNumber, false)
	end
end

---Processes the unlock for a solenoid type
---@param component ModdedComponent the solenoid component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessSolenoidUnlock(component, giveItem)
	if (component.ShopComponent ~= nil) then
		component.ShopComponent.researched = true --activates the shop component
	end

	if (giveItem == true and component.GiveFreeItem) then
		Engineering.AddSolenoid(component.ResourceNumber)
	end
end

------------------------------------------------------------------------------
--- EXPORT RESEARCH ----------------------------------------------------------
------------------------------------------------------------------------------

return Research