#include "script_component.hpp"
/*
Author: Ampers
Get info for rigging anchor cable(s)

* Arguments:
* 0: Aircraft <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft] call ssl_main_fnc_GetAnchorCablesInfo
*/

params ["_aircraft"];

private _index = SSL_compatibleAircraft findIf {_aircraft isKindOf _x};
if (_index >=0) then {
    SSL_anchorCablesInfo # _index;
} else {
    []
};
