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
* [_aircraft, _unit] call ssl_main_fnc_StowAnchorCables
* [cursorObject, ACE_Player] call ssl_main_fnc_canStowAnchorCables
*/

params ["_aircraft", "_unit"];

_aircraft setVariable ["ssl_AnchorCablesReady", false, true];

(_aircraft getVariable ["ssl_AnchorCables", []]) apply {ropeDestroy _x};
_aircraft setVariable ["ssl_AnchorCables", [], true];
(_aircraft getVariable ["ssl_AnchorCableEnds", []]) apply {_x apply {deleteVehicle _x};};
_aircraft setVariable ["ssl_AnchorCableEnds", [], true];

_aircraft removeEventHandler (_aircraft getVariable ["ssl_EH_Killed", -1]);
_aircraft setVariable ["ssl_EH_Killed", -1, true];

{
    if (_x isKindOf "ssl_helper") then {
         deleteVehicle _x;
    };
} forEach attachedObjects _aircraft;
