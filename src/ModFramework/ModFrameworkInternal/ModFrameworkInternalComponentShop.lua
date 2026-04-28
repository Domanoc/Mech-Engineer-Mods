------------------------------------------------------------------------------
--- INTERNAL COMPONENT SHOP FUNCTIONS ----------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Component shop.
---@class ModFrameworkInternalComponentShop
local ComponentShop = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalComponentShopPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")


---The spacing of the shop components
---@type number
local componentSpacing = 97
---The page status for the additional section
---@type ShopPagination
local additionalPage = { CurrentPage = 0, MaxPage = 0 }
---The page status for the mechs section
---@type ShopPagination
local mechsPage = { CurrentPage = 0, MaxPage = 0 }
---The page status for the weapons section
---@type ShopPagination
local weaponsPage = { CurrentPage = 0, MaxPage = 0 }
---The page status for the support section
---@type ShopPagination
local supportPage = { CurrentPage = 0, MaxPage = 0 }
---The page status for the reactors section
---@type ShopPagination
local reactorsPage = { CurrentPage = 0, MaxPage = 0 }

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Use in the create function of obj_database.lua
---
---Loads the needed shop sprites, so we can add buttons and rearrange the layout
function ComponentShop.LoadShopSprites()
	local modPath = Common.GetModPathByName("ModFramework");
	Storage.SpriteShopButtonLeft = Common.AddSprite(modPath.."sprites\\ShopButtonLeft.png", 2, false, false, 0, 0)
	Storage.SpriteShopButtonRight = Common.AddSprite(modPath.."sprites\\ShopButtonRight.png", 2, false, false, 0, 0)
    Storage.SpriteShopRobotOriginal = asset_get_index("spr_engineer_robot")
    Storage.SpriteShopRobotCompressed = Common.AddSprite(modPath.."sprites\\spr_engineer_robot.png", 1, false, false, 0, 0)

	--We change the shop background sprite to allow better rearranging of the items
	local engineeringSprite = asset_get_index("spr_back_shop")
	Common.ReplaceSprite(engineeringSprite, modPath.."sprites\\spr_back_shop.png", 1, false, false, 0, 0)
end

---The robot sprite was bleeding out of the construction box so we replaced its icon
---but when selected we set its full icon again
function ComponentShop.FixRobotComponentBleed()
    local obj_component_shop = Common.GetObjComponentShop()
    local robotEngineer = obj_component_shop.comp_engineer
    local currentItem = obj_component_shop.cur_item
    if (currentItem == 0) then
        return
    end

    if (currentItem.comp_data_type == robotEngineer.comp_data_type and currentItem.comp_type == robotEngineer.comp_type) then
        currentItem.logo = Storage.SpriteShopRobotOriginal
    end
end

---Sets the flag that a new shop update needs to run
function ComponentShop.RequestShopUpdate()
    Storage.IsShopUpdateNeeded = true
end

---Arrange the shop components into its sections and pages
function ComponentShop.RearrangeShopComponents()
	--if the components are set skip
	if (Storage.IsShopUpdateNeeded == false) then
		return
	end

	for _, component in pairs(Storage.AllShopComponents) do
        --We set all components off screen so we can arrange only the ones we have room for
        --The others will be set when the pages change
		component.x = -1000
		component.y = -1000

        --Convert all researched number into proper bools
        if (component.researched == 0) then
			component.researched = false
		elseif (component.researched == 1) then
			component.researched = true
		end
	end

    Private.CalculateMaxAdditionalPage()
    Private.ArrangeAdditionalComponents()

    Private.CalculateMaxMechsPage()
    Private.ArrangeMechsComponents()

    Private.CalculateMaxWeaponsPage()
    Private.ArrangeWeaponsComponents()

    Private.CalculateMaxSupportPage()
    Private.ArrangeSupportComponents()

    Private.CalculateMaxReactorsPage()
    Private.ArrangeReactorsComponents()

	--we only need to run this once so we set the flag to false
	Storage.IsShopUpdateNeeded = false
end

