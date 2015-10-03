params ["_missionCounter","_firstCall"];
private ["_nextMission"];

if ((!isNil "_firstCall") && {_firstCall}) Then {
    funcs =
    [
    AW_fnc_mission_ressuplyTruck,
    AW_fnc_mission_clearTown,
    AW_fnc_mission_AAVehicleDeal
    ];
};
diag_log format ["missionSelection start %1",_missionCounter];
//------------------- Check if the mission amount has been reached.
if (("MissionAmount" call BIS_fnc_getParamValue) == _missionCounter) then {
    [] spawn BIS_fnc_EndMission;
} else {
    _nextMission = (funcs select floor random count funcs);
    funcs = funcs - [_nextMission];
    [_missionCounter] call _nextMission;
};
