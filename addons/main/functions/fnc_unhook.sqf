#include "script_component.hpp"
/*
Author: Ampers
Unhook static line from anchor cable

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_unhook
*/

params ["_unit"];

_unit setVariable ["ssl_state", SSL_STANDING, true];

ropeDestroy (_unit getVariable ["ssl_staticLine", objNull]);
_unit setVariable ["ssl_staticLine", objNull, true];
deleteVehicle (_unit getVariable ["ssl_pack", objNull]);
_unit setVariable ["ssl_pack", objNull, true];
deleteVehicle (_unit getVariable ["ssl_hook", objNull]);
_unit setVariable ["ssl_hook", objNull, true];

_unit setVariable ["ssl_anchorCableEnd", objNull, true];
