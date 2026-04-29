---@meta

---See the gamemaker documentation for further details on the functions

---With this function you can create a new instance of the specified object at any given point within the room and at the depth specified. 
---The depth can be any value, where the lower the depth the "nearer" to the camera things will be drawn and the higher the depth the further away, 
---so an instance at depth -200 will be drawn over an instance at depth +300 (for example).
---@param x number The x position the instance of the given object will be created at
---@param y number The y position the instance of the given object will be created at
---@param depth number The depth to assign the created instance to
---@param obj any The object index of the object to create an instance of
---@return any instance The created instance.
function instance_create_depth(x, y, depth, obj) end

---This function can be used in two ways depending on what you wish to check. 
---You can give it an object_index to check for, in which case this function will return true if any active instances of the specified object exist in the current room, 
---or you can also supply it with an instance id, in which case this function will return true if that specific instance exists and is active in the current room.
---@param obj number object_index or instance id
---@return boolean bool 
function instance_exists(obj) end

---This function will check all the instances of the given object to see which is furthest from the given x/y point. 
---All checks will be from the given x/y position to the origin (the x/y position) of instances of the object specified. 
---If no instances of the object exist, the function will return the keyword no one, 
---but if there are instances then it will return the id of the instance found. 
---Please note that if the instance running the code has the same object index as the object being checked, 
---then it will be included in the check (this includes checks for parent objects if the calling instance is also a child of the parent).
---@param x number The x position to check for instances far from.
---@param y number The y position to check for instances far from.
---@param obj number The object to check for instances of.
---@return number index
function instance_furthest(x, y, obj) end

---This function will check all the instances of the given object to see which is nearest to the given x/y point. 
---All checks will be from the given x/y position to the origin (the x/y position) of instances of the object specified. 
---If no instances of the object exist, the function will return the keyword no one, 
---but if there are instances then it will return the id of the instance found. 
---Please note that if the instance running the code has the same object index as the object being checked, 
---then it will be included in the check (this includes checks for parent objects if the calling instance is also a child of the parent).
---@param x number The x position to check from.
---@param y number The y position to check from.
---@param obj number The object to check for instances of.
---@return number index
function instance_nearest(x, y, obj) end

---With this function you can check a position for a collision with another instance or all instances of an object 
---using the collision mask of the instance that runs the code for the check. When you use this you are effectively 
---asking GameMaker to move the instance to the new position, check for a collision, move back and tell you if a collision was found or not.
---@param x number The x position to check for instances.
---@param y number The y position to check for instances.
---@param obj number The object to check for instances of.
function instance_place(x, y, obj) end