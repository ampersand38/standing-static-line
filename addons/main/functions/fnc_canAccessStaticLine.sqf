#include "script_component.hpp"
/*
Author: Ampers
Check if unit can access the Static Line actions

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [player] call ssl_main_fnc_canAccessStaticLine
*/

params ["_unit"];

(backpack _unit isKindOf "B_Parachute") && {
(vehicle _unit isKindOf "Air") || {vehicle _unit isKindOf "ssl_proxy_stand"}
}
