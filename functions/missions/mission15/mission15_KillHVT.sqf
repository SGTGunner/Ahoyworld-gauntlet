/*
 * Authors: BACONMOP
 * Rewrote by: alganthe
 *
 * Arguments:
 * 0: amount of missions already completed <NUMBER>
 *
 * Return Value:
 * none
 *
 * Mission15: Destroy mortar Emplacement.
 *
 * Phases: 2
 * 1: No BLUFOR spotted
 * 2: BLUFOR spotted, QRF called
 *
 * Conditions:
 * Win: HVT killed
 * Fail: None
 */
 missionInProgress = true;
publicVariable "missionInProgress";

_missionLocations = ["Shuhada","Shuhada_1","Shuhada_2","Shuhada_3","Shuhada_4","Shuhada_5","sinai","sinai_1","sinai_2","sinai_3","sinai_4","sinai_5","West_Sinai","West_Sinai_1","West_Sinai_2","West_Sinai_3","West_Sinai_4","West_Sinai_5","Resafa","Resafa_1","Resafa_2","Resafa_3","Resafa_4","Resafa_5","Nazal","Nazal_1","Nazal_2","Nazal_3","Nazal_4","Nazal_5","Nazal_6","Nazal_7","Al_Fallujah","Al_Fallujah_1","Al_Fallujah_2","Al_Fallujah_3","Al_Fallujah_4","Al_Fallujah_5","Industrial_Park","Industrial_Park_1","Industrial_Park_2","Industrial_Park_3","Industrial_Park_4","Industrial_Park_5","Askari","Askari_2","Askari_3","Askari_3","Askari_4","Askari_5","Jeghaifi","Jeghaifi_1","Jeghaifi_2","Jeghaifi_3","Jeghaifi_4","Jeghaifi_5","Shurta","Shurta_1","Shurta_2","Shurta_3","Shurta_4","Shurta_5","Mualumeen","Mualumeen_1","Mualumeen_2","Mualumeen_3","Mualumeen_4","Mualumeen_5","Muhandisin","Muhandisin_1","Muhandisin_2","Muhandisin_3","Muhandisin_4","Muhandisin_5","Jolan","Jolan_1","Jolan_2","Jolan_3","Jolan_4","Jolan_5","Jolan_6","Jolan_7","North_West","North_West_1","North_West_2","North_West_3","North_West_4","North_West_5","North_West_6","North_West_7"];
//------------------- Get Random Mission Loc
_selectedLocation = _missionLocations call BIS_fnc_selectRandom;
_meetingLocation = [_selectedLocation, 100] call CBA_fnc_randPos;

//------------------- Mission name
_missionName = [] call AW_fnc_missionName;

//------------------- Objective
_hvtGrp = createGroup east;
"rhs_vdv_officer_armored" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_medic" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_engineer" createUnit [_meetingLocation, _hvtGrp];
"rhs_vdv_LAT" createUnit [_meetingLocation, _hvtGrp];
mission15Objective = ((units _hvtGrp) select 0);

//------------------- Defence
_DACvalues = ["m15",[11,0,0],[6,4,20,5],[],[2,1,10,5],[],[0,0,0,0]];
[getMarkerPos _selectedLocation,400,400,0,0,_DACvalues] call DAC_fNewZone;

//------------------- Markers
_marker = createMarker ["mission15_mrk", getMarkerPos _selectedLocation ];
"mission15_mrk" setMarkerShape "ICON";
"mission15_mrk" setMarkerType "selector_selectable";
"mission15_mrk" setMarkerColor "ColorBLUFOR";
"mission15_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission15_1_mrk", getMarkerPos _selectedLocation];
"mission15_1_mrk" setMarkerShape "RECTANGLE";
"mission15_1_mrk" setMarkerSize [400,400];
"mission15_1_mrk" setMarkerBrush "Border";
"mission15_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission15_2_mrk", getMarkerPos "AOMarker"];
"mission15_2_mrk" setMarkerShape "ICON";
"mission15_2_mrk" setMarkerType "mil_dot";
"mission15_2_mrk" setMarkerText "An Enemy officer has been spotted. Take Him Out.";

//------------------- Triggers
nextPhaseTrigger = createTrigger ["EmptyDetector",getMarkerPos _selectedLocation,false];
nextPhaseTrigger setTriggerArea [400,400,0,false];
nextPhaseTrigger setTriggerActivation ["West","East D", false];
nextPhaseTrigger setTriggerStatements ["this","QRFCalled = true;",""];

//------------------- Mission hint
_misHintText = format ["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>An enemy Officer has been spotted. Kill him but be aware. If the enemy find you they will call in their QRF.<br/><br/>",_missionName];
["Globalhint_EH", [_misHintText]] call ace_common_fnc_globalEvent;

//------------------- PFHs
_qrfPFH = {
    if ((!isNil "QRFCalled") && {QRFCalled}) then {
        (_this select 0) params ["_missionName","_selectedLocation"];

        _misEndText = format ["<t align='center' size='2.2'>Attention</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>The enemy QRF has been alerted. Hurry up with the mission.</t>",_missionName];
        ["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

        _rndPos  = [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
        GRP1 = [_rndPos, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
        [GRP1,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

        _rndPos  = [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
        GRP2 = [_rndPos, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
        [GRP2,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

        _rndPos  = [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
        GRP3 = [_rndPos, EAST, (configfile >> 'CfgGroups' >> 'East' >> 'rhs_faction_vdv' >> 'rhs_group_rus_vdv_btr60' >> 'rhs_group_rus_vdv_btr60_squad_2mg' )] call BIS_fnc_spawnGroup;
        [GRP3,(getMarkerPos _selectedLocation)] call BIS_fnc_taskAttack;

        _heliGrp = createGroup east;

        _rndPos  = [getMarkerPos _selectedLocation, 1000] call CBA_fnc_randPos;
        ambientHeli = createVehicle ['RHS_Mi8AMTSh_UPK23_vvsc', _rndPos, [], 0, 'FLY' ];
        [ambientHeli,_heliGrp] call BIS_fnc_spawnCrew; [heliGrp,QRFTarget] call BIS_fnc_taskAttack;

        nextPhaseTrigger = nil;
        QRFCalled = nil;

        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
};
mission15_PFHhandle = [_qrfPFH,10,[_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;

_missionPFH = {
    if (!alive mission15Objective) then {
        (_this select 0) params ["_missionName","_selectedLocation"];

        _misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1. Now get out of the area and new tasking will be assigned</t>",_missionName];
        ["Globalhint_EH", [_misEndText]] call ace_common_fnc_globalEvent;

        deleteMarker "mission15_mrk";
        deleteMarker "mission15_1_mrk";
        deleteMarker "mission15_2_mrk";
        deleteVehicle nextPhaseTrigger;

        mission15Objective = nil;
        GRP1 = nil;
        GRP2 = nil;
        GRP3 = nil;
        ambientHeli = nil;

        [{
            mission15Objective = nil;
        },[], 60] call ace_common_fnc_waitAndExecute;

        [{["m15"] call DAC_fDeleteZone;},[], 300] call ace_common_fnc_waitAndExecute;
        [_selectedLocation,"RECTANGLE",[400,400]] call AW_fnc_missionTransition;
        gauntlet_missionCounter = gauntlet_missionCounter + 1;
        mission15Completed = true;
        publicVariable "mission15Completed";

        [mission15_PFHhandle] call CBA_fnc_removePerFrameHandler;
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
};
[_missionPFH,10,[_missionName,_selectedLocation]] call CBA_fnc_addPerFrameHandler;
