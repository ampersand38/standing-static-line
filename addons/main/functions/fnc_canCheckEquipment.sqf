#include "script_component.hpp"
/*
Author: Ampers
Check if unit can stand in ViV space of aircraft

* Arguments:
* 0: Stand Proxy <OBJECT>
* 1: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_proxy, _unit] call ssl_main_fnc_cancheckEquipment
* [vehicle ACE_Player, ACE_Player] call ssl_main_fnc_cancheckEquipment
*/

params ["_proxy", "_unit"];

(cameraView isEqualTo "INTERNAL") && {
    private _position0 = positionCameraToWorld [0, 0, 0];
    private _position1 = positionCameraToWorld [0, 0, 2];

    private _intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, _proxy, _unit, true, 1, "GEOM"];

    !(_intersections isEqualTo [])
}
