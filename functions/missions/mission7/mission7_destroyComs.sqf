/*
 * Author: BACONMOP
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission7: Destroy the designated radio tower.
 *
 * Phases: None
 *
 * Conditions:
 * Win: Tower destroyed
 * Fail: None
 */
 missionInProgress = true;
publicVariable "missionInProgress";

//----------------- Get Radio Tower Position
_position = [getMarkerPos "Center", 2000] call CBA_fnc_randPos;
_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
_roughPos =[((_flatPos select 0) - 200) + (random 400),((_flatPos select 1) - 200) + (random 400),0];

//----------------- Create Radio Tower
mission7Objective = "Land_TTowerBig_2_F" createVehicle _flatPos;
mission7Objective setVectorUp [0,0,1];

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//----------------- DAC
_DACvaluesradio = ["m7",[3,0,0],[8,4,40,5],[4,2,30,5],[4,1,20,5],[],[0,0,0,0]];
[_position,1000,1000,0,0,_DACvaluesradio] call DAC_fNewZone;

//----------------- Markers
_marker = createMarker ["mission7_mrk", _roughPos ];
"mission7_mrk" setMarkerShape "ICON";
"mission7_mrk" setMarkerType "selector_selectable";
"mission7_mrk" setMarkerColor "ColorBLUFOR";
"mission7_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission7_1_mrk", _roughPos];
"mission7_1_mrk" setMarkerShape "ELLIPSE";
"mission7_1_mrk" setMarkerSize [400,400];
"mission7_1_mrk" setMarkerBrush "Border";
"mission7_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission7_2_mrk", getMarkerPos "AOMarker"];
"mission7_2_mrk" setMarkerShape "ICON";
"mission7_2_mrk" setMarkerType "mil_dot";
"mission7_2_mrk" setMarkerText "OPFOR have set up a communication tower. Take the tower down ASAP!";

//----------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Opfor have set up a communications tower. They are listening in to our comms. Take that tower down Now<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//----------------- mission PFH
_missionPFH = {
    if ((!isNil "mission7Objective") && {!alive mission7Objective}) then {
        (_this select 0) params ["_missionName","_roughPos"];

        _misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with that mission. Further tasking will occur shortly</t>",_missionName];
        ["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

        deleteMarker "mission7_mrk";
        deleteMarker "mission7_1_mrk";
        deleteMarker "mission7_2_mrk";

        [{deleteVehicle mission7Objective;mission7Objective = nil;},[], 60] call ace_common_fnc_waitAndExecute;

        [{["m7"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;

        [_roughPos,"ELLIPSE",[400,400]] call AW_fnc_mission7Transition;
        gauntlet_missionCounter = gauntlet_missionCounter + 1;
        mission7Completed = true;
        publicVariable "mission7Completed";

        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
};
[_missionPFH,10,[_missionName,_roughPos]] call CBA_fnc_addPerFrameHandler;
