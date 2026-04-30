---@meta

---See the gamemaker documentation for further details on the functions

---A reference handle to the gamemaker ds_grid data structure. Its a dynamic 2D data structure used to store values in a grid (rows and columns).
---Lua sees ds maps as a number and you cant access the contents directly as you can with the gamemaker structs
---
---To work with ds maps use functions like: 
---ds_grid_create, ds_grid_write, ds_grid_read, ds_grid_set, ds_grid_get
---@class ds_grid

---This function creates a new DS grid data structure of the specified cell width and height. 
---The function returns DS Grid Handle which must be used in all further functions that deal with this DS grid.
---@param w number The width of the grid to be created.
---@param h number The height of the grid to be created.
---@return ds_grid ds_map the reference handle
function ds_grid_create(w,h) end

---This function can be used to convert the given ds_grid into a string, 
---which can then be stored in an external file (for example). 
---You can read the returned string from this function back into a ds_grid using the function ds_grid_read().
---@param index ds_grid the reference handle
---@return string string the converted string value
function ds_grid_write(index) end

---This function can be used to convert a string which has been created previously by the function ds_grid_write() back into a DS grid. 
---The DS grid must have been created previously using ds_grid_create()
---@param index ds_grid the reference handle where the data gets placed into
---@param str string the converted string value 
function ds_grid_read(index,str) end

---This function can be used to set a given cell within the given DS grid to any value, which can be a real number or a string.
---@param grid ds_grid the reference handle
---@param x number The x position of the cell to set.
---@param y number The y position of the cell to set.
---@param value any The value with which to set the cell.
function ds_grid_set(grid, x, y, value) end

---This function can be used to get the value from any cell within the given DS grid. 
---If you pass invalid grid coordinates to the function, then the value returned will be undefined and an error will be shown in the output window.
---@param grid ds_grid the reference handle
---@param x number The x position of the cell you want to find the value of.
---@param y number The y position of the cell you want to find the value of.
---@return any
function ds_grid_get(grid, x, y) end