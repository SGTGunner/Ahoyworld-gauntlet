/*
 * Author: alganthe
 * Handle the mission selection, this should only be called on server init or in a mission end PFH
 *
 * Arguments:
 * 0: amount of missions played <NUMBER>
 * 1: If this is the first time the function is called <BOOL>
 *
 * Return Value:
 * nothing
 */

params ["_missionCounter","_firstCall"];
private ["_nextMission"];

if (GAMENIGHT == 1) then {
    ["Respawn_EH", [0]] call ace_common_fnc_syncedEvent;
    _respawnWait = {["Respawn_EH", [9999]] call ace_common_fnc_syncedEvent};
    [_respawnWait, [], 120] call ace_common_fnc_waitAndExecute;
};

if ((!isNil "_firstCall") && {_firstCall}) Then {
    funcs =
    [
    AW_fnc_mission_clearTown,
    AW_fnc_mission_ressuplyTruck,
    AW_fnc_mission_AAVehicleDeal,
    AW_fnc_mission_destroyRadar,
    AW_fnc_mission_KillHVT,
    AW_fnc_mission_deployComs,
    AW_fnc_mission_destroyComs
    ];
};

//------------------- Check if the mission amount has been reached.
if (("MissionAmount" call BIS_fnc_getParamValue) == _missionCounter) then {
    [] spawn BIS_fnc_EndMission;
} else {
    _nextMission = (funcs select floor random count funcs);
    funcs = funcs - [_nextMission];
    [_missionCounter] call _nextMission;
};
