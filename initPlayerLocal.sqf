// -------------- Headless Client
if (!hasInterface) then {
    [] spawn {
        if (!hasInterface) then {
            if (isNil 'mytag_headlessClient_server_listener' ) then {
                waitUntil {
                    sleep 1;
                    (!isNil 'mytag_headlessClient_server_listener' )
                };
            };
            mytag_headlessClient_client_active = TRUE;
            publicVariableServer 'mytag_headlessClient_client_active';
            [] execVM 'scripts\core\AI_Machine.sqf';
        };
    };
} else { // ---------------- Player Scripts

    [] call AW_fnc_diary; // Diary
    execVM "scripts\misc\QS_icons.sqf"; // Icons
    [AW_fnc_loadoutsExec,[]] call ace_common_fnc_execNextFrame; // Apply loadouts
    ["zeusAddUnitEH", [(vehicle player)]] call ace_common_fnc_serverEvent; // Add the unit to all curators

    // ACE3 interactions
    [true,"rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]  call compile preprocessFileLineNumbers "functions\misc\FOB\FOB_interactions.sqf"; // Interactions for the FOB
    [true,ammoCargo]  call compile preprocessFileLineNumbers "functions\misc\supplyPoint_interactions.sqf"; // Interactions for the AmmoPole
    [player] call compile preprocessFileLineNumbers "functions\misc\walkingFix_interactions.sqf";

    [missionSelectionLaptop]  call compile preprocessFileLineNumbers "functions\core\missionSelection_interactions.sqf"; // Manual mission selection interactions for the PL
};
