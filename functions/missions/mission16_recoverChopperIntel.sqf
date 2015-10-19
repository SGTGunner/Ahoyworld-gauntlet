/*
 * Authors: BACONMOP
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission16: Secure Intel from downed chopper.
 *
 * Phases: 2
 * 1: BLUFOR not near the chopper, no download
 * 2: BLUFOR near the chopper, downloading
 *
 * Conditions:
 * Win: Download completed and chopper destroyed
 * Fail: Chopper destroyed before the download was complete
 */
 missionInProgress = true;
 
_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Objective
_rndPos = [getMarkerPos _selectedLocation, 200] call CBA_fnc_randPos;
mission16Objective = "RHS_UH60M" createVehicle _rndPos;
mission16Objective setDamage .9;

//------------------- Markers
_marker = createMarker ["mission16_mrk", getMarkerPos _selectedLocation ];
"mission16_mrk" setMarkerShape "ICON";
"mission16_mrk" setMarkerType "selector_selectable";
"mission16_mrk" setMarkerColor "ColorBLUFOR";
"mission16_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission16_1_mrk", getMarkerPos _selectedLocation];
"mission16_1_mrk" setMarkerShape "RECTANGLE";
"mission16_1_mrk" setMarkerSize [400,400];
"mission16_1_mrk" setMarkerBrush "Border";
"mission16_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission16_2_mrk", getMarkerPos "AOMarker"];
"mission16_2_mrk" setMarkerShape "ICON";
"mission16_2_mrk" setMarkerType "mil_dot";
"mission16_2_mrk" setMarkerText "Recover intel from the downed helicopter.";

//------------------- Triggers
nextPhaseTrigger = createTrigger ["EmptyDetector",_rndPos,false];
nextPhaseTrigger setTriggerArea [20,20,20,false];
nextPhaseTrigger setTriggerActivation ["WEST","PRESENT",false];
nextPhaseTrigger setTriggerStatements ["this","missionNextPhase = true;",""];

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A helicopter carrying important information has been shot down. Get out there and recover the data.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH checking every 10s if the mission has been completed
_timerPFH = {
	if ((!isNil "missionNextPhase") && {!(missionNextPhase)}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation","_rndPos"];

		_misSUCText = format ['OP Update<br/><br/>____________________<br/>Uplink with the helicopter has been lost. Restart the download.',_missionName];
		['Globalhint_EH', [_misSUCText]] call ace_common_fnc_globalEvent;

		missionTimer = nil;

		nextPhaseTrigger = createTrigger ["EmptyDetector",_rndPos,false];
		nextPhaseTrigger setTriggerArea [20,20,20,false];
		nextPhaseTrigger setTriggerActivation ["WEST","PRESENT",false];
		nextPhaseTrigger setTriggerStatements ["this","missionNextPhase = true;",""];
	};
	if ((!isNil "missionNextPhase") && {missionNextPhase}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation","_rndPos"];

		_misSUCText = format ["<t align='center' size='2.2'>OP Update</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Intel download has begun. Dig in and prepare for an attack.</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

		missionNextPhase = nil;

		nextPhaseTrigger = createTrigger ["EmptyDetector",_rndPos,false];
		nextPhaseTrigger setTriggerArea [20,20,20,false];
		nextPhaseTrigger setTriggerActivation ["WEST","NOT PRESENT",false];
		nextPhaseTrigger setTriggerStatements ["this","missionNextPhase = false;",""];

		missionTimer = 0;
	};
	if (!isNil "missionTimer") then {
		missionTimer = missionTimer + 10;
	};
	if ((!isNil "missionTimer") && {missionTimer >= (300 + (random 300))}) then {
		(_this select 0) params ["_missionName"];

		_misSUCText = format ["<t align='center' size='2.2'>OP Update</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Intel is secured. Now destroy the helicopter and extract.</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

		missionWin = true;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	}
};
timerPFHhandle = [_timerPFH,10,[_missionName]] call CBA_fnc_addPerFrameHandler;

_reinforcementsPFH = {
	if ((!isNil "enemyReinforcements") && {enemyReinforcements}) then {
		(_this select 0) params ["_selectedLocation"];

		_rndPos  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
		GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP1,(getMarkerPos  _selectedLocation)] call BIS_fnc_taskAttack;

		_rndPos  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
		GRP2 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP2,(getMarkerPos  _selectedLocation)] call BIS_fnc_taskAttack;

		_rndPos  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
		GRP3 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP3,(getMarkerPos  _selectedLocation)] call BIS_fnc_taskAttack;

		_rndPos  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
		GRP4 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
		[GRP4,(getMarkerPos  _selectedLocation)] call BIS_fnc_taskAttack;

		enemyReinforcements = false;
	};
if ((!isNil "GRP1") && {(count (units GRP1) < 4) && (count (units GRP2) < 4) && (count (units GRP3) < 4) && (count (units GRP4) < 4)}) then {
		enemyReinforcements = true;
	};
};
reinforcementsPFHhandle = [_timerPFH,10,[_selectedLocation]] call CBA_fnc_addPerFrameHandler;

_missionPFH = {
	if ((isNil "missionWin") && {!alive mission16Objective}) then {
		(_this select 0) params ["_missionName","_selectedLocation"];

		_misSUCText = format ["<t align='center' size='2.2'>OP Failed</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1. The chopper was destroyed before the download could be complete.</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission16_mrk";
		deleteMarker "mission16_1_mrk";
		deleteMarker "mission16_2_mrk";

		enemyReinforcements = nil;

		_missionCLearing = {
			mission16Objective = nil;
			GRP1 = nil;
			GRP2 = nil;
			GRP3 = nil;
			GRP4 = nil;
		};
		[_missionCLearing,[], 300] call ace_common_fnc_waitAndExecute;

		[_selectedLocation] call AW_fnc_missionTransition;
		gauntlet_missionCounter = gauntlet_missionCounter + 1;

		[timerPFHhandle] call CBA_fnc_removePerFrameHandler;
		[reinforcementsPFHhandle] call CBA_fnc_removePerFrameHandler;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
	if ((!isNil "missionWin") && {missionWin} && {!alive mission16Objective}) then {
		(_this select 0) params ["_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1. Now get out of the area and new tasking will be assigned</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission16_mrk";
		deleteMarker "mission16_1_mrk";
		deleteMarker "mission16_2_mrk";

		missionWin = nil;
		enemyReinforcements = nil;

		_missionCLearing = {
			mission16Objective = nil;
			GRP1 = nil;
			GRP2 = nil;
			GRP3 = nil;
			GRP4 = nil;
		};
		[_missionCLearing,[], 300] call ace_common_fnc_waitAndExecute;

		[_selectedLocation] call AW_fnc_missionTransition;
		gauntlet_missionCounter = gauntlet_missionCounter + 1;

		[timerPFHhandle] call CBA_fnc_removePerFrameHandler;
		[reinforcementsPFHhandle] call CBA_fnc_removePerFrameHandler;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
