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

params ["_unit", ["_useRamp", false]];

_unit setVariable ["ssl_state", SSL_SITTING, true];

private _anchorCableEnd = _unit getVariable ["ssl_anchorCableEnd", objNull];
deleteVehicle (_unit getVariable ["ssl_pack", objNull]);
private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
private _hook = _unit getVariable ["ssl_hook", objNull];
_hook attachTo [_aircraft, _aircraft worldToModelVisual (getPos _anchorCableEnd)];

private _velocity = velocity _aircraft;
_unit hideObjectGlobal true;

if (_useRamp) then {
    private _proxy = _unit getVariable ["ssl_proxy", objNull];
    private _rampExit = (getArray (configFile >> "CfgVehicles" >> typeOf _aircraft >> "VehicleTransport" >> "Carrier" >> "exits")) # 0;
    _proxy attachTo [_aircraft, [0,0,0], _rampExit];
    detach _proxy;
    _proxy setVelocity (velocity _aircraft);
};
moveOut _unit;

[{
    params ["_aircraft", "_unit"];
    (vehicle _unit == _unit)
},{
    params ["_aircraft", "_unit"];
    _unit setVelocity (velocity _aircraft);
    _unit hideObjectGlobal false;
}, [_aircraft, _unit]] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_anchorCableEnd", "_unit"];
    (vehicle _unit == _unit) && {
    (_anchorCableEnd distance _unit) > 10}
},{
    params ["_anchorCableEnd", "_unit"];
    _unit action ["OpenParachute", _unit];

}, [_anchorCableEnd, _unit]] call CBA_fnc_waitUntilAndExecute;

[{
    params ["", "_unit"];
    (vehicle _unit != _unit) && {vehicle _unit isKindOf "ParachuteBase"}
},{
    params ["_velocity", "_unit"];
    vehicle _unit setVelocity _velocity;
}, [_velocity, _unit]] call CBA_fnc_waitUntilAndExecute;


/*
[a, p] call ssl_main_fnc_RigAnchorCables;
a animateDoor ["door_1_source", 1];

removeAllActions player;
player addAction ["Stand Up", {
    private _units = (units player - [player]) select {(_x getVariable ["ssl_state", 0]) == 0 && {[_x]call ssl_main_fnc_canstandUp}};
    if (_units isEqualTo []) exitWith {};
    private _unit = _units select (count _units - 1);
    if ([_unit] call ssl_main_fnc_canstandUp) then {
        [_unit] call ssl_main_fnc_standUp;
        systemChat format ["%1 stood up.", _unit];
    };
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
