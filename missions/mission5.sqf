/*
| Author:
|
|	BACONMOP
|_____
|
|   Description:Selects 2 points for a convoy start and end. Spawns Vehicles and crews them. Then loops to find if the convoy reaches it's destination or not.
|
|	Created: 	1/14/2015
|	Last modified: 24/02/2015 By: Pfc. Christiansen,added updating "tracker" markers for convoy units.
|	Made for AhoyWorld.
*/

// -------------------------- Defines + mission name call

CONV_ARR = 0;
CONV_DEAD = 0;

call KC_fnc_missionName;
_missionName = KC_missionName;
// -------------------------- Start and End Location

_StartPos = ["Convoy_Start","Convoy_Start_1","Convoy_Start_2"];
_EndPos = ["Convoy_End","Convoy_End_1","Convoy_End_2"];

_ConvoyStart = _StartPos call BIS_fnc_selectRandom;
_ConvoyEnd = _EndPos call BIS_fnc_selectRandom;


// -------------------------- Spawn Vehicles
vic1 = createVehicle ["rhs_bmp2k_vdv",getMarkerPos _ConvoyStart, [], 0, "FORMATION" ];
vic2 = createVehicle ["rhs_bmp2d_vdv",getMarkerPos _ConvoyStart, [], 10, "FORMATION" ];
vic3 = createVehicle ["rhs_bmp2_vdv",getMarkerPos _ConvoyStart, [], 20, "FORMATION" ];
vic4 = createVehicle ["RHS_Ural_VDV_01",getMarkerPos _ConvoyStart, [], 30, "FORMATION" ];
vic5 = createVehicle ["rhs_t80u",getMarkerPos _ConvoyStart, [], 40, "FORMATION" ];
vic6 = createVehicle ["rhs_t80u",getMarkerPos _ConvoyStart, [], 50, "FORMATION" ];
vic7 = createVehicle ["rhs_zsu234_aa",getMarkerPos _ConvoyStart, [], 60, "FORMATION" ];
vic8 = createVehicle ["rhs_bmp2d_vdv",getMarkerPos _ConvoyStart, [], 70, "FORMATION" ];


// -------------------------- Spawn Crew

_priorityGroup = createGroup east;

"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];
"rhs_vdv_crew" createUnit [ getMarkerPos _ConvoyStart, _priorityGroup];


// -------------------------- Crew Vehicles

((units _priorityGroup) select 0) assignAsCommander vic1;
((units _priorityGroup) select 0) moveInCommander vic1;
((units _priorityGroup) select 1) assignAsCommander vic2;
((units _priorityGroup) select 1) moveInCommander vic2;
((units _priorityGroup) select 2) assignAsGunner vic1;
((units _priorityGroup) select 2) moveInGunner vic1;
((units _priorityGroup) select 3) assignAsGunner vic2;
((units _priorityGroup) select 3) moveInGunner vic2;
((units _priorityGroup) select 4) assignAsDriver vic1;
((units _priorityGroup) select 4) moveInDriver vic1;
((units _priorityGroup) select 5) assignAsDriver vic2;
((units _priorityGroup) select 5) moveInDriver vic2;
((units _priorityGroup) select 6) assignAsCommander vic3;
((units _priorityGroup) select 6) moveInCommander vic3;
((units _priorityGroup) select 7) assignAsGunner vic3;
((units _priorityGroup) select 7) moveInGunner vic3;
((units _priorityGroup) select 8) assignAsDriver vic3;
((units _priorityGroup) select 8) moveInDriver vic3;
((units _priorityGroup) select 9) assignAsDriver vic4;
((units _priorityGroup) select 9) moveInDriver vic4;
((units _priorityGroup) select 10) assignAsCommander vic5;
((units _priorityGroup) select 10) moveInCommander vic5;
((units _priorityGroup) select 11) assignAsGunner vic6;
((units _priorityGroup) select 11) moveInGunner vic6;
((units _priorityGroup) select 12) assignAsGunner vic5;
((units _priorityGroup) select 12) moveInGunner vic5;
((units _priorityGroup) select 13) assignAsDriver vic6;
((units _priorityGroup) select 13) moveInDriver vic6;
((units _priorityGroup) select 14) assignAsDriver vic5;
((units _priorityGroup) select 14) moveInDriver vic5;
((units _priorityGroup) select 15) assignAsGunner vic8;
((units _priorityGroup) select 15) moveInGunner vic8;
((units _priorityGroup) select 16) assignAsGunner vic7;
((units _priorityGroup) select 16) moveInGunner vic7;
((units _priorityGroup) select 17) assignAsDriver vic8;
((units _priorityGroup) select 17) moveInDriver vic8;
((units _priorityGroup) select 18) assignAsDriver vic7;
((units _priorityGroup) select 18) moveInDriver vic7;
((units _priorityGroup) select 19) assignAsCommander vic8;
((units _priorityGroup) select 19) moveInCommander vic8;
((units _priorityGroup) select 20) assignAsCommander vic7;
((units _priorityGroup) select 20) moveInCommander vic7;


