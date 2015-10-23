/*
 * Author: alganthe
 * Handles mission transitions
 *
 * Arguments:
 * 0: position of the previous mission <OBJECT>
 * 1: shape of the previous marker <STRING>
 * 2: size of the previous marker <ARRAY>
 *
 * Return Value:
 * nothing
 */
params ["_previousLocation","_markerShape","_markerSize"];

_bluforCheck = createTrigger ["EmptyDetector",_previousLocation,false];
_bluforCheck setTriggerArea [400,400,0,false];
_bluforCheck setTriggerActivation ["WEST","NOT PRESENT",false];
_bluforCheck setTriggerStatements ["this","westNotPresent = true;",""];

_markerTransition1 = createMarker ["missionTransition1_mrk",(_previousLocation)];
"missionTransition1_mrk" setMarkerShape _markerShape;
"missionTransition1_mrk" setMarkerSize _markerSize;
"missionTransition1_mrk" setMarkerBrush "Border";
"missionTransition1_mrk" setMarkerColor "ColorGreen";

_markerTransition2 = createMarker ["missionTransition2_mrk", getMarkerPos "AOMarker"];
"missionTransition2_mrk" setMarkerShape "ICON";
"missionTransition2_mrk" setMarkerType "mil_dot";
"missionTransition2_mrk" setMarkerText "Leave the previous AO";

_TriggerPFH = {
    if ((!isNil "westNotPresent") && {westNotPresent}) then {
        (_this select 0) params ["_missionCounter"];

        deleteMarker "missionTransition1_mrk";
        deleteMarker "missionTransition2_mrk";

        deleteVehicle _bluforCheck;
        westNotPresent = nil;
        _markerTransition1 = nil;
        _markerTransition2 = nil;

        [{[] call AW_fnc_missionSelection;}, [], 10] call ace_common_fnc_waitAndExecute;
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
};
[_TriggerPFH,10,[]] call CBA_fnc_addPerFrameHandler;
