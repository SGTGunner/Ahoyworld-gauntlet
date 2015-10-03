// -------------- Headless Client
[] spawn {
    mytag_headlessClient_server_listener = TRUE; publicVariable 'mytag_headlessClient_server_listener';
    sleep 30;
    if (isNil 'mytag_headlessClient_client_active') then {
        [] execVM 'scripts\core\AI_Machine.sqf';
    };
};
//---------------------------------- Server scripts and functions calls

GAMENIGHT = "Gamenight" call BIS_fnc_getParamValue; // CHecking gamenight value
if (GAMENIGHT == 1 ) then {
    [kBox,false] call AW_fnc_VA_filter;  // remove arsenal from the box at spawn.
} else {
    [kBox,true] call AW_fnc_VA_filter;  //Add VA to box in spawn
};

[true] spawn AW_fnc_supplyBox_refiller;		// Supply Depot Reloader, causes errors needs REWRITE
execVM "scripts\core\2_AI_Machine.sqf";				// Ambient AI, needs REWRITE
execVM "scripts\core\ambient_heli.sqf";				// Ambient Airpatrols, needs REWRITE
execVM "scripts\misc\clean.sqf";					// Cleanup script, needs REVIEW
execVM "scripts\core\houseFilling.sqf";				// Fill house, needs REVIEW
[AW_fnc_missionSelection, [0,true], 30] call ace_common_fnc_waitAndExecute;
