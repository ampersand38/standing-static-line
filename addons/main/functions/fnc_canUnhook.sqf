#include "script_component.hpp"
/*
Author: Ampers
Check if unit can unhook parachute from static line

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [player] call ssl_main_fnc_canUnhook
*/

params ["_unit"];

(_unit getVariable ["ssl_state", SSL_SITTING] == SSL_HOOKEDUP) && {

private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
(!isNull _aircraft) && {
    _aircraft getVariable ["ssl_AnchorCablesReady", false];
}}
