#include "script_component.hpp"
/*
Author: Ampers
Check if unit can remove anchor cables on aircraft.

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft, _unit] call ssl_main_fnc_canStowAnchorCables
* [cursorObject, ACE_Player] call ssl_main_fnc_canStowAnchorCables
*/

params ["_aircraft", "_unit"];

_aircraft getVariable ["ssl_AnchorCablesReady", false]
