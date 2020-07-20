#include "script_component.hpp"
/*
Author: Ampers
Hook static line to anchor cable

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [ACE_Player] call ssl_main_fnc_hookUp
*/

params ["_unit"];

_unit setVariable ["ssl_state", SSL_HOOKEDUP, true];

private _aircraft = _unit getVariable ["ssl_aircraft", objNull];
["ssl_hookUp", [_aircraft, _unit], _aircraft] call CBA_fnc_targetEvent;

if (SSL_ShowRopes < 2) exitWith {};

private _AnchorCablesInfo = [_aircraft] call ssl_main_fnc_GetAnchorCablesInfo;
if (_AnchorCablesInfo isEqualTo []) exitWith {};

// find nearest anchor cable
private _shoulderPos = _unit selectionPosition "leftshoulder";
private _shoulderPosA = _aircraft worldToModelVisual (_unit modelToWorldVisual _shoulderPos);

private _distances = _AnchorCablesInfo apply {(_x # 0) distance _shoulderPosA};
private _anchorCableIndex = _distances findIf {_x == selectMin _distances};

(_AnchorCablesInfo select _anchorCableIndex) params ["_start", "_end"];

private _anchorCableEnds = _aircraft getVariable ["ssl_AnchorCableEnds", []];
if (_anchorCableEnds isEqualTo []) exitWith {};
private _anchorCableEnd = _anchorCableEnds select _anchorCableIndex select 1;
_unit setVariable ["ssl_anchorCableEnd", _anchorCableEnd, true];

private _staticLinePos = [_start, _end, _shoulderPosA, false] call BIS_fnc_nearestPoint;
private _posDiff = _shoulderPosA vectorDiff _staticLinePos;

private _hook = "ssl_helper" createVehicle [0,0,1000];
_hook allowDamage false;
_unit setVariable ["ssl_hook", _hook, true];
private _pack = "ssl_helper" createVehicle [0,0,1000];
_pack allowDamage false;
_pack attachTo [_hook, _posDiff vectorAdd [0,0.2,0]];
_unit setVariable ["ssl_pack", _pack, true];

private _staticLine = ropeCreate [_hook, [0,0,0], _pack , [0,0,0], (_hook distance _pack) * 1.35];
_hook attachTo [_aircraft, _staticLinePos vectorAdd [0,-0.1,0]];
_pack setPos (getPos _hook vectorAdd (_posDiff vectorAdd [0,0.2,0]));
//private _staticLine = ropeCreate [_hook, [0,0,0], _unit , _shoulderPos, (_staticLinePos distance _shoulderPosA) * 1.35];
//private _staticLine = ropeCreate [_hook, [0,0,0], (_staticLinePos distance _shoulderPosA) * 1.35];
//[_unit, _shoulderPos] ropeAttachTo _staticLine;

_unit setVariable ["ssl_staticLine", _staticLine, true];
