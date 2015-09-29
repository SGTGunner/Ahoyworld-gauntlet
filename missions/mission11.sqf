/*
| Author:
|
|	Pfc.Christiansen & Josh
|_____
|
|   Description: Seek and destroy enemy tank platoon.
|
|	Created: 11.March 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/


//Defines+locations+missioncall

_missionLocations = ["NukeIns","NukeIns_1","NukeIns_2","NukeIns_3","NukeIns_4","NukeIns_5","NukeIns_6","NukeIns_7","NukeIns_8","NukeIns_9","NukeIns_10","NukeIns_11","NukeIns_12","NukeIns_13","NukeIns_14","NukeIns_15","NukeIns_16","NukeIns_17","NukeIns_18","NukeIns_19","NukeIns_20","NukeIns_21","NukeIns_22","NukeIns_23","NukeIns_24"];


call KC_fnc_missionName;
_missionName = KC_missionName;

//Get Final Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn in objective + lock

_obj_1 = createVehicle ["rhs_btr60_vdv",getMarkerPos _missionLoc, [], 0, "NONE" ];
_obj_2 = createVehicle ["O_ti_technical_F",getMarkerPos _missionLoc, [], 10, "NONE" ];
_obj_3 = createVehicle ["O_ti_technical_a_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_4 = createVehicle ["O_ti_technical_a_F",getMarkerPos _missionLoc, [], 15, "NONE" ];
_obj_5 = createVehicle ["O_ti_truck_s_F",getMarkerPos _missionLoc, [], 10, "NONE" ];
_obj_6 = createVehicle ["Land_TentA_F",getMarkerPos _missionLoc, [], 15, "NONE" ];
_obj_7 = createVehicle ["Land_TentA_F",getMarkerPos _missionLoc, [], 15, "NONE" ];
_obj_8 = createVehicle ["Campfire_burning_F",getMarkerPos _missionLoc, [], 15, "NONE" ];
_obj_9 = createVehicle ["Land_TentA_F",getMarkerPos _missionLoc, [], 15, "NONE" ];

_obj_1 setVehicleLock "LOCKED";
_obj_2 setVehicleLock "LOCKED";
_obj_3 setVehicleLock "LOCKED";
_obj_4 setVehicleLock "LOCKED";
_obj_5 setVehicleLock "LOCKED";

_obj_1 setDir 205;
_obj_2 setDir 20;
_obj_3 setDir 30;

//Spawn In Enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m13",[13,0,0],[2,2,20,5],[],[5,2,35,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

//Marker AO +Hint new AO
_marker = createMarker ["mission11_mrk", getMarkerPos _missionLoc ];
"mission11_mrk" setMarkerShape "ICON";
"mission11_mrk" setMarkerType "selector_selectable";
"mission11_mrk" setMarkerColor "ColorBLUFOR";
"mission11_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission11_1_mrk", getMarkerPos _missionLoc];
"mission11_1_mrk" setMarkerShape "ELLIPSE";
"mission11_1_mrk" setMarkerSize [400,400];
"mission11_1_mrk" setMarkerBrush "Border";
"mission11_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission11_2_mrk", getMarkerPos "AOMarker"];
"mission11_2_mrk" setMarkerShape "ICON";
"mission11_2_mrk" setMarkerType "mil_dot";
"mission11_2_mrk" setMarkerText "Scouts have located a group of enemy technicals. Destroy all the enemy Vehicles.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Scouts have located a group of enemy technicals. Destroy all the enemy Vehicles.<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

waituntil{!alive _obj_1 && !alive _obj_2 && !alive _obj_3 && !alive _obj_4 && !alive _obj_4 && !alive _obj_5};

_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;
deleteMarker "mission11_mrk";
deleteMarker "mission11_1_mrk";
deleteMarker "mission11_2_mrk";

sleep 30;
deleteVehicle _obj_1;
deleteVehicle _obj_2;
deleteVehicle _obj_3;
deleteVehicle _obj_4;
deleteVehicle _obj_5;
deleteVehicle _obj_6;
deleteVehicle _obj_7;
deleteVehicle _obj_8;
deleteVehicle _obj_9;
sleep 30;
waituntil{DAC_NewZone == 0};
["m13"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};

KC_MISS  = false;
