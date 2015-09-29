// -------------- Headless Client
[] spawn {
    mytag_headlessClient_server_listener = TRUE; publicVariable 'mytag_headlessClient_server_listener';
    sleep 30;
    if (isNil 'mytag_headlessClient_client_active') then {
        [] execVM 'scripts\core\AI_Machine.sqf';
    };
};
