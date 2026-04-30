---@meta

---See the gamemaker documentation for further details on the functions

---With this function you can draw any string at any position within the room (for drawing real numbers you should use the string() function to convert them into text). 
---To combine strings you can use + (see example below) and you can also use \n within a string to add a line break so it is drawn over multiple lines 
---(for information on how to properly format a string and what escape characters you can use, please see here). 
---The color of the text and the alpha are governed by the current base alpha and color values as set by draw_set_alpha() and draw_set_colour().
---@param x number The x coordinate of the drawn string.
---@param y number The y coordinate of the drawn string.
---@param string string The string to draw.
function draw_text(x, y, string) end

---This function will draw text in a similar way to draw_text() only now you can choose to scale the text along the horizontal or vertical axis (effectively stretching or shrinking it) 
---and also have GameMaker draw it at an angle (where 0 is normal and every degree over 0 rotates the text anti-clockwise).
---@param x number The x coordinate of the drawn string.
---@param y number The y coordinate of the drawn string.
---@param string string The string to draw.
---@param xscale number The horizontal scale (default 1).
---@param yscale number The vertical scale(default 1).
---@param angle number The angle of the text.
function draw_text_transformed(x, y, string, xscale, yscale, angle) end

---This function will draw text in a similar way to draw_text() only now you can 
---- set the space between each line of text 
---- should the text occupy more than one line 
---- and limit the width (in pixels) of the string per line so that should any line exceed this value
---
---GameMaker will automatically split the text to the next line at the nearest available white-space (if the text has no white-spaces then it will overrun this maximum width value).
---Note that any white space placed at the start of the string will be stripped out before being parsed for drawing because of this. Also note that a value of -1 for the line separation argument will default to a separation based on the height of the "M" character in the chosen font.
---@param x number The x coordinate of the drawn string.
---@param y number The y coordinate of the drawn string.
---@param string string The string to draw.
---@param sep number The distance in pixels between lines of text.
---@param w number The maximum width in pixels of the string before a line break.
function draw_text_ext(x, y, string, sep, w) end

---This function is used to align text along the vertical axis and changing the vertical alignment will change the position and direction 
---in which all further text is drawn, with the default value being fa_top. The following constants are accepted: "fa_top", "fa_middle", "fa_bottom"
---fa_top    = 0
---fa_middle = 1
---fa_bottom = 2
---@param valign 0|1|2 Vertical alignment constant (fa_top = 0, fa_middle = 1, fa_bottom = 2)
function draw_set_valign(valign) end

---This function is used to align text along the horizontal axis and changing the horizontal alignment will change the position and direction 
---in which all further text is drawn with the default value being fa_left. The following constants are accepted: "fa_left", "fa_center", "fa_right"
---fa_left   = 0
---fa_center = 1
---fa_right  = 2
---@param halign 0|1|2 Horizontal alignment constant (fa_left = 0, fa_center = 1, fa_right = 2)
function draw_set_halign(halign) end

---This function will set the font to be used for all further text drawing. 
---This font must have been added into the font assets of the game or have been created using either the font_add() or font_add_sprite().
---@param font number The name of the font to use.
function draw_set_font(font) end

---With this function you can set the base draw color for the game.
---@param col number The color to set for drawing.
function draw_set_color(col) end

---This function draws the sprite assigned to the instance exactly as it would be drawn if the Draw event held no code or actions, 
---and will reflect and changes that have been made to the Sprite Instance Variables in other events.
function draw_self() end

---This function draws the given sprite and sub-image at a position within the game room. 
---For the sprite you can use the instance variable sprite_index to get the current sprite that is assigned to the instance running the code, 
---or you can use any other sprite asset. The same goes for the sub-image, as this can also be set to the instance variable image_index which will set 
---the sub-image to that selected for the current instance sprite (note, that you can draw a different sprite and still use the sub-image value for the current instance), 
---or you can use any other value for this to draw a specific sub-image of the chosen sprite. If the value is larger than the number of sub-images, 
---then GameMaker will automatically loop the number to select the corresponding image (for example, if the sprite being drawn has 5 sub-images numbered 0 to 4 
---and we set the index value to 7, then the function will draw the third sub-image, numbered 2). Finally, 
---the x and y position is the position within the room that the sprite will be drawn, and it is centered on the sprite x offset and y offset.
---@param sprite number The index of the sprite to draw.
---@param subimg number The sub-image (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
---@param x number The x coordinate of where to draw the sprite.
---@param y number The y coordinate of where to draw the sprite.
function draw_sprite(sprite, subimg, x, y) end

---This function will draw the given sprite as in the function draw_sprite() but with additional options to change the scale, 
---blending, rotation and alpha of the sprite being drawn. Changing these values does not modify the resource in any way (only how it is drawn), 
---and you can use any of the available sprite variables instead of direct values for all the arguments in the function. 
---@param sprite number The index of the sprite to draw.
---@param subimg number The sub-image (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
---@param x number The x coordinate of where to draw the sprite.
---@param y number The y coordinate of where to draw the sprite.
---@param xscale number The horizontal scaling of the sprite, as a multiplier: 1 = normal scaling, 0.5 is half etc...
---@param yscale number The vertical scaling of the sprite as a multiplier: 1 = normal scaling, 0.5 is half etc...
---@param rot number The rotation of the sprite. 0=right way up, 90=rotated 90 degrees counter-clockwise etc...
---@param color number The color with which to blend the sprite. 16777215 is default(white) is to display it normally.
---@param alpha number The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
function draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, color, alpha) end

---With this function you can draw a surface at a given position within the room, with the top left corner of the surface being drawn at the specified x/y position.
---
---NOTE When working with surfaces there is the possibility that they can cease to exist at any time due to them being stored in texture memory. 
---You should ALWAYS check that a surface exists using surface_exists() before referencing them directly.
---@param id number The unique ID value of the surface to draw.
---@param x number The x position of where to draw the surface.
---@param y number The y position of where to draw the surface.
function draw_surface(id, x, y) end

---This function will take a surface and then repeatedly tile it across the whole room, starting from the coordinates that you give in the function.
---
---NOTE When working with surfaces there is the possibility that they can cease to exist at any time due to them being stored in texture memory. 
---You should ALWAYS check that a surface exists using surface_exists() before referencing them directly.
---@param id number The unique ID value of the surface to draw.
---@param x number The x position of where to draw the surface.
---@param y number The y position of where to draw the surface.
function draw_surface_tiled(id, x, y) end

---This function can be used to clear the entire screen with a given color and the alpha component of the destination is set to the value you have set - 
---this function does not do any blending as it works but any subsequent blend operations can be set up to use the destination alpha that you have set. 
---This is only for use in the draw event of an instance (it will not show if used in any other event), 
---and it can also be very useful for clearing surfaces when they are newly created.
---@param col_id number The color with which the screen will be cleared
---@param alpha number The transparency of the color with which the screen will be cleared
function draw_clear_alpha(col_id, alpha) end

---With this function you can set the base draw alpha for the game. 
---This value can be set from 0 to 1 with 0 being fully transparent and 1 being fully opaque (the default value), 
---and will affect all further drawing, including backgrounds, sprites, fonts, primitives and 3D.
---@param alpha number The alpha to set (between 0 and 1)
function draw_set_alpha(alpha) end