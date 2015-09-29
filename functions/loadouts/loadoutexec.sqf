/*
| Author:
|
|	Pfc.Christiansen
|_____
|
|   Description: Loadoutexecer
|
|	Created: 17/01-2015
|	Last modified: 23-09-2015
|	Made for AhoyWorld.
*/

_B_officer = ["B_officer_F"];  //Platoon leader
_B_SL = ["B_Soldier_SL_F"];  // Squad leader
_B_TL = ["B_Soldier_TL_F"];  // Team leader
_B_FAC = ["B_recon_JTAC_F"];  // FAC
_B_rifleman = ["B_Soldier_F"];  // Rifleman
_B_grenadier = ["B_Soldier_GL_F"]; // Grenadier
_B_medic = ["B_medic_F"];  // Medic
_B_marksman = ["B_soldier_M_F"];  // Mkarksman
_B_explo = ["_s4"];  // Explosive specialist
_B_AR = ["B_soldier_AR_F"];  // Automatic rifleman
_B_AAR = ["B_soldier_AAR_F"];  // Assistant automatic rifleman
_B_MMG = ["rhsusf_army_ocp_machinegunner"];  // Medium Machnine Gunner
_B_AMG = ["rhsusf_army_ocp_machinegunnera"];  // Assistant Medium Machnine Gunner
_B_AT = ["B_soldier_AT_F"];  // Anti-Tank Specialist
_B_AAT = ["B_soldier_AAT_F"];  // Assistant Anti-Tank Specialist
_B_AA = ["B_soldier_AA_F"];  // Missile AA
_B_AAA = ["B_soldier_AAA_F"];  // Missile AA asst
_B_MAT = ["TF47_B_soldier_M3MAAWS"];  // Medium Anti-Tank Specialist
_B_pilot = ["B_Pilot_F"];  // Pilot
_B_copilot = ["B_helicrew_F"];  // Co-Pilot
_B_crewCommand = ["rhsusf_army_ocp_combatcrewman"];  // Crew Commander
_B_crew = ["B_crew_F"];  // Crew
_B_engi_PLT = ["rhsusf_army_ucp_engineer"];// Platoon engineer
_B_engi_logi = ["B_engineer_F"];  // Engineer logi
_B_CT_lead = ["B_recon_TL_F"]; // Clear Team SL
_B_CT_rifleman = ["B_recon_F"]; // Clear Team Rifleman
_B_CT_explo = ["B_recon_exp_F"]; // Clear Team Demo Man

switch (playerSide) do {
    case west: {
		// Platoon Leader
		if (typeOf player in _B_officer) then {
			[] call AW_fnc_Load_B_officer;
		};

		// Squad Leader
		if (typeOf player in _B_SL) then {
			[] call AW_fnc_Load_B_SL;
		};

		// Team Leader
		if (typeOf player in _B_TL) then {
			[] call AW_fnc_Load_B_TL;
		};

		// FAC
		if (typeOf player in _B_FAC) then {
			[] call AW_fnc_Load_B_FAC;
		};

		// Rifleman
		if (typeOf player in _B_rifleman) then {
			[] call AW_fnc_Load_B_rifleman;
		};

		// Grenadier
		if (typeOf player in _B_grenadier) then {
			[] call AW_fnc_Load_B_grenadier;
		};

		// Medic
		if (typeOf player in _B_medic) then {
			[] call AW_fnc_Load_B_medic;
		};

		// Marksman
		if (typeOf player in _B_marksman) then {
			[] call AW_fnc_Load_B_marksman;
		};

		// Explosive Specialist
		if (typeOf player in _B_explo) then {
			[] call AW_fnc_Load_B_explo;
		};

		// Automatic Rifleman
		if (typeOf player in _B_AR) then	{
			[] call AW_fnc_Load_B_AR;
		};

		// Assistant Automatic Rifleman
		if (typeOf player in _B_AAR) then {
			[] call AW_fnc_Load_B_AAR;
		};

		// Medium Machnine Gunner
		if (typeOf player in _B_MMG) then {
			[] call AW_fnc_Load_B_MMG;
		};

		// Assistant Medium Machnine Gunner
		if (typeOf player in _B_AMG) then {
			[] call AW_fnc_Load_B_AMG;
		};

		// Anti-Tank Specialist
		if (typeOf player in _B_AT) then {
			[] call AW_fnc_Load_B_AT;
		};

		// Assistant Anti-Tank Specialist
		if (typeOf player in _B_AAT) then {
            [] call AW_fnc_Load_B_AAT;
		};

		// Missile AA
		if (typeOf player in _B_AA) then {
			[] call AW_fnc_Load_B_AA;
		};

		// Missile AA asst
		if (typeOf player in _B_AAA) then {
			[] call AW_fnc_Load_B_AAA;
		};

        // Medium Anti-Tank Specialist
        if (typeOf player in _B_MAT) then {
            [] call AW_fnc_Load_B_MAT;
        };

		// Pilot
		if (typeOf player in _B_pilot) then {
			[] call AW_fnc_Load_B_pilot;
		};

		// Co-Pilot
		if (typeOf player in _B_copilot) then {
			[] call AW_fnc_Load_B_copilot;
		};

		// Crew Commander
		if (typeOf player in _B_crewCommand) then {
			[] call AW_fnc_Load_B_crewCommand;
		};

		// Crew
		if (typeOf player in _B_crew) then {
			[] call AW_fnc_Load_B_crew;
		};

        // Platoon engineer
        if (typeOf player in _B_engi_PLT) then {
			[] call AW_fnc_Load_B_engi_PLT;
		};

        // Engineer logi 1
        if (typeOf player in _B_engi_logi) then {
            [] call AW_fnc_Load_B_engi_logi;
        };

        // Clear Team SL
        if (typeOf player in _B_CT_lead) then {
            [] call AW_fnc_Load_B_CT_lead;
        };

        //  Clear Team Rifleman
        if (typeOf player in _B_CT_rifleman) then {
            [] call AW_fnc_Load_B_CT_rifleman;
        };

        // Clear Team Demo Man
        if (typeOf player in _B_CT_explo) then {
            [] call AW_fnc_Load_B_CT_explo;
        };
	};
    case east: {
	};
    case independent: {
 	};
 };
