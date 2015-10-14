/*
 * Author: Pfc.Christiansen
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission4: Destroy Radar Installation.
 *
 * Phases: None
 *
 * Conditions:
 * Win: Radar vehicle destroyed.
 * Fail: None
 */
params ["_missionCounter"];

_missionLocations = ["Outskirts","Outskirts_1","Outskirts_2","Outskirts_3","Outskirts_4","Outskirts_5","Outskirts_6","Outskirts_7","Outskirts_8","Outskirts_9","Outskirts_10"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn in objective
mission4Objective = createVehicle ["rhs_p37",getMarkerPos _selectedLocation, [], 0, "NONE" ];
local _obj_2 = createVehicle ["rhs_v2",getMarkerPos _selectedLocation, [], 20, "NONE" ];
local _obj_3 = createVehicle ["rhs_v2",getMarkerPos _selectedLocation, [], 30, "NONE" ];

//------------------- Spawn In Enemies
_DACvalues = ["m4",[4,0,0],[4,4,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Marker AO +Hint new AO
_marker = createMarker ["mission4_mrk", getMarkerPos _selectedLocation ];
"mission4_mrk" setMarkerShape "ICON";
"mission4_mrk" setMarkerType "selector_selectable";
"mission4_mrk" setMarkerColor "ColorBLUFOR";
"mission4_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission4_1_mrk", getMarkerPos _selectedLocation];
"mission4_1_mrk" setMarkerShape "ELLIPSE";
"mission4_1_mrk" setMarkerSize [400,400];
"mission4_1_mrk" setMarkerBrush "Border";
"mission4_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission4_2_mrk", getMarkerPos "AOMarker"];
"mission4_2_mrk" setMarkerShape "ICON";
"mission4_2_mrk" setMarkerType "mil_dot";
"mission4_2_mrk" setMarkerText "OPFOR has set up a radar installation, this needs to be taken out ASAP to ensure our air-superiority.";

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>OPFOR has set up a radar installation at the location, this needs to be taken out ASAP to ensure our air-superiority <br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH checking every 10s if the mission has been completed
_missionPFH = {
	if (!alive mission4Objective) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission4_mrk";
		deleteMarker "mission4_1_mrk";
		deleteMarker "mission4_2_mrk";

		_missionClearing = {
			deleteVehicle _obj_2;
			deleteVehicle _obj_3;
			deleteVehicle mission4Objective;
			mission4Objective = nil;
		};
		[_missionClearing,[], 60] call ace_common_fnc_waitAndExecute;

		[{["m4"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
