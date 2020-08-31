#include "script_component.hpp"
/*
Author: Ampers
Unhook static line from anchor cable

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_unhook
*/

params ["_unit"];

_unit setVariable ["ssl_state", SSL_STANDING, true];
private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
if (isNull _aircraft) exitWith {};
["ssl_unhook", [_aircraft, _unit], _aircraft] call CBA_fnc_targetEvent;

private _jumpEH = _unit getVariable ["ssl_jumpEH", -1];
if (_jumpEH > -1) then {
    _unit removeEventHandler ["GetOutMan", _jumpEH];
    _unit setVariable ["ssl_jumpEH", -1];
};

if (SSL_ShowRopes < 2) exitWith {};

ropeDestroy (_unit getVariable ["ssl_staticLine", objNull]);
_unit setVariable ["ssl_staticLine", objNull, true];
deleteVehicle (_unit getVariable ["ssl_pack", objNull]);
_unit setVariable ["ssl_pack", objNull, true];
deleteVehicle (_unit getVariable ["ssl_hook", objNull]);
_unit setVariable ["ssl_hook", objNull, true];

_unit setVariable ["ssl_anchorCableEnd", objNull, true];
