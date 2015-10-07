/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Resupply mission by truck.
|
|	Created: 10.January 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/

//Defines+mission name
params ["_missionCounter"];

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn In enemies
_DACvalues = ["m2",[2,0,0],[4,2,20,5],[],[1,2,20,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Spawn Truck in
_spawnLoc = getMarkerPos "spawn_zone";
mission2Objective = createVehicle ["RHS_Ural_Civ_03", _spawnLoc, [], 0, "NONE" ];

//------------------- Markers AO
_marker = createMarker ["mission2_mrk", getMarkerPos _selectedLocation ];
"mission2_mrk" setMarkerShape "ICON";
"mission2_mrk" setMarkerType "selector_selectable";
"mission2_mrk" setMarkerColor "ColorBLUFOR";
"mission2_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission2_1", getMarkerPos _selectedLocation];
"mission2_1_mrk" setMarkerShape "RECTANGLE";
"mission2_1_mrk" setMarkerSize [30,30];
"mission2_1_mrk" setMarkerBrush "Border";
"mission2_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission2_2_mrk", getMarkerPos "AOMarker"];
"mission2_2_mrk" setMarkerShape "ICON";
"mission2_2_mrk" setMarkerType "mil_dot";
"mission2_2_mrk" setMarkerText "A point needs resupplying, bring the truck from the pickup point to the designated area.";

//------------------- win trigger
winTrigger = createTrigger ["EmptyDetector",getMarkerPos _selectedLocation,false];
winTrigger setTriggerArea [20,20,20,false];
winTrigger setTriggerStatements ["mission2Objective distance thistrigger < 10","missionWin = true;",""];

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A point needs resupplying,bring the truck from the pickup-point to the designated area<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH checking every 10s if the mission has been completed
_missionPFH = {
	if ((!isNil "missionWin") && {missionWin}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission2_mrk";
		deleteMarker "mission2_1_mrk";
		deleteMarker "mission2_2_mrk";

		missionWin = nil;
		[{deleteVehicle mission2Objective;mission2Objective = nil;},[], 60] call ace_common_fnc_waitAndExecute;

		[{["m2"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
	if (!alive mission2Objective) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission2_mrk";
		deleteMarker "mission2_1_mrk";
		deleteMarker "mission2_2_mrk";
		deleteVehicle winTrigger;

		winTrigger = nil;
		missionWin = nil;
		[{mission2Objective = nil;},[], 60] call ace_common_fnc_waitAndExecute;

		[{["m2"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
