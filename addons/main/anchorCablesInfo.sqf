// this file stores the anchor cable attachment points and lengths for compatible aircraft classes
/*
call compile preProcessFileLineNumbers '\z\ssl\addons\main\anchorCablesInfo.sqf';
private _position0 = positionCameraToWorld [0, 0, 0];
private _position1 = positionCameraToWorld [0, 0, 2];

private _intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, objNull, ACE_Player, true, 1, "VIEW"];
(_intersections # 0) params ["_posASL","","_aircraft"];
_pos = _aircraft worldToModelVisual (ASLToAGL _posASL) vectorAdd [0,0,0];
if (isNil "ssl_sphere" || {isNull ssl_sphere}) then {
    sphere = "Sign_Sphere10cm_F" createVehicle [0,0,0];
};
sphere attachTo [_aircraft, _pos];
_pos
*/
SSL_compatibleAircraft = [
///////////////////////////////////////////////////////////////////////////////
// RHS
///////////////////////////////////////////////////////////////////////////////
    "RHS_CH_47F_base",
///////////////////////////////////////////////////////////////////////////////
// Base Game
///////////////////////////////////////////////////////////////////////////////
    "VTOL_01_base_F"
];

SSL_anchorCablesInfo = [
///////////////////////////////////////////////////////////////////////////////
// RHS
///////////////////////////////////////////////////////////////////////////////
    //"RHS_CH_47F_base"
    [
        [[0.142578,5.14648,-0.9561],[0.522461,-7.06543,-1.11978],12.1]
    ],
///////////////////////////////////////////////////////////////////////////////
// Base Game
///////////////////////////////////////////////////////////////////////////////
    //"VTOL_01_base_F"
    [
        [[-0.6  ,6.5,-3.5],[-0.6  ,-3.5,-3.5],9.99],
        [[0.2   ,6.5,-3.5],[0.2   ,-3.5,-3.5],9.99],
        [[1     ,6.5,-3.5],[1     ,-3.5,-3.5],9.99]
    ]
];
