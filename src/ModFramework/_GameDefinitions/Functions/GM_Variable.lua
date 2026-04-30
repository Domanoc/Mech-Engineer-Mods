---@meta

---See the gamemaker documentation for further details on the functions

---With this function you can get the value from a given named global variable. 
---You supply the name of the global variable to get the value of as a string (see example code below) 
---and the function will return the value held by the global variable or undefined if the variable does not exist.
---@param name string The name of the global variable to get (as a string)
---@return any value the value held by the global variable or undefined if the variable does not exist.
function variable_global_get(name) end

---With this function you can set the value of a given global variable. 
---You supply the name of the global variable to set the value of as a string (see example code below), 
---and then the value to set (can be any valid data type). 
---If the global variable does not exist already in the game it will be created and then assigned the value.
---@param name string The name of the global variable to set (as a string)
---@param value any The value to set the global variable to
function variable_global_set(name, value) end

---With this function you can check whether a global scope variable exists or not. 
---You supply the global variable name to check for as a string (see example code below) 
---and the function will return true if a global variable with the given name exists or false otherwise.
---@param name string The name of the global variable to check for (as a string)
---@return boolean bool true if a global variable with the given name exists or false otherwise.
function variable_global_exists(name) end

---With this function you can retrieve an array populated with the instance variable names for an instance, 
---or the global variables for a game. When you pass in an instance ID value, 
---each entry in the array will be a string of the variable name that corresponds to an instance scope variable that has been created in the instance. 
---@param instance_id number The unique ID value of the instance to check
---@return string[]
function variable_instance_get_names(instance_id) end

---With this function you can check whether an instance scope variable exists or not. 
---You supply the unique instance ID value (which can be found from the Instance Properties in the room editor, 
---or is returned when you call the function instance_create_layer()) as well as the variable name to check for as a string (see example code below). 
---The function will return true if a variable with the given name exists for the instance and false otherwise.
---@param instance_id number The unique ID value of the instance to check
---@param name string The name of the variable to check for
---@return boolean bool true if a variable with the given name exists for the instance and false otherwise.
function variable_instance_exists(instance_id, name) end

---With this function you can get the value from a given named variable. 
---You supply the unique instance ID value (which can be found from the Instance Properties in the room editor, 
---or is returned when you call the function instance_create_layer()) as well as the name of the variable to get the value of as a string (see example code below). 
---The function will return the value held by the variable, or undefined if the variable does not exist.
---@param instance_id number The unique ID value of the instance to check
---@param name string The name of the variable to get (as a string)
---@return any value the value or undefined if the named variable does not exist
function variable_instance_get(instance_id, name) end

---With this function you can set the value of a given variable in an instance. 
---You supply the unique instance ID value (which can be found from the Instance Properties in the room editor, 
---or is returned when you call the function instance_create_layer()) as well as the name of the variable to set the value of as a string (see example code below),
---and then finally the value to set (can be any valid data type). If the variable does not exist already in the instance it will be created and then assigned the value.
---@param instance_id number The unique ID value of the instance to use
---@param name string The name of the variable to set (as a string)
---@param value any The value to set the variable to
function variable_instance_set(instance_id, name, value) end