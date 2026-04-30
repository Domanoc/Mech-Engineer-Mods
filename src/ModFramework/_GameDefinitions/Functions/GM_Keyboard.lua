---@meta

---See the gamemaker documentation for further details on the functions

---With this function you can check to see if a key has been pressed or not. Unlike the keyboard_check() function, 
---this function will only run once for every time the key is pressed down, 
---so for it to trigger again, the key must be first released and then pressed again.
---@param key number the virtual key code to check for
---@return boolean bool
function keyboard_check_pressed(key) end

---With this function you can check to see if a key has been released or not. 
---Unlike the keyboard_check() function, this function will only run once for every time the key is lifted, 
---so for it to trigger again, the key must be first pressed and then released again.
---@param key number the virtual key code to check for
---@return boolean bool
function keyboard_check_released(key) end

---With this function you can check to see if a key is held down or not.
---Unlike the keyboard_check_pressed or keyboard_check_released functions which are only triggered once when the key is pressed or released, this function is triggered every step that the key is held down for.
---@param key number the virtual key code to check for
---@return boolean bool
function keyboard_check(key) end