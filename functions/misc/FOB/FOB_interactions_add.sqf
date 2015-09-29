/*
 * Author: alganthe
 * Add the necessary ACE3 interactions on the FOB vehicle.
 *
 * Arguments:
* 0: call check <BOOL>
* 1: Vehicle class to add the actions to <OBJECT>
*
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * [true,"SomeVehicle"] call AW_fnc_FOB_interactions_add
 */
params ["_called","_FOBvehc"];

if (_called) then {
    _actionDeploy = ["FOBdeploy","Deploy the FOB","",{[cursorTarget,player] call AW_fnc_FOB_CanDeploy},{[cursorTarget] call AW_fnc_FOB_deploy_check}] call ace_interact_menu_fnc_createAction;
    _actionRepack = ["FOBrepack","Repack the FOB","",{[cursorTarget,player] call AW_fnc_FOB_CanRepack},{[cursorTarget] call AW_fnc_FOB_repack_check}] call ace_interact_menu_fnc_createAction;
    [_FOBvehc, 0, ["ACE_MainActions"],_actionDeploy] call ace_interact_menu_fnc_addActionToClass;
    [_FOBvehc, 0, ["ACE_MainActions"],_actionRepack] call ace_interact_menu_fnc_addActionToClass;
};
