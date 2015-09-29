/*
| Author:
|
|	BACONMOP
|_____
|
|   Description:  Radio Tower needs to be destroyed
|
|	Created: 26.January 2014
|	Last modified: 26.January 2014 By: Christiansen
|	Coded for AhoyWorld.
*/

// ----------------- Get Radio Tower Position

	_position = [getMarkerPos "Center", 4000] call CBA_fnc_randPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];

	while {(count _flatPos) < 1} do {
		_position = [getMarkerPos "Center", 4000] call CBA_fnc_randPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};

	_roughPos =
	[
		((_flatPos select 0) - 200) + (random 400),
		((_flatPos select 1) - 200) + (random 400),
		0
	];

// ----------------- Create Radio Tower

	radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
	waitUntil { sleep 0.5; alive radioTower };
	radioTower setVectorUp [0,0,1];
	radioTowerAlive = true; publicVariable "radioTowerAlive";

// ----------------- DAC

	waituntil{DAC_NewZone == 0};
	_DACvaluesradio = ["Radio_Defenders",[3,0,0],[8,4,40,5],[4,2,30,5],[4,1,20,5],[],[0,0,0,0]];
	[_roughPos,1000,1000,0,0,_DACvaluesradio] call DAC_fNewZone;
	waituntil{DAC_NewZone == 0};
// ----------------- Briefing

	call KC_fnc_missionName;
	_missionName = KC_missionName;


	_marker = createMarker ["mission1_mrk", _roughPos ];
	"mission1_mrk" setMarkerShape "ICON";
	"mission1_mrk" setMarkerType "selector_selectable";
	"mission1_mrk" setMarkerColor "ColorBLUFOR";
	"mission1_mrk" setMarkerText "Objective";

	_marker2 = createMarker ["mission1_1_mrk", _roughPos];
	"mission1_1_mrk" setMarkerShape "ELLIPSE";
	"mission1_1_mrk" setMarkerSize [400,400];
	"mission1_1_mrk" setMarkerBrush "Border";
	"mission1_1_mrk" setMarkerColor "ColorOPFOR";

	_marker3 = createMarker ["mission7_2_mrk", getMarkerPos "AOMarker"];
	"mission7_2_mrk" setMarkerShape "ICON";
	"mission7_2_mrk" setMarkerType "mil_dot";
	"mission7_2_mrk" setMarkerText "OPFOR have set up a communication tower. Take the tower down ASAP!";

	_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Opfor have set up a communications tower. They are listening in to our comms. Take that tower down Now<br/><br/>",
		_missionName
	];
	["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

// ----------------- Wait For Tower To Die

	waitUntil {sleep 3; !alive radioTower};
	radioTowerAlive = false; publicVariable "radioTowerAlive";

// ----------------- De-Brief

	_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with that mission. Further tasking will occur shortly</t>",_missionName];
	["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;
	deleteMarker "mission1_mrk";
	deleteMarker "mission1_1_mrk";
	deleteMarker "mission7_2_mrk";

// ----------------- Delete

	sleep 60;
	waituntil{DAC_NewZone == 0};
	["Radio_Defenders"] call DAC_fDeleteZone;
	waituntil{DAC_NewZone == 0};
	deleteVehicle radioTower;

KC_MISS = false;
