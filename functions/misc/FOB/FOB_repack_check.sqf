/*
 * Author: alganthe
 * Check if the FOB can be repacked
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * <BOOL>
 *
 * Example:
 *
 * ["FOBvehc1"] call AW_fnc_FOB_repack_check
 */
params ["_vehicle"];
private ["_return"];

if (alive _vehicle && {_vehicle doorPhase "extend_shelter_source" > 0.99} && {!isnil "MHQ_Net"}) then {
    _return = true;
 }
else {
    _return= false;
};
_return
