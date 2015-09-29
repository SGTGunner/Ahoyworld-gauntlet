/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Call this to get a enemy reinforcement chopper. EXAMPLE: ["MARKERNAME"] call KC_fnc_reinforceChopper
|	
|	Created: 16. March 2015
|	Last modified: 
|	Made for AhoyWorld.
*/

//-------------Defines.

_destination = _this select 0;
_spawn = getMarkerPos "Heli_spawn";
_helicopter = "RHS_Mi8mt_vdv";




//-------------Spawn Chopper and Crew it.

_heliSide = createGroup east;
reinf_heli = createVehicle [_helicopter, _spawn, [], 0, "FLY" ];
_crewHeli =	[reinf_heli,_heliSide] call BIS_fnc_spawnCrew;

	


//-------------Spawn Infantry and move them inside the chopper.
_grp2 = [getMarkerPos "Heli_Spawn", EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_squad_mg_sniper")] call BIS_fnc_spawnGroup;

{
_x moveInCargo reinf_heli;
} forEach units  _grp2;



//-------------Set WP for helicopter


_waypointLoc = [_destination,500 ] call CBA_fnc_randPos;

_wpUNL = _heliSide addWaypoint [getMarkerPos  _destination,0];
_wpUNL setWaypointType "TR UNLOAD";
_wpUNL setwaypointCombatMode "BLUE";
_wpUNL setWaypointBehaviour "SAFE"; 
_wpUNL setWaypointCompletionRadius 40;




