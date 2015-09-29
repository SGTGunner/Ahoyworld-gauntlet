/*
 * Author: alganthe
 * Progression bar for the FOB deployment
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
 * [cursorTarget,player] call AW_fnc_FOB_CanDeploy
 */
params ["_vehicle","_unit"];
private ["_onCompletion", "_onFailure","_condition"];

[_unit] call ace_common_fnc_goKneeling;  // make the unit kneel
//---------------------------- Completion
_onCompletion = {
    (_this select 0) params ["_vehicle"];
    ["FOB_EH",[_vehicle],[_vehicle,false,nil]] call ace_common_fnc_TargetEvent;
};
//---------------------------- Failure
_onFailure = {
    ["FOB deployment interrupted",1.5,_unit] call ace_common_fnc_displayTextStructured;
};
//---------------------------- Per frame check
_condition = {
    (_this select 0) params ["_vehicle","_unit"];
    (alive _vehicle && {isnil "MHQ_Net"} && {alive _unit} && {speed _vehicle <= 1} && {_vehicle doorPhase "extend_shelter_source" > 0.01})
};

[60, [_vehicle,_unit], _onCompletion, _onFailure,"Deploying the FOB",_condition] call ace_common_fnc_progressBar;
