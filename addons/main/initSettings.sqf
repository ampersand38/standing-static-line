[
    "SSL_RequireParachute", "CHECKBOX",
    ["Require Parachute Backpack", "Require equipping a parachute backpack to Hook Up and Jump. If unchecked, parachute vehicles will be created for units without a parachute backpack."],
    "Standing Static Line",
    false, // default
    true, // isGlobal
    {},
    false // needRestart
] call CBA_settings_fnc_init;

[
    "SSL_DefaultParachute", "EDITBOX",
    ["Default Parachute", "Class name of parachute vehicle to spawn for units without a parachute backpack."],
    "Standing Static Line",
    "NonSteerable_Parachute_F",
    true, // isGlobal
    {},
    false // needRestart
] call CBA_settings_fnc_init;

[
    "SSL_ShowRopes", "LIST",
    ["Show Ropes", "Use PhysX ropes to represent Anchor Cables and Static Lines (very performance heavy for more than ~20 units)."],
    "Standing Static Line",
    [
        [0,1,2],
        ["None", "Anchor Cables Only", "Anchor Cables and Static Lines"],
        0
    ],
    true, // isGlobal
    {},
    false // needRestart
] call CBA_settings_fnc_init;
