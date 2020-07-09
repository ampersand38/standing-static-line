#include "script_component.hpp"
/*
Author: Ampers
Check if unit can perform static line jump

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [player] call ssl_main_fnc_canJump
*/

params ["_unit"];

(_unit getVariable ["ssl_state", 0] == SSL_HOOKEDUP)
