/*
| Author: 
|
|	BACONMOP
|_____
|
|   Description:  Creates Ambient enemy AI around straggler Blufor
|	
|	Created: 28.June 2015
|	Last modified: 28.June 2015
|	Coded for AhoyWorld.
*/

BACON_2nd_AI_Machine = true;
publicVariable "BACON_2nd_AI_Machine";

while {BACON_2nd_AI_Machine} do {
		_target = objNull;
		_targetPos = [0,0,0];
			
			if (isMultiplayer) then {
				_target = playableUnits select (floor (random (count playableUnits)));
			} else {
				_target = switchableUnits select (floor (random (count switchableUnits)));
			};
			
			if (!isNull _target) then {
				_distance = 250 + (random 500);
				_dir = getDir _target;
				_targetPos = [_target, _distance, _dir] call BIS_fnc_relPos;
				
				if(surfaceIsWater _targetPos) then{}
					else{
				
					_AAIT = createTrigger ["EmptyDetector", _target];
					_AAIT setTriggerArea [750, 750, 0, false];
					_AAIT setTriggerActivation ["WEST", "PRESENT", false];
					_AAIT setTriggerStatements ["this","",""];
					
				
					if ((_targetPos distance (getMarkerPos "respawn_west")) > 1500 && side _target == WEST && (count list _AAIT < 5)) then { 
						waituntil{DAC_NewZone == 0};
						_GRP1 = [_targetPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_squad_2mg" )] call BIS_fnc_spawnGroup;
						[_GRP1,(getMarkerPos  _target)] call BIS_fnc_taskAttack;
						_AAIT2 = createTrigger ["EmptyDetector", _targetPos];
						_AAIT2 setTriggerArea [1500, 1500, 0, false];
						_AAIT2 setTriggerActivation ["WEST", "PRESENT", false];
						_AAIT2 setTriggerStatements ["this","",""];
						waitUntil {(count list _AAIT < 1) && (count list _AAIT2 < 1)};
						deletevehicle _AAIT;
						deletevehicle _AAIT2;
						deleteGroup _GRP1;
						
					};
				deletevehicle _AAIT;
				};
			};
			sleep 3;
	};