---@meta

---See the gamemaker documentation for further details on the functions

---This function will return the width (in pixels) of the input string, taking into account any line-breaks the text may have. 
---It is very handy for calculating distances between text elements based on the total width of the letters 
---that make up the string as it would be drawn with draw_text() using the currently defined font.
---@param value string The string to measure the width of.
---@return number width The width of the given string.
function string_width(value) end

---This function will return the height (in pixels) of the input string, taking into account the line separation and any line-breaks the text may have. 
---It is very handy for calculating distances between text elements based on the tallest of the letters 
---that make up the string as it would be drawn with draw_text() using the currently defined font.
---@param value string The string to measure the height of.
---@return number height The height of the given string.
function string_height(value) end