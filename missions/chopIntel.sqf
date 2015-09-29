/*
| Author:
|
|	BACONMOP
|_____
|
|   Description: Secure Intel from downed chopper
|
|	Created: 5. July 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/


// Mission name

call KC_fnc_missionName;
_missionName = KC_missionName;

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
_missionLoc = _missionLocations call BIS_fnc_selectRandom;


_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A helicopter carrying important information has been shot down. Get out there and recover the data.<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

// mission markers

_marker = createMarker ["Chop_Intel", getMarkerPos _missionLoc ];
"Chop_Intel" setMarkerShape "ICON";
"Chop_Intel" setMarkerType "selector_selectable";
"Chop_Intel" setMarkerColor "ColorBLUFOR";
"Chop_Intel" setMarkerText "Objective";

_marker2 = createMarker ["Chop_Intel_mrk_1", getMarkerPos _missionLoc];
"Chop_Intel_mrk_1" setMarkerShape "RECTANGLE";
"Chop_Intel_mrk_1" setMarkerSize [400,400];
"Chop_Intel_mrk_1" setMarkerBrush "Border";
"Chop_Intel_mrk_1" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["Chop_Intel_2_mrk", getMarkerPos "AOMarker"];
"Chop_Intel_2_mrk" setMarkerShape "ICON";
"Chop_Intel_2_mrk" setMarkerType "mil_dot";
"Chop_Intel_2_mrk" setMarkerText "Recover intel from the downed helicopter.";

// create objective

rndPos  =  [getMarkerPos _missionLoc, 200] call CBA_fnc_randPos;

_hawk = "RHS_UH60M" createVehicle rndPos;
_hawk setDamage .9;


// detectors

_dt = createTrigger ["EmptyDetector", rndPos];
_dt setTriggerArea [6, 6, 0, false];
_dt setTriggerActivation ["WEST", "PRESENT", false];
_dt setTriggerStatements ["this","",""];

_dt2 = createTrigger ["EmptyDetector", rndPos];
_dt2 setTriggerArea [20, 20, 0, false];
_dt2 setTriggerActivation ["WEST", "NOT PRESENT", false];
_dt2 setTriggerStatements ["this","",""];

_dt3 = createTrigger ["EmptyDetector", rndPos];
_dt3 setTriggerArea [1000, 1000, 0, false];
_dt3 setTriggerActivation ["EAST", "NOT PRESENT", false];
_dt3 setTriggerStatements ["this","",""];

// random position

_rndPos  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;
_rndPos1  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;
_rndPos2  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;


// core loop

_downloadTime = 300 + (random 300);
_halfDownloadTime = _downloadTime / 2;
_coreLoop = true;
meetingTimer = false;
_timer = 0;
_downloadComplete = false;
_timerDone = false;
intel = false;
while {_coreLoop} do {

	if (count list _dt > 0 && !intel && !_timerDone) then {
		_misSUCText = format ["<t align='center' size='2.2'>OP Update</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Intel download has begun. Dig in and prepare for an attack.</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
		deleteVehicle _dt2;
		intel = true;
		meetingTimer = true;
		_timer = 0;
		_dt2 = createTrigger ["EmptyDetector", rndPos];
		_dt2 setTriggerArea [20, 20, 0, false];
		_dt2 setTriggerActivation ["WEST", "NOT PRESENT", false];
		_dt2 setTriggerStatements ["this","_misSUCText = format ['OP Update<br/><br/>____________________<br/>Uplink with the helicopter has been lost. Restart the download.',_missionName];
									['Globalhint_EH', [_misSUCText]] call ace_common_fnc_globalEvent;intel = false;meetingTimer = false;",""];
	};

	if (intel && count list _dt3 < 1) then {
		_GRP1 = [_rndPos, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
		[_GRP1,rndPos] call BIS_fnc_taskAttack;
		_GRP2 = [_rndPos2, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
		[_GRP2,rndPos] call BIS_fnc_taskAttack;
		_GRP3 = [_rndPos1, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
		[_GRP3,rndPos] call BIS_fnc_taskAttack;_heliGrp = createGroup east;
		ambientHeli = createVehicle ['RHS_Mi8AMTSh_UPK23_vvsc', getMarkerPos "Heli_Spawn", [], 0, 'FLY' ];
		[ambientHeli,_heliGrp] call BIS_fnc_spawnCrew; [_heliGrp,rndPos] call BIS_fnc_taskAttack;
	};

	if (meetingTimer) then {
		_timer = _timer + 1;
		if (_timer == _halfDownloadTime) then {
			_misSUCText = format ["<t align='center' size='2.2'>OP Update</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Download is about halfway complete.</t>",_missionName];
			["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
		};
		if (_timer == _downloadTime) then {
			_misSUCText = format ["<t align='center' size='2.2'>OP Update</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Intel is secured. Now destroy the helicopter and extract.</t>",_missionName];
			["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
			meetingTimer = false;
			_downloadComplete = true;
			_timerDone = true;
			deleteVehicle _dt2;
		};
	};


	if (!_downloadComplete && (!alive _hawk)) then {
		_misSUCText = format ["<t align='center' size='2.2'>OP Failed</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1. The chopper was destroyed before the download could be complete.</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
		_coreLoop = false;
		deleteVehicle _dt2;
	};

	if (_timerDone && (!alive _hawk)) then {
		_coreLoop = false;
	};

	sleep 1;
};

// Finish, De-brief and delete

_dt4 = createTrigger ["EmptyDetector", getMarkerPos _missionLoc];
_dt4 setTriggerArea [600, 600, 0, false];
_dt4 setTriggerActivation ["EAST", "PRESENT", false];
_dt4 setTriggerStatements ["this","",""];

_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1. Now get out of the area and new tasking will be assigned</t>",_missionName];
["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

waitUntil {sleep 5; count list _dt4 < 1};



deleteVehicle _dt;
deleteVehicle _dt3;
deleteVehicle _dt4;
deleteMarker "Chop_Intel";
deleteMarker "Chop_Intel_mrk_1";
deleteMarker "Chop_Intel_2_mrk";
sleep 60;
deleteVehicle _hawk;

KC_MISS = false;
