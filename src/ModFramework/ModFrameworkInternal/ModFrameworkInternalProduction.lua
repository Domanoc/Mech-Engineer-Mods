------------------------------------------------------------------------------
--- INTERNAL PRODUCTION FUNCTIONS --------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Production tab.
---@class ModFrameworkInternalProduction
local Production = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalProductionPrivate
local Private = {}
------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

---Flag indicating if the shop components are stored
---@type boolean
local areShopComponentsStored = false

---Flag indicating if the modded weapon descriptions are set
---@type boolean
local isWeaponDescComplete = false

---A timer number to animate long texts
---@type number
local textScrollTimer = 0

---The interval in frames for the scroll timer
---@type number
local textScrollInterval = 30

---The description animation data, or nil when not animating.
---@type DescriptionLineData[]?
local descriptionData = nil

---The component type of the current item. So we can track if it changes.
---@type number
local CurrentComponentType = -1

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Fixes the empty references in the obj_component_shop.comp_wep table.
---
---Used in the create function of obj_component_shop.lua
---Function needs to run before other functions use the comp_wep.
function Production.FixShopWeaponList()
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_wep = obj_component_shop.comp_wep
	local newCompWep = {}

	--the comp_wep has a lot of empty entries we will remove them to reduce modding complexity
	for i = 1, 12, 1 do
		table.insert(newCompWep, comp_wep[i])
	end

	--return the updated table
	obj_component_shop.comp_wep = newCompWep
end

---Fixes the empty references in the obj_content_weapons.list_weapon table.
---
---Used in the create function of obj_component_shop.lua
---Function needs to run before other functions use the list_weapon
function Production.FixContentWeaponList()
	if(Common.IsLoadedGame()) then
		--This issue is only present on new games
		return
	end
	local obj_content_weapons = Common.GetObjContentWeapons()

	--Copy the array to the working set
	local list_weapon = obj_content_weapons.list_weapon
	local newListWep = {}

	--the comp_wep has a lot of empty entries we will remove them to reduce modding complexity
	for _, value in pairs(list_weapon) do
		if (value ~= -4) then
			table.insert(newListWep, value)
		end
	end

	--return the updated table
	obj_content_weapons.list_weapon = newListWep
end

---This Fixes the missing production sprites after loading a modded game.
---Modded sprite data is not saved so we need to fix this after load.
---
---Used in the load_game_post_event function of obj_database.lua
function Production.SetModdedSprites()
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local hanger_mass = obj_component_shop.hanger_mass

	--Hanger identifiers
	local hangerTableIndexes = {
		component_type = 2,
		item_index = 3,
		logo = 5,
		logo_index = 11
	}

	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		local componentType = hangar[hangerTableIndexes.component_type]
		local itemIndex = hangar[hangerTableIndexes.item_index]

		for _, modded_item in ipairs(Storage.ModdedComponentList) do
			if(componentType == modded_item.ComponentType and itemIndex == modded_item.ResourceNumber) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hangerTableIndexes.logo] = modded_item.SpriteIndex
				hangar[hangerTableIndexes.logo_index] = modded_item.SpriteIndex
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass
end

---The modded weapon descriptions need to be set in the ini output.
---So the modded weapon have descriptions when using them in the engineering tab.
---
---Used in the draw_top_menu function of obj_database.lua
---This is the earliest spot where the ini loading can be completed
function Production.SetModdedWeaponDescriptions()
	local obj_weapon_test = Common.GetObjWeaponTest()

	--We check if the ini has been loaded or if the update is complete
	if(obj_weapon_test.load_ini == false or isWeaponDescComplete == true) then
		return
	end

	--Copy the array to the working set
	local weaponDescriptions = obj_weapon_test.weapon_description

	for _, component in ipairs(Storage.ModdedComponentList) do
		if(component.ComponentType == Types.ComponentTypes.Weapon and
		   component.WeaponData ~= nil) then
			weaponDescriptions[component.DatabaseIndex] = component.WeaponData.Description
		end
	end

	--return new data
	obj_weapon_test.weapon_description = weaponDescriptions

	--we only need to run this once so we set the flag to true
	isWeaponDescComplete = true
end

