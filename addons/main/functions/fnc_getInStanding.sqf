#include "script_component.hpp"
/*
Author: Ampers
Move unit into vehicle seat near center of view

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [cursorObject, ACE_Player] call ssl_main_fnc_getInStanding
* [a, (curatorSelected # 0 # 0)] call ssl_main_fnc_getInStanding
*/

params ["_aircraft", "_unit"];

if (!isNil "ssl_proxy_local" && {!isNull ssl_proxy_local}) then {
    deleteVehicle ssl_proxy_local;
};

private _proxy = "ssl_proxy_stand" createVehicle [0,0,1000];

if (_aircraft setVehicleCargo _proxy) then {
    _unit moveInDriver _proxy;
    /*
    _unit attachTo [_proxy, [0,0,0.05]];
    _unit setDir 180;
    _unit setVariable ["ssl_proxy_stand", _proxy, true];
    _unit switchMove "amovpercmstpsnonwnondnon";
    if (isPlayer _unit) then {
        [_unit] call ace_weaponselect_fnc_putWeaponAway;
    } else {
        _unit disableAI "ANIM";
    };

    detach _unit;
    _unit setVelocity (velocity _aircraft);
    */
    _unit setVariable ["ssl_aircraft", _aircraft, true];
    //_unit setVariable ["ssl_proxy", _proxy, true];
    _unit setVariable ["ssl_state", SSL_STANDING, true];
} else {
    deleteVehicle _proxy;
};

