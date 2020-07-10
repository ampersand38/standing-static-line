/*
Author: Ampers
EH fired when unit exits the ViV standing proxy

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [player] call ssl_main_fnc_EH_GetOut
*/

//params ["_vehicle", "_role", "_unit", "_turret"];
params ["_vehicle", "", "_unit"];

if ([_unit] call ssl_main_fnc_canJump) then {
    [_unit] call ssl_main_fnc_jump;
};

deleteVehicle _vehicle;
_unit setVariable ["ssl_state", SSL_SITTING, true];
_unit setVariable ["ssl_aircraft", objNull, true];
