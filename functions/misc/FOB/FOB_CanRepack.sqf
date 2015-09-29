/*
 * Author: alganthe
 * Progression bar for the FOB repack
 *
 * Arguments:
 * 0: FOB vehicle <OBJECT>
 * 1: unit doing the action <OBJECT>
 *
 * Return Value:
 * nothing
 *
 * Example:
 *
 * [cursorTarget,player] call AW_fnc_FOB_CanRepack
 */
params ["_vehicle","_unit"];
private ["_onCompletion", "_onFailure","_condition"];

[_unit] call ace_common_fnc_goKneeling;  // make the unit kneel
//---------------------------- Completion
_onCompletion = {
    (_this select 0) params ["_vehicle","_unit"];
    ["FOB_EH",[_vehicle],[_vehicle,true,nil]] call ace_common_fnc_TargetEvent;
    ["FOB repacking finished",1.5,_unit] call ace_common_fnc_displayTextStructured;
};
//---------------------------- Failure
_onFailure = {
    ["FOB repacking interrupted",1.5,_unit] call ace_common_fnc_displayTextStructured;
};
//---------------------------- Per frame check
_condition = {
    (_this select 0) params ["_vehicle","_unit"];
    (alive _vehicle && {alive _unit} && {speed _vehicle <= 1} && {_vehicle doorPhase "extend_shelter_source" > 0.99} && {!isnil "MHQ_Net"})
};


[60, [_vehicle,_unit], _onCompletion, _onFailure,"Repacking the FOB",_condition] call ace_common_fnc_progressBar;