---Stores the shop components references.
---
---Used in the draw_top_menu function of obj_database.lua
---As by then all components should been made regardless if they are non framework.
function Production.StoreShopComponents()
	--if the components are stored skip
	if (areShopComponentsStored == true) then
		return
	end

	local obj_database = Common.GetObjDatabase()
	local obj_component_shop = Common.GetObjComponentShop()

	--Store all components in a all collection
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_beacon)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_city_parts)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_engineer)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_rocket)
	Private.StoreShopComponents(obj_component_shop.comp_cabin)
	Private.StoreShopComponents(obj_component_shop.comp_injector)
	Private.StoreShopComponents(obj_component_shop.comp_kernel)
	Private.StoreShopComponents(obj_component_shop.comp_lr_armor_end)
	Private.StoreShopComponents(obj_component_shop.comp_lr_armor_middle)
	Private.StoreShopComponents(obj_component_shop.comp_magnet)
	Private.StoreShopComponents(obj_component_shop.comp_mech)
	Private.StoreShopComponents(obj_component_shop.comp_motor)
	Private.StoreShopComponents(obj_component_shop.comp_piston)
	Private.StoreShopComponents(obj_component_shop.comp_reactor)
	Private.StoreShopComponents(obj_component_shop.comp_safety)
	Private.StoreShopComponents(obj_component_shop.comp_solenoid)
	Private.StoreShopComponents(obj_component_shop.comp_wep)
	if (obj_component_shop.CustomComponents ~= nil) then
		Private.StoreShopComponents(obj_component_shop.CustomComponents)
	end

	--Temporary work around for the "Robot Pilots Mod"
	if(obj_component_shop.comp_robot_pilot ~= nil) then
		table.insert(Storage.AllShopComponents, obj_component_shop.comp_robot_pilot)
	end

	--Store weapons per type
	for _, component in pairs(obj_component_shop.comp_wep) do
		local weaponData = obj_database.weapon_stat[component.comp_data_type + 1]
		local weaponType = ds_map_find_value(weaponData, "type")
		if (weaponType == Types.WeaponTypes.Kinetic) then
			table.insert(Storage.WeaponsComponents.Kinetic, component)
		elseif (weaponType == Types.WeaponTypes.Missile) then
			table.insert(Storage.WeaponsComponents.Missile, component)
		elseif (weaponType == Types.WeaponTypes.Energy) then
			table.insert(Storage.WeaponsComponents.Energy, component)
		elseif (weaponType == Types.WeaponTypes.Thermal) then
			table.insert(Storage.WeaponsComponents.Thermal, component)
		end
	end

	--Store reactors per type
	for _, component in pairs(obj_component_shop.comp_reactor) do
		local reactorData = obj_database.reactor_stat[component.comp_data_type + 1]
		local reactorType = ds_map_find_value(reactorData, "type")
		if (reactorType == Types.ReactorTypes.Combustion) then
			table.insert(Storage.ReactorComponents.Combustion, component)
		elseif (reactorType == Types.ReactorTypes.Fission) then
			table.insert(Storage.ReactorComponents.Fission, component)
		elseif (reactorType == Types.ReactorTypes.Fusion) then
			table.insert(Storage.ReactorComponents.Fusion, component)
		end
	end

	--we only need to run this once so we set the flag to true
	areShopComponentsStored = true
end

---Adds the known modded component to the production tab where applicable.
---
---Used in the create function of obj_component_shop.lua
---This the earliest point where the obj_component_shop exists and the ModdedComponentList should be completed. 
function Production.AddModdedComponents()
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.CanBeConstructed) then
			if (component.ComponentType == Types.ComponentTypes.Mech) then
				Private.AddMech(component)
			elseif (component.ComponentType == Types.ComponentTypes.Weapon) then
				Private.AddWeapon(component)
			elseif (component.ComponentType == Types.ComponentTypes.Solenoid) then
				Private.AddSolenoid(component)
			elseif (component.ComponentType >= 1000 and
					component.ComponentType < Storage.NextCustomComponentType) then
				Private.AddCustomComponent(component)
			end
		end
	end
end

