/*
 * Author: alganthe
 * Handles mission transitions
 *
 * Arguments:
 * 0: amount of missions done <NUMBER>
 * 1: position of the previous mission <OBJECT>
 *
 * Return Value:
 * nothing
 */
params ["_previousLocation"];

_bluforCheck = createTrigger ["EmptyDetector",getMarkerPos _previousLocation,false];
_bluforCheck setTriggerArea [400,400,0,false];
_bluforCheck setTriggerActivation ["WEST","NOT PRESENT",false];
_bluforCheck setTriggerStatements ["this","westNotPresent = true;",""];

_markerTransition1 = createMarker ["missionTransition1_mrk",(getMarkerPos _previousLocation)];
"missionTransition1_mrk" setMarkerShape "ELLIPSE";
"missionTransition1_mrk" setMarkerSize [500,500];
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