// -------------------------- Create Way-point

_Convoy_WP1 = _priorityGroup addWaypoint [getMarkerPos "Convoy_End", 0];
_Convoy_WP1 setWaypointType "Move";
_Convoy_WP1 setWaypointBehaviour "SAFE";
_Convoy_WP1 setWaypointFormation "Column";

// -------------------------- End-Trigger for alive and arrived

_trg = createTrigger ["EmptyDetector",getMarkerPos _ConvoyEnd];
_trg setTriggerArea [100,100,0,false];
_trg setTriggerActivation ["EAST","PRESENT", false];
_trg setTriggerStatements ["vic1 distance thistrigger < 7","CONV_ARR = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _ConvoyEnd];
_trg2 setTriggerStatements ["!alive vic1 && !alive vic2 && !alive vic3 && !alive vic4 && !alive vic5 && !alive vic6 && !alive vic7 && !alive vic8","CONV_DEAD = 1",""];


//-------------------------- Create marker for start of convoy and hint missions

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A large convoy needs to be stopped, intel only has the start-point, suggest scouting out from the origin to find it! Good Luck!<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

_marker = createMarker ["mission5_mrk", getMarkerPos _ConvoyStart ];
"mission5_mrk" setMarkerShape "ICON";
"mission5_mrk" setMarkerType "selector_selectable";
"mission5_mrk" setMarkerColor "ColorBLUFOR";
"mission5_mrk" setMarkerText "Convoy Start Position";

_marker3 = createMarker ["mission5_2_mrk", getMarkerPos "AOMarker"];
"mission5_2_mrk" setMarkerShape "ICON";
"mission5_2_mrk" setMarkerType "mil_dot";
"mission5_2_mrk" setMarkerText "A large convoy needs to be stopped, intel only has the start-point, suggest scouting out from the origin to find it.";


//-------------------------- Create "tracking" markers.

_vic1_mrk = createMarker ["vic1_mrk",getPos vic1];
"vic1_mrk" setMarkerShape "ICON";
"vic1_mrk" setMarkerType "o_armor";
"vic1_mrk" setMarkerColor "ColorOPFOR";

_vic2_mrk = createMarker ["vic2_mrk",getPos vic2];
"vic2_mrk" setMarkerShape "ICON";
"vic2_mrk" setMarkerType "o_armor";
"vic2_mrk" setMarkerColor "ColorOPFOR";

_vic3_mrk = createMarker ["vic3_mrk",getPos vic3];
"vic3_mrk" setMarkerShape "ICON";
"vic3_mrk" setMarkerType "o_armor";
"vic3_mrk" setMarkerColor "ColorOPFOR";

_vic4_mrk = createMarker ["vic4_mrk",getPos vic4];
"vic4_mrk" setMarkerShape "ICON";
"vic4_mrk" setMarkerType "o_armor";
"vic4_mrk" setMarkerColor "ColorOPFOR";

_vic5_mrk = createMarker ["vic5_mrk",getPos vic5];
"vic5_mrk" setMarkerShape "ICON";
"vic5_mrk" setMarkerType "o_armor";
"vic5_mrk" setMarkerColor "ColorOPFOR";

_vic6_mrk = createMarker ["vic6_mrk",getPos vic6];
"vic6_mrk" setMarkerShape "ICON";
"vic6_mrk" setMarkerType "o_armor";
"vic6_mrk" setMarkerColor "ColorOPFOR";

_vic7_mrk = createMarker ["vic7_mrk",getPos vic7];
"vic7_mrk" setMarkerShape "ICON";
"vic7_mrk" setMarkerType "o_armor";
"vic7_mrk" setMarkerColor "ColorOPFOR";

_vic8_mrk = createMarker ["vic8_mrk",getPos vic8];
"vic8_mrk" setMarkerShape "ICON";
"vic8_mrk" setMarkerType "o_armor";
"vic8_mrk" setMarkerColor "ColorOPFOR";

//-------------------------- Make "tracking" markers move after XX seconds

_tracking1 = [] spawn {
											while {not isnull vic1} do { "vic1_mrk" setmarkerpos getpos vic1; sleep 30; };
										};

_tracking2 = [] spawn {
											while {not isnull vic2} do { "vic2_mrk" setmarkerpos getpos vic2; sleep 30; };
										};

_tracking3 = [] spawn {
											while {not isnull vic3} do { "vic3_mrk" setmarkerpos getpos vic3; sleep 30; };
										};

_tracking4 = [] spawn {
											while {not isnull vic4} do { "vic4_mrk" setmarkerpos getpos vic4; sleep 30; };
										};

_tracking5 = [] spawn {
											while {not isnull vic5} do { "vic5_mrk" setmarkerpos getpos vic5; sleep 30; };
										};


_tracking6 = [] spawn {
											while {not isnull vic6} do { "vic6_mrk" setmarkerpos getpos vic6; sleep 30; };
										};

_tracking7 = [] spawn {
											while {not isnull vic7} do { "vic7_mrk" setmarkerpos getpos vic7; sleep 30; };
										};

_tracking8 = [] spawn {
											while {not isnull vic8} do { "vic8_mrk" setmarkerpos getpos vic8; sleep 30; };
										};


waituntil {CONV_ARR == 1 or CONV_DEAD == 1};

if (CONV_ARR == 1) then
		{

						_misFAILText = format
						[
							"<t align='center' size='2.2'>OP Failed</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/>The convoy arrived at its destination,you failed to stopped it. Await new tasking<br/><br/>",
							_missionName
						];

						["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;

		};
if (CONV_DEAD == 1) then
		{

			_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
			["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;			


		};
sleep 30;
deleteVehicle vic1;
deleteVehicle vic2;
deleteVehicle vic3;
deleteVehicle vic4;
deleteVehicle vic5;
deleteVehicle vic6;
deleteVehicle vic7;
deleteVehicle vic8;
deleteMarker "mission5_mrk";
deleteMarker "mission5_2_mrk";
deleteMarker "vic1_mrk";
deleteMarker "vic2_mrk";
deleteMarker "vic3_mrk";
deleteMarker "vic4_mrk";
deleteMarker "vic5_mrk";
deleteMarker "vic6_mrk";
deleteMarker "vic7_mrk";
deleteMarker "vic8_mrk";
terminate _tracking1;
terminate _tracking2;
terminate _tracking3;
terminate _tracking4;
terminate _tracking5;
terminate _tracking6;
terminate _tracking7;
terminate _tracking8;
deleteVehicle _trg;
deleteVehicle _trg2;
sleep 30;

KC_MISS = false;
