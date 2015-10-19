/*
 * Author: alganthe
 * Deploy / unpack the FOB
 *
 * Arguments:
* 0: Vehicle to deploy the FOB on <OBJECT>
* 1: Deployed already? <BOOL>
* 2: Cleanup ? (Optionnal) <BOOL>
* 3: Owner of the vehicle <OBJECT>
*
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * ["FOBvehc",true,nil,_owner] call AW_fnc_FOB_deploy
 */
params ["_vehicle","_deployed","_cleanup"];

//---------------------------- Check if the call was done correctl, vehicle will be server owned if _cleanup is defined
if (!(isNil "_cleanup")) then {
    //---------------------------- Unlock the vehicle
    _vehicle setVehicleLock "UNLOCKED";
    //---------------------------- Restore the fuel
    [_vehicle,0] spawn rhs_fnc_fmtv_Deploy;

    //---------------------------- If the FOB was already deployed remove it
   if !(isNil "MHQ_Mash") then {

       //---------------------------- Remove variable
       MHQ_Mash setvariable ["isMedicalFacility",false,false];
       //---------------------------- Cleanup of the FOB + make sure the variables are nil
       deleteVehicle MHQ_Mash;
       deleteVehicle MHQ_Antenna;
       deleteVehicle MHQ_box;
       deleteVehicle MHQ_Net;
       MHQ_Mash = nil;
       MHQ_Antenna = nil;
       MHQ_box = nil;
       MHQ_Net  = nil;
   };

   //---------------------------- Return nil to avoid executing the rest.
   _cleanup = nil;
   _deployed = nil;
};
//---------------------------- Check if the call was done properly
if (!isNil "_deployed" && {local _vehicle}) then {
    //---------------------------- FOB already deployed
    if (_deployed) then {
        _vehicle setVehicleLock "UNLOCKED";
        [_vehicle,0] spawn rhs_fnc_fmtv_Deploy;

        //***********Undo Variables
        MHQ_Mash setvariable ["isMedicalFacility",false,false];
        //***********Cleanup+pack hints
        deleteVehicle MHQ_Mash;
        deleteVehicle MHQ_Antenna;
        deleteVehicle MHQ_box;
        deleteVehicle MHQ_Net;
        MHQ_Mash = nil;
        MHQ_Antenna = nil;
        MHQ_box = nil;
        MHQ_Net  = nil;
        _deployed = false;
    }
    //---------------------------- FOB NOT already deployed
    else {
        {moveOut _x} forEach crew _vehicle;
        _vehicle setVehicleLock "LOCKED";
        //---------------------------- Objects
        MHQ_Net = "Land_CamoNetB_NATO" createVehicle getPosWorld _vehicle;
        MHQ_Net allowDamage false;
        MHQ_Net attachTo [_vehicle,[0,-2,0]];
        MHQ_Net setDir 180;
        MHQ_Net setPos getPosWorld MHQ_Net;
        MHQ_box = "Box_NATO_AmmoVeh_F" createVehicle getPosWorld _vehicle;
        MHQ_box allowDamage false;
        MHQ_box attachTo [_vehicle,[2.5,0,-1]];
        MHQ_box setvariable ["ACE_cargo_size",-1];
        MHQ_Antenna = "Land_antenna" createVehicle getPosWorld _vehicle;
        MHQ_Antenna allowDamage false;
        MHQ_Antenna attachTo [_vehicle,[4,10,-1]];
        MHQ_Mash = "MASH" createVehicle getPosWorld _vehicle;
        MHQ_Mash allowDamage false;
        MHQ_Mash attachTo [_vehicle,[-4.2,0,-0.6]];

        //---------------------------- Add Ammo to box
        clearMagazineCargoGlobal MHQ_box;
        clearItemCargoGlobal MHQ_box;
        clearWeaponCargoGlobal MHQ_box;
        MHQ_box addItemCargoGlobal ["ACE_fieldDressing", 40];
        MHQ_box addItemCargoGlobal ["ACE_packingBandage", 40];
        MHQ_box addItemCargoGlobal ["ACE_elasticBandage", 40];
        MHQ_box addItemCargoGlobal ["ACE_tourniquet", 10];
        MHQ_box addItemCargoGlobal ["ACE_morphine", 40];
        MHQ_box addItemCargoGlobal ["ACE_atropine", 40];
        MHQ_box addItemCargoGlobal ["ACE_epinephrine", 40];
        MHQ_box addItemCargoGlobal ["ACE_quikclot", 40];
        MHQ_box addItemCargoGlobal ["ACE_personalAidKit", 10];
        MHQ_box addItemCargoGlobal ["ACE_surgicalKit", 10];
        MHQ_box addItemCargoGlobal ["ACE_bodyBag", 5];
        MHQ_box addItemCargoGlobal ["ACE_SpareBarrel", 5];
        MHQ_box addItemCargoGlobal ["ACE_Sandbag_empty", 100];
        MHQ_box addItemCargoGlobal ["ACE_EarPlugs", 15];
        MHQ_box addItemCargoGlobal ["ACE_Clacker", 5];
        MHQ_box addItemCargoGlobal ["ACE_M26_Clacker", 5];
        MHQ_box addItemCargoGlobal ["ACE_plasmaIV_250", 10];
        MHQ_box addItemCargoGlobal ["ACE_bloodIV_250", 10];
        MHQ_box addItemCargoGlobal ["ACE_salineIV_250", 10];
        MHQ_box addItemCargoGlobal ["DemoCharge_Remote_Mag", 2];
        MHQ_box addWeaponCargoGlobal ["Binocular", 2];
        MHQ_box addMagazineCargoGlobal ["rhsusf_100Rnd_762x51", 20];
        MHQ_box addMagazineCargoGlobal ["rhsusf_100Rnd_556x45_soft_pouch", 20];
        MHQ_box addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag", 15];
        MHQ_box addWeaponCargoGlobal ["rhs_weap_m16a4_carryhandle_pmag", 5];
        MHQ_box addWeaponCargoGlobal ["rhs_weap_m4_carryhandle_pmag", 5];
        MHQ_box addWeaponCargoGlobal ["rhs_weap_m4a1_grip", 5];
        MHQ_box addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_Mk318_Stanag", 40];
        MHQ_box addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_Mk262_Stanag", 40];
        MHQ_box addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 40];
        //---------------------------- Fin Hint for user+Grid broadcast(Use EH to broadcast hint)
        _gridPos = [(getPosWorld _vehicle),true]call ace_common_fnc_getMapGridFromPos;
        _fobHintText = format [
                                                     "<t align='center' size='2.2'>FOB Deployed at </t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><br/><br/>",_gridPos
                                                                  ];
        ["Globalhint_EH", [_fobHintText]] call ace_common_fnc_globalEvent;

        //---------------------------- Variables(Boost radio range,add to medical,ammo to box )
        _vehicle setVariable ["tf_range", 50000, true];
        MHQ_Mash setvariable ["ACE_medical_isMedicalFacility",true,true];
        _deployed = true;
    };
};
