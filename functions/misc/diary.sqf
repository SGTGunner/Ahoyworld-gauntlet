/*
| Author: 
|
|	Quiksilver.
|
| Modified last by: Pfc. Christiansen
|
|_____
|
| Description: 
|	
|	Created: 14/2/2015. Altered: 16/2/2015
|	Coded for AhoyWorld EU 3 to replace Patrol Ops with a perpetual mission with few scripts.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions, 
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World.
| 	Feel free to re-format or make it look better.
|_____
|
| Usage: 
|	
|	Search below for the diary entries you would like to edit. 
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	This Mission was created by Pfc.Christiansen and BACONMOP
|	
|	Please be respectful and do not remove credit.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Enforcement",
"
<br />The purpose of the above rules are to ensure a fun and relaxing environment for public players.
<br />
<br />Server rules are in place merely as a means to that end.
<br />
<br />Guideline for enforcement:
<br />
<br />-	Innocent rule violation and disruptive behavior: 
<br />
<br />		= Verbal / Written request to cease, or warning.
<br /> 
<br />-	Minor or first-time rule violation:
<br />
<br />		= Kick, or 0 - 7 day ban.
<br />
<br />-	Serious or repetitive rule violation: 
<br />
<br />		= 7 day to permanent ban.
<br />
<br />
<br />The above is subject to discretion.
"
]];

player createDiaryRecord ["rules",
[
"General",
"
<br />1. Do not teamkill. This one shouldn’t even be here… ANY type of on purpose teamkilling will not be accepted. IE: Revenge killing, executions, dicking around…
<br />2. Do not dare/antagonize someone to teamkill, and/or create a situation where teamkilling is very likely to happen. (capturing an enemy vehicle and failing to properly notifying your team)
<br />3. Listen to the Chain of Command.
<br />4. Do not type over side chat.(Unless in an emergency). On game nights, if you do this to often, this may result in a kick.
<br />5. Do not discharge any of your weapons in base on purpose! This includes launchers with their back blast.
<br />6. Pilots should not get into jets/helicopters unless told to by Command elements.
<br />7. Do not use 2 seater aircraft when alone.
<br />8. CAS  pilots(Helicopter/Jet) should be on standby in a safe orbit over AO unless instructed otherwise by command element(Not Squad Leaders). CAS standby and not fire unless told to by command.
<br />9. Firing 20mm or 30mm cannon can cause server lag issues, so please use them with discretion.
<br />10. If you select a role, please play that role. We don’t expect a medic to be running around with a AT launcher + LMG. Just play your role.
<br />11. The first medic on a scene decides how to treat a patient. Do not run up to a patient and start doing medical stuff without asking the on scene medic first.
<br />12. Radios are not for chit-chat. Please keep radio chatter to a minimum. If you have to talk do it LOCALLY.
<br />13. The motor pool and spawn area is not for helicopters or jets. Do not land them there. Use the helipads instead. When no helipad is available, land outside base in a safe area.
<br />
<br />If you see a player in violation of the above, contact a moderator or admin (teamspeak).
"
]];



//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> Teamspeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"AHOY WORLD",
"
<br /> Address: ts.ahoyworld.co.uk
<br />
<br /> Visitors and guests welcome!
"
]];

//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"Shots left in magazine",
"
<br /><font size='16'>Q:</font> How do I check the amount of rounds left in my magazine?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Press CTRL and press R.
<br /> 2. This will give you an indication of how heavy the magazine is and thus how many rounds are left.
<br /> Green = full or near full, Yellow = around half empty, Red = almost empty if you can reload now if your about to move onto the enemy
<br />
"
]];

player createDiaryRecord ["faq",
[
"AGM Keys",
"
<br /><font size='16'>Q:</font> Which keys to I use to interact with myself or others?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Press Left Control+ Left Windows key to interact with yourself.
<br /> 2. Press Left Windows key to interact with other players/vehicles.
<br /> 3. Your SELF-INTERACTION key is used to interact with your gear, from putting earplugs in, attaching items to you, self-healing, repacking your magazines.
<br /> 4. Your INTERACTION key is used to interact with other players, vehicles. You can heal other players, use Team Management to join their squad, cable-tie units (do not use on friendly players). 
<br />
"
]];

player createDiaryRecord ["faq",
[
"AGM Vector",
"
<br /><font size='16'>Q:</font> How do I properly use AGM Vector and which keys to use?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Use Vector as any other binoculars, press B to pull it out.
<br /> 2. Always point the middle cross towards and on the target.
<br /> 3. To measure DISTANCE to the target, aim at it, press and hold R until a red square appears then release the key. A distance to your target should appear in the right section of your vector. Distance is measured in meters.
<br /> 4. To measure BEARING to the target, aim at it, press and hold Tab until a red square appears then release the key. A bearing to your target should appear in the left section of your vector. Bearing is measured in degrees.
<br /> 5. For more information about the usage of the Vector, visit the AW Forums, in EU#3 section, click Basic Guides topic.
<br />
"
]];

player createDiaryRecord ["faq",
[
"AGM Weapon Safety",
"
<br /><font size='16'>Q:</font> How do I put my weapon on safe?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Press Left Control + ~ (tilde key - next to 1).
<br /> 2. A weapon and text should appear in top right corner saying: Put on Safety and your fire mode has no bar.
<br /> 3. Remove the safety by pressing same buttons again or by switching firing mode of your weapon. A text should say Remove safety and your fire mode should be visible.
<br />
"
]];

player createDiaryRecord ["faq",
[
"SR Radio",
"
<br /><font size='16'>Q:</font> How do i use my short range radio?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Press left or right CTRL + P.
<br /> 2. When using a rifleman radio such as the RF-7800 you will need a MicroDagger to program the radio. Also it has a range of about 2km.
<br /> 3. If you press CLR you clear the frequency and you can type in a new one.
<br /> 4. When you are done typing in the frequency click the ENT button and you will now be able to hold CAPS LOCK and talk with other people on the same frequency.
<br /> 
"
]];

player createDiaryRecord ["faq",
[
"LR Radio",
"
<br /><font size='16'>Q:</font> How do i use my long range radio?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Get a long range radio from the arsenal(Backpack).
<br /> 2. Press LEFT ALT + P.
<br /> 3. This is basically a bigger version of the short range radio used as a backpack.
<br /> 4. To use this radio you have to hold CTRL + CAPS LOCK and you will be able to talk with people that also has a long range radio but over a longer range than the short range one.
<br />
"
]];

//-------------------------------------------------- Change Log
player createDiaryRecord ["changelog",
[
"V 0.01",
"
<br />[ADDED] Initial release of Fallujah(port from v.20 of Gauntlet)
"
]];

player createDiaryRecord ["changelog",
[
"V 0.02",
"
<br />[FIXED] MH-9 and AH-9 now respawn.
<br />[CHANGED] MH-9 Hummingbird now has only bench seats.
<br />[CHANGED] Anti-Air team was replaced by Spec-Ops Clear Team.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.03",
"
<br />[TWEAKED] Ambient AI should now usually spawn in front of Blufor Advance.
"
]];
//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"Gauntlet",
"
<br />Mission authors:<br /><br />

		- <font size='16'>Pfc.Christiansen<br /><br />
		- <font size='16'>BACONMOP</font><br />
		
<br />Other:<br /><br />
		QS Vehicle Respawn and Cleanup<br />
		- Quicksilver<br />
		DAC<br />
		- Silola<br />
		CSSA3<br />
		- Cyrokrypto<br /><br />
		CHVD<br />
		- Champ-1<br /> <br />
		ATLAS Squadmanager<br />
		- Champ-1<br /> <br />
"
]];