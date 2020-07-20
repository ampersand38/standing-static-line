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
//(_aircraft getVariable ["ssl_AnchorCablesReady", false]) && {
(_unit getVariable ["ssl_state", SSL_SITTING] == SSL_SITTING) && {
    if (isNil "ssl_proxy_local" || {isNull ssl_proxy_local}) then {
        ssl_proxy_local = "ssl_proxy_stand" createVehicleLocal [0,0,1000];
    };
    (_aircraft canVehicleCargo ssl_proxy_local) # 0
}
//}
