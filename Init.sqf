/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Init for server\player
|
|	Created: 1.December 2014
|	Last modified: 17. March 2015 By: Pfc.Christiansen Reason: Added EH for respawnWave
|	Made for AhoyWorld.
*/

//---------------------------------- Variables and settings

enableSaving [false,false];
DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf"; // DAC
Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "functions\Zen_OccupyHouse.sqf";

//---------------------------------- EH That can be ran on both server and Client
["Globalhint_EH", AW_fnc_Globalhint_handler] call ace_common_fnc_addEventHandler;
["FOB_EH", AW_fnc_FOB_handler] call ace_common_fnc_addEventHandler;

//---------------------------------- Server Script Calls
if (isServer) then {
	// check for gamenight mode, can be IMPROVED
	GAMENIGHT = "Gamenight" call BIS_fnc_getParamValue; // CHecking gamenight value
	if (GAMENIGHT == 1 ) then {
		[kBox,false] call AW_fnc_VA_filter;  // remove arsenal from the box at spawn.
		[] execVM "scripts\core\waveRespawn.sqf"; // Respawned when current mission ends, needs REVIEW
		sleep 5;
		setPlayerRespawnTime  9999999; // Set respawn time to infinite to avoid respawns
	} else {
		[kBox,true] call AW_fnc_VA_filter;  //Add VA to box in spawn
	};

	[true] spawn AW_fnc_supplyBox_refiller;		// Supply Depot Reloader, causes errors needs REWRITE
	execVM "scripts\core\main.sqf";						// Mission selector engine, needs REWRITE
	execVM "scripts\core\2_AI_Machine.sqf";				// Ambient AI, needs REWRITE
	execVM "scripts\core\ambient_heli.sqf";				// Ambient Airpatrols, needs REWRITE
	execVM "scripts\misc\clean.sqf";					// Cleanup script, needs REVIEW
	execVM "scripts\core\houseFilling.sqf";				// Fill house, needs REVIEW
};
