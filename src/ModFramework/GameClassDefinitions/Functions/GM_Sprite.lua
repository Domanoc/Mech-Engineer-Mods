---@meta

---See the gamemaker documentation for further details on the functions

---This function works in almost the exact same manner as sprite_add(), only instead of returning the index of the sprite you are importing, 
---it overwrites a previously created sprite index. When using this function you should use a sprite index that has been created and stored 
---in a variable using other functions like sprite_add() or sprite_create_from_surface(), or even sprite_duplicate(), 
---rather than a resource tree sprite asset.
---
---Regardless of the sprite being replaced, this function will create a new texture page for the sprite and so care should be taken 
---when using it as it may adversely affect performance by increasing the number of required texture swaps for rendering.
---@param ind number The index of the sprite to permanently replace.
---@param filepath string The filename of the image to make the new sprite.
---@param imgnumb number The number of frames the sprite will be cut up into horizontally.
---@param removeback boolean Indicates whether to make all pixels with the background color (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges.
---@param xorig number The x coordinate of the origin, relative to the sprite's top left corner.
---@param yorig number The y coordinate of the origin, relative to the sprite's top left corner.
function sprite_replace(ind, filepath, imgnumb, removeback, smooth, xorig, yorig) end

---With this function you can add an image as a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg or *.json format. 
---The function returns the new sprite index which must then be used in all further code that relates to the sprite. 
---@param filepath string The filename of the image to make the new sprite.
---@param imgnumb number The number of frames the sprite will be cut up into horizontally.
---@param removeback boolean Indicates whether to make all pixels with the background color (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges.
---@param xorig number The x coordinate of the origin, relative to the sprite's top left corner.
---@param yorig number The y coordinate of the origin, relative to the sprite's top left corner.
---@return number index The index of the sprite
function sprite_add(filepath, imgnumb, removeback, smooth, xorig, yorig) end

---This function will merge the sprite indexed in argument 1 ("ind2") with that which is indexed in argument 0 ("ind1"). 
---The images themselves are NOT merged together, but rather the image indices are merged, 
---with the sub images from sprite "ind2" appended onto those of sprite "ind1", ie: they are added on at the end. 
---Note that if the sprites are different sizes, then the appended sprites are stretched to fit the image size for "ind1".
---
---This change is permanent, and from the moment you use this function until the game is closed or the sprite deleted, 
---the sprite that is being merged into will be changed, however the sprite that it is being merged with will remain the same.
---@param ind1 number The index of the sprite to merge.
---@param ind2 number The index of the sprite that ind1 is to be merged with.
function sprite_merge(ind1, ind2) end

---This function will return the index of a newly created sprite that is a duplicate (copy) of the one input as the "index" argument.
---If the function fails, -1 is returned. This function must be used to copy any sprites from the original assets before any transformations can be done on them.
---For example, if you wish to change the bounding box for a sprite, or set its alpha from another sprite, you must first duplicate it,
---then perform the operation on the duplicated sprite and use that. A duplicated sprite will be places on its own unique texture page when created, 
---meaning that duplicating multiple sprites will create multiple texture pages and have an impact on performance, so use this function only when necessary.
---@param index number The index of the sprite to duplicate.
---@return number index The index of the duplicated sprite
function sprite_duplicate(index) end

---This function will delete a sprite from the game, freeing any memory that was reserved for it. 
---This is a very important function for those moments when you need to create and change sprites from external sources (like loading a sprite from a file with sprite_add(), 
---or duplicating a sprite using sprite_duplicate()) and should always be used to remove those assets that are no longer needed by a game, 
---or to clear an indexed asset from a variable before re-assigning another asset to that variable.
---@param index number The index of the sprite to be deleted.
---@return boolean This function will return true if the sprite was successfully deleted, or false in case of an invalid sprite (e.g. it was already deleted).
function sprite_delete(index) end

---This function will return the name as a string of the specified sprite. 
---This name is the one that has been specified for the sprite in the resource tree of the main GameMaker window. 
---Please note that this is only a string and cannot be used to reference the sprite directly - for that you would need the sprite index. 
---You can, however, use this string to get the sprite index using the returned string along with the function asset_get_index().
---@param index number The index of the sprite to get the name of.
---@return string the name of the sprite index
function sprite_get_name(index) end

---With this function you can set the properties of the collision mask that a sprite should have. 
---If you select either automatic (0) or full image (1) as the bounding box mode then the individual bounding box values can be set to 0. 
---However for a user defined mask (2) you will have to set these values. 
---The different bounding box values are always relative to the top left corner of the sprite (irrespective of the x and y origin) which is considered position (0, 0).
---@param ind number The index of the sprite to set the bounding box of.
---@param sepmasks boolean Whether to create collision masks for each sub-image of the sprite (true), or one mask for all (false).
---@param bboxmode number What kind of bounding box to use. 0 = automatic, 1 = full image, 2 = user defined.
---@param bbleft number The maximum left position of the bounding box.
---@param bbtop number The maximum top position of the bounding box.
---@param bbright number The maximum right position of the bounding box.
---@param bbbottom number The maximum bottom position of the bounding box.
---@param kind number The kind of mask, a constant (see the table in the description).
---@param tolerance number Indicates the tolerance in the transparency value (0=no tolerance, 255=full tolerance).
function sprite_collision_mask(ind, sepmasks, bboxmode, bbleft, bbtop, bbright, bbbottom, kind, tolerance) end