/*
| Author:
|
|	BACONMOP
|_____
|
|   Description: Kill an HVT, also sends a QRF
|
|	Created: 30. June 2015
|	Last modified:1. July 2015 By: BACONMOP
|	Made for AhoyWorld.
*/

// Mission Location and name
params ["_missionCounter"];

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;
_meetingLocation = [_selectedLocation, 100] call CBA_fnc_randPos;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Objective
_hvtGrp = createGroup east;
"rhs_vdv_officer_armored" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_medic" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_engineer" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_LAT" createUnit [_meetingLocation, _hvtGrp];
mission14Objective = ((units _hvtGrp) select 0);

//------------------- Defence
_DACvalues = ["m11",[11,0,0],[6,4,20,5],[],[2,1,10,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;
rndPos  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
rndPos1  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
rndPos2  =  [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
rndPos3  =  [getMarkerPos _selectedLocation, 3000] call CBA_fnc_randPos;

//------------------- Markers
_marker = createMarker ["HVT_mrk", getMarkerPos _selectedLocation ];
"HVT_mrk" setMarkerShape "ICON";
"HVT_mrk" setMarkerType "selector_selectable";
"HVT_mrk" setMarkerColor "ColorBLUFOR";
"HVT_mrk" setMarkerText "Objective";

_marker2 = createMarker ["HVT_mrk_1", getMarkerPos _selectedLocation];
"HVT_mrk_1" setMarkerShape "RECTANGLE";
"HVT_mrk_1" setMarkerSize [400,400];
"HVT_mrk_1" setMarkerBrush "Border";
"HVT_mrk_1" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["HVT_2_mrk", getMarkerPos "AOMarker"];
"HVT_2_mrk" setMarkerShape "ICON";
"HVT_2_mrk" setMarkerType "mil_dot";
"HVT_2_mrk" setMarkerText "An Enemy officer has been spotted. Take Him Out.";

//------------------- Triggers
QRFTarget = getMarkerPos _selectedLocation;
nextPhaseTrigger = createTrigger ["EmptyDetector",QRFTarget];
nextPhaseTrigger setTriggerArea [400,400,0,false];
nextPhaseTrigger setTriggerActivation ["West","East D", false];
nextPhaseTrigger setTriggerStatements ["this","GRP1 = [rndPos, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
[GRP1,QRFTarget] call BIS_fnc_taskAttack;
GRP2 = [rndPos2, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
[GRP2,QRFTarget] call BIS_fnc_taskAttack;
GRP3 = [rndPos1, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
[GRP3,QRFTarget] call BIS_fnc_taskAttack;_heliGrp = createGroup east;
ambientHeli = createVehicle ['RHS_Mi8AMTSh_UPK23_vvsc', rndPos3, [], 0, 'FLY' ];
[ambientHeli,_heliGrp] call BIS_fnc_spawnCrew; [heliGrp,QRFTarget] call BIS_fnc_taskAttack;QRFCalled = true;",""];

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>An enemy Officer has been spotted. Kill him but be aware. If the enemy find you they will call in their QRF.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFHs
_qrfPFH = {
	if ((!isNil "QRFCalled") && {QRFCalled}) then {
		(_this select 0) params ["","_missionName",""];

		_misEndText = format ["<t align='center' size='2.2'>Attention</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>The enemy QRF has been alerted. Hurry up with the mission.</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_qrfPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;

_missionPFH = {
	if (!alive mission14Objective) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1. Now get out of the area and new tasking will be assigned</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "HVT_mrk";
		deleteMarker "HVT_mrk_1";
		deleteMarker "HVT_2_mrk";
		deleteVehicle nextPhaseTrigger;

		mission14Objective = nil;
		QRFCalled = nil;
		rndPos = nil;
		rndPos1 = nil;
		rndPos2 = nil;
		rndPos3 = nil;
		GRP1 = nil;
		GRP2 = nil;
		GRP3 = nil;
		ambientHeli = nil;
		QRFTarget = nil;
		nextPhaseTrigger = nil;

		[{["m11"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;
		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