---Draw call for the modded shop buttons and events
function ComponentShop.ShopDraw()
	local obj_component_shop = Common.GetObjComponentShop()
	if (obj_component_shop.activated == true) then

		--Buttons for additional
        if (additionalPage.MaxPage > 0) then
            Private.DrawButton(Storage.SpriteShopButtonLeft, 86, 454, Private.AdditionalLeftButtonPressed)
		    Private.DrawButton(Storage.SpriteShopButtonRight, 284, 454, Private.AdditionalRightButtonPressed)
		end

		--Buttons for mechs
        if (mechsPage.MaxPage > 0) then
            Private.DrawButton(Storage.SpriteShopButtonLeft, 454, 454, Private.MechsLeftButtonPressed)
		    Private.DrawButton(Storage.SpriteShopButtonRight, 652, 454, Private.MechsRightButtonPressed)
		end

		--Buttons for weapons
		if (weaponsPage.MaxPage > 0) then
			Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 174, Private.WeaponsLeftButtonPressed)
		    Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 174, Private.WeaponsRightButtonPressed)
		end

		--Buttons for support
        if (supportPage.MaxPage > 0) then
            Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 542, Private.SupportLeftButtonPressed)
            Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 542, Private.SupportRightButtonPressed)
		end

		--Buttons for reactors
        if (reactorsPage.MaxPage > 0) then
            Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 728, Private.ReactorsLeftButtonPressed)
		    Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 728, Private.ReactorsRightButtonPressed)
		end

        --Draw for the weapon indicators
        local weaponIndicatorSprite = asset_get_index("spr_wep_indicator")
        for _, weaponIndicator in ipairs(Storage.WeaponIndicators) do
            draw_sprite_ext(weaponIndicatorSprite, weaponIndicator.SubImageIndex, weaponIndicator.X, weaponIndicator.Y, 2, 2, 0, 16777215, 1)
        end

        --Fix the mouse cursor moving behind the elements
        Private.DrawMouseCursor()
	end
end

---Draws a button and listens for mouse left button press
---@param image number the index of the image
---@param x number the x coordinate where to draw
---@param y number the y coordinate where to draw
---@param func fun() the action on mouse left button press
function Private.DrawButton(image, x, y, func)
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local isButtonDown
	if (mx > x and mx < x + 22 and my > y and my < y + 24) then
		isButtonDown = 1;
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	else
		isButtonDown = 0
	end
	draw_sprite(image, isButtonDown, x, y)
end

---Draws the mouse cursor at the mouse coordinates
function Private.DrawMouseCursor()
    local cursor = asset_get_index("spr_cursor")
    local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local isButtonDown
	if (mouse_check_button(Types.MouseButtons.Left)) then
		isButtonDown = 1;
	else
		isButtonDown = 0
	end
    draw_sprite_ext(cursor, isButtonDown, mx, my, 2, 2, 0, 16777215, 1)
end

---Calculate and set the max page for the additional section
function Private.CalculateMaxAdditionalPage()
    local obj_component_shop = Common.GetObjComponentShop()

    local count = 0
    local slotsPerPage = 24
    local cadence = 6

    for _, component in ipairs(obj_component_shop.comp_cabin) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(obj_component_shop.comp_motor) do
        if (component.researched == true) then
            count = count + 1
        end
    end

    local maxPages = math.ceil(count / slotsPerPage) - 1
    additionalPage.MaxPage = maxPages
end

---Arranging the cabin and motor components in the 18 slots under the additional section
function Private.ArrangeAdditionalComponents()
    local obj_component_shop = Common.GetObjComponentShop()

    local index = 0
	local pageWidth = 3 * componentSpacing
    ---@type ArrangeSettings
    local settings = {
        CurrentPage = additionalPage.CurrentPage,
        SlotsPerPage = 18,
        Cadence = 6,
        StartX = 20 - (pageWidth * additionalPage.CurrentPage),
        StartY = 485
    }

    index = Private.ArrangeLoopVertical(obj_component_shop.comp_cabin, index, settings)
    index = Private.NextCadance(index, settings.Cadence)
    index = Private.ArrangeLoopVertical(obj_component_shop.comp_motor, index, settings)
end

---Calculate and set the max page for the mechs section
function Private.CalculateMaxMechsPage()
    local obj_component_shop = Common.GetObjComponentShop()

    local count = 0
    local slotsPerPage = 30
    local cadence = 5

    for _, component in ipairs(obj_component_shop.comp_mech) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(obj_component_shop.comp_lr_armor_end) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(obj_component_shop.comp_lr_armor_middle) do
        if (component.researched == true) then
            count = count + 1
        end
    end

    local maxPages = math.ceil(count / slotsPerPage) - 1
    mechsPage.MaxPage = maxPages
