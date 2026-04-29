
---One time script when the game is started
---@param q game_obj_component_shop
function create(q)--one time script when save is loaded	
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.Production.FixShopWeaponList()
	Internal.Production.AddModdedComponents()
end

---update information when item is picked
---@param q game_obj_component_shop
function update_prices(q)
	Internal.Production.UpdateCustomTypePrices()
end

---if component is read.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 number of the hangar to check (from 1 to 10) to check. checking hanger_mass 2d massive. yes, it's misspelled
function done(q, i)
end

---draw when item is placed on the table to watch its stats
---@param q game_obj_component_shop
---@param cut_item_type any
function draw_item_text(q, cut_item_type)
	Internal.Production.DrawCustomComponentDescription()
end