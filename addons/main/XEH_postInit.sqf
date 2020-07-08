#include "script_component.hpp"

["ssl_main_moveSeat", {
    //params ["_unit", "_vehicle", "_proxy"];
    call ssl_main_fnc_moveSeatLocal;
}] call CBA_fnc_addEventHandler;

[
    "Standing Static Line", "ssl_main_showSeats", "Show Seats",{
        if (isNull curatorCamera) then {
            [player] call ssl_main_fnc_findSeat;
        } else {
            if (count (curatorSelected # 0) == 1) then {
                [curatorSelected # 0 # 0] call ssl_main_fnc_findSeat;
            };
        };
    },{
        ssl_main_pfh_running = false;
        //ssl_main_vehicle = nil;
        //ssl_main_proxy = nil;
    }, [29, [false, false, false]], false                  //, 0, true
] call CBA_fnc_addKeybind; // LWIN
[
    "Standing Static Line", "ssl_main_selectSeat", "Select Seat",{

        if (!ssl_main_pfh_running) exitWith {};
        if (isNull curatorCamera) then {
            [player] call ssl_main_fnc_moveSeat;
        } else {
            if (count (curatorSelected # 0) == 1) then {
                [curatorSelected # 0 # 0] call ssl_main_fnc_moveSeat;
            };
        };
        ssl_main_pfh_running = false;
    },{
    }, [45, [false, true, false]], false                  //, 0, true
] call CBA_fnc_addKeybind; // x
/*
[
    "Standing Static Line", "ssl_main_selectSeat", "Select Seat",{
        if (isNull curatorCamera) then {
            [player] call ssl_main_fnc_findSeat;
        } else {
            if (count (curatorSelected # 0) == 1) then {
                [curatorSelected # 0 # 0] call ssl_main_fnc_findSeat;
            };
        };
    },{
        ssl_main_pfh_running = false;
        if (isNull curatorCamera) then {
            [player] call ssl_main_fnc_moveSeat;
        } else {
            if (count (curatorSelected # 0) == 1) then {
                [curatorSelected # 0 # 0] call ssl_main_fnc_moveSeat;
            };
        };
  }, [45, [false, false, false]], false                  //, 0, true
] call CBA_fnc_addKeybind; // x
*/
