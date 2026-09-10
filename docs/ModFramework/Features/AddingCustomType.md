# ModFramework - Adding a new custom component type

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua" in the create function.

## Requirements
- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 1 Sprite
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (48x48)   
    The sprite is used in the production screen and in the inventory.   
    The sprite can be in color.   
    The sprite should have a transparent background.

## Code example
```lua
--load the mod framework
Mod = GetModFramework()

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--load needed types
local componentSizes = Mod.Types.ComponentSizes

--An example for creating a custom component.
--This is used when you need a component button in the shop that isn't linked to a standard game component.
--It will handle the shop position, description and cost.
--The result trigger needs to be done by the mod creator.
Mod.Database.AddCustomComponent({
	ReferenceName = 	"example_custom_component", --The reference name of the custom component, used to find its references
	ComponentSize =     componentSizes.Small, 		--The size of the component when constructing it. 1 for single slot or 5 for a full row
	IsResearched = 	    false,				  		--Set to true if its pre researched, else false.
	PriceMetallite =    1000,				  		--The amount of metallite needed to produce this custom component
	PriceBjorn = 	    1000,				  		--The amount of bjorn needed to produce this custom component
	PriceMunilon =      1000,				  		--The amount of munilon needed to produce this custom component
	PriceSkalaknit =    1000,				  		--The amount of skalaknit needed to produce this custom component
	PriceStaff = 	    10,					  		--The amount of staff needed to produce this custom component
	ProductionDays =    2,					  		--The amount of days it takes to produce this custom component
	SpritePath = 		modFilepath.."sprites\\example_custom.png", --The filepath for the custom component sprite. (expected 48x48 pixels)
	ShopDescription = {
		--Add the lines that should be displayed in the shop description
		--We can add a maximum of 10 lines. More will overflow the shop window.
		--The label supports localization
		{ Label = { LocalizedDefaultValue = "CUSTOM ITEM" }, Value = 1 },
		{ Label = { LocalizedDefaultValue = "SOME STAT NAME" }, Value = 0.45 },
	}
})
```

## Notes
Unlike the other component types it only has access to the IsResearched flag. 
- CanBeConstructed flag can be seen as a default true, as its the main purpose of adding a custom component.
- GiveFreeItem flag can seen as default false, as the framework doesn't know what to give.
- IsResearched = false, will expect that the weapon will be added to a research to unlock this.

**Note:** the framework does handle the setting the desired cost and dealing with staff for the production of this component. 

This type has [localization](../Localization.md) support.

## Adding a completion trigger

To add actual completion logic see the following example that was made in the obj_component_shop.lua

```lua
---Triggers when a component production completes.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 The number of the hangar to check to check. Note you need to increase the value by 1 to get the correct Hangar slot.
function done(q, i)
    --load needed types
	local hangarIndexes = Mod.Types.HangarIndexes

    local hangarSlot = i + 1
    local hangar = q.hanger_mass[hangarSlot]
	local componentType = hangar[hangarIndexes.component_type]
	local component = Mod.Common.GetCustomComponentByType(componentType)

    --Check if we found a component and if the name matches the custom component we made
    if (component ~= nil and
        component.ReferenceName == "example_custom_component") then
        --The Staff used by the construction is already returned.
        --You only need to add whatever mod logic you need for this custom component
        --Example: Giving non standard things like pilots

        local emoticon = Mod.Common.GetPilotTemplateIndex("EMOTICON")
        if (emoticon ~= nil) then
            Mod.Hangar.AddPilot({
                Template = emoticon, 	--this wil determine the used sprite and the missing optional values.
                Age = 0,				--the age of the pilot
                IsCyborg = true,		--if true the pilot is a cyborg
                Name = "MR SMILE",      --the name of the pilot
                WorkExperience = {		--the text for the work experience
                    --Data that represents a string that will be localized. Its recommended to be in english for code readability
                    --The other actual values will be pulled from the mods localization files
                    --Use the GenerateLocalizationFiles() function to generate the mods localization files in development
                    LocalizedString = { LocalizedDefaultValue = "Example of a reused work experience text." },
                    --We can reuse a previous localized reference if the value is the same
                    ReferenceName = "example_pilot_reuse"
                },
            })
        end
    end
end
```

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)