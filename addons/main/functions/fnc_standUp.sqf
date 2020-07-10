#include "script_component.hpp"
/*
Author: Ampers
Move unit out of aicraft seat to standing in ViV space

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_standUp
*/

params ["_unit"];

private _aircraft = vehicle _unit;
_unit hideObjectGlobal true;
moveOut _unit;

[{
    params ["", "_unit"];
    vehicle _unit == _unit
},{
    params ["_aircraft", "_unit"];
    [_aircraft, _unit] call ssl_main_fnc_getInStanding
}, [_aircraft, _unit]] call CBA_fnc_waitUntilAndExecute;

[{
    vehicle _this isKindOf "ssl_proxy_stand"
},{
    _this hideObjectGlobal false;
}, _unit] call CBA_fnc_waitUntilAndExecute;
