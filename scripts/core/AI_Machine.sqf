/*
| Author: 
|
|	BACONMOP
|_____
|
|   Description:  Creates Ambient enemy AI around Blufor
|	
|	Created: 13.January 2015
|	Last modified: 22.January 2015
|	Coded for AhoyWorld.
*/

BACON_AI_Machine = true;
publicVariable "BACON_AI_Machine";

while {BACON_AI_Machine} do {
		_target = objNull;
		_targetPos = [0,0,0];
			
			if (isMultiplayer) then {
				_target = playableUnits select (floor (random (count playableUnits)));
			} else {
				_target = switchableUnits select (floor (random (count switchableUnits)));
			};
			
			if (!isNull _target) then {
				_distance = 1000 + (random 500);
				_dir = getDir _target;
				_targetPos = [_target, _distance, _dir] call BIS_fnc_relPos;
				_AAIT = createTrigger ["EmptyDetector", _target];
				_AAIT setTriggerArea [750, 750, 0, false];
				_AAIT setTriggerActivation ["WEST", "PRESENT", false];
				_AAIT setTriggerStatements ["this","",""];
				
				if ((_targetPos distance (getMarkerPos "respawn_west")) > 1500 && side _target == WEST && (_target distance (getMarkerPos "respawn_west")) > 1500) then { 
					waituntil{DAC_NewZone == 0};
					_DACvalues = ["ambient_zone",[1,0,0],[8,4,40,5],[4,2,30,5],[2,1,20,5],[],[0,0,0,0]];
					[_targetPos,1000,1000,0,0,_DACvalues] call DAC_fNewZone;
					_AAIT2 = createTrigger ["EmptyDetector", _targetPos];
					_AAIT2 setTriggerArea [1500, 1500, 0, false];
					_AAIT2 setTriggerActivation ["WEST", "PRESENT", false];
					_AAIT2 setTriggerStatements ["this","",""];
					waitUntil {(count list _AAIT < 1) && (count list _AAIT2 < 1)};
					deletevehicle _AAIT;
					deletevehicle _AAIT2;
					waituntil{DAC_NewZone == 0};
					["ambient_zone"] call DAC_fDeleteZone;
				};
				deletevehicle _AAIT;
			};
			sleep 3;
	};