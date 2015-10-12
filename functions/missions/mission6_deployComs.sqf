/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Deploy Com-Array
|
|	Created: 19.January 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/

//Defines+mission name
params ["_missionCounter"];

_missionLocations = ["Outskirts","Outskirts_1","Outskirts_2","Outskirts_3","Outskirts_4","Outskirts_5","Outskirts_6","Outskirts_7","Outskirts_8","Outskirts_9","Outskirts_10"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;
_pickUp = getMarkerPos "spawn_zone";

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn In Container
mission6Objective = createVehicle ["B_Slingload_01_Repair_F", _pickUp, [], 0, "NONE" ];

//------------------- Populate deploy zone with enemies
_DACvalues = ["m6",[2,0,0],[6,4,20,5],[],[],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission6_mrk", getMarkerPos _selectedLocation ];
"mission6_mrk" setMarkerShape "ICON";
"mission6_mrk" setMarkerType "selector_selectable";
"mission6_mrk" setMarkerColor "ColorBLUFOR";
"mission6_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission6_1_mrk", getMarkerPos _selectedLocation];
"mission6_1_mrk" setMarkerShape "RECTANGLE";
"mission6_1_mrk" setMarkerSize [50,50];
"mission6_1_mrk" setMarkerBrush "Border";
"mission6_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission6_2_mrk", getMarkerPos "AOMarker"];
"mission6_2_mrk" setMarkerShape "ICON";
"mission6_2_mrk" setMarkerType "mil_dot";
"mission6_2_mrk" setMarkerText "A communications array needs to be deployed, you will find the crate in the pickup zone. Enemy presence should be clear out before deploying com-array.";

//------------------- Triggers
nextPhaseTrigger = createTrigger ["EmptyDetector",getMarkerPos _selectedLocation,false];
nextPhaseTrigger setTriggerArea [50,50,50,false];
nextPhaseTrigger setTriggerActivation ["WEST","PRESENT",false];
nextPhaseTrigger setTriggerStatements ["this && mission6Objective distance thistrigger < 15","missionNextPhase = true;",""];

//------------------- Mission Hint
_misHintText = format["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A Communications array needs to be deployed, you will find the crate in the Pickup zone.Enemy presence should be cleared out before deploying com-array. Expect heavy resistance to you deploying the array at the designated area. Good Luck!<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH checking every 10s if the box is in the right place to call reinforcements
_reinforcementsPFH = {
	if ((!isNil "missionNextPhase") && {missionNextPhase}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_rndPos = [_selectedLocation, 1500] call CBA_fnc_randPos;
		GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP1,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

		_rndPos = [_selectedLocation, 1500] call CBA_fnc_randPos;
		GRP2 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP2,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

		_rndPos = [_selectedLocation, 1500] call CBA_fnc_randPos;
		GRP3 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP3,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

		_nextPhaseTrigger2 = createTrigger ["EmptyDetector",getMarkerPos _selectedLocation,false];
		_nextPhaseTrigger2 setTriggerArea [800,800,800,false];
		_nextPhaseTrigger2 setTriggerStatements ["(count (units GRP1) < 4) && (count (units GRP2) < 4) && (count (units GRP3) < 4)","missionWin = true;",""];

		missionNextPhase = nil;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_reinforcementsPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;

//------------------- PFH checking every 10s if the mission has been completed
_missionPFH = {
	if (!alive mission6Objective) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misFailText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>The crate was destroyed, too bad, wait on further tasking</t>",_missionName];
		["Globalhint_EH", [_misFailText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission6_mrk";
		deleteMarker "mission6_1_mrk";
		deleteMarker "mission6_2_mrk";
		deleteVehicle mission6Objective;
		deleteVehicle nextPhaseTrigger;

		missionNextPhase = nil;
		missionWin = nil;
		mission6Objective = nil;
		nextPhaseTrigger = nil;
		GRP1 = nil;
		GRP2 = nil;
		GRP3 = nil;

		[{["m6"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
	if ((!isNil "missionWin") && {missionWin}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission6_mrk";
		deleteMarker "mission6_1_mrk";
		deleteMarker "mission6_2_mrk";
		deleteVehicle mission6Objective;


		missionWin = nil;
		mission6Objective = nil;
		GRP1 = nil;
		GRP2 = nil;
		GRP3 = nil;

		[{["m6"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
