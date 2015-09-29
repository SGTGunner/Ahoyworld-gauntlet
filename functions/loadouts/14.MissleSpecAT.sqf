removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "rhs_uniform_cu_ocp";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 5 do {player addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 2 do {player addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_morphine";};
player addItemToUniform "ACE_tourniquet";
player addItemToUniform "ACE_IR_Strobe_Item";
for "_i" from 1 to 2 do {player addItemToUniform "RH_15Rnd_45cal_fnp";};
player addVest "rhsusf_iotv_ocp_Rifleman";
for "_i" from 1 to 5 do {player addItemToVest "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
player addItemToVest "SmokeShell";
player addItemToVest "SmokeShellGreen";
player addItemToVest "SmokeShellBlue";
player addItemToVest "ACE_HandFlare_White";
player addBackpack "rhsusf_assault_eagleaiii_ocp";
player addItemToBackpack "rhs_fgm148_magazine_AT";
player addHeadgear "rhsusf_ach_helmet_headset_ocp";

player addWeapon "rhs_weap_m4_grip";
player addPrimaryWeaponItem "rhsusf_acc_anpeq15";
player addPrimaryWeaponItem "rhsusf_acc_EOTECH";
player addWeapon "rhs_weap_fgm148";
player addWeapon "RH_fnp45t";
player addHandgunItem "RH_X300";

player addItemToBackpack "rhs_fgm148_magazine_AT";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "tf_microdagr";
player linkItem "tf_rf7800str";
player linkItem "ACE_NVG_Gen4";