
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
	local ok, mod = pcall(require, "ModFramework")
	if (not ok or isLoaded ~= true) then
		local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check and correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)
		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
	end
	return mod
end

---One time script when the game is started
---@param q game_obj_battle_map_ext
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	q.Allies = {}
	LoadLocalization()
end

---Triggers when the extraction countdown is happening
---Triggers every interval of 5%
---@param q game_obj_battle_map_ext
function map_progression(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map_ext
function creating_map_start(q)
	q.Allies = {}

	local mechCamera = Mod.Settings.GetBooleanSettingValue("MechCamera")
	if (mechCamera == true) then
		variable_global_set("button_camera_up", 9999)
		variable_global_set("button_camera_down", 9999)
		variable_global_set("button_camera_left", 9999)
		variable_global_set("button_camera_right", 9999)
	else
		local keys = Mod.Types.VirtualKeys
		variable_global_set("button_camera_up", keys.W)
		variable_global_set("button_camera_down", keys.S)
		variable_global_set("button_camera_left", keys.A)
		variable_global_set("button_camera_right", keys.D)
	end

	--We disable the zoom buttons so we can reuse the R and F
	variable_global_set("button_zoom_in", 9999)
	variable_global_set("button_zoom_out", 9999)
end

---Triggers once per mech that is going into the battle
---@param q game_obj_battle_map_ext
---@param q_pm any obj_ally(mech in the battle)
---@param q_om any obj_mech_item(mech card, contains IDs of all components and settings)
function creating_phy_mechs(q,q_pm,q_om)
end

---One time trigger before the battle start
---@param q game_obj_battle_map_ext
function creating_map_middle(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map_ext
function drawing_surf_gen_map(q)
end

---One time trigger before the battle start
---@param q game_obj_battle_map_ext
function creating_map_end(q)
end

---when battle ends, mechs dead. for regular scout maps
---@param q any
function battle_end_scout_mechs_dead(q)
end

---when battle ends, mechs win. for regular scout maps
---@param q any
function battle_end_scout_win(q)
end

---@param q any
function battle_retreat(q)
end

---Triggers every frame of the battle even when the battle is paused
---@param q game_obj_battle_map_ext
function battle_going_start(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	SetSquadOrder()
end

---Triggers every unpaused frame of the battle
---Triggers after battle_going_start
---@param q game_obj_battle_map_ext
function battle_logic(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	ProcessMechControls(q)
	CountDownTimer()
end

---Triggers every unpaused frame of the battle
---Triggers after battle_logic
---@param q game_obj_battle_map_ext
function battle_end(q)
end

---Triggers every frame of the battle even when the battle is paused
---Triggers after battle_end
---@param q game_obj_battle_map_ext
function battle_going_end(q)
end

---Triggers every frame
---Triggers after battle_going_end
---@param q game_obj_battle_map_ext
function draw(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	--We disallow the selection box
	q.mech_selecting = false

	DrawOrderText()
end

---Triggers every frame
---Triggers after draw
---@param q game_obj_battle_map_ext
function draw_end(q)
end


------------------------------------------------------------------------------
--- MOD FUNCTIONS ------------------------------------------------------------
------------------------------------------------------------------------------

---The time in frames before the next squad command.
---@type number
local SquadCommandTimer = 20

---The Squad leader
---@type game_obj_ally_ext?
local leader = nil

---The current squad order
---@type "FormUp"|"HoldPosition"
local SquadOrder = "FormUp"

---The display text for the given order.
---@type string
local OrderDisplayText = ""

---The time in frames before the order text disappears.
---@type number
local OrderTimer = 0

---The localization string for the form up order.
---@type string
local localizedFormUp = ""

---The localization string for the hold position order.
---@type string
local localizedHoldPosition = ""

---Loop through the mechs and set the control commands.
---@param obj_battle_map game_obj_battle_map_ext The battle map.
function ProcessMechControls(obj_battle_map)
	local i = 0
	for _, ally in pairs(obj_battle_map.Allies) do
		if(instance_exists(ally)) then
			if (i == 0) then
				--Main mech
				DirectControlMech(ally)
				leader = ally
			elseif (i == 1 and
					leader ~= nil) then
				--Squad mate 1
				ControlSquadMember(leader, ally, -105)
			elseif (i == 2 and
					leader ~= nil) then
				--Squad mate 1
				ControlSquadMember(leader, ally, 105)
			elseif (i == 3 and
					leader ~= nil) then
				--Squad mate 1
				ControlSquadMember(leader, ally, 180)
			end

			--We skip dead mechs
			if (ally.dead == false) then
				i = i + 1
			end
		end
	end

	if (SquadCommandTimer == 0 and
		leader ~= nil) then
		SquadCommandTimer = GetSquadCommandInterval(leader)
	else
		SquadCommandTimer = SquadCommandTimer - 1
	end
end

---Handle the control on the given mech.
---@param mech game_obj_ally_ext The mech to control.
function DirectControlMech(mech)
	mech.IsControlled = true

	if (mech.dead == true) then
		return
	end

	SetEnemyTarget(mech)
	SetWeaponsFire(mech)
	SetMovement(mech)
	SetReload(mech)
end

---Sets the main target for the mech, 
---finds the closest enemy to the mouse pointer.
---@param mech game_obj_ally_ext The mech that gets the enemy target set.
function SetEnemyTarget(mech)
	local mx = window_view_mouse_get_x(2)
	local my = window_view_mouse_get_y(2)
	local mechX = mech.x
	local mechY = mech.y

	mech.ex = mx
	mech.ey = my
	mech.angle_str = 0
	mech.dir_to_en = point_direction(mechX, mechY, mx, my)
	mech.dist_to_en = point_distance(mechX, mechY, mx, my)
	mech.enem = instance_nearest(mx, my, asset_get_index("obj_enemy")) -- if doesn't exist, returns -4
end

---Set the desired movement for the mech.
---@param mech game_obj_ally_ext The mech to move.
function SetMovement(mech)
	local obj_battle_map = Mod.Common.GetObjBattleMap()
	if(obj_battle_map.manual_camera == true) then
		--Don't move mech when moving camera
		--return
	end

	--Map constraints
	local mapMinX = 0
	local mapMaxX = 1920
	local mapMinY = 2000
	local mapMaxY = 3920

	--Mech
	local mechX = mech.x
	local mechY = mech.y
	local mechSpeed = mech.base_speed

	--new position
	local newPosX, newPosY = GetMovementInput(mechX, mechY)
	local newPosDistance = point_distance(newPosX, newPosY, mechX, mechY)
	local hasNoCollision = place_free(newPosX, newPosY)

	if (newPosDistance > 1 and
		hasNoCollision == true and
		newPosX > mapMinX and
		newPosX < mapMaxX and
		newPosY > mapMinY and
		newPosY < mapMaxY) then

		local direction = point_direction(mechX, mechY, newPosX, newPosY)
		mech.x = mechX + lengthdir_x(mechSpeed, direction)
		mech.y = mechY + lengthdir_y(mechSpeed, direction)
	end

	--Set the mech position icon to match
	mech.finish_x = mech.x
	mech.finish_y = mech.y

	--Keep Camera on the mech
	local mechCamera = Mod.Settings.GetBooleanSettingValue("MechCamera")
	if (mechCamera == true) then
		obj_battle_map.manual_camera = true
		obj_battle_map.cam_x = lerp(obj_battle_map.cam_x, mech.x, 0.1)
		obj_battle_map.cam_y = lerp(obj_battle_map.cam_y, mech.y, 0.1)
	end
end

---Set the weapons fire for the mech based on user input.
---@param mech game_obj_ally_ext The mech that is shooting.
function SetWeaponsFire(mech)
	local mouse = Mod.Types.MouseButtons
	if (mouse_check_button(mouse.Left) == true) then
		mech.IsShooting = true
		return
	end
	mech.IsShooting = false
end

---Triggers the reload on user input.
---@param mech game_obj_ally_ext The mech that is reloading.
function SetReload(mech)
	local reloadKey = GetReloadKey()
	if (keyboard_check_pressed(reloadKey)) then
		ReloadWhiteAmmo(mech)
		ReloadRedAmmo(mech)
		ReloadYellowAmmo(mech)
	end

	RefundRemainingWhiteAmmo(mech)
	RefundRemainingRedAmmo(mech)
	RefundRemainingYellowAmmo(mech)
end

---Processing the red ammo reload.
---@param mech game_obj_ally_ext The mech that is reloading.
function ReloadRedAmmo(mech)
	if (mech.cur_reload_time_red == 1000 or mech.ammo_percent_red == math.huge) then
		return
	end

	--If there is still ammo remaining we store it for a refund in reload time
	if (mech.cur_reload_time_red > 0) then
		--Store the remaining ammo for a refund time
		mech.RedAmmoStillLoaded = mech.cur_reload_time_red
	end
	--we set the remaining ammo to 0 to force the reload
	mech.cur_reload_time_red = 0
end

---Process the red ammo refund.
---When reloading with ammo still loaded.
---@param mech game_obj_ally_ext The mech that is reloading.
function RefundRemainingRedAmmo(mech)
	if (mech.current_max_reload_time_red == 0 or
		mech.RedAmmoStillLoaded == 0 or
		mech.reload_type_red == false) then
		return
	end

	--Based on the percentage that was remaining we remove that percentage from the timer.
	local percentageStillLoaded = mech.RedAmmoStillLoaded / 1000
	local timeReduction = mech.current_max_reload_time_red * percentageStillLoaded
	mech.reload_type_red_timer = mech.reload_type_red_timer - timeReduction
	mech.RedAmmoStillLoaded = 0
end

---Processing the white ammo reload.
---@param mech game_obj_ally_ext The mech that is reloading.
function ReloadWhiteAmmo(mech)
	if (mech.cur_reload_time_white == 1000 or mech.ammo_percent_white == math.huge) then
		return
	end

	--If there is still ammo remaining we store it for a refund in reload time
	if (mech.cur_reload_time_white > 0) then
		--Store the remaining ammo for a refund time
		mech.WhiteAmmoStillLoaded = mech.cur_reload_time_white
	end
	--we set the remaining ammo to 0 to force the reload
	mech.cur_reload_time_white = 0
end

---Process the white ammo refund.
---When reloading with ammo still loaded.
---@param mech game_obj_ally_ext The mech that is reloading.
function RefundRemainingWhiteAmmo(mech)
	if (mech.current_max_reload_time_white == 0 or
		mech.WhiteAmmoStillLoaded == 0 or
		mech.reload_type_white == false) then
		return
	end

	--Based on the percentage that was remaining we remove that percentage from the timer.
	local percentageStillLoaded = mech.WhiteAmmoStillLoaded / 1000
	local timeReduction = mech.current_max_reload_time_white * percentageStillLoaded
	mech.reload_type_white_timer = mech.reload_type_white_timer - timeReduction
	mech.WhiteAmmoStillLoaded = 0
end

---Processing the yellow ammo reload.
---@param mech game_obj_ally_ext The mech that is reloading.
function ReloadYellowAmmo(mech)
	if (mech.cur_reload_time_yellow == 1000 or mech.ammo_percent_yellow == math.huge) then
		return
	end

	--If there is still ammo remaining we store it for a refund in reload time
	if (mech.cur_reload_time_yellow > 0) then
		--Store the remaining ammo for a refund time
		mech.YellowAmmoStillLoaded = mech.cur_reload_time_yellow
	end
	--we set the remaining ammo to 0 to force the reload
	mech.cur_reload_time_yellow = 0
end

---Process the yellow ammo refund.
---When reloading with ammo still loaded.
---@param mech game_obj_ally_ext The mech that is reloading.
function RefundRemainingYellowAmmo(mech)
	if (mech.current_max_reload_time_yellow == 0 or
		mech.YellowAmmoStillLoaded == 0 or
		mech.reload_type_yellow == false) then
		return
	end

	--Based on the percentage that was remaining we remove that percentage from the timer.
	local percentageStillLoaded = mech.YellowAmmoStillLoaded / 1000
	local timeReduction = mech.current_max_reload_time_yellow * percentageStillLoaded
	mech.reload_type_yellow_timer = mech.reload_type_yellow_timer - timeReduction
	mech.YellowAmmoStillLoaded = 0
end

---Applies the movement input to the position.
---@param startX number The starting x position.
---@param StartY number The starting y position.
---@return number newX The new x position.
---@return number newY The new y position.
function GetMovementInput(startX, StartY)
	local moveUp = GetMoveUpKey()
	local moveDown = GetMoveDownKey()
	local moveLeft = GetMoveLeftKey()
	local moveRight = GetMoveRightKey()
	if (keyboard_check(moveUp) == true) then
		StartY = StartY - 4
	end
	if (keyboard_check(moveDown) == true) then
		StartY = StartY + 4
	end
	if (keyboard_check(moveLeft) == true) then
		startX = startX - 4
	end
	if (keyboard_check(moveRight) == true) then
		startX = startX + 4
	end
	return startX, StartY
end

---Sets the desired position for the squad member.
---@param leader game_obj_ally_ext The Squad leader.
---@param member game_obj_ally_ext The squad member.
---@param angle number The angle in degrees offset in the formation
function ControlSquadMember(leader, member, angle)
	if (SquadOrder == "FormUp") then
		SetSquadPosition(leader, member, angle, 40)
	elseif (SquadOrder == "HoldPosition") then
		return
	end
end

---Sets the desired position for the squad member.
---@param leader game_obj_ally_ext The Squad leader.
---@param member game_obj_ally_ext The squad member.
---@param angle number The angle in degrees to offset the position.
---@param distance number The distance in pixels to offset the position.
function SetSquadPosition(leader, member, angle, distance)
	if (SquadCommandTimer ~= 0) then
		return
	end

	--Map constraints
	local mapMinX = 0
	local mapMaxX = 1920
	local mapMinY = 2000
	local mapMaxY = 3920

	local direction = (leader.mirror_dir + angle) % 360

	local newPosX = leader.x + lengthdir_x(distance, direction)
	local newPosY = leader.y + lengthdir_y(distance, direction)
	local newPosDistance = point_distance(newPosX, newPosY, member.x, member.y)
	local hasNoCollision = place_free(newPosX, newPosY)

	if (newPosDistance > 40 and
		hasNoCollision == true and
		newPosX > mapMinX and
		newPosX < mapMaxX and
		newPosY > mapMinY and
		newPosY < mapMaxY) then

		member.DesiredSquadPosX = newPosX
		member.DesiredSquadPosY = newPosY
	end
end

---Gets the interval between squad orders.
---@param leader game_obj_ally_ext The Squad leader.
---@return number interval The interval in frames.
function GetSquadCommandInterval(leader)
	local baseInterval = 100
	local skillPenalty = 1.4
	local interval = math.floor(((100 - leader.pilot_skill) * skillPenalty) + baseInterval)

	return interval
end

---Sets the squad order based on user input
function SetSquadOrder()
	local squadFollow = GetSquadFollowKey()
	local squadHold = GetSquadHoldKey()
	if (keyboard_check_pressed(squadFollow)) then
		SquadOrder = "FormUp"
		OrderDisplayText = localizedFormUp
		OrderTimer = 120
	end
	if (keyboard_check_pressed(squadHold)) then
		SquadOrder = "HoldPosition"
		OrderDisplayText = localizedHoldPosition
		OrderTimer = 120
	end
end

---Decrease the order timer
function CountDownTimer()
	if (OrderTimer >= 0) then
		OrderTimer = OrderTimer - 1
	end
end

---Draw the display order text
function DrawOrderText()
	if (OrderTimer < 0 or leader == nil) then
		return
	end

	local x = leader.x
	local y = leader.y + 20

	draw_set_halign(1)
	draw_set_color(make_colour_rgb(255, 255, 255))
	draw_text_transformed(x, y, OrderDisplayText, 1.5, 1.5, 0)
end

---Load the localization texts
function LoadLocalization()
	localizedFormUp = Mod.Common.GetLocalizedString("Custom", "FormUp", { LocalizedDefaultValue = "Get in position"})
	localizedHoldPosition = Mod.Common.GetLocalizedString("Custom", "HoldPosition", { LocalizedDefaultValue = "Hold position"})
end

---Get the key code for reload.
---@return number key The key code for reload.
function GetReloadKey()
	local reloadKey = Mod.Settings.GetKeyBindSettingValue("Reload")
	if (reloadKey == nil) then
		local keys = Mod.Types.VirtualKeys
		reloadKey = keys.R
	end
	return reloadKey
end

---Get the key code for move up.
---@return number key The key code for move up.
function GetMoveUpKey()
	local moveDown = Mod.Settings.GetKeyBindSettingValue("MoveUp")
	if (moveDown == nil) then
		local keys = Mod.Types.VirtualKeys
		moveDown = keys.W
	end
	return moveDown
end

---Get the key code for move down.
---@return number key The key code for move down.
function GetMoveDownKey()
	local moveDown = Mod.Settings.GetKeyBindSettingValue("MoveDown")
	if (moveDown == nil) then
		local keys = Mod.Types.VirtualKeys
		moveDown = keys.S
	end
	return moveDown
end

---Get the key code for move left.
---@return number key The key code for move left.
function GetMoveLeftKey()
	local moveLeft = Mod.Settings.GetKeyBindSettingValue("MoveLeft")
	if (moveLeft == nil) then
		local keys = Mod.Types.VirtualKeys
		moveLeft = keys.A
	end
	return moveLeft
end

---Get the key code for move right.
---@return number key The key code for move right.
function GetMoveRightKey()
	local moveRight = Mod.Settings.GetKeyBindSettingValue("MoveRight")
	if (moveRight == nil) then
		local keys = Mod.Types.VirtualKeys
		moveRight = keys.D
	end
	return moveRight
end

---Get the key code for squad follow.
---@return number key The key code for squad follow.
function GetSquadFollowKey()
	local squadFollow = Mod.Settings.GetKeyBindSettingValue("SquadFollow")
	if (squadFollow == nil) then
		local keys = Mod.Types.VirtualKeys
		squadFollow = keys.D
	end
	return squadFollow
end

---Get the key code for squad hold.
---@return number key The key code for squad hold.
function GetSquadHoldKey()
	local squadHold = Mod.Settings.GetKeyBindSettingValue("SquadHold")
	if (squadHold == nil) then
		local keys = Mod.Types.VirtualKeys
		squadHold = keys.D
	end
	return squadHold
end