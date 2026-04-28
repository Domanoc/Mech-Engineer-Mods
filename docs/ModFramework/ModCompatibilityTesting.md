# Mod Compatibility Testing

- I did Some basic testing with the other mods to see what works.
- All test where done with the ModFramework loaded first and then the mod being tested
- Note this is not an exhaustive test suite but tries to cover the basics

## Summary:
17 mods where tested.  
These 17 mods represent every mod on steam as of 2026-04-25  
Excluding my own mod "Combat Data Core" This mod has an update planned with full ModFramework support and thus excluded  

4 Mods failed the tests.  
1 Mod failed even without the ModFramework.  
All failed mods where fix with minimal edits and then passed all tests.  
### Failed mods:
- Magic Wand (example mod)
- Robot Pilots Mod
- Skaian's Mech Pack
- MinimumPilotStats

## Test Scenarios: chs mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: EZ difficulty
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Girl Pilot Mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Heavy & Superheavy Mechs
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Italian Translation mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Japanese Translation mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: KAWAII Pilot Mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Magic Wand (example mod)
- Does it start without errors (clean save)? ❌  
The mod was reliant on there being empty researches and did not create its own reference.  
Fix was 1 extra line of code.  
New tests with fixed mod.  
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Pilot Stats Randomizer mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Rebalance Mod
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Robot Pilots Mod
- Does it start without errors (clean save)? ❌  
The mod was reliant on there being empty researches and did not create its own reference.  
Fix was 1 extra line of code.  
New tests with fixed mod.  
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅
- This mod provides a custom component type.   
This might create conflicts with the rearranging of the shop components by the framework.   
Although this is currently in a section that doesn't see a growing list of items. ⚠️ 
Created a temporary catch to get this item and add it back to the shop with the rearrange support. ✅

## Test Scenarios: Simple Autocannon
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Simple EML
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Skaian's Mech Pack
- Does it start without errors (clean save)? ❌  
The mod was reliant on there being empty researches and did not create its own reference.  
Fix was 3 extra lines of code.  
New tests with fixed mod.  
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: MinimumPilotStats
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ❌  
The mod produced the same error when used standalone.  
The mod tried to do a compare on a variable that was never set.  
Fix was 1 extra line of code.  
New tests with fixed mod.
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: tinyFont
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅

## Test Scenarios: Nozomiplus
- Does it start without errors (clean save)? ✅
- Can i open all tabs without error? ✅
- Can i start a battle without errors? ✅
- Can i pass the day without errors? ✅
- Can i save and reload without errors? ✅
- Any errors when all the research is unlocked? ✅
- Can i save and reload without errors (research unlocked)? ✅



-----
##### [Home](../../readme.md)