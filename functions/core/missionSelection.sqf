params ["_missionCounter"];

diag_log format ["MissionSelection 1 %1",_missionCounter];
//------------------- Check if the mission amount has been reached.
if (("MissionAmount" call BIS_fnc_getParamValue) == _missionCounter) then {
    [] spawn BIS_fnc_EndMission;
};
[_missionCounter] call ([AW_fnc_mission1, AW_fnc_mission1] call BIS_fnc_selectRandom);  // Select a random mission
diag_log format ["MissionSelection 2 %1",_missionCounter];
