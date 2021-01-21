[LSTRING(StandingStaticLine), QGVAR(AIGetInStanding), [LSTRING(AIGetInStanding), LSTRING(AIGetInStanding_Description)], {
    private _aircraft = if (vehicle player == player) then {
        cursorObject
    } else {
        if (isNull (player getVariable ["ssl_aircraft", objNull])) then {
            vehicle player
        } else {
            player getVariable ["ssl_aircraft", objNull]
        }
    };
    if (isNull _aircraft) exitWith {};
    private _units = units player select {
        !isPlayer _x && {
            (_x getVariable ["ssl_state", 0]) == 0 && {
                [_aircraft, _x] call ssl_main_fnc_canGetInStanding
            }
        }
    };
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select (count _units - 1);
    [_aircraft, _unit] call ssl_main_fnc_getInStanding;
    systemChat format ["%1 boarded.", _unit];
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[LSTRING(StandingStaticLine), QGVAR(AIStandUp), [LSTRING(AIStandUp), LSTRING(AIStandUp_Description)], {
    private _units = units player select {
        !isPlayer _x && {
            (_x getVariable ["ssl_state", 0]) == 0 && {
                [_x]call ssl_main_fnc_canstandUp
            }
        }
    };
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select (count _units - 1);
    if ([_unit] call ssl_main_fnc_canstandUp) then {
        [_unit] call ssl_main_fnc_standUp;
        systemChat format ["%1 stood up.", _unit];
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[LSTRING(StandingStaticLine), QGVAR(AIHookUp), [LSTRING(AIHookUp), LSTRING(AIHookUp_Description)], {
    private _units = units player select {
        !isPlayer _x && {
            (_x getVariable ["ssl_state", 0]) == 1
        }
    };
    if (_units isEqualTo []) exitWith {};
    _units apply {
        if ([_x] call ssl_main_fnc_canHookUp) then {
            [_x] call ssl_main_fnc_HookUp;
        };
    };
    systemChat format ["%1 units hooked up.", count _units];
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[LSTRING(StandingStaticLine), QGVAR(AIJump), [LSTRING(AIJump), LSTRING(AIJump_Description)], {
    private _units = units player select {
        !isPlayer _x && {
            (_x getVariable ["ssl_state", 0]) == 2
        }
    };
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select 0;
    if ([_unit] call ssl_main_fnc_canJump) then {
        [_unit, true] call ssl_main_fnc_jump;
        systemChat format ["%1 jumped!", _unit];
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound
