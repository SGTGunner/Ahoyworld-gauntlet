/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: IED Mission
|
|	Created: 1.November 2014
|	Last modified: 05.July 2015 Reason: Updated code structure and modified it to fit into gauntlet
|	Coded for AhoyWorld.
*/


//Arrays,defines etc.
IED_DET = 0;
BLU_PRSNT = 1;
_missionLocations= ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"]; //Define location to spawn IED cluster.
_missionLocation = _missionLocations call BIS_fnc_selectRandom;
_ieds = ["IEDUrbanBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo" ,"IEDLandBig_Remote_Ammo" ,"IEDLandBig_Remote_Ammo" ]; //IED types.

//Get Operation Name
call KC_fnc_missionName;
_missionName = KC_missionName;

//Get IED Type
_ied = _ieds call BIS_fnc_selectRandom;

//Spawn IED3 Live IEDS and 2 dummys

IED1 = createVehicle [_ied, getMarkerPos _missionLocation, [], 0, "NONE"] ;
_ied = _ieds call BIS_fnc_selectRandom;
IED2 = createVehicle [_ied, getMarkerPos _missionLocation, [], 10, "NONE"] ;
_ied = _ieds call BIS_fnc_selectRandom;
IED3 = createVehicle [_ied, getMarkerPos _missionLocation, [], 15, "NONE"] ;
_ied = _ieds call BIS_fnc_selectRandom;
fakeIED1 =createVehicle [_ied, getMarkerPos _missionLocation, [], 4, "NONE"] ;
_ied = _ieds call BIS_fnc_selectRandom;
fakeIED2 =createVehicle [_ied, getMarkerPos _missionLocation, [], 23, "NONE"] ;
_ied = _ieds call BIS_fnc_selectRandom;


//Add speed trigger for IED1,2,3
_trg = createTrigger ["EmptyDetector",getPos IED1];
_trg setTriggerArea [6,6,6,false];
_trg setTriggerActivation ["WEST","PRESENT", false];
_trg setTriggerStatements ["speed player > 5 && player distance thistrigger < 8","null =[] execVM 'missions\IEDdefuse_expl.sqf'",""];


_trg2 = createTrigger ["EmptyDetector",getPos IED2];
_trg2 setTriggerArea [6,6,6,false];
_trg2 setTriggerActivation ["WEST","PRESENT", false];
_trg2 setTriggerStatements ["speed player > 5 && player distance thistrigger < 8","null =[] execVM 'missions\IEDdefuse_expl.sqf'",""];

_trg3 = createTrigger ["EmptyDetector",getPos IED3];
_trg3 setTriggerArea [6,6,6,false];
_trg3 setTriggerActivation ["WEST","PRESENT", false];
_trg3 setTriggerStatements ["speed player > 5 && player distance thistrigger < 8","null =[] execVM 'missions\IEDdefuse_expl.sqf'",""];

//ADD Checker for alive BLU
_trg4 = createTrigger ["EmptyDetector",getMarkerPos _missionLocation];
_trg4  setTriggerArea [30,30,30,false];
_trg4  setTriggerActivation ["WEST","PRESENT", true];
_trg4  setTriggerStatements ["true","BLU_PRSNT = 1","BLU_PRSNT = 0"];

//Spawn DAC(do spawn groups of snipers instead?)


//Mission Hint and marker

_marker = createMarker ["IED_mrk_1", getMarkerPos _missionLocation ];
"IED_mrk_1" setMarkerShape "ICON";
"IED_mrk_1" setMarkerType "selector_selectable";
"IED_mrk_1" setMarkerColor "ColorBLUFOR";
"IED_mrk_1" setMarkerText "Objective";

_marker2 = createMarker ["IED_mrk_2", getMarkerPos _missionLocation];
"IED_mrk_2" setMarkerShape "ELLIPSE";
"IED_mrk_2" setMarkerSize [400,400];
"IED_mrk_2" setMarkerBrush "Border";
"IED_mrk_2" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["IED_mrk_3", getMarkerPos "AOMarker"];
"IED_mrk_3" setMarkerShape "ICON";
"IED_mrk_3" setMarkerType "mil_dot";
"IED_mrk_3" setMarkerText "HUMINT reports an IED location, dispose of any IEDs";


_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>HUMINT reports an IED location, dispose of any IEDs<br/><br/>",
		_missionName
	];

["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//Complete Task(checkloop)
waitUntil {!alive IED1 && !alive IED2 && !alive IED3};

if ( IED_DET == 0 && BLU_PRSNT == 1) then
				{


				deleteVehicle IED1;
				deleteVehicle IED2;
				deleteVehicle IED3;
				deleteVehicle fakeIED1;
				deleteVehicle fakeIED2;
				deleteVehicle _trg;
				deleteVehicle _trg2;
				deleteVehicle _trg3;
				deleteVehicle _trg4;
				_misWinText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
				GlobalHint = _misWinText; publicVariable "GlobalHint"; hint parseText GlobalHint;
				};

if ( IED_DET == 1 ) then

			{

			_misFailText = format ["<t align='center' size='2.2'>OP Failed</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
			["Globalhint_EH", [_misFailText]] call ace_common_fnc_globalEvent;



			};
sleep 30;
				deleteVehicle IED1;
				deleteVehicle IED2;
				deleteVehicle IED3;
				deleteVehicle fakeIED1;
				deleteVehicle fakeIED2;
				deleteVehicle _trg;
				deleteVehicle _trg2;
				deleteVehicle _trg3;
				deleteVehicle _trg4;
KC_MISS = false;
