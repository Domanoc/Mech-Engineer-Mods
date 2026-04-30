---@meta

---Access to the functions for the Database.
---@class ModFrameworkDatabase
local Database = {}

---Adds a new mech to the games obj_database.
---@param mechData MechCreationData The dataset for adding a new mech.
function Database.AddMech(mechData) end

---Add a new weapon to the games obj_database.
---@param weaponData WeaponCreationData The dataset for adding a new weapon.
function Database.AddWeapon(weaponData) end

---Add a new solenoid to the games obj_database.
---@param solenoidData SolenoidCreationData The dataset for adding a new solenoid.
function Database.AddSolenoid(solenoidData) end

---Add a new pilot template to the games obj_database.
---@param pilotData PilotTemplateData The dataset for creating a new pilot template.
function Database.AddPilotTemplate(pilotData) end

---Add a new custom component to the game.
---
---Reminder this will only create the shop listing. A completion trigger needs to manually created.
---@param componentData CustomComponentCreationData The dataset for adding a new custom component.
function Database.AddCustomComponent(componentData) end

return Database
