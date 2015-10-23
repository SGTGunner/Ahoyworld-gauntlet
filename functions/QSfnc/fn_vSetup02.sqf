/*
 * Author: ???
 * vSetup02 serves as a
 *
 * Arguments:
* 0:  the  ? <BOOL>
* 1: Vehicle to add the actions to <OBJECT>
*
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * [true] call AW_fnc_FOB_interactions_add
 */
//============================================= CONFIG
params ["_vehicle","_type"];

_type = typeOf _vehicle;

if (isNull _vehicle) exitWith {};

//============================================= ARRAYS
_ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// ghosthawk
_strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];					// strider
_blackVehicles = ["B_Heli_Light_01_armed_F"];									// black skin
_wasp = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F"];						// MH-9
_orca = ["O_Heli_Light_02_unarmed_F"];											// Orca
_mobileArmory = ["B_Truck_01_ammo_F"];											// Mobile Armory
_noAmmoCargo = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];					// Bobcat CRV
_slingHeli = ["I_Heli_Transport_02_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];  // sling capable
_slingable = ["B_Heli_Light_01_F"];												// slingable
_notSlingable = ["B_Heli_Light_01_armed_F", "B_Heli_Attack_01_F"];				// not slingable
_dropHeli = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// drop capable
_uav = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F"];			// UAVs
_fob = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];

//============================================= SORT
if (_type in _fob) then {
    ["FOB_EH", [_vehicle,nil,true]] call ace_common_fnc_serverEvent;
};
_vehicle setVariable ["slingable",TRUE,TRUE];

{_x addCuratorEditableObjects [[_vehicle],false];} count allCurators;
