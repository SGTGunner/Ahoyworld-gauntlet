/*
| Author:
|
|	Pfc.Christiansen & Josh
|_____
|
|   Description: Seek and destroy enemy tank platoon.
|
|	Created: 11.March 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/
params ["_missionCounter"];

_missionLocations = ["NukeIns","NukeIns_1","NukeIns_2","NukeIns_3","NukeIns_4","NukeIns_5","NukeIns_6","NukeIns_7","NukeIns_8","NukeIns_9","NukeIns_10","NukeIns_11","NukeIns_12","NukeIns_13","NukeIns_14","NukeIns_15","NukeIns_16","NukeIns_17","NukeIns_18","NukeIns_19","NukeIns_20","NukeIns_21","NukeIns_22","NukeIns_23","NukeIns_24"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn in objective + lock
mission11Objective1 = createVehicle ["rhs_btr60_vdv",getMarkerPos _selectedLocation, [], 0, "NONE" ];
mission11Objective2 = createVehicle ["O_ti_technical_F",getMarkerPos _selectedLocation, [], 10, "NONE" ];
mission11Objective3 = createVehicle ["O_ti_technical_a_F",getMarkerPos _selectedLocation, [], 20, "NONE" ];
mission11Objective4 = createVehicle ["O_ti_technical_a_F",getMarkerPos _selectedLocation, [], 15, "NONE" ];
mission11Objective5 = createVehicle ["O_ti_truck_s_F",getMarkerPos _selectedLocation, [], 10, "NONE" ];
mission11Object1= createVehicle ["Land_TentA_F",getMarkerPos _selectedLocation, [], 15, "NONE" ];
mission11Object2 = createVehicle ["Land_TentA_F",getMarkerPos _selectedLocation, [], 15, "NONE" ];
mission11Object3 = createVehicle ["Campfire_burning_F",getMarkerPos _selectedLocation, [], 15, "NONE" ];
mission11Object4 = createVehicle ["Land_TentA_F",getMarkerPos _selectedLocation, [], 15, "NONE" ];

mission11Objective1 setVehicleLock "LOCKED";
mission11Objective2 setVehicleLock "LOCKED";
mission11Objective3 setVehicleLock "LOCKED";
mission11Objective4 setVehicleLock "LOCKED";
mission11Objective5 setVehicleLock "LOCKED";

mission11Objective1 setDir 205;
mission11Objective2 setDir 20;
mission11Objective3 setDir 30;

//------------------- Spawn In Enemies
_DACvalues = ["m11",[13,0,0],[2,2,20,5],[],[5,2,35,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission11_mrk", getMarkerPos _selectedLocation ];
"mission11_mrk" setMarkerShape "ICON";
"mission11_mrk" setMarkerType "selector_selectable";
"mission11_mrk" setMarkerColor "ColorBLUFOR";
"mission11_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission11_1_mrk", getMarkerPos _selectedLocation];
"mission11_1_mrk" setMarkerShape "ELLIPSE";
"mission11_1_mrk" setMarkerSize [400,400];
"mission11_1_mrk" setMarkerBrush "Border";
"mission11_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission11_2_mrk", getMarkerPos "AOMarker"];
"mission11_2_mrk" setMarkerShape "ICON";
"mission11_2_mrk" setMarkerType "mil_dot";
"mission11_2_mrk" setMarkerText "Scouts have located a group of enemy technicals. Destroy all the enemy Vehicles.";

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Scouts have located a group of enemy technicals. Destroy all the enemy Vehicles.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFH
_missionPFH = {
	if ((!alive mission11Objective1) && (!alive mission11Objective2) && (!alive mission11Objective3) && (!alive mission11Objective4) && (!alive mission11Objective5)) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission11_mrk";
		deleteMarker "mission11_1_mrk";
		deleteMarker "mission11_2_mrk";

		_missionClearing = {
			deleteVehicle mission11Objective1;
			deleteVehicle mission11Objective2;
			deleteVehicle mission11Objective3;
			deleteVehicle mission11Objective4;
			deleteVehicle mission11Objective5;
			deleteVehicle mission11Object1;
			deleteVehicle mission11Object2;
			deleteVehicle mission11Object3;
			deleteVehicle mission11Object4;

			mission11Objective1 = nil;
			mission11Objective2 = nil;
			mission11Objective3 = nil;
			mission11Objective4 = nil;
			mission11Objective5 = nil;
			mission11Object1 = nil;
			mission11Object2 = nil;
			mission11Object3 = nil;
			mission11Object4 = nil;
		};

		[_missionClearing,[], 60] call ace_common_fnc_waitAndExecute;

		[{["m11"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
