
private ["_veh","_fuel"];

 _veh = _this select 0;
 _fuel = _this select 1;
 if (local _veh) then
 {
    _veh setFuel _fuel;
} else
{
    PVsetFuel = _this;
     if (isDedicated) then {
     (owner _veh) publicVariableClient "PVsetFuel";
      } else {
        publicVariableServer "PVsetFuel";
      };
 };