end

---Arranging the mech and armor components in the 30 slots under the mechs section
function Private.ArrangeMechsComponents()
    local obj_component_shop = Common.GetObjComponentShop()

    local index = 0
	local pageWidth = 5 * componentSpacing
    ---@type ArrangeSettings
    local settings = {
        CurrentPage = mechsPage.CurrentPage,
        SlotsPerPage = 30,
        Cadence = 5,
        StartX = 320 - (pageWidth * mechsPage.CurrentPage),
        StartY = 485
    }

    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_mech, index, settings)
    index = Private.NextCadance(index, settings.Cadence)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_lr_armor_end, index, settings)
    index = Private.NextCadance(index, settings.Cadence)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_lr_armor_middle, index, settings)
end

---Calculate and set the max page for the weapon section
function Private.CalculateMaxWeaponsPage()
    local count = 0
    local slotsPerPage = 24
    local cadence = 3

    for _, component in ipairs(Storage.WeaponsComponents.Kinetic) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(Storage.WeaponsComponents.Missile) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(Storage.WeaponsComponents.Energy) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(Storage.WeaponsComponents.Thermal) do
        if (component.researched == true) then
            count = count + 1
        end
    end

    local maxPages = math.ceil(count / slotsPerPage) - 1
    weaponsPage.MaxPage = maxPages
end

---Arranging the weapon components in the 24 slots under the weapons section
function Private.ArrangeWeaponsComponents()
    local index = 0
	local pageWidth = 8 * componentSpacing
    ---@type ArrangeSettings
    local settings = {
        CurrentPage = weaponsPage.CurrentPage,
        SlotsPerPage = 24,
        Cadence = 3,
        StartX = 1120 - (pageWidth * weaponsPage.CurrentPage),
        StartY = 221
    }

    --Clear the list
    Storage.WeaponIndicators = {}

	index = Private.ArrangeWeaponsLoopVertical(Storage.WeaponsComponents.Kinetic, index, settings, Types.WeaponInicator.Kinetic)
    index = Private.NextCadance(index, settings.Cadence)
	index = Private.ArrangeWeaponsLoopVertical(Storage.WeaponsComponents.Missile, index, settings, Types.WeaponInicator.Missile)
	index = Private.NextCadance(index, settings.Cadence)
	index = Private.ArrangeWeaponsLoopVertical(Storage.WeaponsComponents.Energy, index, settings, Types.WeaponInicator.Energy)
	index = Private.NextCadance(index, settings.Cadence)
	index = Private.ArrangeWeaponsLoopVertical(Storage.WeaponsComponents.Thermal, index, settings, Types.WeaponInicator.Thermal)
end

---Calculate and set the max page for the support section
function Private.CalculateMaxSupportPage()
    local obj_component_shop = Common.GetObjComponentShop()

    local count = 0
    local slotsPerPage = 8

    ---@type game_obj_component[]
    local components = {
        obj_component_shop.comp_city_parts,
        obj_component_shop.comp_beacon,
        obj_component_shop.comp_rocket,
        obj_component_shop.comp_engineer,
    }

    for _, component in ipairs(components) do
        if (component.researched == true) then
            count = count + 1
        end
    end

    local maxPages = math.ceil(count / slotsPerPage) - 1
    supportPage.MaxPage = maxPages
end

---Arranging the city parts, lure, rocket and robot components in the 8 slots under the support section
function Private.ArrangeSupportComponents()
    local obj_component_shop = Common.GetObjComponentShop()

    local index = 0
	local pageWidth = 8 * componentSpacing
    ---@type ArrangeSettings
    local settings = {
        CurrentPage = mechsPage.CurrentPage,
        SlotsPerPage = 8,
        Cadence = 8,
        StartX = 1120 - (pageWidth * mechsPage.CurrentPage),
        StartY = 595
    }

    --The robot engineer sprite was bleeding out of its component button so we edit it for the shop
    obj_component_shop.comp_engineer.logo = Storage.SpriteShopRobotCompressed

    ---@type game_obj_component[]
    local components = {
        obj_component_shop.comp_city_parts,
        obj_component_shop.comp_beacon,
        obj_component_shop.comp_rocket,
        obj_component_shop.comp_engineer,
    }
    Private.ArrangeLoopHorizontal(components, index, settings)
