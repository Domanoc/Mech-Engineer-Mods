---@meta

---See the gamemaker documentation for further details on the functions

---This function will return true if the mouse button being checked has been pressed or false if it has not. 
---This function will only be triggered once for any mouse button when it is first pressed and to trigger it again 
---the button will need to have been released and pressed again. Note that it will be considered triggered for the duration of the step, 
---and for all instances that have any mouse events or that use this same function.
---@param numb -1|0|1|2|3|4|5 Which mouse button to check for.
---@return boolean bool
function mouse_check_button_pressed(numb) end

---This function will return true if the mouse button being checked has been released or false if it has not. 
---This function will only be triggered once for any mouse button when it is released 
---and to trigger it again the button will need to have been pressed and released again.
---@param numb -1|0|1|2|3|4|5 Which mouse button to check for.
---@return boolean bool
function mouse_check_button_released(numb) end

---This function will return true if the mouse button being checked is held down or false if it is not.
---@param numb -1|0|1|2|3|4|5 Which mouse button to check for.
---@return boolean bool true if the mouse button being checked is held down or false if it is not.
function mouse_check_button(numb) end

---Gets the mouse position x in window/screen coordinates, (0,0) = top-left of the window
---@return number x the mouse position x in window/screen coordinates
function window_mouse_get_x() end

---Gets the mouse position y in window/screen coordinates, (0,0) = top-left of the window
---@return number y the mouse position y in window/screen coordinates
function window_mouse_get_y() end

---This function will return the mouse x position relative to the view selected.
---@param number number The id of the view to compare the mouse position to.
---@return number x the mouse position relative to the view
function window_view_mouse_get_x(number) end

---This function will return the mouse y position relative to the view selected.
---@param number number The id of the view to compare the mouse position to.
---@return number y the mouse position relative to the view
function window_view_mouse_get_y(number) end

---This function returns the x-coordinate of the mouse with respect to all the active views and returns the same value mouse_x.
---@return number x the mouse position relative to the view
function window_views_mouse_get_x() end

---This function returns the y-coordinate of the mouse with respect to all the active views and returns the same value mouse_y.
---@return number y the mouse position relative to the view
function window_views_mouse_get_y() end