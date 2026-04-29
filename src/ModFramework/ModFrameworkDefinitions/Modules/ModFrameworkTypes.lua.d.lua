---@meta

---Access to Types used by the framework.
---@class ModFrameworkTypes
local Types = {}

---Component types
---@class ComponentTypes
local ComponentTypes = {
	Mech = 1,
	Cabin = 2,
	Motor = 3,
	Weapon = 4,
	Reactor = 5,
	Injector = 6,
	Piston = 7,
	Kernel = 8,
	Safety = 9,
	Magnet = 10,
	Solenoid = 11,
	ArmorLayerMiddle = 95,
	ArmorLayerEnd = 96,
	Rocket = 97,
	Beacon = 98,
	CityParts = 99
}
Types.ComponentTypes = ComponentTypes

---Component sizes
---@class ComponentSizes
local ComponentSizes = {
	--a single hanger slot
	Small = 1,
	--a full hanger row, 5 slots
	Large = 5
}
Types.ComponentSizes = ComponentSizes

---The base cabin indexes
---@class BaseCabins
local BaseCabins = {
	Cabin_0 = 0,
	Cabin_1 = 1,
	Cabin_2 = 2,
	Cabin_3 = 3,
	Cabin_4 = 4,
	Cabin_5 = 5,
}
Types.BaseCabins = BaseCabins

---The base motor indexes
---@class BaseMotors
local BaseMotors = {
	Combustion_1 = 0,
	Combustion_2 = 1,
	Electric_1 = 2,
	Combustion_3 = 3,
	Electric_2 = 4,
	Electric_3 = 5,
}
Types.BaseMotors = BaseMotors

---The base mech indexes
---@class BaseMechs
local BaseMechs = {
	Miner = 0,
	Castle = 1,
	Plate = 2,
	Holo = 3,
	Quadro = 4,
	Tentacle = 5,
	Triangle = 6,
}
Types.BaseMechs = BaseMechs

---MechModule identifiers
---@class MechModules
local MechModules = {
	Aux = 1,
	Motor = 2,
	Reactor = 3,
	Weapon = 4,
	Cabin = 5
}
Types.MechModules = MechModules

---The base weapon indexes
---@class BaseWeapons
local BaseWeapons = {
	SIX_BARRELED_GUN = 0,
	ROCKET_SYSTEM = 1,
	TANK_GUN = 2,
	MISSILE_LAUNCHER = 3,
	HIGH_POWER_IMPULSE_LASER = 4,
	RAPID_FIRING_LASER = 5,
	FLAMETHROWER = 6,
	MASS_ACCELERATOR = 7,
	TESLA_CANNON = 8,
	PLASMA_ACCELERATOR = 9,
	TOXIN_SPRAYER = 10,
	PARTICLE_EMITTER = 11,
}
Types.BaseWeapons = BaseWeapons

---Weapon type identifiers
---@class WeaponTypes
local WeaponTypes = {
	Kinetic = "white",
	Missile = "red",
	Energy = "blue",
	Thermal = "yellow",
}
Types.WeaponTypes = WeaponTypes

---Weapon indicator identifiers
---@class WeaponIndicator
local WeaponIndicator = {
	Kinetic = 0,
	Missile = 1,
	Thermal = 2,
	Energy = 3,
}
Types.WeaponIndicator = WeaponIndicator

---The base reactors indexes
---@class BaseReactors
local BaseReactors = {
	Combustion = 0,
	Fission = 1,
	Fusion = 2,
}
Types.BaseReactors = BaseReactors

---Reactor type identifiers
---@class ReactorTypes
local ReactorTypes = {
	Combustion = 1,
	Fission = 2,
	Fusion = 3,
}
Types.ReactorTypes = ReactorTypes

---The base magnets indexes
---@class BaseMagnets
local BaseMagnets = {
	Curved = 0,
	Horizontal = 1,
	Vertical = 2,
}
Types.BaseMagnets = BaseMagnets

