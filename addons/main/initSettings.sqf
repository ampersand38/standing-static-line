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
