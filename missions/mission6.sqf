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

_missionLocations = ["Outskirts","Outskirts_1","Outskirts_2","Outskirts_3","Outskirts_4","Outskirts_5","Outskirts_6","Outskirts_7","Outskirts_8","Outskirts_9","Outskirts_10"];

call KC_fnc_missionName;
_missionName = KC_missionName;

CRATE_ARR = 0;
CRATE_DES = 0;
CRATE_DEPLOYED = 0;
// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;
_pickUp = getMarkerPos "spawn_zone";


//Spawn In Container

package = createVehicle ["B_Slingload_01_Repair_F", _pickUp, [], 0, "NONE" ];

//Populate deploy zone with enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m6",[2,0,0],[6,4,20,5],[],[],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

//Mission Hint
_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A Communications array needs to be deployed, you will find the crate in the Pickup zone.Enemy presence should be cleared out before deploying com-array. Expect heavy resistance to you deploying the array at the designated area. Good Luck!<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//Marker for drop-off point.

_marker = createMarker ["mission6_mrk", getMarkerPos _missionLoc ];
"mission6_mrk" setMarkerShape "ICON";
"mission6_mrk" setMarkerType "selector_selectable";
"mission6_mrk" setMarkerColor "ColorBLUFOR";
"mission6_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission6_1_mrk", getMarkerPos _missionLoc];
"mission6_1_mrk" setMarkerShape "RECTANGLE";
"mission6_1_mrk" setMarkerSize [50,50];
"mission6_1_mrk" setMarkerBrush "Border";
"mission6_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission6_2_mrk", getMarkerPos "AOMarker"];
"mission6_2_mrk" setMarkerShape "ICON";
"mission6_2_mrk" setMarkerType "mil_dot";
"mission6_2_mrk" setMarkerText "A communications array needs to be deployed, you will find the crate in the pickup zone. Enemy presence should be clear out before deploying com-array.";

//Trigger for detecting crate in objective area

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [50,50,50,false];
_trg setTriggerStatements ["package distance thistrigger < 15","CRATE_ARR = 1",""];

//Core Loop

_accepted = false;
_coreloop = true;
while {_coreloop} do {
	if (CRATE_ARR == 0) then {
		if (!alive package) exitWith {
			_misFailText = format ["<t align='center' size='2.2'>OP Failed</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>The crate was destroyed, too bad, wait on further tasking</t>",_missionName];
			["Globalhint_EH", [_misFailText]] call ace_common_fnc_globalEvent;
			_coreloop = false;

			deleteVehicle _trg;
			deleteMarker "mission6_1_mrk";
			deleteMarker "mission6_mrk";
			deleteMarker "mission6_2_mrk";

			sleep 20;
			deleteVehicle package;
		};
	};

	if (CRATE_ARR == 1) then {
		_coreloop = false;
		_misMidHintText = format
			[
				"<t align='center' size='2.2'>Attention!</t><br/><t size='1.5' align='center' color='#FFCF11'></t><br/>____________________<br/>Enemy counter-attack imminent,dig in!!<br/><br/>",
				_missionName
			];

		["Globalhint_EH", [_misMidHintText]] call ace_common_fnc_globalEvent;
		sleep 20;



		_posTrg = createTrigger ["EmptyDetector", getMarkerPos _missionLoc];
		_rndPos = [_missionLoc, 1500] call CBA_fnc_randPos;
		_accepted = false;
		while {!_accepted} do {
			if ((_rndPos distance (getMarkerPos _missionLoc)) < 1000) then {
				_rndPos = [_missionLoc, 1500] call CBA_fnc_randPos;
			} else {
				_accepted = true;
			};
		};

		_GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[_GRP1,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
		sleep  15;
		_GRP2 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[_GRP2,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
		sleep  15;
		_GRP3 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[_GRP3,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
		sleep 20;
		waitUntil{sleep 2; count (units _GRP1) < 4};
		waitUntil{sleep 2; count (units _GRP2) < 4};
		waitUntil{sleep 2; count (units _GRP3) < 4};
		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteVehicle _trg;
		deleteMarker "mission6_1_mrk";
		deleteMarker "mission6_mrk";
		deleteMarker "mission6_2_mrk";

		sleep 60;
		deleteVehicle package;
		waituntil{DAC_NewZone == 0};
		["m6"] call DAC_fDeleteZone;
		waituntil{DAC_NewZone == 0};
	};

	sleep 5;

};

KC_MISS = false;
