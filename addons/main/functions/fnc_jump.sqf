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

params ["_unit"];

_unit setVariable ["ssl_state", SSL_SITTING, true];

private _anchorCableEnd = _unit getVariable ["ssl_anchorCableEnd", objNull];
deleteVehicle (_unit getVariable ["ssl_pack", objNull]);
private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
private _hook = _unit getVariable ["ssl_hook", objNull];
_hook attachTo [_aircraft, _aircraft worldToModelVisual (getPos _anchorCableEnd)];

moveOut _unit;

[{
    params ["_aircraft", "_unit"];
    (vehicle _unit == _unit)
},{
    params ["_aircraft", "_unit"];
    _unit setVelocity (velocity _aircraft);
}, [_aircraft, _unit]] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_anchorCableEnd", "_unit"];
    (vehicle _unit == _unit) && {
    (_anchorCableEnd distance _unit) > 10}
},{
    params ["_anchorCableEnd", "_unit"];
    _unit action ["OpenParachute", _unit];
}, [_anchorCableEnd, _unit]] call CBA_fnc_waitUntilAndExecute;


/*
[a, p] call ssl_main_fnc_RigAnchorCables;
a animateDoor ["door_1_source", 1];

player addAction ["Jump!", {
    params ["_player"];
    private _units = (units player) select {(_x getVariable ["ssl_state", 0]) == 2};
    moveOut (_units select (count _units - 1));
}, nil, 6, true, false, "binocular"];

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
