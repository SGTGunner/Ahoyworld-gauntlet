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
