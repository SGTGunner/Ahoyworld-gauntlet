/*/
 * Author: alganthe
 * Filter the arsenal for a given box
 *
 * Arguments:
 * 0: Box <OBJECT>
 * 1: filter <BOOLEAN
 *
 * Return Value:
 * Array of items added in the form of ["item1","item2",......"itemN"]
 *
 * Example:
 *
 * [_this,true] call AW_fnc_VA_filter;
 */

params ["_box","_filter"];


if (_filter) then {
    //ACE
    ["AmmoboxInit",[_box,true,{true}]] call BIS_fnc_arsenal;
    [_box,[true],true] call BIS_fnc_removeVirtualItemCargo;

    _blackList = [
    //Optics
    "optic_Nightstalker",
    "optic_tws",
    "optic_tws_mg"
    ];
    _availableItems = [true] call AW_fnc_findItemList;

    _availableItems = _availableItems - _blackList;

    [_box,_availableItems,true] call BIS_fnc_addVirtualItemCargo;

} else {
    [_box,[true],true] call BIS_fnc_removeVirtualItemCargo;
};
