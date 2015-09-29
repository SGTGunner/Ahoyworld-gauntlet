/*
 * Author: alganthe
 * Check if the FOB can be deployed
 *
 * Arguments:
 * 0: vehicle to check <OBJECT>
 *
 * Return Value:
 * <BOOL>
 *
 * Example:
 *
 * [FOB] call AW_fnc_FOB_deploy_check
 */
params ["_vehicle"];
private ["_return"];

if ((alive _vehicle) && {speed _vehicle <= 1} && {([_vehicle,10] call AW_fnc_find_flatPos)} && {_vehicle doorPhase "extend_shelter_source" > 0.01}) then {
    _return = true;
}
else {
    _return= false;
};
_return
