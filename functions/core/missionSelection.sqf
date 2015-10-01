params ["_missionCounter"];

//------------------- Check if the mission amount has been reached.
if (("MissionAmount" call BIS_fnc_getParamValue) == _missionCounter) then {
    [] spawn BIS_fnc_EndMission;
} else {
    [_missionCounter] call ([mission_AAVehicleDeal, mission_AAVehicleDeal,AW_fnc_mission_AAVehicleDeal] call BIS_fnc_selectRandom);  // Select a random mission
};
