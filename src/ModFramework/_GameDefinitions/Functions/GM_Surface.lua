---@meta

---See the gamemaker documentation for further details on the functions


---This function is used to create a surface and will return the index of the surface which should be stored in a variable for future function calls.
---@param width number The width of the surface to be created
---@param height number The height of the surface to be created
---@return number index the index of the surface
function surface_create(width, height) end

---This function is essential when working with surfaces due to their volatile nature. 
---Surfaces are always held in texture memory which means that they can be destroyed from one moment to the next, 
---so you should always check that a surface exists before doing anything with it (this includes drawing it to the screen). 
---@param surface_id number The ID of the surface to check.
---@return boolean bool true if exist false otherwise
function surface_exists(surface_id) end

---When you are working with surfaces, you should always use this function whenever you are finished using them. 
---Surfaces take up space in memory and so need to be removed, normally at the end of a room, 
---but it can be done at any time depending on the use you put them to. 
---Failure to do so can cause memory leaks which will eventually slow down and crash your game.
---@param surface_id number The ID of the surface to be freed.
function surface_free(surface_id) end

---This function resets all further drawing from the target surface back to the screen.
---@return boolean bool Whether the render target was reset successfully
function surface_reset_target() end

---This function will save a surface to disc using the given filename. The surface must be saved as a *.png format file.
---@param surface_id number The ID of the surface to set as the drawing target.
---@param filepath string The filepath of the saved image file.
function surface_save(surface_id, filepath) end

---With this function you set all further drawing to the target surface rather than the screen and in this way you can tell GameMaker to only draw specific things to the specified surface.
---@param surface_id number	The surface to set as the drawing target.
---@return boolean Bool Whether the render target was set successfully
function surface_set_target(surface_id) end