removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "rhs_uniform_cu_ucp";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 5 do {player addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 2 do {player addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_morphine";};
player addItemToUniform "ACE_tourniquet";
player addItemToUniform "ACE_IR_Strobe_Item";
player addItemToUniform "RH_15Rnd_9x19_M9";
player addVest "rhsusf_iotv_ucp";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
player addHeadgear "rhsusf_cvc_green_helmet";

player addWeapon "rhs_weap_mk18_grip2_KAC";
player addWeapon "RH_m9";
player addWeapon "Rangefinder";

player addItemToVest "rhs_mag_30Rnd_556x45_Mk318_Stanag";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "tf_anprc152";
player linkItem "ItemGPS";