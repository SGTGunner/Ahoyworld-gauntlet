/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Destroy crashlanded UAV.
|
|	Created: 27.January 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/

//Defines+mission name

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];

call KC_fnc_missionName;
_missionName = KC_missionName;

COUNTER_ATK = 0;

// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Create Trigger for Blufor

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [400,400,0,false];
_trg setTriggerActivation ["WEST","PRESENT", false];
_trg setTriggerStatements ["this","COUNTER_ATK = 1",""];



//Mission Hint

 _misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A UAV has crashlanded, destroy it before the enemies can retrieve it. <br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

_marker = createMarker ["mission9_mrk", getMarkerPos _missionLoc ];
"mission9_mrk" setMarkerShape "ICON";
"mission9_mrk" setMarkerType "selector_selectable";
"mission9_mrk" setMarkerColor "ColorBLUFOR";
"mission9_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission9_1_mrk", getMarkerPos _missionLoc];
"mission9_1_mrk" setMarkerShape "ELLIPSE";
"mission9_1_mrk" setMarkerSize [400,400];
"mission9_1_mrk" setMarkerBrush "Border";
"mission9_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission9_2_mrk", getMarkerPos "AOMarker"];
"mission9_2_mrk" setMarkerShape "ICON";
"mission9_2_mrk" setMarkerType "mil_dot";
"mission9_2_mrk" setMarkerText "A UAV has crashlanded, destroy it before the enemies can retrieve it.";

//Create UAV and Lock

k_uav = createVehicle ["B_UAV_02_F", getMarkerPos _missionLoc, [], 100, "NONE" ];


//Wait for blufor to get near uav

waitUntil {COUNTER_ATK == 1};

//Hint East are approaching

_misMidHintText = format
	[
		"<t align='center' size='2.2'>Attention!</t><br/><t size='1.5' align='center' color='#FFCF11'></t><br/>____________________<br/>OPFOR Forces are nearing the crash site, take them out before destroying the UAV<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misMidHintText]] call ace_common_fnc_globalEvent;

// Spawn enemy COUNTER_ATK

_rndPos  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;


_GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
[_GRP1,(getPos k_uav)] call BIS_fnc_taskAttack;

sleep  15;

_rndPos2 =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;

_GRP2 = [_rndPos2, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
[_GRP2,(getPos k_uav)] call BIS_fnc_taskAttack;

sleep  15;

_rndPos3  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;

_GRP3 = [_rndPos3, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_btr60" >> "rhs_group_rus_vdv_btr60_squad_2mg" )] call BIS_fnc_spawnGroup;
[_GRP3,(getPos k_uav)] call BIS_fnc_taskAttack;



waitUntil{!alive k_uav};

_misSUCText = format

	[

	"<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",
	_missionName

	];
["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

sleep 15;
deleteVehicle k_uav;
deleteVehicle _trg;
deleteMarker "mission9_mrk";
deleteMarker "mission9_1_mrk";
deleteMarker "mission9_2_mrk";

KC_MISS = false;
