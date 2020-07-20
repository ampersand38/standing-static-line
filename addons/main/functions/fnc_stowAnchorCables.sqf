#include "script_component.hpp"
/*
Author: Ampers
Prepare aircraft ViV space for standing paratroops

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft, _unit] call ssl_main_fnc_stowAnchorCables
* [cursorObject, ACE_Player] call ssl_main_fnc_stowAnchorCables
* [(curatorSelected # 0 # 0), ACE_Player] call ssl_main_fnc_stowAnchorCables
*/

params ["_aircraft", ["_unit", objNull]];

_aircraft setVariable ["ssl_AnchorCablesReady", false, true];

if (SSL_ShowRopes < 1) exitWith {};

(_aircraft getVariable ["ssl_AnchorCables", []]) apply {ropeDestroy _x};
_aircraft setVariable ["ssl_AnchorCables", [], true];
(_aircraft getVariable ["ssl_AnchorCableEnds", []]) apply {_x apply {deleteVehicle _x};};
_aircraft setVariable ["ssl_AnchorCableEnds", [], true];

private _handle = _aircraft getVariable ["ssl_EH_Killed", -1];
if (_handle > -1) then {
    _aircraft removeEventHandler ["Killed", _handle];
    _aircraft setVariable ["ssl_EH_Killed", -1, true];
};

{
    if (_x isKindOf "ssl_helper") then {
         deleteVehicle _x;
    };
} forEach attachedObjects _aircraft;
