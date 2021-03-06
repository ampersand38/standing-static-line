["ssl_hookUp", {
    params ["_aircraft", "_unit"];
    private _hookedUpUnits = _aircraft getVariable ["ssl_HookedUpUnits", []];
    _hookedUpUnits pushBack _unit;
    _aircraft setVariable ["ssl_HookedUpUnits", _hookedUpUnits, true];
}] call CBA_fnc_addEventHandler;

["ssl_unhook", {
    params ["_aircraft", "_unit"];
    private _hookedUpUnits = _aircraft getVariable ["ssl_HookedUpUnits", []];
    _hookedUpUnits = _hookedUpUnits - [_unit];
    _aircraft setVariable ["ssl_HookedUpUnits", _hookedUpUnits, true];
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    ["vehicle", {
        params ["_unit", "_newVehicle", "_oldVehicle"];
        if !(_newVehicle isKindOf "ssl_proxy_stand") then {
            _unit setVariable ["ssl_state", SSL_SITTING, true];
        };
    }, true] call CBA_fnc_addPlayerEventHandler;
};

/*
["amp_slingload_adjustRope", {
    params ["_rope", "_speed", "_length", "_relative"];
    ropeUnwind [_rope, _speed, _length, _relative];
}] call CBA_fnc_addEventHandler;

["Helicopter", "InitPost", {
    params ["_heli"];
    if (local _heli) then {
        _heli addItemCargoGlobal ["amp_slingload_CargoSling", 4];
    };
    _heli addEventHandler ["RopeAttach", {
        //params ["_heli", "_rope", "_object"];
        ["amp_slingload_localise", [_this # 0]] call CBA_fnc_serverEvent;
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;

["Helicopter", "Local", {
    params ["_heli", "_isLocal"];
    if _isLocal then {["amp_slingload_localise", [_heli]] call CBA_fnc_serverEvent;};
}, true] call CBA_fnc_addClassEventHandler;

["amp_slingload_apexFitting", "Deleted", {
    params ["_apexFitting"];
    private _cargo = _apexFitting getVariable ["amp_slingload_cargo4Fitting", objNull];
    if !(isNull _cargo) then {
        _cargo setVariable ["amp_slingload_ropes4Cargo", [], true];
    };
}, true] call CBA_fnc_addClassEventHandler;

["amp_slingload_apexFitting", "Killed", {
    params ["_apexFitting"];
    deleteVehicle _apexFitting;
}, true] call CBA_fnc_addClassEventHandler;

["ssl_proxy_stand", "GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
}, true, [], true] call CBA_fnc_addClassEventHandler;
*/
