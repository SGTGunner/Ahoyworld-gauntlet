params ["_unit"];

_fixWalking = ["fixWalkingAction","Fix forced walking","",{player setHit ["legs", 0]},
{(player getHit "legs" >= 0.50) && (player call ace_medical_fnc_isInStableCondition)
}] call ace_interact_menu_fnc_createAction;
[_unit, 1, ["ACE_SelfActions"],_fixWalking] call ace_interact_menu_fnc_addActionToObject;
