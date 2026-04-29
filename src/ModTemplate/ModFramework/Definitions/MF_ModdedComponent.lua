
---@class ModdedComponent Dataset containing info for modded components.
---@field ReferenceName string The reference name of the component. Should be an unique name to prevent conflicts with other mods.
---@field ComponentType number The type of component.
---@field ComponentSize ComponentSize The size of the component when constructing it.
---@field DatabaseIndex number The index of the component in the database, or 1 for custom components.
---@field ResourceNumber number The number for the resource, or 1 for custom components. This is normally 1 less than the Database index.
---@field IsResearched boolean True if the component is researched from the start of the game, false otherwise.
---@field CanBeConstructed boolean True if it can be constructed in the component shop, false otherwise.
---@field GiveFreeItem boolean True if a free copy is created when triggered as an unlock, false otherwise.
---@field SpriteIndex number The index of the component sprite, Used to fix production sprites on game load.
---@field ShopComponent game_obj_component? The game object component that is placed in the shop, if CanBeConstructed is set to false this will be nil.
---@field WeaponData ModdedComponentWeaponData? The additional weapon data for weapon components, nil otherwise.
---@field CustomData ModdedComponentCustomData? The additional custom component data, nil otherwise.

---@class ModdedComponentWeaponData Dataset containing weapon info.
---@field Description string The description text for the weapon component.
---@field BlueLength number The range of a blue weapon for a weapon component, zero otherwise.

---@class ModdedComponentCustomData Dataset containing the custom component info.
---@field PriceMetallite number the amount of metallite needed to produce this custom component
---@field PriceBjorn number the amount of bjorn needed to produce this custom component
---@field PriceMunilon number the amount of munilon needed to produce this custom component
---@field PriceSkalaknit number the amount of skalaknit needed to produce this custom component
---@field PriceStaff number the amount of staff needed to produce this custom component
---@field ProductionDays number the amount of days it takes to produce this custom component
---@field ShopDescription ShopDescriptionLine[]

---@class ModdedComponentSearchCriteria
---@field ReferenceName string The reference name of the component.
---@field ComponentType GameComponentType The type of component.