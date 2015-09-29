/*
| Author:
|
|	Josh
|_____
|
|   Description: Capture enemy ballistic missile launcher
|
|	Created: 11.March 2015
|	Last modified:13. March 2015 By: Pfc.Christiansen
|	Made for AhoyWorld.
*/


//Defines+locations+missioncall

_missionLocations = ["NukeIns","NukeIns_1","NukeIns_2","NukeIns_3","NukeIns_4","NukeIns_5","NukeIns_6","NukeIns_7","NukeIns_8","NukeIns_9","NukeIns_10","NukeIns_11","NukeIns_12","NukeIns_13","NukeIns_14","NukeIns_15","NukeIns_16","NukeIns_17","NukeIns_18","NukeIns_19","NukeIns_20","NukeIns_21","NukeIns_22","NukeIns_23","NukeIns_24"];

_dropZone = getMarkerPos "spawn_zone";

call KC_fnc_missionName;
_missionName = KC_missionName;

TRUCK_SALV = 0;
TRUCK_DEAD = 0;
//Get Final Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn in objective + lock

obj_1 = createVehicle ["O_Truck_03_device_F",getMarkerPos _missionLoc, [], 0, "NONE" ];
_obj_2 = createVehicle ["O_ti_truck_s_F",getMarkerPos _missionLoc, [], 10, "NONE" ];
_obj_3 = createVehicle ["O_ti_technical_a_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_4 = createVehicle ["O_ti_technical_a_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_5 = createVehicle ["O_ti_technical_F",getMarkerPos _missionLoc, [], 25, "NONE" ];

_obj_2 setVehicleLock "LOCKED";
_obj_3 setVehicleLock "LOCKED";
_obj_4 setVehicleLock "LOCKED";
_obj_5 setVehicleLock "LOCKED";

_obj_2 setDir 20;
_obj_3 setDir 30;

//Spawn In Enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m12",[12,0,0],[6,3,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

//Marker AO +Hint new AO
_marker = createMarker ["mission12_mrk", getMarkerPos _missionLoc ];
"mission12_mrk" setMarkerShape "ICON";
"mission12_mrk" setMarkerType "selector_selectable";
"mission12_mrk" setMarkerColor "ColorBLUFOR";
"mission12_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission12_1_mrk", getMarkerPos _missionLoc];
"mission12_1_mrk" setMarkerShape "ELLIPSE";
"mission12_1_mrk" setMarkerSize [400,400];
"mission12_1_mrk" setMarkerBrush "Border";
"mission12_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission12_2_mrk", getMarkerPos "AOMarker"];
"mission12_2_mrk" setMarkerShape "ICON";
"mission12_2_mrk" setMarkerType "mil_dot";
"mission12_2_mrk" setMarkerText "Intel suggests the enemy have purchased a nuclear device. Capture and bring back to base the device.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Intel suggests the enemy have purchased a nuclear device. Capture and bring back to base the device.<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//Trigger for salvaged truck + if truck dies
_trg = createTrigger ["EmptyDetector",_dropZone];
_trg setTriggerArea [20,20,20,false];
_trg setTriggerStatements ["obj_1 distance thistrigger < 10","TRUCK_SALV = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg2 setTriggerArea [20,20,20,false];
_trg2 setTriggerStatements ["!alive obj_1","TRUCK_DEAD = 1",""];


//EndMiss
waitUntil {TRUCK_SALV == 1 or TRUCK_DEAD == 1};


	if ( TRUCK_SALV == 1) then
		{
							_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
							["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
		};
	if ( TRUCK_DEAD == 1) then
		{
							_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
							["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;
		};

deleteVehicle _trg;
deleteVehicle _trg2;
deleteMarker "mission12_mrk";
deleteMarker "mission12_1_mrk";
deleteMarker "mission12_2_mrk";

sleep 30;
deleteVehicle obj_1;
deleteVehicle _obj_2;
deleteVehicle _obj_3;
deleteVehicle _obj_4;
deleteVehicle _obj_5;
sleep 30;
waituntil{DAC_NewZone == 0};
["m12"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};

KC_MISS  = false;
