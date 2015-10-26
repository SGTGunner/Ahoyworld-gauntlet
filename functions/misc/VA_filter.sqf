/*/
 * Author: alganthe
 * Filter the arsenal for a given box
 *
 * Arguments:
 * 0: Box <OBJECT>
 * 1: filter <BOOLEAN
 *
 * Return Value:
 * Array of items added in the form of ["item1","item2",......"itemN"]
 *
 * Example:
 *
 * [_this,true] call AW_fnc_VA_filter;
 */

params ["_box","_filter"];


if (_filter) then {
    //ACE
    ["AmmoboxInit",[_box,true,{true}]] call BIS_fnc_arsenal;
    [_box,[true],true] call BIS_fnc_removeVirtualItemCargo;
    [_box,[true],true] call BIS_fnc_removeVirtualWeaponCargo;

    _weaponsBlacklist = [
    // ------------------- SOS equipped weapon(s)
    "arifle_MXC_SOS_point_snds_F","arifle_MXM_SOS_pointer_F","srifle_DMR_03_SOS_F","srifle_DMR_01_SOS_F","srifle_EBR_SOS_F","rhs_weap_sr25_sup_usmc",

    // ------------------- Leupold equipped weapon(s)
    "rhs_weap_m14ebrri_leu","rhs_weap_XM2010_d_leu","rhs_weap_XM2010_wd_leu","rhs_weap_m39","rhs_weap_sr25_sup_marsoc","rhs_weap_sr25_usmc",

    // ------------------- SMA AAC
    "SMA_AAC_MPW_12_Black","SMA_AAC_MPW_9_Black","SMA_AAC_MPW_9_Woodland","SMA_AAC_MPW_9_Desert","SMA_AAC_MPW_9_Tan","SMA_AAC_MPW_9_OD","SMA_AAC_MPW_12_Black","SMA_AAC_MPW_12_Woodland","SMA_AAC_MPW_12_Desert","SMA_AAC_MPW_12_Tan","SMA_AAC_MPW_12_OD","SMA_AAC_MPW_16_Black","SMA_AAC_MPW_16_Woodland","SMA_AAC_MPW_16_Desert","SMA_AAC_MPW_16_Tan","SMA_AAC_MPW_16_OD",
    "srifle_GM6_F","srifle_GM6_camo_F","srifle_GM6_SOS_F","srifle_GM6_LRPS_F","srifle_GM6_camo_SOS_F","srifle_GM6_camo_LRPS_F",
    "hlc_rifle_psg1",

    // ------------------- Katiba
    "arifle_Katiba_F","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_C_ACO_pointer_F","arifle_Katiba_C_ACO_F","arifle_Katiba_ACO_F","arifle_Katiba_pointer_F","arifle_Katiba_ACO_pointer_F","arifle_Katiba_ARCO_F","arifle_Katiba_ARCO_pointer_F","arifle_Katiba_GL_ACO_F","arifle_Katiba_GL_ARCO_pointer_F","arifle_Katiba_GL_ACO_pointer_F","arifle_Katiba_GL_Nstalker_pointer_F","arifle_Katiba_GL_ACO_pointer_snds_F","arifle_Katiba_C_ACO_pointer_snds_F","arifle_Katiba_ACO_pointer_snds_F","arifle_Katiba_ARCO_pointer_snds_F",

    // ------------------- Intervention
    "srifle_LRR_F","srifle_LRR_camo_F","srifle_LRR_SOS_F","srifle_LRR_LRPS_F","srifle_LRR_camo_SOS_F","srifle_LRR_camo_LRPS_F",

    // ------------------- RHS XM2010
    "rhs_weap_XM2010","rhs_weap_XM2010_wd","rhs_weap_XM2010_d","rhs_weap_XM2010_sa","rhs_weap_XM2010_d_leu","rhs_weap_XM2010_wd_leu",

    // ------------------- ASP-1 Kir
    "srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_04_ACO_F","srifle_DMR_04_MRCO_F","srifle_DMR_04_SOS_F","srifle_DMR_04_DMS_F","srifle_DMR_04_ARCO_F","srifle_DMR_04_NS_LP_F",

    // ------------------- Cyrus
    "srifle_DMR_05_blk_F","srifle_DMR_05_tan_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_05_ACO_F","srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_DMS_F","srifle_DMR_05_KHS_LP_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_ARCO_F",

    // ------------------- MAR-10
    "srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_02_ACO_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_SOS_F","srifle_DMR_02_DMS_F","srifle_DMR_02_sniper_AMS_LP_S_F","srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_ARCO_F",

    // ------------------- RHS M32
    "rhs_weap_m32","rhs_weap_m32_usmc",

    // ------------------- 	Mk-I EMR Test
    "srifle_DMR_03_spotter_F"
    ];

    _itemBlackList = [
    // ------------------------- Optics
    "optic_Nightstalker",
    "optic_tws",
    "optic_tws_mg",
    "optic_LRPS",
    "ACE_optic_LRPS_2D",
    "ACE_optic_LRPS_PIP",
    "optic_SOS",
    "ACE_optic_SOS_2D",
    "ACE_optic_SOS_PIP",
    "rhsusf_acc_LEUPOLDMK4",
    "rhsusf_acc_LEUPOLDMK4_2",
    "Leupold_Mk4",
    "rhsusf_acc_ACOG3_test",

    // ------------------------- Uniforms (vanilla)
    "U_O_CombatUniform_ocamo",
    "U_O_CombatUniform_oucamo",
    "U_O_OfficerUniform_ocamo",
    "U_O_SpecopsUniform_ocamo",
    "U_I_CombatUniform",
    "U_I_CombatUniform_shortsleeve",
    "U_I_OfficerUniform",
    "U_O_PilotCoveralls",
    "U_I_pilotCoveralls",
    "U_I_HeliPilotCoveralls",

    // ------------- Ghilies
    "U_O_FullGhillie_ard",
    "U_I_FullGhillie_ard",
    "U_B_FullGhillie_ard",
    "U_O_FullGhillie_lsh",
    "U_I_FullGhillie_lsh",
    "U_B_FullGhillie_lsh",
    "U_I_FullGhillie_sard",
    "U_O_FullGhillie_sard",
    "U_B_FullGhillie_sard",
    "U_O_GhillieSuit",
    "U_I_GhillieSuit",
    "U_B_GhillieSuit",

    // ------------- Wetsuits
    "U_O_Wetsuit",
    "U_I_Wetsuit",

    // ------------- CIV clothes
    "U_C_Poloshirt_blue",
    "U_C_Poloshirt_burgundy",
    "U_C_Poloshirt_stripped",
    "U_C_Poloshirt_tricolour",
    "U_C_Poloshirt_salmon",
    "U_C_Poloshirt_redwhite",

    // ------------- drivers
    "U_C_Driver_1_black",
    "U_C_Driver_1_blue",
    "U_C_Driver_2",
    "U_C_Driver_1",
    "U_C_Driver_1_green",
    "U_C_Driver_1_orange",
    "U_C_Driver_1_red",
    "U_C_Driver_3",
    "U_C_Driver_4",
    "U_C_Driver_1_white",
    "U_C_Driver_1_yellow",

    // ------------- Guerilla clothes
    "U_BG_Guerilla1_1",
    "U_BG_Guerilla2_1",
    "U_BG_Guerilla2_2",
    "U_BG_Guerilla2_3",
    "U_BG_Guerilla3_1",
    "U_BG_Guerilla3_2",
    "U_BG_Guerrilla_6_1",
    "U_BG_leader",

    // ------------- random
    "U_C_HunterBody_grn",
    "U_OrestesBody",
    "U_C_Journalist",
    "U_Marshal",
    "U_C_Scientist",
    "U_C_WorkerCoveralls",
    "U_C_Poor_1",
    "U_Competitor",
    "U_Rangemaster",
    "U_B_Protagonist_VR",
    "U_O_Protagonist_VR",
    "U_I_Protagonist_VR",

    // ------------- Uniforms (TRYK)
    "TRYK_U_taki_BL",
    "TRYK_U_taki_BLK",
    "TRYK_U_taki_COY",
    "TRYK_U_taki_WH",
    "TRYK_U_taki_G_BL",
    "TRYK_U_taki_G_BLK",
    "TRYK_U_taki_G_COY",
    "TRYK_U_taki_G_WH",
    "TRYK_SUITS_BLK_F",
    "TRYK_SUITS_BR_F",
    "TRYK_ZARATAKI",
    "TRYK_ZARATAKI2",
    "TRYK_ZARATAKI3",

    // ------------- Uniforms (MFFA)
    "O_cg_cwp_uniform1",
    "O_cg_cwp_uniform2",
    "O_cg_cwp_uniform3",
    "O_cg_uniform1_cup",
    "O_cg_uniform2_cup",
    "O_cg_cdp_uniform1",
    "O_cg_cdp_uniform2",
    "O_cg_cdp_uniform3",
    "O_cg_uniform4",

    // ------------------------- Helmets
    "H_HelmetSpecO_blk",
    "H_HelmetSpecO_ocamo",
    "H_HelmetLeaderO_ocamo",
    "H_HelmetLeaderO_oucamo",
    "H_HelmetIA",
    "H_PilotHelmetFighter_O",
    "H_PilotHelmetFighter_I",
    "H_PilotHelmetHeli_O",
    "H_PilotHelmetHeli_I",
    "H_CrewHelmetHeli_O",
    "H_CrewHelmetHeli_I",
    "H_HelmetCrew_I",
    "H_HelmetCrew_O",
    "H_RacingHelmet_1_F",
    "H_RacingHelmet_2_F",
    "H_RacingHelmet_3_F",
    "H_RacingHelmet_4_F",
    "H_RacingHelmet_1_black_F",
    "H_RacingHelmet_1_blue_F",
    "H_RacingHelmet_1_green_F",
    "H_RacingHelmet_1_red_F",
    "H_RacingHelmet_1_white_F",
    "H_RacingHelmet_1_yellow_F",
    "H_RacingHelmet_1_orange_F",
    "H_Cap_marshal",
    "H_StrawHat",
    "H_StrawHat_dark",
    "H_Hat_blue",
    "H_Hat_brown",
    "H_Hat_camo",
    "H_Hat_grey",
    "H_Hat_checker",
    "H_Hat_tan",
    "H_MilCap_ocamo",
    "H_MilCap_dgtl",

    // ------------- Helmets (MFFA)
    "cg_MICH_cwp",
    "H_HelmetCrew_O_cg",
    "cg_MICH_cup",
    "cg_MICH_cdp",

    // ------------- Helmets (TRYK)
    "TRYK_H_pakol2",
    "TRYK_H_pakol",
    "TRYK_H_wig",
    "TRYK_H_ghillie_top_headless3",
    "TRYK_H_ghillie_over_green",
    "TRYK_H_ghillie_top_green",
    "TRYK_H_ghillie_top_headless_green",
    "TRYK_H_ghillie_over",
    "TRYK_H_ghillie_top",
    "TRYK_H_ghillie_top_headless",

    // ------------------------- Glasses
    "G_Goggles_VR",
    "TRYK_H_ghillie_top_headless3glass",
    "G_Lady_Blue",
    "G_Spectacles",
    "G_Spectacles_Tinted",
    "G_I_Diving",
    "G_O_Diving",

    // ------------------------- Vests
    "V_Press_F",
    "V_HarnessO_brn",
    "V_HarnessOGL_brn",
    "V_HarnessO_gry",
    "V_HarnessOGL_gry",
    "V_HarnessOSpec_brn",
    "V_HarnessOSpec_gry",
    "V_RebreatherIR",
    "V_RebreatherIA",
    "V_PlateCarrierIAGL_dgtl",
    "V_PlateCarrierIAGL_oli",
    "V_PlateCarrierIA1_dgtl",
    "V_PlateCarrierIA2_dgtl",
    "cg_HarnessO_cwp",
    "cg_HarnessOGL_cwp",
    "cg_HarnessO_cdp",
    "cg_HarnessOGL_cdp",
    "cg_HarnessO_cup",
    "cg_HarnessOGL_cup",
    "TRYK_LOC_AK_chestrig_OD",
    "TRYK_LOC_AK_chestrig_TAN",
    "TRYK_V_PlateCarrier_POLICE",
    "TRYK_V_Sheriff_BA_OD",
    "TRYK_V_tacv1LC_FBI_BK",
    "TRYK_V_tacv1LC_FBI2_BK",
    "TRYK_V_tacv1_FBI_BK",
    "TRYK_V_tacv1LC_MSL_BK",
    "TRYK_V_tacv1LC_MSL_NV",
    "TRYK_V_tacv1LMSL_BK",
    "TRYK_V_tacv1LMSL_NV",
    "TRYK_V_tacv1_MSL_BK",
    "TRYK_V_tacv1_MSL_NV",
    "TRYK_V_tacv1_P_BK",
    "TRYK_V_tacv1LC_P_BK",
    "TRYK_V_tacv1LC_P2_BK",
    "TRYK_V_tacv1LP_BK",
    "TRYK_V_tacv1LC_SRF_BK",
    "TRYK_V_tacv1LC_SRF2_BK",
    "TRYK_V_tacv1LC_SRF_OD",
    "TRYK_V_tacv1LC_SRF2_OD",
    "TRYK_V_tacv1LSRF_BK",
    "TRYK_V_tacv1_SHERIFF_BK",
    "TRYK_V_harnes_blk_L",
    "TRYK_V_harnes_od_L",
    "TRYK_V_harnes_TAN_L"
    ];

    _availableItems = [true] call AW_fnc_findItemList;
    _availableItems = _availableItems - _itemBlackList;

    _availableItems = _availableItems - _weaponsBlacklist;

    [_box,_availableItems,true] call BIS_fnc_addVirtualItemCargo;
    [_box,_availableItems,true] call BIS_fnc_addVirtualWeaponCargo;
} else {
    [_box,[true],true] call BIS_fnc_removeVirtualItemCargo;
};
