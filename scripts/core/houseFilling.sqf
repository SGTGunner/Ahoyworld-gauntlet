while {true} do {
		_target = objNull;
		_targetPos = [0,0,0];
			
			if (isMultiplayer) then {
				_target = playableUnits select (floor (random (count playableUnits)));
			} else {
				_target = switchableUnits select (floor (random (count switchableUnits)));
			};
			
			if ((_target distance (getMarkerPos "building_center")) < 1500 || (_target distance (getMarkerPos "building_center_2")) < 1500 || (_target distance (getMarkerPos "building_center_1")) < 1500) then {
			
			if (!isNull _target) then {
				_distance = 100 + (random 200);
				_dir = getDir _target;
				_targetPos = [_target, _distance, _dir] call BIS_fnc_relPos;
				_AAIT = createTrigger ["EmptyDetector", _target];
				_AAIT setTriggerArea [300, 300, 0, false];
				_AAIT setTriggerActivation ["WEST", "PRESENT", false];
				_AAIT setTriggerStatements ["this","",""];
				
				if (side _target == WEST) then { 
					_GRP1 = [_targetPos, EAST, (configfile >> "CfgGroups" >> "East" >> "O_ti" >> "O_ti_ins" >> "O_ti_g_team_F" )] call BIS_fnc_spawnGroup;
					0 = [_targetPos,units _GRP1, 100, true, false] call Zen_OccupyHouse;
					_GRP2 = [_targetPos, EAST, (configfile >> "CfgGroups" >> "East" >> "O_ti" >> "O_ti_ins" >> "O_ti_g_team_F" )] call BIS_fnc_spawnGroup;
					0 = [_targetPos,units _GRP2, 100, true, false] call Zen_OccupyHouse;
					_AAIT2 = createTrigger ["EmptyDetector", _targetPos];
					_AAIT2 setTriggerArea [400, 400, 0, false];
					_AAIT2 setTriggerActivation ["WEST", "PRESENT", false];
					_AAIT2 setTriggerStatements ["this","",""];
					waitUntil {(count list _AAIT < 1) && (count list _AAIT2 < 1)};
					{deleteVehicle _x;} forEach units _GRP1;
					waitUntil {(count list _AAIT < 1) && (count list _AAIT2 < 1)};
					{deleteVehicle _x;} forEach units _GRP2;
				};
				deletevehicle _AAIT;
			};
			};
			sleep 3;
			
	};