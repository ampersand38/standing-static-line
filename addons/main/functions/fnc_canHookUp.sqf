#include "script_component.hpp"
/*
Author: Ampers
Check if unit can hook up parachute to static line

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [player] call ssl_main_fnc_canHookUp
*/

params ["_unit"];

(_unit getVariable ["ssl_state", SSL_SITTING] == SSL_STANDING)