---@meta

---See the gamemaker documentation for further details on the functions

---This function is similar to random_range() only with integer values as the input. 
---You supply the low value for the range as well as the high value, 
---and the function will return a random integer value within (and including) the given range. 
---For example, irandom_range(10, 35) will return an integer between 10 and 35 inclusive.
---@param x1 number The low end of the range from which the random number will be selected.
---@param x2 number The high end of the range from which the random number will be selected.
---@return number random will return an integer between x1 and x2 inclusive
function irandom_range(x1, x2) end

---This function returns a random value as an integer (whole number). So, for example, to get a random number from 0 to 9 you can use irandom(9) and it will return a number from 0 to 9 inclusive.
---@param x number The upper range from which the random number will be selected.
---@return number random a number from 0 to x inclusive.
function irandom(x) end

---This function returns a random floating-point (decimal) number between the specified lower limit (inclusive) and the specified upper limit (inclusive).
---For example, random_range(20,50) will return a random number from 20.00 to 50.00, but the value may be a real number like 38.65265. Real numbers can also be used as input arguments.
---@param x1 number The low end of the range from which the random number will be selected.
---@param x2 number The high end of the range from which the random number will be selected.
---@return number random will return an number between x1 and x2 inclusive
function random_range(x1, x2) end

---This function returns a random floating-point (decimal) number between 0.0 (inclusive) and the specified upper limit (inclusive).
---For example, random(100) will return a value from 0 to 100.00, but that value can be 22.56473! 
---You can also use real numbers and not integers in this function like this - random(0.5), which will return a value between 0 and 0.500.
---@param x number The upper range from which the random number will be selected.
---@return number random will return an number between 0 and x inclusive
function random(x)  end