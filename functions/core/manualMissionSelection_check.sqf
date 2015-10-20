/*
 * Author: alganthe
 * Check if a mission can be safely manually selected
 *
 * Arguments:
 * 0: unit doing the call <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 */
params ["_unit"];
private ["_return"];

if (("missionSelection" call BIS_fnc_getParamValue) == 1) then {

    if ((vehicle _unit == s3) && {!isNil 'missionInProgress'} && {!(missionInProgress)}) then {
        _return = true;
    } else {
        _return = false;
    };
} else {
    _return = false;
};

_return
