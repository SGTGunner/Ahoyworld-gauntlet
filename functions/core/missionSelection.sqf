/*
 * Author: alganthe
 * Handle the mission selection, this should only be called on server init or after missionTransition
 *
 * Arguments:
 * 0: amount of missions played <NUMBER>
 * 1: If this is the first time the function is called <BOOL>
 *
 * Return Value:
 * nothing
 */
params ["_firstCall"];

if (("EnableRespawn" call BIS_fnc_getParamValue) == 1) then {
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
    AW_fnc_mission_destroyComs,
    AW_fnc_mission_recoverCrate,
    AW_fnc_mission_destroyUAV,
    AW_fnc_mission_guerMeeting,
    AW_fnc_mission_tankPlatoon,
    AW_fnc_mission_captureNuclearDevice,
    AW_fnc_mission_destroyMortar,
    AW_fnc_mission_captureAndDefendTown,
    AW_fnc_mission_recoverChopperIntel
    ];
};
//------------------- Check if the mission amount has been reached.
if (("missionSelection" call BIS_fnc_getParamValue) == 1) then {
    _hintText = format ['OP Update<br/><br/>____________________<br/>Mission selection available.',_missionName];
    ['Globalhint_EH', [_hintText]] call ace_common_fnc_globalEvent;
} else {
    if ((!isNil "gauntlet_missionCounter") && {("MissionAmount" call BIS_fnc_getParamValue) == gauntlet_missionCounter}) then {
        [] spawn BIS_fnc_EndMission;
    } else {
        local _nextMission = (funcs select floor random count funcs);
        funcs = funcs - [_nextMission];
        [] call _nextMission;
    };
};

missionInProgress = false;
publicVariable "missionInProgress";
