/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Stop deal between insurgents and opfor
|
|	Created: 10.January 2015
|	Last modified: By:
|	Made for AhoyWorld.
*/

//Defines+mission name

_ins_truck = getMarkerPos "mission_3_truck_1";
_ins_car = getMarkerPos "mission_3_car_1";
_opf_car = getMarkerPos "mission_3_car_2";
_opf_truck= getMarkerPos "mission_3_truck_2";
_obj = getMarkerPos "mission_3_aa";

call KC_fnc_missionName;
_missionName = KC_missionName;

//Spawn ambiant vics+lock and objective

_ins_car_spwn = createVehicle ["y_technical_a", _ins_car, [], 0, "NONE" ];
_ins_truck_spwn = createVehicle ["y_truck_small", _ins_truck, [], 0, "NONE" ];

_opf_car_spwn = createVehicle ["rhs_tigr_vdv", _opf_car, [], 0, "NONE" ];
_opf_truck_spwn = createVehicle ["rhs_typhoon_vdv", _opf_truck, [], 0, "NONE" ];

_objective = createVehicle ["rhs_zsu234_aa", _obj, [], 0, "NONE" ];

_ins_car_spwn setVehicleLock "LOCKED";
_ins_truck_spwn setVehicleLock "LOCKED";
_opf_car_spwn setVehicleLock "LOCKED";
_opf_truck_spwn setVehicleLock "LOCKED";

_ins_car_spwn setDir 205;
_ins_truck_spwn setDir 205;

_opf_car_spwn setDir 25;
_opf_truck_spwn setDir 25;

_objective setDir 290;

//Spawn In Enemies (2 zones as heavy defence @ objective and ambient around AF)

waituntil{DAC_NewZone == 0};
_DACvalues = ["m3_1",[3,0,0],[5,4,20,5],[],[3,2,20,5],[],[0,0,0,0]];
[_obj,600,600,0,0,_DACvalues] call DAC_fNewZone;

waituntil{DAC_NewZone == 0};

_DACvalues = ["m3_2",[3,0,0],[5,3,20,5],[],[],[3,2,20,5],[0,0,0,0]];
[_obj,250,250,0,0,_DACvalues] call DAC_fNewZone;

waituntil{DAC_NewZone == 0};
//AO marker+hint

//Marker AO +Hint new AO
_marker = createMarker ["mission3_mrk", _obj];
"mission3_mrk" setMarkerShape "ICON";
"mission3_mrk" setMarkerType "selector_selectable";
"mission3_mrk" setMarkerColor "ColorBLUFOR";
"mission3_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission3_1_mrk", _obj];
"mission3_1_mrk" setMarkerShape "ELLIPSE";
"mission3_1_mrk" setMarkerSize [400,400];
"mission3_1_mrk" setMarkerBrush "Border";
"mission3_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission3_2_mrk", getMarkerPos "AOMarker"];
"mission3_2_mrk" setMarkerShape "ICON";
"mission3_2_mrk" setMarkerType "mil_dot";
"mission3_2_mrk" setMarkerText "A deal is going down between the OPFOR and Insurgents, the Insurgents are trying to aquire a AA-vehicle,stop the trade and clear out any enemies and blow up the AA-vehicle.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A deal is going down between the OPFOR and Insurgents, the Insurgents are trying to aquire a AA-vehicle,stop the trade and clear out any enemies and blow up the AA-vehicle. Good Luck!<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

waituntil{!alive _objective};

_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with halting the trade. %1 was a success</t>",_missionName];
["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

deleteMarker "mission3_mrk";
deleteMarker "mission3_1_mrk";
deleteMarker "mission3_2_mrk";

sleep 30;
deleteVehicle _ins_car_spwn;
deleteVehicle _ins_truck_spwn;
deleteVehicle _opf_car_spwn;
deleteVehicle _opf_truck_spwn;
deleteVehicle _objective;
sleep 30;
waituntil{DAC_NewZone == 0};
["m3_1"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};
["m3_2"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};
KC_MISS = false;
