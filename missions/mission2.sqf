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
TRUCK_ARR = 0;
TRUCK_DEAD = 0;
_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];

_spawnLoc = getMarkerPos "spawn_zone";
call KC_fnc_missionName;
_missionName = KC_missionName;

// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn In enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m2",[2,0,0],[4,2,20,5],[],[1,2,20,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

//Spawn Truck in

truck = createVehicle ["RHS_Ural_Civ_03", _spawnLoc, [], 0, "NONE" ];

//Marker AO +Hint new AO

_marker = createMarker ["mission2_mrk", getMarkerPos _missionLoc ];
"mission2_mrk" setMarkerShape "ICON";
"mission2_mrk" setMarkerType "selector_selectable";
"mission2_mrk" setMarkerColor "ColorBLUFOR";
"mission2_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission2_1", getMarkerPos _missionLoc];
"mission2_1_mrk" setMarkerShape "RECTANGLE";
"mission2_1_mrk" setMarkerSize [30,30];
"mission2_1_mrk" setMarkerBrush "Border";
"mission2_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission2_2_mrk", getMarkerPos "AOMarker"];
"mission2_2_mrk" setMarkerShape "ICON";
"mission2_2_mrk" setMarkerType "mil_dot";
"mission2_2_mrk" setMarkerText "A point needs resupplying, bring the truck from the pickup point to the designated area.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A point needs resupplying,bring the truck from the pickup-point to the designated area<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//Triggers for mission end

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [20,20,20,false];
_trg setTriggerStatements ["truck distance thistrigger < 10","TRUCK_ARR = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg2 setTriggerArea [20,20,20,false];
_trg2 setTriggerStatements ["!alive truck","TRUCK_DEAD = 1",""];


waitUntil {TRUCK_ARR == 1 or TRUCK_DEAD == 1};


	if ( TRUCK_ARR == 1) then
		{
							_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
							["Globalhint_EH", [_misSUCText]] call ace_common_fnc_globalEvent;
		};
	if ( TRUCK_DEAD == 1) then
		{
							_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
							["Globalhint_EH", [_misFAILText]] call ace_common_fnc_globalEvent;
		};

deleteVehicle _trg;
deleteVehicle _trg2;
deleteMarker "mission2_mrk";
deleteMarker "mission2_1_mrk";
deleteMarker "mission2_2_mrk";
sleep 10;
deleteVehicle truck;
sleep 50;

waituntil{DAC_NewZone == 0};
["m2"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};
KC_MISS = false;