---Sets the shop prices for the custom components
---
---Used in the update_prices function of obj_component_shop.lua
function Production.UpdateCustomTypePrices()
	local obj_component_shop = Common.GetObjComponentShop()
	local component = Private.GetCustomComponent(obj_component_shop.cur_item.comp_type)

	if (component ~= nil and 
		component.comp_type >= 1000 and
		component.comp_type < Storage.NextCustomComponentType and
		component.CustomData ~= nil) then
		obj_component_shop.price_metallite = component.CustomData.PriceMetallite
		obj_component_shop.price_bjorn = component.CustomData.PriceBjorn
		obj_component_shop.price_munilon = component.CustomData.PriceMunilon
		obj_component_shop.price_skalaknit = component.CustomData.PriceSkalaknit
		obj_component_shop.price_staff = component.CustomData.PriceStaff
		obj_component_shop.days_left = component.CustomData.ProductionDays
	end
end

---Draws the shop description for custom components
---
---Used in the draw_item_text function of obj_component_shop.lua
function Production.DrawCustomComponentDescription()
    local obj_component_shop = Common.GetObjComponentShop()
	local component = Private.GetCustomComponent(obj_component_shop.cur_item.comp_type)

	if (component ~= nil and
		component.comp_type >= 1000 and
		component.comp_type < Storage.NextCustomComponentType and
		component.CustomData ~= nil) then

		--Create the animation dataset
		if (descriptionData == nil or CurrentComponentType ~= component.comp_type) then
			descriptionData = {}
			for key, _ in ipairs(component.CustomData.ShopDescription) do
				---@type DescriptionLineData
				local data = {
					DisplayStep = -1,
					IsDoneScrolling = false,
					IsDoneWaiting = false
				}
				descriptionData[key] = data
			end
			--Reset Timer
			textScrollTimer = 0
		end

		local labelColor = make_colour_rgb(204, 165, 118)
		local valueColor = make_colour_rgb(114, 165, 204)
		local labelX = 834
		local valueX = 1088
		local startY = 686
		local rowHeight = 32
		local row = 0

		for key, line in ipairs(component.CustomData.ShopDescription) do
			local lineData = descriptionData[key]
			local value = string.format("%g", line.Value)
			local label = Private.GetDisplayLabel(lineData, line.Label, value)

			--Draw label
			draw_set_halign(0)
			draw_set_color(labelColor)
			draw_text_transformed(labelX, startY + (rowHeight * row), label, 2, 2, 0)
			--Draw value
			draw_set_color(valueColor)
			draw_set_halign(2)
			draw_text_transformed(valueX, startY + (rowHeight * row), value, 2, 2, 0)
			row = row + 1

			if (textScrollTimer == textScrollInterval - 1) then
				if (lineData.IsDoneScrolling == true and lineData.IsDoneWaiting == false) then
					lineData.IsDoneWaiting = true
				elseif (lineData.IsDoneScrolling == true and lineData.IsDoneWaiting == true) then
					lineData.DisplayStep = -1
					lineData.IsDoneScrolling = false
					lineData.IsDoneWaiting = false
				else
					lineData.DisplayStep = lineData.DisplayStep + 1
				end
			end
		end

		--Increase the timer
		textScrollTimer = textScrollTimer + 1
		textScrollTimer = textScrollTimer % textScrollInterval
	else
		--Reset
		textScrollTimer = 0
		descriptionData = nil
	end

	CurrentComponentType = obj_component_shop.cur_item.comp_type
end

---Get the part of the string that will fit. And scroll based on the lines DisplayStep.
---@param lineData DescriptionLineData The dataset to track the shop description line animation.
---@param label string The label string.
---@param value string The value string.
---@return string label The label string or part that will fit.
function Private.GetDisplayLabel(lineData, label, value)
	local maxLineWidth = 252 / 2 --text is scaled by factor 2
	local padding = 10
	local valueWidth = string_width(value) + padding
	if (string_width(label) <= maxLineWidth - valueWidth) then
		return label
	end

	local firstLoop = true
	local labelLength = #label
	for i = labelLength, 0, -1 do
		local widthTest = label:sub(1 + lineData.DisplayStep, i)
		if (string_width(widthTest) <= maxLineWidth - valueWidth) then
			if (firstLoop == true) then
				lineData.IsDoneScrolling = true
			end
			return widthTest
		end
		firstLoop = false
	end

	return "" --If we get here the value must have been massive
end

