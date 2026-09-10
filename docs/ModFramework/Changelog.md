# Changelog

## [v1.5] - 2026-09-10
### Added
- Remove functions for items
- Remove function for starting mechs
### Fixed
- Bug where items where incorrectly added resulting in duplicate or missing items

## [v1.4] - 2026-05-18
### Fixed
- Fix the error when a mech was destroyed with the RTS controls enabled

## [v1.3] - 2026-05-13
### Added
- Added settings support for keybindings
- Added a select all button for the RTS controls (`)

## [v1.2] - 2026-05-13
### Fixed
- Selecting components causes a nil exception.
- Fullscreen mode not having the correct mouse coordinates.

## [v1.1] - 2026-05-12
### Fixed
- Pilots being deleted when returning to the hangar.

## [v1.0] - 2026-05-09
Public release on steam
### Added
- More Documentation
### Fixed
- Error with the Quality of life feature: Partial mech assembly

## [v0.2] - 2026-05-07
### Added
- Added Quality of life feature: Quick move pilots
    - Shift+Left clicking pilots moves them into free mechs
    - Shift+Left clicking pilots moves them back into the hangar
    - Option is toggleable from the mod settings menu
- Added Quality of life feature: RTS unit selection
    - Default selection with 1-8 to select that mech and unselect the rest
    - Shift + 1-8 selects the mech and keeps the previous selection
    - Ctrl + 1-8 stores the current selection to the number
    - Option is toggleable from the mod settings menu
- Added Quality of life feature: Partial mech assembly
    - Option to partial complete a mech assembly when you don't have enough engineers
    - Option is toggleable from the mod settings menu
- Added Stored mod settings (currently only boolean type), Settings are stored in the save file
- Added Mod Settings Menu:
    - Can change settings during gameplay
    - Can save settings as default settings for new saves
- More Documentation

## [v0.1] - 2026-05-01
### Added
- Added auto rearrange for shop components
- Added auto register shop items on unlock or item registration through the framework
- Added auto fix for battle sound tables
- Added auto registration for weapon descriptions
- Added auto fix for missing weapon indicators on modded weapons in the shop
- Added auto fix to stop the robot engineer from excessively bleeding out of its shop button
- Added auto fix for modded production sprites on load when item was registered through the framework
- Added auto fix for modding research not having the correct day requirement when added to an existing save
- Added localization support for weapon descriptions, research descriptions and pilot work experience
- Added page support for all shop sections when to many items are registered
- Added type documentation on game objects
- Added type documentation on ModFramework functions, types and classes
- Added wrapper functions for sprite actions to safely throw error messages with a crash
- Added wrapper functions for getting gameobjects as a typed return
- Added wrapper function to get the mod path
- Added wrapper function to check if its a loaded game
- Added support to reference mod items from other mods when item was registered through the framework
- Added framework type classes that contain readable references for game states
- Added framework support to mod:
    - Mechs
    - Weapons
        - Support for extending the range of energy weapons
    - Solenoids
    - Research
        - Support to move existing researches
        - Support to relink existing researches
        - support to add framework handled unlocks to existing researches
    - Pilots
    - Custom Components
- Added framework support to add to inventory
    - Cabins
    - Motors
    - Mechs
    - Weapons
    - Reactors
    - Injectors
    - Pistons
    - Kernels
    - Safeties
    - Magnets
    - Solenoids
    - Pilots
- Added Debug functions
    - Unlock all research next day
    - Unlock all shop components
    - Write the contents of a gamemaker object to a message
    - Write the contents of a gamemaker object to a class definition
    - Write the contents of a gamemaker ds map to a message
    - Write the contents of a table to a message

---
##### [Home](../../readme.md)
