/*
 * Author: alganthe
 * Search for CfgWeapons and CfgGlasses entries with scope = 2
 *
 * Arguments:
 * 0: Search for weapons and items <BOOL>
 *
 * Return Value:
 * Array of strings !!! WARNING VERY LONG ARRAYS !!! <ARRAY>
 *
 * Example:
 *
 * copyToClipboard ([true] call AW_fnc_findItemList);
 */
params ["_weaponsAndGlasses"];
private ["_cfgArray","_returnArray"];
_returnArray = [];

if (_weaponsAndGlasses) then {
    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2) &&
    {((configName _x) call ace_common_fnc_getConfigType) == 'CfgWeapons'}
    )" configClasses (configFile >> "CfgWeapons");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;

    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2) &&
    {((configName _x) call ace_common_fnc_getConfigType) == 'CfgGlasses'}
    )" configClasses (configFile >> "CfgGlasses");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;
} else {
    _cfgArray = "(
    (getNumber (_x >> 'scope') >= 2) &&
    {((configName _x) call ace_common_fnc_getConfigType) == 'CfgVehicles'} &&
    {901 in (getArray (_x >> 'allowedSlots'))}
    )" configClasses (configFile >> "CfgVehicles");
    {_returnArray pushBack (configName _x)} forEach _cfgArray;
};

_returnArray
