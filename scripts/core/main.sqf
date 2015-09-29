

/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description:
|
|	Created: 1.November 2014
|	Last modified: 17. March 2015 By: Pfc. Christiansen Reason: Rewritten to be truly random selected and to not select the same mission twice.
|	Coded for AhoyWorld.
*/

//Check for server and wait for DAC to init
if (!isServer) exitWith {};
waituntil{DAC_Basic_Value == 1} ;
sleep 15;
_missionCounter = 0;

//---------------------------------- Define missions.
_allMissions = [

"mission1",
"mission2",
"mission3",
"mission4",
//"mission5", not for fallujah play style
"mission6",
"mission7",
"mission8",
"mission9",
//"mission10", bugged, pending fix
"mission11",
"mission12",
"mission13",
"killHVT",
"IEDdefuse_expl",
"ChopIntel"
];

//---------------------------------- Copy Missionlist.
_missionsRuntime = _allMissions;

//----------------------------------Variables.
KC_MISS = false;
publicVariable "KC_MISS";
//---------------------------------- Start Main Loop.
while {true} do {


//----------------------------------Check if runtime is nearing empty and repopulate array if near empty except the last called mission
																		if ((count _missionsRuntime) < 0) then {
																																							_missionsRuntime = _allMissions;
																																							_missionsRuntime = _missionsRuntime - [_currentMission];
																																						};
//----------------------------------- Get truly random mission and execute it.
																		_mission = _missionsRuntime  select (floor (random (count _missionsRuntime)));
																		_currentMission = execVM format["missions\%1.sqf", _mission];



	waitUntil {sleep 5; scriptDone _currentMission};

	_missionCounter = _missionCounter + 1;

	if (("MissionAmount" call BIS_fnc_getParamValue) == _missionCounter) then {
		[] spawn BIS_fnc_EndMission;
	};


    KC_MISS = true;
	publicVariable "KC_MISS";
};