---The base injector indexes
---@class BaseInjectors
local BaseInjectors = {
	LowPressure = 0,
	HighPressure = 1,
}
Types.BaseInjectors = BaseInjectors

---The base piston indexes
---@class BasePistons
local BasePistons = {
	LowPressure = 0,
	HighPressure = 1,
}
Types.BasePistons = BasePistons

---The base kernel indexes
---@class BaseKernels
local BaseKernels = {
	Gray = 0,
	Silver = 1,
	Red = 2,
}
Types.BaseKernels = BaseKernels

---The base safety index
---@Type 0
Types.BaseSafety = 0

---The base solenoid indexes
---@class BaseSolenoids
local BaseSolenoids = {
	BrownSolenoid = 0,
	BlueSolenoid = 1,
}
Types.BaseSolenoids = BaseSolenoids

---The base research res numbers
---@class BaseResearchResNumbers
local BaseResearchResNumbers = {
	PREPARATIONS = 0,
	TANK_GUN = 1,
	IMPROVING_THE_ICE_REACTOR = 2,
	FIRST_GENERATION_ENGINE = 3,
	UNDERWATER_BATTLE = 4,
	CABIN_1_REINFORCED_FRAME = 5,
	TORPEDOES = 6,
	THIRD_GENERATION_ENGINE = 7,
	NUCLEAR_REACTOR = 8,
	ROCKET_LAUNCH = 9,
	FOURTH_GENERATION_ENGINE = 10,
	NEW_MECH_PLATE = 11,
	NEW_MECH_HOLO = 12,
	NEW_MECH_CASTLE = 13,
	MUNILON = 14,
	FIFTH_GENERATION_ENGINE = 15,
	SIXTH_GENERATION_ENGINE = 16,
	CABINS_2_AND_3 = 17,
	LASER = 18,
	FLAMETHROW = 19,
	HEAT_DRAIN = 20,
	ARMOR = 21,
	DRONE = 22,
	NEW_MECH_TRIANGLE = 23,
	NEW_MECH_TENTACLE = 24,
	NEW_MECH_QUADRO = 25,
	CABINS_4_AND_5 = 26,
	REPAIR_SHOP = 27,
	RAILGUN_AMPS = 28,
	TESLA = 29,
	ATOMIC_BOMB = 30,
	THERMONUCLEAR_REACTOR = 31,
	RAILGUN_PLASMA = 32,
	TOXIN_SPRAYER = 33,
	THIN_ARMOR_PLATES = 34,
	ENERGY_SHIELD_BOOSTER = 35,
	PROCESSOR_PROGRAMS = 36,
	REACTOR_OVERCHARGE = 37,
	ANTI_MISSILE_SYSTEMS = 38,
	NEEDLE_BULLETS = 39,
	ROBOTIZATION = 40,
	CYBORGIZATION = 41,
	CYBORG_SQUADS = 42,
	DEPTH_CHARGE = 43,
}
Types.BaseResearchResNumbers = BaseResearchResNumbers

---Research index identifiers for the mres tables
---@class ResearchIndexes
local ResearchIndexes = {
	Position = 1, 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	Link_1 = 2,			--link 1, Link to open the next research. Should contain the number of the research from the array
	Link_2 = 3,			--link 2, Link to open the next research. Should contain the number of the research from the array
	Link_3 = 4,			--link 3, Link to open the next research. Should contain the number of the research from the array
	Condition = 5,		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	RequiredDays = 6,	--the required days to complete the research
	RequiredStaff = 7,	--the required available staff to start the research
	IconType = 8,		--research icon type (0-combat, 1-production, 2-passability)
	IconSubtype = 9, 	--research icon subtype (see left column in the game in research menu)
	Description = 10	--the description text for the research
}
Types.ResearchIndexes = ResearchIndexes

---Research conditions
---@class ResearchConditions
local ResearchConditions = {
	--It is closed, the prerequisites need to be completed
	Closed = 0,
	--It can be selected to start researching
	Opened = 1,
	--It is currently being researched
	Researching = 2,
	--The research is complete
	Researched = 3
}
Types.ResearchConditions = ResearchConditions

