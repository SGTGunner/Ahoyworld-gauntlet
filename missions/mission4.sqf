/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Destroy Radar Installation.
|
|	Created: 10.January 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/


//Defines+locations+missioncall

_missionLocations = ["Outskirts","Outskirts_1","Outskirts_2","Outskirts_3","Outskirts_4","Outskirts_5","Outskirts_6","Outskirts_7","Outskirts_8","Outskirts_9","Outskirts_10"];

call KC_fnc_missionName;
_missionName = KC_missionName;

//Get Final Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn in objective

_obj_1 = createVehicle ["rhs_p37",getMarkerPos _missionLoc, [], 0, "NONE" ];
_obj_2 = createVehicle ["rhs_v2",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_3 = createVehicle ["rhs_v2",getMarkerPos _missionLoc, [], 30, "NONE" ];

//Spawn In Enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m4",[4,0,0],[4,4,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

//Marker AO +Hint new AO
_marker = createMarker ["mission4_mrk", getMarkerPos _missionLoc ];
"mission4_mrk" setMarkerShape "ICON";
"mission4_mrk" setMarkerType "selector_selectable";
"mission4_mrk" setMarkerColor "ColorBLUFOR";
"mission4_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission4_1_mrk", getMarkerPos _missionLoc];
"mission4_1_mrk" setMarkerShape "ELLIPSE";
"mission4_1_mrk" setMarkerSize [400,400];
"mission4_1_mrk" setMarkerBrush "Border";
"mission4_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission4_2_mrk", getMarkerPos "AOMarker"];
"mission4_2_mrk" setMarkerShape "ICON";
"mission4_2_mrk" setMarkerType "mil_dot";
"mission4_2_mrk" setMarkerText "OPFOR has set up a radar installation, this needs to be taken out ASAP to ensure our air-superiority.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>OPFOR has set up a radar installation at the location, this needs to be taken out ASAP to ensure our air-superiority <br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

waituntil{!alive _obj_1};

_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;
deleteMarker "mission4_mrk";
deleteMarker "mission4_1_mrk";
deleteMarker "mission4_2_mrk";

sleep 30;
deleteVehicle _obj_1;
deleteVehicle _obj_2;
deleteVehicle _obj_3;
sleep 30;
waituntil{DAC_NewZone == 0};
["m4"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};

KC_MISS  = false;
