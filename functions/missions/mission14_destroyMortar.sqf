/*
 * Authors: Pfc.Christiansen
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission14: Destroy mortar Emplacement.
 *
 * Phases: None
 *
 * Conditions:
 * Win: Target vehicle destroyed
 * Fail: None
 */
_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn in objective
_rndPos  =  [getMarkerPos _selectedLocation, 200] call CBA_fnc_randPos;
mission14Objective = "B_rr_mortar_F" createVehicle _rndPos;
mission14Objective setDamage .9;
mission14Objective setVehicleAmmo 0;

//------------------- Spawn In Enemies
_DACvalues = ["m14",[4,0,0],[4,4,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission14_mrk", getMarkerPos _selectedLocation ];
"mission14_mrk" setMarkerShape "ICON";
"mission14_mrk" setMarkerType "selector_selectable";
"mission14_mrk" setMarkerColor "ColorBLUFOR";
"mission14_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission14_1_mrk", getMarkerPos _selectedLocation];
"mission14_1_mrk" setMarkerShape "ELLIPSE";
"mission14_1_mrk" setMarkerSize [400,400];
"mission14_1_mrk" setMarkerBrush "Border";
"mission4_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission14_2_mrk", getMarkerPos "AOMarker"];
"mission14_2_mrk" setMarkerShape "ICON";
"mission14_2_mrk" setMarkerType "mil_dot";
"mission14_2_mrk" setMarkerText "OPFOR has set up a Mortar emplacement. Destroy it ASAP to allow our forces to push up.";

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>OPFOR has set up a Mortar emplacement. Destroy it ASAP to allow our forces to push up. <br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH
_missionPFH = {
	if (!alive mission14Objective) then {
		(_this select 0) params ["_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission14_mrk";
		deleteMarker "mission14_1_mrk";
		deleteMarker "mission14_2_mrk";

		[{deleteVehicle mission14Objective;mission14Objective = nil;},[], 60] call ace_common_fnc_waitAndExecute;

		[{["m14"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

		[_selectedLocation] call AW_fnc_missionTransition;
		gauntlet_missionCounter = gauntlet_missionCounter + 1;
		
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
