#include "script_component.hpp"
/*
Author: Ampers
Perform static line jump

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_jump
*/

[a, p] call ssl_main_fnc_RigAnchorCables;
a animateDoor ["door_1_source", 1];

removeAllActions player;

player addAction ["Open Ramp", {
    cursorObject animateDoor ["door_1_source", 1];
}];

player addAction ["Stand Up", {
    private _units = (units player - [player]) select {(_x getVariable ["ssl_state", 0]) == 0 && {[_x]call ssl_main_fnc_canstandUp}};
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select (count _units - 1);
    if ([_unit] call ssl_main_fnc_canstandUp) then {
        [_unit] call ssl_main_fnc_standUp;
        systemChat format ["%1 stood up.", _unit];
    };
}, nil, 6, true, false, "binocular"];

player addAction ["Get In Standing", {
    private _aircraft = if (vehicle player == player) then {
        cursorObject
    } else {
        if (isNull (player getVariable ["ssl_aircraft", objNull])) then {
            vehicle player
        } else {
            player getVariable ["ssl_aircraft", objNull]
        }
    };
    private _units = (units player - [player]) select {
        (_x getVariable ["ssl_state", 0]) == 0 && {
            [_aircraft, _x] call ssl_main_fnc_canGetInStanding
        }
    };
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select (count _units - 1);
    [_aircraft, _unit] call ssl_main_fnc_getInStanding;
    systemChat format ["%1 boarded.", _unit];
}, nil, 6, true, false, "binocular"];

player addAction ["Hook Up", {
    private _units = (units player - [player]) select {(_x getVariable ["ssl_state", 0]) == 1};
    if (_units isEqualTo []) exitWith {};
    _units apply {
        if ([_x] call ssl_main_fnc_canHookUp) then {
            [_x] call ssl_main_fnc_HookUp;
        };
    };
    systemChat format ["%1 units hooked up.", count _units];
}, nil, 6, true, false, "nightVision"];

player addAction ["Jump!", {
    private _units = (units player - [player]) select {(_x getVariable ["ssl_state", 0]) == 2};
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select 0;
    if ([_unit] call ssl_main_fnc_canJump) then {
        [_unit, true] call ssl_main_fnc_jump;
        systemChat format ["%1 jumped!", _unit];
    };
}, nil, 6, true, false, "headlights"];

[] spawn {
{
if ((_x getVariable ["ssl_state", 0]) == 0) then {
[a, _x] call ssl_main_fnc_getInStanding;
sleep 0.1;
};
} forEach units player;
}

[] spawn {
sleep 1;
{
if ((_x getVariable ["ssl_state", 0]) == 1) then {
[_x] call ssl_main_fnc_hookup;
sleep 0.1;
};
} forEach units player;
}
