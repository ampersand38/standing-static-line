#include "script_component.hpp"
/*
Author: Ampers
Check if unit can access the Static Line actions

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [cursorObject, ACE_Player] call ssl_main_fnc_canAccessStaticLineOut
*/

params ["_aircraft", "_unit"];

true ||
(backpack _unit isKindOf "B_Parachute") && {
(_aircraft isKindOf "Air")
}
