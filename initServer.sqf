// -------------- Functions compiling
call compile preprocessFileLineNumbers "functions\core\serverSide_functions_compile.sqf";

// -------------- Mission vars
gauntlet_missionCounter = 0;

// -------------- Headless Client
[] spawn {
    mytag_headlessClient_server_listener = TRUE; publicVariable 'mytag_headlessClient_server_listener';
    sleep 30;
    if (isNil 'mytag_headlessClient_client_active') then {
        [] execVM 'scripts\core\AI_Machine.sqf';
    };
};
//---------------------------------- Mission params related code
if (("MakeVAAvailable" call BIS_fnc_getParamValue) == 1 ) then {
    [kBox,false] call AW_fnc_VA_filter;  // remove arsenal from the box at spawn.
} else {
    [kBox,true] call AW_fnc_VA_filter;  //Add VA to box in spawn
};

//---------------------------------- Scripts and functions calls.
[true] spawn AW_fnc_supplyBox_refiller;		// Supply Depot Reloader, causes errors needs REWRITE
execVM "scripts\core\2_AI_Machine.sqf";		// Ambient AI, needs REWRITE
execVM "scripts\core\ambient_heli.sqf";		// Ambient Airpatrols, needs REWRITE
execVM "scripts\misc\clean.sqf";			// Cleanup script, needs REVIEW
execVM "scripts\core\houseFilling.sqf";		// Fill house, needs REVIEW
[AW_fnc_missionSelection, [true], 30] call ace_common_fnc_waitAndExecute; // STart mission selection after 30s

//---------------------------------- EHs
["zeusAddUnitEH",AW_fnc_zeusAddUnit_EH] call ace_common_fnc_addEventHandler;

{_x addCuratorEditableObjects [[kBox],false];} count allCurators;
