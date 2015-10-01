// -------------- Headless Client
[] spawn {
    mytag_headlessClient_server_listener = TRUE; publicVariable 'mytag_headlessClient_server_listener';
    sleep 30;
    if (isNil 'mytag_headlessClient_client_active') then {
        [] execVM 'scripts\core\AI_Machine.sqf';
    };
};
//---------------------------------- Server scripts and functions calls

[true] spawn AW_fnc_supplyBox_refiller;		// Supply Depot Reloader, causes errors needs REWRITE
execVM "scripts\core\2_AI_Machine.sqf";				// Ambient AI, needs REWRITE
execVM "scripts\core\ambient_heli.sqf";				// Ambient Airpatrols, needs REWRITE
execVM "scripts\misc\clean.sqf";					// Cleanup script, needs REVIEW
execVM "scripts\core\houseFilling.sqf";				// Fill house, needs REVIEW
[{0 call AW_fnc_missionSelection;}, [], 30] call ace_common_fnc_waitAndExecute;
