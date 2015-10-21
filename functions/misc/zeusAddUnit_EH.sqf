/*
 * Author: alganthe
 * Add unit to zeus, called upon respawn and initPlayerLocal.
 *
 * Arguments:
 * 0: Unit needed to be added <OBJECT>
 *
 * Return Value:
 * nothing
 */
params ["_unit"];

{_x addCuratorEditableObjects [[_unit],false];} count allCurators;
