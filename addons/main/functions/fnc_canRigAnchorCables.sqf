#include "script_component.hpp"
/*
Author: Ampers
Check if unit can prepare anchor cables on aircraft.

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft, _unit] call ssl_main_fnc_canRigAnchorCables
* [cursorObject, ACE_Player] call ssl_main_fnc_canRigAnchorCables
*/

params ["_aircraft", ["_unit", objNull]];

!(_aircraft getVariable ["ssl_AnchorCablesReady", false]) && {
!(_aircraft isKindOf "ParachuteBase") && {
    if (isNil "ssl_proxy_local" || {isNull ssl_proxy_local}) then {
        ssl_proxy_local = "ssl_proxy_stand" createVehicleLocal [0,0,1000];
    };
    (_aircraft canVehicleCargo ssl_proxy_local) # 0
}}
