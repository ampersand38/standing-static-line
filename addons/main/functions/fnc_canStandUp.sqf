#include "script_component.hpp"
/*
Author: Ampers
Check if unit can move from aircraft seat to standing in ViV space

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_canStandUp
*/

params ["_unit"];

private _aircraft = vehicle _unit;

_aircraft isKindOf "Air" &&
{_unit getVariable ["ssl_state", SSL_SITTING] == SSL_SITTING} &&
{_aircraft getCargoIndex _unit > -1}
