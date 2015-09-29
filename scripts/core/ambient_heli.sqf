/*
| Author:
|
|	BACONMOP
|_____
|
|   Description: Ambient Helicopter Patrol
|
|	Created: 16 March 2015
|	Last modified: 16 March 2015 By: PFC.Christiansen Reason: Added a editiable amount of WPs for helipath instead of fixed number.
|	Made for AhoyWorld.
*/

_loop = true;

_heliPool = [
	"RHS_Ka52_vvs",
	"RHS_Ka52_UPK23_vvsc",
	"RHS_Ka52_UPK23_vvs",
	"RHS_Mi24P_AT_vvsc",
	"RHS_Mi24P_CAS_vvsc",
	"RHS_Mi24P_vvsc",
	"RHS_Mi24V_AT_vvsc",
	"RHS_Mi24V_vvsc",
	"RHS_Mi24V_FAB_vvsc",
	"RHS_Mi24V_UPK23_vvsc",
	"RHS_Mi8AMTSh_vvsc",
	"RHS_Mi8AMTSh_FAB_vvsc",
	"RHS_Mi8AMTSh_UPK23_vvsc",
	"RHS_Mi8MTV3_vvsc",
	"RHS_Mi8MTV3_FAB_vvsc",
	"RHS_Mi8MTV3_UPK23_vvsc"
];
While {_loop} do {
	_heli = _heliPool call BIS_Fnc_selectRandom;

	_heliGrp = createGroup east;
	_ambientHeli = createVehicle [_heli, getMarkerPos "Heli_Spawn", [], 0, "FLY" ];
	[_ambientHeli,_heliGrp] call BIS_fnc_spawnCrew;


	for "_i" from 1 to ("AmbientHeliWPs" call BIS_fnc_getParamValue) do {
		_wpPos =  ["center", 4000] call CBA_fnc_randPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "MOVE";
		_heliWp setWaypointCompletionRadius 50;
	};

	_wp = _heliGrp addwaypoint [getMarkerPos "center",0];
	_wp setWaypointType "CYCLE";
	sleep 2700 + (random 900);
	_returnWP = _heliGrp addwaypoint [getMarkerPos "Heli_Spawn",0];
	sleep 200;
	_heli setDamage .90;
	sleep 100;
	deleteVehicle _heli;

};
