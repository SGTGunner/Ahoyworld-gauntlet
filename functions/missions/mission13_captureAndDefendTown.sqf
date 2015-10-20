/*
 * Authors: Josh
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission13: Capture a town and defend it.
 *
 * Phases: 2
 * 1: Town hasn't been cleared (OPFOR still present inside the marker)
 * 2: Town has been cleared, reinforcements called
 *
 * Conditions:
 * Win: Phase 2 started and reinforcements mostly killed
 * Fail: None
 */
 missionInProgress = true;
publicVariable "missionInProgress";

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn enemies
_DACvalues = ["m13",[11,0,0],[8,4,20,5],[3,2,20,5],[2,2,10,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission13_mrk", getMarkerPos _selectedLocation ];
"mission13_mrk" setMarkerShape "ICON";
"mission13_mrk" setMarkerType "selector_selectable";
"mission13_mrk" setMarkerColor "ColorBLUFOR";
"mission13_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission13_1_mrk", getMarkerPos _selectedLocation];
"mission13_1_mrk" setMarkerShape "RECTANGLE";
"mission13_1_mrk" setMarkerSize [400,400];
"mission13_1_mrk" setMarkerBrush "Border";
"mission13_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission13_2_mrk", getMarkerPos "AOMarker"];
"mission13_2_mrk" setMarkerShape "ICON";
"mission13_2_mrk" setMarkerType "mil_dot";
"mission13_2_mrk" setMarkerText "A town has been occupied, you need to clear it out! Good Luck.";

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A town has been occupied, you need to clear it out! Good Luck.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- Triggers
_missionNextPhaseTriggerWait = {
	(_this select 0) params ["_selectedLocation"];
	missionNextPhaseTrigger = createTrigger ["EmptyDetector",getMarkerPos _selectedLocation,false];
	missionNextPhaseTrigger setTriggerArea [500,500,0,false];
	missionNextPhaseTrigger setTriggerActivation ["EAST","NOT PRESENT", false];
	missionNextPhaseTrigger setTriggerStatements ["this","missionNextPhase = true;",""];
};
[_missionNextPhaseTriggerWait, [_selectedLocation], 60] call ace_common_fnc_waitAndExecute;

//------------------- PFH
_missionPFH = {
	if ((!isNil "missionNextPhase") && {missionNextPhase}) then {
		(_this select 0) params ["_missionName","_selectedLocation"];

		_misMidHintText = format ["<t align='center' size='2.2'>Attention!</t><br/><t size='1.5' align='center' color='#FFCF11'></t><br/>____________________<br/>Enemy reinforcements have arrived! Prepare for Counter-Attack!<br/><br/>",_missionName];
		["Globalhint_EH", [_misMidHintText]] call ace_common_fnc_globalEvent;

		missionNextPhase = nil;

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
	};
	if ((!isNil "GRP1") && {(count (units GRP1) < 4) && (count (units GRP2) < 4) && (count (units GRP3) < 4) && (count (units GRP4) < 4)}) then {
		(_this select 0) params ["_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission13_1_mrk";
		deleteMarker "mission13_mrk";
		deleteMarker "mission13_2_mrk";

		GRP1 = nil;
		GRP2 = nil;
		GRP3 = nil;

		[{["m13"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

		[_selectedLocation] call AW_fnc_missionTransition;
		gauntlet_missionCounter = gauntlet_missionCounter + 1;
        mission13Completed = true;
        publicVariable "mission13Completed";

		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
