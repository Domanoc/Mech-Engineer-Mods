---@meta

---Access to the functions for the Database.
---@class ModFrameworkDatabase
local Database = {}

---Adds a new mech to the games obj_database
---@param mechData MechCreationData dataset for adding a new mech
function Database.AddMech(mechData) end

---Add a new weapon to the games obj_database
---@param weaponData WeaponCreationData
function Database.AddWeapon(weaponData) end

---Add a new solenoid to the games obj_database
---@param solenoidData SolenoidCreationData
function Database.AddSolenoid(solenoidData) end

---Add a new pilot template to the games obj_database
---@param pilotData PilotTemplateData the dataset for creating a new pilot template
function Database.AddPilotTemplate(pilotData) end

---Add a new custom component to the games obj_database
---@param componentData CustomComponentCreationData
function Database.AddCustomComponent(componentData) end

return Database
