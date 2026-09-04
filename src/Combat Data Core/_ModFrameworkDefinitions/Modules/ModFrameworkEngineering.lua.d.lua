---@meta

---Access to the functions for the Engineering tab.
---@class ModFrameworkEngineering
local Engineering = {}

---Adds a component of type cabin to engineering.
---@param resourceNumber number The resource number of the cabin.
function Engineering.AddCabin(resourceNumber) end

---Adds a component of type motor to engineering.
---@param resourceNumber number the index of the motor in the database.
function Engineering.AddMotor(resourceNumber) end

---Adds a component of type mech to engineering.
---@param resourceNumber number The resource number of the mech.
---@param name string? The name of the new mech. Or nil for a random default name.
function Engineering.AddMech(resourceNumber, name) end

---Adds a component of type weapon to engineering.
---@param resourceNumber number The resource number of the weapon.
---@param huge boolean True if the weapon is huge/+sized, false otherwise.
function Engineering.AddWeapon(resourceNumber, huge) end

---Adds a component of type reactor to engineering.
---@param resourceNumber number The resource number of the reactor.
function Engineering.AddReactor(resourceNumber) end

---Adds a component of type injector to engineering.
---@param resourceNumber number The resource number of the injector.
function Engineering.AddInjector(resourceNumber) end

---Adds a component of type piston to engineering.
---@param resourceNumber number The resource number of the piston.
function Engineering.AddPiston(resourceNumber) end

---Adds a component of type kernel to engineering.
---@param resourceNumber number The resource number of the kernel.
function Engineering.AddKernel(resourceNumber) end

---Adds a component of type safety to engineering.
---@param resourceNumber number The resource number of the safety.
function Engineering.AddSafety(resourceNumber) end

---Adds a component of type magnet to engineering.
---@param resourceNumber number The resource number of the magnet.
function Engineering.AddMagnet(resourceNumber) end

---Adds a component of type solenoid to engineering.
---@param resourceNumber number The resource number of the solenoid.
function Engineering.AddSolenoid(resourceNumber) end

---Removes all existing cabins from engineering.
function Engineering.RemoveCabins() end

---Removes all existing motors from engineering.
function Engineering.RemoveMotors() end

---Removes all existing mechs from engineering.
function Engineering.RemoveMechs() end

---Removes all existing weapons from engineering.
function Engineering.RemoveWeapons() end

---Removes all existing reactors from engineering.
function Engineering.RemoveReactors() end

---Removes all existing injectors from engineering.
function Engineering.RemoveInjectors() end

---Removes all existing pistons from engineering.
function Engineering.RemovePistons() end

---Removes all existing kernels from engineering.
function Engineering.RemoveKernels() end

---Removes all existing safeties from engineering.
function Engineering.RemoveSafeties() end

---Removes all existing magnets from engineering.
function Engineering.RemoveMagnets() end

---Removes all existing solenoids from engineering.
function Engineering.RemoveSolenoids() end

return Engineering
