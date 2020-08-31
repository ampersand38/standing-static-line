#include "script_component.hpp"
/*
Author: Ampers
Move unit into cargo seat of aircraft

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_sitDown
*/

params ["_unit"];

private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
if (isNull _aircraft) exitWith {};
_unit setVariable ["ssl_aircraft", objNull, true];

if (_unit in _aircraft) exitWith {
    _unit setVariable ["ssl_state", SSL_SITTING, true];
};

moveOut _unit;

[{
    params ["_unit"];
    vehicle _unit == _unit
},{
    params ["_aircraft", "_unit"];
    _unit setVariable ["ssl_state", SSL_SITTING, true];

    private _proxy = _unit getVariable ["ssl_proxy", objNull];
    deleteVehicle _proxy;
    _unit setVariable ["ssl_proxy", objNull, true];

    private _openSeats = fullcrew [_aircraft,"",true] select {isNull (_x # 0)};
    (_openSeats select (count _openSeats - 1)) params ["", "", "_seatCargoIndex", "_seatTurretPath"];

    private _moveBackCode = _unit getVariable ["ssl_main_moveBackCode", nil];
    private _moveBackParams = _unit getVariable ["ssl_main_moveBackParams", nil];
    if (!isNil "_moveBackCode" && {!isNil "_moveBackParams"}) exitWith {
        [_unit, _moveBackParams] call _moveBackCode;
        _unit setVariable ["ssl_main_moveBackCode", nil];
        _unit setVariable ["ssl_main_moveBackParams", nil];
    };

    //_x params ["_seatOccupant", "_seatRole", "_seatCargoIndex", "_seatTurretPath"];
    switch (true) do {
        case (!(_seatTurretPath isEqualTo [])): {
            _unit moveInTurret [_aircraft, _seatTurretPath];
        };
        case (_seatCargoIndex >= 0): {
            _unit moveInCargo [_aircraft, _seatCargoIndex];
        };
        default {
            _unit moveInAny _aircraft;
        };
    };

}, [_aircraft, _unit]] call CBA_fnc_waitUntilAndExecute;
