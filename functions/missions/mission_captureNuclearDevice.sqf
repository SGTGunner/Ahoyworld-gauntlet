/*
| Author:
|
|	Josh
|_____
|
|   Description: Capture enemy ballistic missile launcher
|
|	Created: 11.March 2015
|	Last modified:13. March 2015 By: Pfc.Christiansen
|	Made for AhoyWorld.
*/
params ["_missionCounter"];

_missionLocations = ["NukeIns","NukeIns_1","NukeIns_2","NukeIns_3","NukeIns_4","NukeIns_5","NukeIns_6","NukeIns_7","NukeIns_8","NukeIns_9","NukeIns_10","NukeIns_11","NukeIns_12","NukeIns_13","NukeIns_14","NukeIns_15","NukeIns_16","NukeIns_17","NukeIns_18","NukeIns_19","NukeIns_20","NukeIns_21","NukeIns_22","NukeIns_23","NukeIns_24"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;
_dropZone = getMarkerPos "spawn_zone";

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Spawn in objective + lock
mission12Objective = createVehicle ["O_Truck_03_device_F",getMarkerPos _selectedLocation, [], 0, "NONE" ];
mission12Object1 = createVehicle ["O_ti_truck_s_F",getMarkerPos _selectedLocation, [], 10, "NONE" ];
mission12Object2 = createVehicle ["O_ti_technical_a_F",getMarkerPos _selectedLocation, [], 20, "NONE" ];
mission12Object3 = createVehicle ["O_ti_technical_a_F",getMarkerPos _selectedLocation, [], 20, "NONE" ];
mission12Object4 = createVehicle ["O_ti_technical_F",getMarkerPos _selectedLocation, [], 25, "NONE" ];

mission12Object1 setVehicleLock "LOCKED";
mission12Object2 setVehicleLock "LOCKED";
mission12Object3 setVehicleLock "LOCKED";
mission12Object4 setVehicleLock "LOCKED";

mission12Object3 setDir 20;
mission12Object4 setDir 30;

//------------------- Spawn In Enemies
_DACvalues = ["m12",[12,0,0],[6,3,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission12_mrk", getMarkerPos _selectedLocation];
"mission12_mrk" setMarkerShape "ICON";
"mission12_mrk" setMarkerType "selector_selectable";
"mission12_mrk" setMarkerColor "ColorBLUFOR";
"mission12_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission12_1_mrk", getMarkerPos _selectedLocation];
"mission12_1_mrk" setMarkerShape "ELLIPSE";
"mission12_1_mrk" setMarkerSize [400,400];
"mission12_1_mrk" setMarkerBrush "Border";
"mission12_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission12_2_mrk", getMarkerPos "AOMarker"];
"mission12_2_mrk" setMarkerShape "ICON";
"mission12_2_mrk" setMarkerType "mil_dot";
"mission12_2_mrk" setMarkerText "Intel suggests the enemy have purchased a nuclear device. Capture and bring back to base the device.";

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Intel suggests the enemy have purchased a nuclear device. Capture and bring back to base the device.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- Trigger
winTrigger = createTrigger ["EmptyDetector",_dropZone,false];
winTrigger setTriggerArea [20,20,20,false];
winTrigger setTriggerStatements ["mission12Objective distance thistrigger < 10","missionWin = true;",""];

//------------------- PFH
_missionPFH = {
	if ((!isNil "missionWin") && {missionWin}) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission12_mrk";
		deleteMarker "mission12_1_mrk";
		deleteMarker "mission12_2_mrk";

		missionWin = nil;

		_missionClearing = {
			deleteVehicle mission12Object1;
			deleteVehicle mission12Object2;
			deleteVehicle mission12Object3;
			deleteVehicle mission12Object4;

			mission12Objective = nil;
			mission12Object1 = nil;
			mission12Object2 = nil;
			mission12Object3 = nil;
			mission12Object4 = nil;
		};
		[_missionClearing,[], 60] call ace_common_fnc_waitAndExecute;

		[{["m12"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
	if (!alive mission12Objective) then {
		(_this select 0) params ["_missionCounter","_missionName","_selectedLocation"];

		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
		["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;

		deleteMarker "mission12_mrk";
		deleteMarker "mission12_1_mrk";
		deleteMarker "mission12_2_mrk";
		deleteVehicle winTrigger;

		winTrigger = nil;
		missionWin = nil;

		_missionClearing = {
			deleteVehicle mission12Object1;
			deleteVehicle mission12Object2;
			deleteVehicle mission12Object3;
			deleteVehicle mission12Object4;

			mission12Objective = nil;
			mission12Object1 = nil;
			mission12Object2 = nil;
			mission12Object3 = nil;
			mission12Object4 = nil;
		};
		[_missionClearing,[], 60] call ace_common_fnc_waitAndExecute;

		[{["m12"] call DAC_fDeleteZone;},[], 60] call ace_common_fnc_waitAndExecute;

		[(_missionCounter+1),_selectedLocation] call AW_fnc_missionTransition;
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
};
[_missionPFH,10,[_missionCounter,_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
