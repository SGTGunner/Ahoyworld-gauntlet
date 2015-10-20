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

    // ACE3 interactions
    [true,"rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"] call AW_fnc_FOB_interactions_add; // Interactions for the FOB
    [true,ammoCargo] call AW_fnc_supplyPoint_interactions_add; // Interactions for the AmmoPole

    if (vehicle player == s3) then {
        [missionSelectionLaptop] call AW_fnc_missionSelection_interactions; // Manual mission selection interactions for the PL
    };
};
