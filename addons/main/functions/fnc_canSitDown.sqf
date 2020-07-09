#include "script_component.hpp"
/*
Author: Ampers
Check if unit can sit down in cargo seat in aircraft

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_canSitDown
*/

params ["_unit"];

(_unit getVariable ["ssl_state", SSL_SITTING] == SSL_STANDING) && {

private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
(!isNull _aircraft) && {
    (fullcrew [_aircraft,"",true] findIf {isNull (_x # 0)}) >= 0
}}
