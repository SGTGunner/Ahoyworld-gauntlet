/*
 * Author: alganthe
 * ServerSide EH sending the missionInProgress variable to whoever ask it.
 *
 * Arguments:
 * 0: ID of the unit doing the call <OBJECT>
 *
 * Return Value:
 * None
 */
params ["_client"];

_client publicVariableClient "missionInProgress";
