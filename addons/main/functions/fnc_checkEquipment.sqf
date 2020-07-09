#include "script_component.hpp"
/*
Author: Ampers
Move unit into vehicle seat near center of view

* Arguments:
* 0: Stand Proxy <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [vehicle ACE_Player, ACE_Player] call ssl_main_fnc_checkEquipment
*/

params ["_proxy", "_unit"];

private _position0 = positionCameraToWorld [0, 0, 0];
private _position1 = positionCameraToWorld [0, 0, 2];

private _intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, _proxy, _unit, true, 1, "GEOM"];

if (_intersections isEqualTo []) exitWith {false};

private _target = _intersections select 0 select 2;

systemChat str _target;

if ((_target getVariable ["ssl_state", SSL_SITTING]) == SSL_HOOKEDUP) then {
    private _picture = "\a3\ui_f\data\Map\Diary\Icons\taskSucceeded_ca.paa";
    [name _target, _picture] call ace_common_fnc_displayTextPicture;
} else {
    private _picture = "\a3\ui_f\data\Map\Diary\Icons\taskFailed_ca.paa";
    [name _target, _picture] call ace_common_fnc_displayTextPicture;
};
