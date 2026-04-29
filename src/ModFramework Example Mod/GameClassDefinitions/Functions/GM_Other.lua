---@meta

---See the gamemaker documentation for further details on the functions

---Gets all the key values for a struct and returns them in an array
---@param id number the index for the struct
---@return string[] array the key values of the struct as strings
function struct_get_names(id) end

---This function gets the unique identifying index for a game asset from its name.
---
---If the asset is not found, the function will return a value of -1, otherwise it will return the unique index ID for the asset being checked. 
---This ID can then be used in other functions as you would any other index value, like the sprite_index or the path_index, for example. 
---Please note that although this function can be used to reference assets from strings (see example below), 
---you should always make sure that the asset exists before using it otherwise you may get errors that will crash your game.
---@param name any The name of the game asset to get the index of (a string).
---@return any asset The asset for the object, or -1 if the asset is not found.
function asset_get_index(name) end

---This function creates a pop-up message box which displays the given string and a button marked "Ok" to close it.
---@param value string The string to show in the pop-up message.
function show_message(value) end

------GameMaker provides this function (as well as others) to permit the user to make their own colors. 
---This particular function takes three component parts, the red, the green and the blue components of the color that you wish to make.
---These values are taken as being between 0 and 255 so you can make 16,777,216 (256*256*256) colors with this!
---@param red number The red component of the color
---@param green number The green component of the color
---@param blue number The blue component of the color
---@return number
function make_colour_rgb(red, green, blue) end