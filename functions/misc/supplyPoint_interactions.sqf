/*
 * Author: alganthe
 * Add the necessary ACE3 interactions on the Ammo Pole.
 *
 * Arguments:
* 0: call check <BOOL>
* 1: Oject to add the actions to <OBJECT>
*
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * [true,MyBigPole] call AW_fnc_supplyPoint_interactions_add
 */
params ["_called","_supplyItem"];

if (_called) then {
    _createTrack = ["createTrackAction","Get a spare track","",{"ACE_Track" createVehicle getMarkerPos "Net_Ammo"},{true}] call ace_interact_menu_fnc_createAction;
    _createWheel = ["createWheelAction","Get a spare wheel","",{"ACE_Wheel" createVehicle getMarkerPos "Net_Ammo"},{true}] call ace_interact_menu_fnc_createAction;
    _createBox = ["createBoxAction","Get an empty ammo box","",{["B_supplyCrate_F"] call AW_fnc_createBox},{true}] call ace_interact_menu_fnc_createAction;
    [_supplyItem, 0, ["ACE_MainActions"],_createTrack] call ace_interact_menu_fnc_addActionToObject;
    [_supplyItem, 0, ["ACE_MainActions"],_createWheel] call ace_interact_menu_fnc_addActionToObject;
    [_supplyItem, 0, ["ACE_MainActions"],_createBox] call ace_interact_menu_fnc_addActionToObject;
};