---Research icons
---@class ResearchIcons
local ResearchIcons = {
	Damage = 		{ IconType = 0 , IconSubType = 0 },
	Survival = 		{ IconType = 0 , IconSubType = 1 },
	Engineering = 	{ IconType = 1 , IconSubType = 0 },
	Production = 	{ IconType = 1 , IconSubType = 1 },
	Research = 		{ IconType = 1 , IconSubType = 2 },
	Plains = 		{ IconType = 2 , IconSubType = 0 },
	Ocean = 		{ IconType = 2 , IconSubType = 1 },
	Wasteland = 	{ IconType = 2 , IconSubType = 2 },
	Desert = 		{ IconType = 2 , IconSubType = 3 },
	Swamp = 		{ IconType = 2 , IconSubType = 4 },
	Volcano = 		{ IconType = 2 , IconSubType = 5 },
	Snow = 			{ IconType = 2 , IconSubType = 6 },
	City = 			{ IconType = 2 , IconSubType = 7 },
	Mountain = 		{ IconType = 2 , IconSubType = 8 },
	Cave = 			{ IconType = 2 , IconSubType = 9 },
}
Types.ResearchIcons = ResearchIcons

---The activity types for the pilots
---@class PilotActivities
local PilotActivities = {
	Eating = 0,
	Sports = 1,
	Resting = 2,
	Walking = 3,
	Unknown = 4,
	Simulator = 5,
}
Types.PilotActivities = PilotActivities

---A non complete list of Virtual Keys
---@class VirtualKeys
local VirtualKeys = {
	--Control keys

	Backspace = 8,
	Tab = 9,
	Enter = 13,
	Shift = 16,
	Ctrl = 17,
	Alt = 18,
	PauseBreak = 19,
	CapsLock = 20,
	Escape = 27,
	Space = 32,
	PageUp = 33,
	PageDown = 34,
	End = 35,
	Home = 36,
	ArrowLeft = 37,
	ArrowUp = 38,
	ArrowRight = 39,
	ArrowDown = 40,
	Insert = 45,
	Delete = 46,

	--Number row

	Number_0 = 48,
	Number_1 = 49,
	Number_2 = 50,
	Number_3 = 51,
	Number_4 = 52,
	Number_5 = 53,
	Number_6 = 54,
	Number_7 = 55,
	Number_8 = 56,
	Number_9 = 57,

	--Letters

	A = 65,
	B = 66,
	C = 67,
	D = 68,
	E = 69,
	F = 70,
	G = 71,
	H = 72,
	I = 73,
	J = 74,
	K = 75,
	L = 76,
	M = 77,
	N = 78,
	O = 79,
	P = 80,
	Q = 81,
	R = 82,
	S = 83,
	T = 84,
	U = 85,
	V = 86,
	W = 87,
	X = 88,
	Y = 89,
	Z = 90,

	--NumPad

	NumPad0 = 96,
	NumPad1 = 97,
	NumPad2 = 98,
	NumPad3 = 99,
	NumPad4 = 100,
	NumPad5 = 101,
	NumPad6 = 102,
	NumPad7 = 103,
	NumPad8 = 104,
	NumPad9 = 105,
	Multiply = 106,
	Add = 107,
	Subtract = 109,
	Divide = 111,

	--Function keys

	F1 = 112,
	F2 = 113,
	F3 = 114,
	F4 = 115,
	F5 = 116,
	F6 = 117,
	F7 = 118,
	F8 = 119,
	F9 = 120,
	F10 = 121,
	F11 = 122,
	F12 = 123,
}
Types.VirtualKeys = VirtualKeys

---A list of mouse buttons
---@class MouseButtons
local MouseButtons = {
	Left = 1,
	Right = 2,
	Middle = 3,
	Side1 = 4,
	Side2 = 5,
	any = -1,
	None = 0
}
Types.MouseButtons = MouseButtons

return Types