end

---Calculate and set the max page for the reactors section
function Private.CalculateMaxReactorsPage()
    local obj_component_shop = Common.GetObjComponentShop()

    local count = 0
    local slotsPerPage = 24
    local cadence = 8

    for _, component in ipairs(Storage.ReactorComponents.Combustion) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_injector) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_piston) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(Storage.ReactorComponents.Fission) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_kernel) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_safety) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    count = Private.NextCadance(count, cadence)
    for _, component in ipairs(Storage.ReactorComponents.Fusion) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_magnet) do
        if (component.researched == true) then
            count = count + 1
        end
    end
    for _, component in ipairs(obj_component_shop.comp_solenoid) do
        if (component.researched == true) then
            count = count + 1
        end
    end

    local maxPages = math.ceil(count / slotsPerPage) - 1
    reactorsPage.MaxPage = maxPages
end

---Arranging the reactor, injector, piston, kernel, safety, magenet and solenoid components in the 24 slots under the reactors section
function Private.ArrangeReactorsComponents()
    local obj_component_shop = Common.GetObjComponentShop()

    local index = 0
	local pageWidth = 8 * componentSpacing
    ---@type ArrangeSettings
    local settings = {
        CurrentPage = reactorsPage.CurrentPage,
        SlotsPerPage = 24,
        Cadence = 8,
        StartX = 1120 - (pageWidth * mechsPage.CurrentPage),
        StartY = 765
    }

    index = Private.ArrangeLoopHorizontal(Storage.ReactorComponents.Combustion, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_injector, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_piston, index, settings)
    index = Private.NextCadance(index, settings.Cadence)
    index = Private.ArrangeLoopHorizontal(Storage.ReactorComponents.Fission, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_kernel, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_safety, index, settings)
    index = Private.NextCadance(index, settings.Cadence)
    index = Private.ArrangeLoopHorizontal(Storage.ReactorComponents.Fusion, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_magnet, index, settings)
    index = Private.ArrangeLoopHorizontal(obj_component_shop.comp_solenoid, index, settings)
end

---Skips the index to the next full row or column
---@param index number the current index for the placement
---@param cadence number the amount of items in a row/column
---@return number index the new current index for the placement
function Private.NextCadance(index, cadence)
    if (index % cadence ~= 0) then
		return index + (cadence - (index % cadence))
	end
    return index
end

