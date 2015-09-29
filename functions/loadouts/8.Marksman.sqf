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
player addItemToUniform "ACE_Kestrel4500";
this addItemToVest "ACE_ATragMX";
for "_i" from 1 to 2 do {player addItemToUniform "RH_16Rnd_40cal_usp";};
player addVest "rhsusf_iotv_ocp_Rifleman";
for "_i" from 1 to 7 do {player addItemToVest "rhsusf_20Rnd_762x51_m118_special_Mag";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
player addItemToVest "SmokeShell";
player addItemToVest "SmokeShellGreen";
player addItemToVest "SmokeShellBlue";
player addItemToVest "ACE_HandFlare_White";
player addHeadgear "rhs_Booniehat_ocp";

player addWeapon "rhs_weap_m14ebrri";
player addPrimaryWeaponItem "FHQ_optic_LeupoldERT";
player addWeapon "RH_uspm";
player addWeapon "lerca_1200_tan";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "tf_microdagr";
player linkItem "tf_rf7800str";
player linkItem "ACE_NVG_Gen4";