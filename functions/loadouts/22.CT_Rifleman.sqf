comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
player forceAddUniform "TRYK_U_B_BLK3CD";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 5 do {player addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 3 do {player addItemToUniform "RH_7Rnd_45cal_m1911";};
for "_i" from 1 to 5 do {player addItemToUniform "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
player addVest "TRYK_V_ArmorVest_Delta";
for "_i" from 1 to 3 do {player addItemToVest "ACE_morphine";};
player addItemToVest "ACE_epinephrine";
player addItemToVest "ACE_tourniquet";
for "_i" from 1 to 2 do {player addItemToVest "ACE_elasticBandage";};
for "_i" from 1 to 2 do {player addItemToVest "ACE_quikclot";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
player addItemToVest "SmokeShellRed";
player addItemToVest "SmokeShellGreen";
player addHeadgear "TRYK_H_PASGT_BLK";
player addGoggles "TRYK_Shemagh_shade_G";
comment "Add weapons";
player addWeapon "rhs_weap_mk18_grip2_KAC";
player addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";
player addPrimaryWeaponItem "FHQ_acc_ANPEQ15_black";
player addPrimaryWeaponItem "FHQ_optic_HWS";
player addWeapon "RH_kimber_nw";
player addHandgunItem "RH_gemtech45";
player addHandgunItem "RH_X300";
player addWeapon "Binocular";
comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "tf_anprc152_2";
player linkItem "ItemGPS";
player linkItem "NVGoggles_OPFOR";