/*
| Author:
|
|	BACONMOP
|_____
|
|   Description: Guerilla Meeting.
|
|	Created: 29.January 2015
|	Last modified: 16.02-15 By: BACONMOP Reason: made counter attack more aggressive
|	Made for AhoyWorld.
*/

// ------------------- Find Obj Pos

if (!isNull s3) then{

call KC_fnc_missionName;
_missionName = KC_missionName;

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];

_missionLoc = _missionLocations call BIS_fnc_selectRandom;

_meatingLoc = [_missionLoc, 100] call CBA_fnc_randPos;

// ------------------- Create OBJ

_gurGrp = createGroup west;
"B_G_officer_F" createUnit [_meatingLoc, _gurGrp];
"B_G_Soldier_F" createUnit [_meatingLoc, _gurGrp];

_gurOfficer = ((units _gurGrp) select 0);
_gurRifle = ((units _gurGrp) select 1);

waituntil{DAC_NewZone == 0};
_DACvaluesWayPoint = ["m20",[10,0,0],[20],[20],[20],[],[0,0,0,0]];
[getMarkerPos _missionLoc,200,200,0,0,_DACvaluesWayPoint] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

// ------------------- Briefing

_marker = createMarker ["mission10_mrk", getMarkerPos _missionLoc ];
"mission10_mrk" setMarkerShape "ICON";
"mission10_mrk" setMarkerType "selector_selectable";
"mission10_mrk" setMarkerColor "ColorBLUFOR";
"mission10_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission10_1_mrk", getMarkerPos _missionLoc];
"mission10_1_mrk" setMarkerShape "RECTANGLE";
"mission10_1_mrk" setMarkerSize [200,200];
"mission10_1_mrk" setMarkerBrush "Border";
"mission10_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission10_2_mrk", getMarkerPos "AOMarker"];
"mission10_2_mrk" setMarkerShape "ICON";
"mission10_2_mrk" setMarkerType "mil_dot";
"mission10_2_mrk" setMarkerText "A local guerrilla leader has requested a meeting with command. Meet with him and make sure he and the Platoon commander can complete the meeting.";

_misHintText = format
["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A local Guerrilla Leader has requested a meeting with command. Meet with him and make sure he and the Platoon commander can complete the meeting.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

// ------------------- Core Loop

_accepted = false;
_coreLoop = true;
_timer = 1;
_meetingTimer = false;
while{_coreLoop} do {

	if(!_accepted) then {
		if (s3 distance _gurOfficer < 20) then{
			[_gurOfficer, _gurRifle] joinSilent group s3;
			_accepted = true;
			_DACLoc = [_missionLoc, 1000] call CBA_fnc_randPos;
			while {_DACLoc distance _meatingLoc < 1000} do {
				_DACLoc = [_missionLoc, 1000] call CBA_fnc_randPos;
			};
			waituntil{DAC_NewZone == 0};
			_DACvaluesWayPoint = ["m10_1",[10,0,0,0],[5,3,3,8],[2,2,2,8],[1,1,1,8],[],[0,0,0,0]];
			[_DACLoc,200,200,0,0,_DACvaluesWayPoint] call DAC_fNewZone;
			waituntil{DAC_NewZone == 0};
			_misHintText = format ["<t align='center' size='2.2'></t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/><br/>Be advised OpFor are attacking<br/><br/>",_missionName];
			["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;
			_meetingTimer = true;
		};
	};

	if (!alive s3) then{
		_coreLoop = false;
		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>The Platoon Commander has died!</t>",_missionName];
		["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;
	};

	if (!alive _gurOfficer) then{
		_coreLoop = false;
		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>The Guerrilla Leader has died! %1 Failed</t>",_missionName];
		["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;
	};

	if (_meetingTimer) then {
		_timer = _timer + 1;
		if (_timer == 600) then {
			_coreLoop = false;
			_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, The meeting is complete</t>",_missionName];
			["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
			_meetingTimer = false;
		};
	};
	sleep 1;
};

// ------------------- Clean up

_gurLeaveWP = [_missionLoc, 2000] call CBA_fnc_randPos;
[_gurOfficer, _gurRifle] joinSilent _gurGrp;

_Convoy_WP1 = _gurGrp addWaypoint [_gurLeaveWP, 0];
_Convoy_WP1 setWaypointType "Move";
_Convoy_WP1 setWaypointBehaviour "SAFE";
_Convoy_WP1 setWaypointFormation "Column";

sleep 60;
deleteVehicle _gurOfficer;
deleteVehicle _gurRifle;
deleteMarker "mission10_mrk";
deleteMarker "mission10_1_mrk";
deleteMarker "mission10_2_mrk";

["m20"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};
["m10_1"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};

};
KC_MISS = false;
