/*
 * Author: alganthe
 * Adds the necessary interactions to the platoon commander.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * nothing
 */
 //mission 1
params ["_object"];

 _mission1 = ["StartMission1","Clear town","",{[] remoteExecCall ['AW_fnc_mission_clearTown',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission1Completed")}] call ace_interact_menu_fnc_createAction;
 [_object, 0, ["ACE_MainActions"],_mission1] call ace_interact_menu_fnc_addActionToObject;

 //mission 2
_mission2 = ["StartMission2","Deliver ressuply truck","",{[] remoteExecCall ['AW_fnc_mission_ressuplyTruck',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission2Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission2] call ace_interact_menu_fnc_addActionToObject;

 //mission 3
_mission3 = ["StartMission3","Stop AA vehicle deal","",{[] remoteExecCall ['AW_fnc_mission_AAVehicleDeal',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission3Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission3] call ace_interact_menu_fnc_addActionToObject;

 //mission 4
_mission4 = ["StartMission4","Destroy radar installation","",{[] remoteExecCall ['AW_fnc_mission_destroyRadar',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission4Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission4] call ace_interact_menu_fnc_addActionToObject;

/* mission hasn't been converted to the new system yet.
 //mission 5
_mission5 = ["",{[] remoteExecCall ['mission_clearTown',2];},{}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission5] call ace_interact_menu_fnc_addActionToObject;
*/

 //mission 6
_mission6 = ["StartMission6","Deploy communication array","",{[] remoteExecCall ['AW_fnc_mission_deployComs',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission6Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission6] call ace_interact_menu_fnc_addActionToObject;

 //mission 7
_mission7 = ["StartMission7","Destroy radio tower","",{[] remoteExecCall ['AW_fnc_mission_destroyComs',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission7Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission7] call ace_interact_menu_fnc_addActionToObject;

 //mission 8
_mission8 = ["StartMission8","Recover crate","",{[] remoteExecCall ['AW_fnc_mission_recoverCrate',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission8Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission8] call ace_interact_menu_fnc_addActionToObject;

 //mission 9
_mission9 = ["StartMission9","Destroy UAV","",{[] remoteExecCall ['AW_fnc_mission_destroyUAV',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission9Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission9] call ace_interact_menu_fnc_addActionToObject;

 //mission 10
_mission10 = ["StartMission10","Guerilla meeting","",{[] remoteExecCall ['AW_fnc_mission_guerMeeting',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission10Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission10] call ace_interact_menu_fnc_addActionToObject;

 //mission 11 Capture nuclear device
_mission11 = ["StartMission11","Destroy technicals platoon","",{[] remoteExecCall ['AW_fnc_mission_tankPlatoon',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission11Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission11] call ace_interact_menu_fnc_addActionToObject;

 //mission 12
_mission12 = ["StartMission12","Capture nuclear device","",{[] remoteExecCall ['AW_fnc_mission_captureNuclearDevice',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission12Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission12] call ace_interact_menu_fnc_addActionToObject;

 //mission 13
_mission13 = ["StartMission13","Capture and defend town","",{[] remoteExecCall ['AW_fnc_mission_captureAndDefendTown',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission13Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission13] call ace_interact_menu_fnc_addActionToObject;

 //mission 14
_mission14 = ["StartMission14","Destroy mortar emplacement","",{[] remoteExecCall ['AW_fnc_mission_destroyMortar',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission14Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission14] call ace_interact_menu_fnc_addActionToObject;

 //mission 15
_mission15 = ["StartMission15","Kill HVT","",{[] remoteExecCall ['AW_fnc_mission_KillHVT',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission15Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission15] call ace_interact_menu_fnc_addActionToObject;

 //mission 16
_mission16   = ["StartMission16","Recover chopper intel","",{[] remoteExecCall ['AW_fnc_mission_recoverChopperIntel',2];},{([vehicle player] call AW_fnc_manualMissionSelection_check) && (isNil "mission16Completed")}] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_mission16] call ace_interact_menu_fnc_addActionToObject;
