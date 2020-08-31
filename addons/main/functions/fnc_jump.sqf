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
//ssl_main_fnc_jump={
params ["_unit", ["_useRamp", true]];

private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
if (isNull _aircraft) exitWith {};
["ssl_unhook", [_aircraft, _unit], _aircraft] call CBA_fnc_targetEvent;

private _velocity = velocity _aircraft;

private _anchorCableEnd = _unit getVariable ["ssl_anchorCableEnd", _aircraft];
if (_anchorCableEnd != _aircraft) then {
    private _pack = _unit getVariable ["ssl_pack", objNull];
    if (!isNull _pack) then {
        deleteVehicle _pack;
    };
    private _hook = _unit getVariable ["ssl_hook", objNull];
    if (!isNull _hook) then {
        _hook attachTo [_aircraft, _aircraft worldToModel (getPos _anchorCableEnd)];
    };
};

// open parachute when static line is taut
[{
    params ["_anchorCableEnd", "_unit"];
    (vehicle _unit == _unit) && {
    (_anchorCableEnd distance _unit) > 10}
},{
    params ["_anchorCableEnd", "_unit"];
    _unit action ["OpenParachute", _unit];
    //systemChat format ["%1 opened parachute", _unit];
}, [_anchorCableEnd, _unit]] call CBA_fnc_waitUntilAndExecute;
/*
// unit match velocity with Aircraft
[{
    params ["", "_unit"];
    (vehicle _unit == _unit)
},{
    params ["_velocity", "_unit"];
    _unit setVelocity _velocity;
    systemChat format ["%1 left aircraft", _unit];
}, [_velocity, _unit]] call CBA_fnc_waitUntilAndExecute; */

// parachute match velocity with unit
[{
    params ["", "_unit"];
    (vehicle _unit != _unit) && {vehicle _unit isKindOf "ParachuteBase"}
},{
    params ["_velocity", "_unit"];
    vehicle _unit setVelocity _velocity;
    //systemChat format ["%1 is in parachute", _unit];
}, [_velocity, _unit]] call CBA_fnc_waitUntilAndExecute;

_unit setVariable ["ssl_state", SSL_SITTING, true];
_unit setVariable ["ssl_aircraft", objNull];
if (vehicle _unit != _unit) then {
    _unit action ["getOut", vehicle _unit];
};
