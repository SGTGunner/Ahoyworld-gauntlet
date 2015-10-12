class AW {
    tag = "AW";
    class functions {
        //Main
        class missionName {file = "functions\core\missionName.sqf";};
        class missionSelection {file = "functions\core\missionSelection.sqf";};
        class missionTransition {file = "functions\core\missionTransition.sqf";};
        class respawnTime_EH {file = "functions\core\respawnTime_EH.sqf";};

        //Missions
        class mission_clearTown {file = "functions\missions\mission1_clearTown.sqf";};
        class mission_ressuplyTruck {file = "functions\missions\mission2_ressuplyTruck.sqf";};
        class mission_AAVehicleDeal {file = "functions\missions\mission3_AAVehicleDeal.sqf";};
        class mission_destroyRadar {file = "functions\missions\mission4_destroyRadar.sqf";};
        class mission_deployComs {file = "functions\missions\mission6_deployComs.sqf";};
        class mission_destroyComs {file = "functions\missions\mission7_destroyComs.sqf";};
        class mission_recoverCrate {file = "functions\missions\mission8_recoverCrate.sqf";};
        class mission_destroyUAV {file = "functions\missions\mission9_destroyUAV.sqf";};
        class mission_guerMeeting {file = "functions\missions\mission10_guerMeeting.sqf";};
        class mission_tankPlatoon {file = "functions\missions\mission11_tankPlatoon.sqf";};
        class mission_captureNuclearDevice {file = "functions\missions\mission12_captureNuclearDevice.sqf";};
        class mission_captureAndDefendTown {file = "functions\missions\mission13_captureAndDefendTown.sqf";};
        class mission_destroyMortar {file = "functions\missions\mission14_destroyMortar.sqf";};
        class mission_KillHVT {file = "functions\missions\mission15_KillHVT.sqf";};
        class mission_recoverChopperIntel {file = "functions\missions\mission16_recoverChopperIntel.sqf";};

        //Loadouts
        class loadoutsExec {file = "functions\loadouts\loadoutexec.sqf";};
        class Load_B_officer {file = "functions\loadouts\1.Platoon_Leader.sqf";};
        class Load_B_SL {file = "functions\loadouts\2.SquadLeader.sqf";};
        class Load_B_TL {file = "functions\loadouts\3.TeamLeader.sqf";};
        class Load_B_FAC {file = "functions\loadouts\4.FAC.sqf";};
        class Load_B_rifleman {file = "functions\loadouts\5.Rifleman.sqf";};
        class Load_B_grenadier {file = "functions\loadouts\6.Grenadier.sqf";};
        class Load_B_medic {file = "functions\loadouts\7.Medic.sqf";};
        class Load_B_marksman {file = "functions\loadouts\8.Marksman.sqf";};
        class Load_B_explo {file = "functions\loadouts\9.Explosive_Spec.sqf";};
        class Load_B_AR {file = "functions\loadouts\10.AutoRifleman.sqf";};
        class Load_B_AAR {file = "functions\loadouts\11.AssistAR.sqf";};
        class Load_B_MMG {file = "functions\loadouts\12.MMG.sqf";};
        class Load_B_AMG {file = "functions\loadouts\13.AssistMMG.sqf";};
        class Load_B_AT {file = "functions\loadouts\14.MissleSpecAT.sqf";};
        class Load_B_AAT {file = "functions\loadouts\15.AssistMissleSpecAT.sqf";};
        class Load_B_AA {file = "functions\loadouts\16.MissleSpecAA.sqf";};
        class Load_B_AAA {file = "functions\loadouts\17.AssistMissleSpecAA.sqf";};
        class Load_B_MAT {file = "functions\loadouts\25.MATSpec.sqf";};
        class Load_B_pilot {file = "functions\loadouts\18.Pilot.sqf";};
        class Load_B_copilot {file = "functions\loadouts\19.Co-Pilot.sqf";};
        class Load_B_crewCommand {file = "functions\loadouts\20.CrewCommander.sqf";};
        class Load_B_crew {file = "functions\loadouts\21.Crew.sqf";};
        class Load_B_CT_rifleman {file = "functions\loadouts\22.CT_Rifleman.sqf";};
        class Load_B_CT_lead {file = "functions\loadouts\23.CT_SL.sqf";};
        class Load_B_CT_explo {file = "functions\loadouts\24.CT_DemoSpec.sqf";};
        class Load_B_engi_PLT {file = "functions\loadouts\26.PLTeng.sqf";};
        class Load_B_engi_logi {file = "functions\loadouts\27.LOGeng.sqf";};

        //FOB
        class FOB_handler {file = "functions\misc\FOB\FOB_handler.sqf";};
        class FOB_deploy_check {file = "functions\misc\FOB\FOB_deploy_check.sqf";};
        class FOB_repack_check {file = "functions\misc\FOB\FOB_repack_check.sqf";};
        class FOB_interactions_add {file = "functions\misc\FOB\FOB_interactions_add.sqf";};
        class FOB_CanDeploy {file ="functions\misc\FOB\FOB_CanDeploy.sqf";};
        class FOB_CanRepack {file ="functions\misc\FOB\FOB_CanRepack.sqf";};

        //Misc
        class VA_filter {file = "functions\misc\VA_filter.sqf";};
        class daytime {file = "functions\misc\daytime.sqf";};
        class Globalhint_handler {file = "functions\misc\Globalhint_handler.sqf";};
        class find_flatPos {file = "functions\misc\find_flatPos.sqf";};
        class supplyPoint_interactions_add {file = "functions\misc\supplyPoint_interactions_add.sqf";};
        class createBox {file = "functions\misc\createBox.sqf";};
        class supplyBox_refiller {file = "functions\misc\supplyBox_refiller.sqf";};
        class diary {file = "functions\misc\diary.sqf";};
     };
};
class QS {
    tag = "QS";
	class functions {
        file = "functions\QSfnc";
		class vMonitor {};
		class vSetup02 {};
        class conditionMobileArmory {};
	};
};
class KC {
	tag= "KC";
	class functions {
		file = "functions";
		class reinforceChopper {};
	};
};
