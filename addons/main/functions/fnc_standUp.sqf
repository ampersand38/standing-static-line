#include "script_component.hpp"
/*
Author: Ampers
Move unit out of aicraft seat to standing in ViV space

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_standUp
*/

params ["_unit"];

private _aircraft = vehicle _unit;

// if aircraft can't ViV
if (isNil "ssl_proxy_local" || {isNull ssl_proxy_local}) then {
    ssl_proxy_local = "ssl_proxy_stand" createVehicleLocal [0,0,1000];
};
if !((_aircraft canVehicleCargo ssl_proxy_local) # 0) exitWith {
    _unit setVariable ["ssl_aircraft", _aircraft, true];
    _unit setVariable ["ssl_state", SSL_STANDING, true];
};

#define TAKEN_SEAT_TIMEOUT 0.5

#define TO_COMPARTMENT_STRING(var) if !(var isEqualType "") then {var = format [ARR_2("Compartment%1",var)]}

#define MOVE_IN_CODE(command) (_this select 0) command (_this select 1)

private ["_driverCompartments", "_isDriverIsolated", "_cargoCompartments", "_cargoCompartmentsLast", "_compartment", "_currentTurret", "_moveBackCode", "_moveBackParams"];

// find current seat
private _currentVehicle = vehicle _unit;
private _fullCrew = fullCrew [_currentVehicle, "", true];
(
    _fullCrew select (_fullCrew findIf {_unit == _x select 0})
) params ["", "_role", "_cargoIndex", "_turretPath"];

_currentTurret = _turretPath;

switch (_role) do {
    case "driver": {
        if (_isDriverIsolated) then {
            [] breakOut "main";
        };
        _compartment = _driverCompartments;
        _moveBackCode = {MOVE_IN_CODE(moveInDriver)};
        _moveBackParams = _currentVehicle;
    };
    case "cargo": {
        private _cargoNumber = fullCrew [_vehicle, "cargo", true] findIf {_unit == _x select 0};
        _compartment = _cargoCompartments select (_cargoNumber min _cargoCompartmentsLast);
        _moveBackCode = {MOVE_IN_CODE(moveInCargo)};
        _moveBackParams = [_currentVehicle, _cargoIndex];
    };
    default {
        private _turretConfig = [_vehicleConfig, _turretPath] call CBA_fnc_getTurret;
        _compartment = (_turretConfig >> "gunnerCompartments") call BIS_fnc_getCfgData;
        TO_COMPARTMENT_STRING(_compartment);
        _moveBackCode = {MOVE_IN_CODE(moveInTurret)};
        _moveBackParams = [_currentVehicle, _turretPath];
    };
};

_unit setVariable ["ssl_main_moveBackCode", _moveBackCode];
_unit setVariable ["ssl_main_moveBackParams", _moveBackParams];

_unit hideObjectGlobal true;
moveOut _unit;

[{
    params ["", "_unit"];
    vehicle _unit == _unit
},{
    params ["_aircraft", "_unit"];
    [_aircraft, _unit] call ssl_main_fnc_getInStanding
}, [_aircraft, _unit]] call CBA_fnc_waitUntilAndExecute;

[{
    vehicle _this isKindOf "ssl_proxy_stand"
},{
    _this hideObjectGlobal false;
}, _unit] call CBA_fnc_waitUntilAndExecute;
