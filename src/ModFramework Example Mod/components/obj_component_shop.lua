
---One time script when the game is started
---@param q game_obj_component_shop
function create(q)
    --load the mod framework as a global for use within this file
	Mod = require("ModFramework")
--
--    local component = Mod.Common.GetObjComponent()
--    local instance = instance_create_depth(q.weapon_start_x + 96 * 4, q.weapon_start_y + 96 * 4, -1, component)
--    
end

---update information when item is picked
---@param q game_obj_component_shop
function update_prices(q)
end

---if component is read.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 number of the hangar to check (from 1 to 10) to check. checking hanger_mass 2d massive. yes, it's misspelled
function done(q, i)
end

local i = 0
---draw when item is placed on the table to watch its stats
---@param q game_obj_component_shop
---@param cur_item_type number
function draw_item_text(q, cur_item_type)
--
--    local labelColor = make_colour_rgb(204, 165, 118)
--    local valueColor = make_colour_rgb(114, 165, 204)
--    local labelX = 834
--    local valueX = 1088
--    local startY = 686
--    local rowHeight = 32
--    local row = 0
--
--    local v_text = "WEIGHT";
--	local v_amount = "102";
--
--    local lines = {
--        { Label = "WEIGHT", Value = "102" },
--        { Label = "PASSIVE ARMOR", Value = "4" },
--    }
--
--	if (cur_item_type == 200) then
--
--        for _, line in ipairs(lines) do
--            --Draw label
--            draw_set_halign(0)
--            draw_set_color(labelColor)
--            draw_text_transformed(labelX, startY + (rowHeight * row), line.Label, 2, 2, 0)
--            --Draw value
--            draw_set_color(valueColor)
--            draw_set_halign(2)
--            draw_text_transformed(valueX, startY + (rowHeight * row), line.Value, 2, 2, 0)
--
--            row = row + 1
--        end
--
--        --Draw label
--        draw_set_halign(0)
--        draw_set_color(labelColor)
--        draw_text_transformed(labelX, startY + (rowHeight * row), tostring(i), 2, 2, 0)
--
--
--		draw_set_color(valueColor)
--		draw_set_halign(2)
--		draw_text_transformed(valueX, 886, tostring(i), 2, 2, 0)
--
--        i = i + 1
--        i = i % 20
--	end;
end