---Gets the custom component of the requested type
---@param componentType number The component type to search for.
---@return game_obj_component? component The found component, nil otherwise.
function Private.GetCustomComponent(componentType)
	local obj_component_shop = Common.GetObjComponentShop()
	for _, component in ipairs(obj_component_shop.CustomComponents) do
		if (component.comp_type == componentType) then
			return component
		end
	end
	return nil
end

---Adds a component of type mech to the production tab.
---@param component ModdedComponent The modded mech component that gets added to the production tab.
function Private.AddMech(component)
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_mech = obj_component_shop.comp_mech

	local arraySize = #comp_mech
	local componentIndex = arraySize + 1
	local addedMechComponent = Private.AddComponentInstance()
	addedMechComponent.comp_type = Types.ComponentTypes.Mech
	addedMechComponent.comp_data_type = component.ResourceNumber
	addedMechComponent.size = component.ComponentSize
	addedMechComponent.researched = component.IsResearched
	comp_mech[componentIndex] = addedMechComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = addedMechComponent

	--send array back
	obj_component_shop.comp_mech = comp_mech
end

---Adds a component of type weapon to the production tab.
---@param component ModdedComponent The modded mech component that gets added to the production tab.
function Private.AddWeapon(component)
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_wep = obj_component_shop.comp_wep

	local arraySize = #comp_wep
	local componentIndex = arraySize + 1
	local addedWeaponComponent = Private.AddComponentInstance()
	addedWeaponComponent.comp_type = Types.ComponentTypes.Weapon
	addedWeaponComponent.comp_data_type = component.ResourceNumber
	addedWeaponComponent.size = component.ComponentSize
	addedWeaponComponent.researched = component.IsResearched
	comp_wep[componentIndex] = addedWeaponComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = addedWeaponComponent

	--send array back
	obj_component_shop.comp_wep = comp_wep
end

---Adds a component of type solenoid to the production tab.
---@param component ModdedComponent The modded mech component that gets added to the production tab.
function Private.AddSolenoid(component)
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_solenoid = obj_component_shop.comp_solenoid

	local arraySize = #comp_solenoid
	local componentIndex = arraySize + 1
	local addedSolenoidComponent = Private.AddComponentInstance()
	addedSolenoidComponent.comp_type = Types.ComponentTypes.Solenoid
	addedSolenoidComponent.comp_data_type = component.ResourceNumber
	addedSolenoidComponent.size = component.ComponentSize
	addedSolenoidComponent.researched = component.IsResearched
	comp_solenoid[componentIndex] = addedSolenoidComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = addedSolenoidComponent

	--send array back
	obj_component_shop.comp_solenoid = comp_solenoid
end

---Adds a component of type custom to the production tab.
---@param component ModdedComponent The modded custom component that gets added to the production tab.
function Private.AddCustomComponent(component)
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_custom = {}
	if (obj_component_shop.CustomComponents ~= nil) then
		comp_custom = obj_component_shop.CustomComponents
	end

	local arraySize = #comp_custom
	local componentIndex = arraySize + 1
	local addedCustomComponent = Private.AddComponentInstance()
	addedCustomComponent.comp_type = component.ComponentType
	addedCustomComponent.comp_data_type = component.ResourceNumber
	addedCustomComponent.logo = component.SpriteIndex
	addedCustomComponent.size = component.ComponentSize
	addedCustomComponent.researched = component.IsResearched
	addedCustomComponent.CustomData = component.CustomData
	comp_custom[componentIndex] = addedCustomComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = addedCustomComponent

	--send array back
	obj_component_shop.CustomComponents = comp_custom
end

---Create a new obj_component instance.
---@return game_obj_component objComponent the new obj_component instance.
function Private.AddComponentInstance()
	local obj_component = Common.GetObjComponent()
	local newComponent = instance_create_depth(0, 0, -1, obj_component)
	--Auto assign based on obj_database info
	newComponent.logo = -4
	return newComponent
end

---Store the shop components.
---@param array game_obj_component[] The components to store.
function Private.StoreShopComponents(array)
	for _, component in pairs(array) do
		table.insert(Storage.AllShopComponents, component)
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL PRODUCTION -----------------------------------------------
------------------------------------------------------------------------------

return Production