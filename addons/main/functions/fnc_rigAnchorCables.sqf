#include "script_component.hpp"
/*
Author: Ampers
Prepare aircraft ViV space for standing paratroops

* Arguments:
* 0: Aircraft <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft, _unit] call ssl_main_fnc_RigAnchorCables
* [cursorObject, ACE_Player] call ssl_main_fnc_canRigAnchorCables
*/

params ["_aircraft", "_unit"];

deleteVehicle ssl_proxy_local;
_aircraft setVariable ["ssl_AnchorCablesReady", true, true];

// create ropes to look like static line
private _AnchorCablesInfo = getArray (configFile >> "CfgVehicles" >> typeOf _aircraft >> "SSL_AnchorCablesInfo");
if (_AnchorCablesInfo isEqualTo []) exitWith {};

private _AnchorCables = [];
private _AnchorCableEnds = [];
_AnchorCablesInfo apply {
    _x params ["_start", "_end", "_length"];
    private _startObj = "ssl_helper" createVehicle [0,0,1000];
    _startObj attachTo [_aircraft, _start];
    private _endObj = "ssl_helper" createVehicle [0,0,1000];
    _endObj attachTo [_aircraft, _end];
    _AnchorCableEnds pushBack [_startObj, _endObj];
    _AnchorCables pushBack (ropeCreate [_startObj, [0,0,0], _endObj, [0,0,0], _length]);
};

_aircraft setVariable ["ssl_AnchorCables", _AnchorCables, true];
_aircraft setVariable ["ssl_AnchorCableEnds", _AnchorCableEnds, true];

private _handle = _aircraft addEventHandler ["Killed", {
    params ["_aircraft"];
    _aircraft removeEventHandler _thisEventHandler;
    if ([_aircraft] call ssl_main_fnc_canStowAnchorCables) then {
        [_aircraft] call ssl_main_fnc_StowAnchorCables;
    };
}];
_aircraft setVariable ["ssl_EH_Killed", _handle, true];