---Arrange components to a grid in vertical columns
---@param array game_obj_component[] the components to be arranged
---@param index number the current index for the placement
---@param settings ArrangeSettings the settings for the arrangement
---@return number index the new current index for the placement
function Private.ArrangeLoopVertical(array, index, settings)
    local upperBounds = (settings.SlotsPerPage - 1) + (settings.SlotsPerPage * settings.CurrentPage)
	local lowerBounds = settings.SlotsPerPage * settings.CurrentPage

	for _, component in ipairs(array) do
		local x = settings.StartX + componentSpacing * (index // settings.Cadence)
		local y = settings.StartY + componentSpacing * (index % settings.Cadence)
		if (component.researched == false) then
            --We skip components that are not unlocked
		elseif (index > upperBounds) then
			return index + 1
		elseif (index < lowerBounds) then
			index = index + 1
		else
			component.x = x
			component.y = y
			index = index + 1
		end
	end
	return index
end

---Arrange components to a grid in horizontal rows
---@param array game_obj_component[] the components to be arranged
---@param index number the current index for the placement
---@param settings ArrangeSettings the settings for the arrangement
---@return number index the new current index for the placement
function Private.ArrangeLoopHorizontal(array, index, settings)
    local upperBounds = (settings.SlotsPerPage - 1) + (settings.SlotsPerPage * settings.CurrentPage)
	local lowerBounds = settings.SlotsPerPage * settings.CurrentPage

	for _, component in ipairs(array) do
		local x = settings.StartX + componentSpacing * (index % settings.Cadence)
		local y = settings.StartY + componentSpacing * (index // settings.Cadence)
		if (component.researched == false) then
            --We skip components that are not unlocked
		elseif (index > upperBounds) then
			return index + 1
		elseif (index < lowerBounds) then
			index = index + 1
		else
			component.x = x
			component.y = y
			index = index + 1
		end
	end
	return index
end

---Arrange weapon components to a grid in vertical columns
---Has special logic to add weapon indicators
---@param array game_obj_component[] the components to be arranged
---@param index number the current index for the placement
---@param settings ArrangeSettings the settings for the arrangement
---@param indicatorType 0|1|2|3 the subimage that needs to be shown
---@return number index the new current index for the placement
function Private.ArrangeWeaponsLoopVertical(array, index, settings, indicatorType)
    local upperBounds = (settings.SlotsPerPage - 1) + (settings.SlotsPerPage * settings.CurrentPage)
	local lowerBounds = settings.SlotsPerPage * settings.CurrentPage

	for _, component in ipairs(array) do
		local x = settings.StartX + componentSpacing * (index // settings.Cadence)
		local y = settings.StartY + componentSpacing * (index % settings.Cadence)
		if (component.researched == false) then
            --We skip components that are not unlocked
		elseif (index > upperBounds) then
			return index + 1
		elseif (index < lowerBounds) then
			index = index + 1
		else
            ---@type WeaponIndicatorLocation
            local weaponIndidator = {
                X = x + 76,
                Y = y + 76,
                SubImageIndex = indicatorType
            }
            table.insert(Storage.WeaponIndicators, weaponIndidator)
			component.x = x
			component.y = y
			index = index + 1
		end
	end
	return index
end

------------------------------------------------------------------------------
--- BUTTON EVENTS ------------------------------------------------------------
------------------------------------------------------------------------------

---The left button event for the additional section
function Private.AdditionalLeftButtonPressed()
    additionalPage.CurrentPage = additionalPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (additionalPage.CurrentPage < 0) then
		additionalPage.CurrentPage = additionalPage.MaxPage
	end
end

---The right button event for the additional section
function Private.AdditionalRightButtonPressed()
	additionalPage.CurrentPage = additionalPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (additionalPage.CurrentPage > additionalPage.MaxPage) then
		additionalPage.CurrentPage = 0
	end
end

---The left button event for the mechs section
function Private.MechsLeftButtonPressed()
    mechsPage.CurrentPage = mechsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (mechsPage.CurrentPage < 0) then
		mechsPage.CurrentPage = mechsPage.MaxPage
	end
end

---The right button event for the mechs section
function Private.MechsRightButtonPressed()
	mechsPage.CurrentPage = mechsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (mechsPage.CurrentPage > mechsPage.MaxPage) then
		mechsPage.CurrentPage = 0
	end
end

---The left button event for the weapon section
function Private.WeaponsLeftButtonPressed()
	weaponsPage.CurrentPage = weaponsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (weaponsPage.CurrentPage < 0) then
		weaponsPage.CurrentPage = weaponsPage.MaxPage
	end
end

---The right button event for the weapon section
function Private.WeaponsRightButtonPressed()
	weaponsPage.CurrentPage = weaponsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (weaponsPage.CurrentPage > weaponsPage.MaxPage) then
		weaponsPage.CurrentPage = 0
	end
end

---The left button event for the support section
function Private.SupportLeftButtonPressed()
    supportPage.CurrentPage = supportPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (supportPage.CurrentPage < 0) then
		supportPage.CurrentPage = supportPage.MaxPage
	end
end

---The right button event for the support section
function Private.SupportRightButtonPressed()
	supportPage.CurrentPage = supportPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (supportPage.CurrentPage > supportPage.MaxPage) then
		supportPage.CurrentPage = 0
	end
end

---The left button event for the reactors section
function Private.ReactorsLeftButtonPressed()
    reactorsPage.CurrentPage = reactorsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (reactorsPage.CurrentPage < 0) then
		reactorsPage.CurrentPage = reactorsPage.MaxPage
	end
end

---The right button event for the reactors section
function Private.ReactorsRightButtonPressed()
	reactorsPage.CurrentPage = reactorsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (reactorsPage.CurrentPage > reactorsPage.MaxPage) then
		reactorsPage.CurrentPage = 0
	end
end


------------------------------------------------------------------------------
--- EXPORT INTERNAL COMPONENT SHOP -------------------------------------------
------------------------------------------------------------------------------

return ComponentShop