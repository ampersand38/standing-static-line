#include "script_component.hpp"
/*
Author: Ampers
Check if unit can stand in ViV space of aircraft

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft, _unit] call ssl_main_fnc_canGetInStanding
* [cursorObject, ACE_Player] call ssl_main_fnc_canGetInStanding
*/

params ["_aircraft", "_unit"];

(_aircraft getVariable ["ssl_AnchorCablesReady", false]) && {
(_unit getVariable ["ssl_state", SSL_SITTING] == SSL_SITTING) && {
(vehicle _unit == _unit) && {
    if (isNil "ssl_proxy_local" || {isNull ssl_proxy_local}) then {
        ssl_proxy_local = "ssl_proxy_stand" createVehicleLocal [0,0,1000];
    };
    (_aircraft canVehicleCargo ssl_proxy_local) # 0
}}}

