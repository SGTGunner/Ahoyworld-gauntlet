/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Init for server\player
|
|	Created: 1.December 2014
|	Last modified: 30. January 2015 By: Pfc.Christiansen
|	Made for AhoyWorld.
*/

[] call AW_fnc_loadoutsExec; //Standard Loadouts
["zeusAddUnitEH", [(vehicle player)]] call ace_common_fnc_serverEvent; // Add the unit to all curators
