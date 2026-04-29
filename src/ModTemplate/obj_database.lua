
---Check if the ModFramework can be found
function CheckForModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
	if isLoaded ~= true then
		local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check an correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
	end
end

---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Check if the ModFramework can be found
	CheckForModFramework()
	--load the mod framework as a global for use within this file
	Mod = require("ModFramework")
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
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end