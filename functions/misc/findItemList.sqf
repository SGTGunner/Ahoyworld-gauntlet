/*
 * Author: alganthe
 * Search for CfgWeapons and CfgGlasses entries with scope = 2
 *
 * Arguments:
 * 0: turn on RHS UFRF filter <BOOL>
 *
 * Return Value:
 * Array of strings !!! WARNING VERY LONG ARRAYS !!! <ARRAY>
 *
 * Example:
 *
 * copyToClipboard ([true] call AW_fnc_findItemList);
 */
params ["_filter"];
private ["_cfgArray","_returnArray"];
_returnArray = [];

if (_filter) then {
    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2) &&
    {!((getText (_x >> 'dlc')) == 'RHS_AFRF')}
    )" configClasses (configFile >> "CfgWeapons");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;

    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2)
    )" configClasses (configFile >> "CfgGlasses");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;
} else {
    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2)
    )" configClasses (configFile >> "CfgWeapons");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;

    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2)
    )" configClasses (configFile >> "CfgGlasses");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;
};

_returnArray
