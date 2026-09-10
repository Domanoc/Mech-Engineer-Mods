
---One time script when the game is started
---@param q game_obj_component_shop
function create(q)--one time script when save is loaded	
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.Production.FixShopWeaponList()
	Internal.Production.AddModdedComponents()
end

---Triggers when item is selected in the component shop. Used to update price information.
---@param q game_obj_component_shop
function update_prices(q)
	Internal.Production.UpdateCustomTypePrices()
end

---Triggers when a component production completes.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 The number of the hangar to check to check. Note you need to increase the value by 1 to get the correct Hangar slot.
function done(q, i)
	Internal.Production.ReturnStaffAfterCustomComponentCompletion(i+1)
end

---Draw triggers when item is selected in the component shop.
---@param q game_obj_component_shop
---@param cur_item_type number
function draw_item_text(q, cur_item_type)
	Internal.Production.DrawCustomComponentDescription()
end