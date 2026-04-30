---@meta

---See the gamemaker documentation for further details on the functions

---This opens an ini file for reading and/or writing.
---If the ini file does not exist at the location, it may be created when writing.
---Only one ini file can be open at a time. Remember to call ini_close()
---to ensure data is written to disk.
---@param pathname string The filepath for the .ini file.
function ini_open(pathname) end

---Closes the currently open ini file and writes any pending data to disk.
---Must be called after writing, or changes will be lost.
function ini_close() end

---Reads a string value from an ini file.
---Ini files are split into sections containing key-value pairs.
---@param section string The section of the .ini to read from.
---@param key string The key within the relevant section of the .ini to read from.
---@param default string Default value if key is not found
---@return string value the string that was read or the default value otherwise
function ini_read_string(section, key, default) end

---Writes a string value to an ini file.
---Ini files are split into sections containing key-value pairs.
---@param section string The section of the .ini to write to.
---@param key string The key within the relevant section of the .ini to write to.
---@param value string The number value to write to the relevant destination.
function ini_write_string(section, key, value) end

---Reads a numeric value from an ini file.
---Ini files are split into sections containing key-value pairs.
---@param section string The section of the .ini to read from.
---@param key string The key within the relevant section of the .ini to read from.
---@param default number Default value if key is not found
---@return number value the number that was read or the default value otherwise
function ini_read_real(section, key, default) end

---Writes a number value to an ini file.
---Ini files are split into sections containing key-value pairs.
---@param section string The section of the .ini to write to.
---@param key string The key within the relevant section of the .ini to write to.
---@param value number The number value to write to the relevant destination.
function ini_write_real(section, key, value) end