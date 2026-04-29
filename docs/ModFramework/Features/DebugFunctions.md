# ModFramework - Debug Functions

#### [Back to overview](../Overview.md)
---

A list of general use framework helper functions:

### Note:
All functions expect the framework to be loaded in the file. Recommended place to load is the create function.
```lua
--load the mod framework as a global for use within this file
Mod = require("ModFrameworkModule")
```


## Unlock all research the next day
Sets all research to be unlocked the next day. This can be used to quickly test if unlocks are working correctly.

Recommend use in "obj_database.lua" in the draw_top_menu function.
```lua
---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	--Here are some function to help with testing
	--Its recommended to remove these before releasing your mod
	local keys = Mod.Types.VirtualKeys
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all Research.")
		Mod.Research.UnlockAllResearch()
    end
end
```

## Unlock all shop components
Sets all shop components to researched. This can be used to test the component shop. This action is not saved as the components state on load is determined by research unlocks or game events.

Recommend use in "obj_database.lua" in the draw_top_menu function.
```lua
---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	--Here are some function to help with testing
	--Its recommended to remove these before releasing your mod
	local keys = Mod.Types.VirtualKeys
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all components.")
		Mod.Production.UnlockAllShopComponents()
    end
end
```

## Get the mod path
Use to get the filepath to the mod folder, regardless of the file your code is in. 
```lua
--path to the mod folder
local modFilepath = Mod.Common.GetModPath()
```

There is an alternative version to get the path by name
```lua
---path to the ModFramework folder
local modPath = Mod.Common.GetModPathByName("ModFramework")
```

## Check if its a loaded game
Use to run code only on new save game, for example adding extra items or pilots.
```lua
--We need to check if the this start is a new game or from a loaded save
if(Mod.Common.IsLoadedGame()) then
	--Since we don't want to add new items on loaded saves we return the function here.
	return
end
```

## Show messages or errors
Use to show a standardized message box to the user. These message boxes free the game execution so can be used for debugging.

Included in the message box will be a traceback. This helps finding where the message was send from and can be used for debugging proposes.
```lua
Mod.Common.ShowMessage("Unlocking all components.")
Mod.Common.ShowError("Could not do the thing i wanted to do.")
```

## Dumb object to message
Useful for printing the contents of gamemaker structs or tables. you can copy the message box by selecting (default when opening) and using Ctrl+C. and then dump in your text editor of choice.   
**Note:** since gamemaker structs are seen as numbers in lua this function cannot see the difference. Every number is treated as a gamemaker struct. So it wil throw an error when it was just a number.
```lua
--Prints the contents of a object to a message box
Mod.Common.DumpObjToMessage(object)
```

For DS maps use this.
```lua
Mod.Common.DsmapToMessage(ds_map)
```

## To Class Type message
Was used to make the gameobject documentation as seen [here](../../src/ModFramework/GameClassDefinitions/).
```lua
Mod.Common.ToClassTypeMessage(object)
```

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
