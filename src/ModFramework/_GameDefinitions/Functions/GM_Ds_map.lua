---@meta

---See the gamemaker documentation for further details on the functions

---A reference handle to the gamemaker ds_map data structure, stores key and value pairs.
---Lua sees ds maps as a number and you cant access the contents directly as you can with the gamemaker structs
---
---To work with ds maps use functions like: 
---ds_map_exists, ds_map_create, ds_map_destroy, ds_map_add, ds_map_copy, ds_map_find_value, ds_map_keys_to_array
---@class ds_map

---This function will return true if the specified key exists in the (previously created) DS map, and false if it does not.
---@param id ds_map The id of the data structure to check
---@param key string The key to check for
---@return boolean bool true if the specified key exists in the DS map, and false if it does not.
function ds_map_exists(id, key) end

---This function is used to create a new, empty DS map and will return a Handle to it which is then used to access the data structure in all other DS map functions.
---@return ds_map ds_map the reference handle
function ds_map_create() end

---DS maps take up space in memory, which is allocated to them when they are created. 
---This means that you also need to free this memory when the DS map is not needed to prevent errors,
---memory leaks and loss of performance when running your game. This function does just that.
---@param id ds_map the reference handle
function ds_map_destroy(id) end

---This function should be used to add sets of key/value pairs into the specified DS map.
---
---You can check this function to see if it was successful or not (it will return true on success or false otherwise), 
---as it may fail if there already exists the same key in the DS map or you specify a non-existent DS map as the ID of the map to add to.
---
---The keys and and values you supply can be made up of any combination of data types, so all of the following - and more - are acceptable (although, in practice, you would most commonly use a string for the key):
---@param id ds_map the reference handle
---@param key string The key of the value to add.
---@param val any The value to add to the map.
---@return boolean bool it will return true on success or false otherwise
function ds_map_add(id, key, val) end

---You can use this function to copy the contents of one map into another one that you have previously created using ds_map_create(). 
---If the DS map that is being copied to is not empty, then this function will clear it first before copying. 
---The original DS map remains unchanged by this process.
---@param id ds_map The id of the map you are copying to
---@param source ds_map The id of the map you are copying from
function ds_map_copy(id, source) end

---With this function you can get the value from a specified key. The input values of the function are the (previously created) DS map to use and the key to check for.
---If no such key exists then the function will return undefined.
---@param id ds_map The id of the map to use.
---@param key string The key to find.
---@return any value the value found or if no such key exists then the function will return undefined.
function ds_map_find_value(id, key) end

---With this function you can retrieve all of the keys that a DS map contains. 
---You supply the DS map ID to get the keys from (as returned by ds_map_create()) and the function will return an array where each entry in the array is a key from the DS map.
---@param id ds_map The id of the map to use.
---@return table
function ds_map_keys_to_array(id) end