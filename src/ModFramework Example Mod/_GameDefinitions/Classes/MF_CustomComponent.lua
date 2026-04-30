---@class CustomComponentCreationData Dataset for adding a new custom component.
---@field ReferenceName string The reference name of the custom component. Should be an unique name to prevent conflicts with other mods.
---@field ComponentSize ComponentSize The size of the component when constructing it.
---@field IsResearched boolean True if the component is researched from the start of the game, false otherwise.
---@field Sprite string The sprite for the custom component.
---@field PriceMetallite number The amount of metallite needed to produce this custom component.
---@field PriceBjorn number The amount of bjorn needed to produce this custom component.
---@field PriceMunilon number The amount of munilon needed to produce this custom component.
---@field PriceSkalaknit number The amount of skalaknit needed to produce this custom component.
---@field PriceStaff number The amount of staff needed to produce this custom component.
---@field ProductionDays number The amount of days it takes to produce this custom component.
---@field ShopDescription ShopDescriptionLine[] The description lines that will be shown when the custom component is selected in the shop.

---@class ModdedComponentCustomData Dataset containing the custom component info.
---@field PriceMetallite number The amount of metallite needed to produce this custom component.
---@field PriceBjorn number The amount of bjorn needed to produce this custom component.
---@field PriceMunilon number The amount of munilon needed to produce this custom component.
---@field PriceSkalaknit number The amount of skalaknit needed to produce this custom component.
---@field PriceStaff number The amount of staff needed to produce this custom component.
---@field ProductionDays number The amount of days it takes to produce this custom component.
---@field ShopDescription LocalizedShopDescriptionLine[] The description lines that will be shown when the custom component is selected in the shop.

---@class ShopDescriptionLine A description line that will be shown when the custom component is selected in the shop.
---@field Label LocalizedString The label text for the description line.
---@field Value number The value for the description line.

---@class LocalizedShopDescriptionLine A description line that will be shown when the custom component is selected in the shop.
---@field Label string The label text for the description line.
---@field Value number The value for the description line.

---@class DescriptionLineData Dataset to track the shop description line animations
---@field DisplayStep number The Current step number.
---@field IsDoneScrolling boolean True if done scrolling to the left, false otherwise.
---@field IsDoneWaiting boolean True if done waiting to restart scrolling, false otherwise.