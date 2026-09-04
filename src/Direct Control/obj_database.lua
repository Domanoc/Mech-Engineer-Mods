
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
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	Mod.Settings.RegisterBooleanSetting("DirectControl", true, { LocalizedDefaultValue = "Enable direct control" })
	Mod.Settings.RegisterBooleanSetting("MechCamera", true, { LocalizedDefaultValue = "Force camera to follow the controlled mech" })

	local keys = Mod.Types.VirtualKeys
	Mod.Settings.RegisterKeyBindSetting("MoveUp", keys.W, { LocalizedDefaultValue = "Move up" })
	Mod.Settings.RegisterKeyBindSetting("MoveDown", keys.S, { LocalizedDefaultValue = "Move down" })
	Mod.Settings.RegisterKeyBindSetting("MoveLeft", keys.A, { LocalizedDefaultValue = "Move left" })
	Mod.Settings.RegisterKeyBindSetting("MoveRight", keys.D, { LocalizedDefaultValue = "Move right" })
	Mod.Settings.RegisterKeyBindSetting("Reload", keys.R, { LocalizedDefaultValue = "Reload" })
	Mod.Settings.RegisterKeyBindSetting("SquadFollow", keys.F1, { LocalizedDefaultValue = "Squad order: Follow me" })
	Mod.Settings.RegisterKeyBindSetting("SquadHold", keys.F2, { LocalizedDefaultValue = "Squad order: Hold position" })
end

---saving system deletes the file and creates new one before saving new info
---@param q any
function save_game_pre_event(q)
end

---@param q game_obj_database
function save_game_post_event(q)
end

---@param q game_obj_database
function load_game_pre_event(q)
end

---Called after the game is loaded
---@param q game_obj_database
function load_game_post_event(q)
end

---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	SetSquadSize()
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end


------------------------------------------------------------------------------
--- MOD FUNCTIONS ------------------------------------------------------------
------------------------------------------------------------------------------


---Set the squad size based on the district 5 level.
function SetSquadSize()
	local obj_content_hangar = Mod.Common.GetObjContentHangar()
	---@type game_obj_district
	local district5 = obj_content_hangar.m_dist[6][1]

	if (district5.level == 0) then
		variable_global_set("squad_size", 1)
	elseif (district5.level == 1) then
		variable_global_set("squad_size", 2)
	elseif (district5.level == 2) then
		variable_global_set("squad_size", 3)
	elseif (district5.level == 3) then
		variable_global_set("squad_size", 4)
	end
end