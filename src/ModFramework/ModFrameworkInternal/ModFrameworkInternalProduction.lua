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
local areShopComponentsStored = false

---Flag indicating if the modded weapon descriptions are set
local isWeaponDescComplete = false

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Use in the create function of obj_component_shop.lua
---
---Fixes the empty references in the comp_wep table
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

---Use in the create function of obj_component_shop.lua
---
---Fixes the empty references in the list_weapon table
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

---Use in the load_game_post_event function of obj_database.lua
---
---This Fixes the missing production sprites after loading a modded game
---Modded sprite data is not saved so we need to fix this after load
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
			if(componentType == modded_item.ComponentType and itemIndex == modded_item.Index) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hangerTableIndexes.logo] = modded_item.Sprite
				hangar[hangerTableIndexes.logo_index] = modded_item.Sprite
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass
end

---Use in the draw_top_menu function of obj_database.lua
---
---The modded weapon descriptions need to be set in the ini output
function Production.SetModdedWeaponDescriptions()
	local obj_weapon_test = Common.GetObjWeaponTest()

	--We check if the ini has been loaded or if the update is complete
	if(obj_weapon_test.load_ini == false or isWeaponDescComplete == true) then
		return
	end

	--Copy the array to the working set
	local weaponDescriptions = obj_weapon_test.weapon_description

	for _, component in ipairs(Storage.ModdedComponentList) do
		if(component.ComponentType == Types.ComponentTypes.Weapon) then
			local descriptionIndex = component.Index + 1
			weaponDescriptions[descriptionIndex] = component.WeaponDescription
		end
	end

	--return new data
	obj_weapon_test.weapon_description = weaponDescriptions

	--we only need to run this once so we set the flag to true
	isWeaponDescComplete = true
end

---Use in the draw_top_menu function of obj_database.lua
---
---Stores the shop components references
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

---Use in the create function of obj_component_shop.lua
---
---Adds the known modded component to the production tab where applicable
function Production.AddModdedComponents()
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.CanBeConstructed) then
			if (component.ComponentType == Types.ComponentTypes.Mech) then
				Private.AddMech(component)
			elseif (component.ComponentType == Types.ComponentTypes.Weapon) then
				Private.AddWeapon(component)
			elseif (component.ComponentType == Types.ComponentTypes.Solenoid) then
				Private.AddSolenoid(component)
			end
		end
	end
end

---Adds a component of type mech to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddMech(component)

	local mech_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_mech = obj_component_shop.comp_mech

	local arraySize = #comp_mech
	local componentIndex = arraySize + 1
	local addedMechComponent = Private.AddComponentInstance()
	addedMechComponent.comp_type = Types.ComponentTypes.Mech
	addedMechComponent.comp_data_type = mech_number		--number in database
	addedMechComponent.size = component_size			--number of slots used in construction
	addedMechComponent.researched = researched			--true for researched or false for not
	comp_mech[componentIndex] = addedMechComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = componentIndex,
	}

	--send array back
	obj_component_shop.comp_mech = comp_mech
end

---Adds a component of type weapon to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddWeapon(component)

	local weapon_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_wep = obj_component_shop.comp_wep

	local arraySize = #comp_wep
	local componentIndex = arraySize + 1
	local addedWeaponComponent = Private.AddComponentInstance()
	addedWeaponComponent.comp_type = Types.ComponentTypes.Weapon
	addedWeaponComponent.comp_data_type = weapon_number		--number in database
	addedWeaponComponent.size = component_size				--number of slots used in construction
	addedWeaponComponent.researched = researched			--true for researched or false for not
	comp_wep[componentIndex] = addedWeaponComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = componentIndex,
	}

	--send array back
	obj_component_shop.comp_wep = comp_wep
end

---Adds a component of type solenoid to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddSolenoid(component)

	local solonoid_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_solenoid = obj_component_shop.comp_solenoid

	local arraySize = #comp_solenoid
	local componentIndex = arraySize + 1
	local addedSolenoidComponent = Private.AddComponentInstance()
	addedSolenoidComponent.comp_type = Types.ComponentTypes.Solenoid
	addedSolenoidComponent.comp_data_type = solonoid_number		--number in database
	addedSolenoidComponent.size = component_size				--number of slots used in construction
	addedSolenoidComponent.researched = researched				--true for researched or false for not
	comp_solenoid[componentIndex] = addedSolenoidComponent

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = componentIndex,
	}

	--send array back
	obj_component_shop.comp_solenoid = comp_solenoid
end

---Create a new obj_component instance
---@return game_obj_component objComponent the new obj_component instance
function Private.AddComponentInstance()
	local obj_component = Common.GetObjComponent()
	local newComponent = instance_create_depth(0, 0, -1, obj_component)
	--auto assign based on obj_database info
	newComponent.logo = -4
	return newComponent
end

---Store the shop components
---@param array game_obj_component[] the components to store
function Private.StoreShopComponents(array)
	for _, component in pairs(array) do
		table.insert(Storage.AllShopComponents, component)
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL PRODUCTION -----------------------------------------------
------------------------------------------------------------------------------

return Production