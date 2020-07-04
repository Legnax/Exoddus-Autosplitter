//  An autosplitter for Abe's Exoddus for PC: English / English GoG, Spanish, French / French Steam, German and Italian. 
//  Language should be detected automatically. It can be outputted selecting "LangDetected" through ASL Var Viewer.
//  Created by LegnaX. 04 July 2020.

state("Exoddus", "1.7.1") // EVERY LANGUAGE!!
{	
	// ENGLISH!!
	byte EN_LEVEL_ID : 0x1C3030;
	byte EN_PATH_ID : 0x1C3032;
	byte EN_CAM_ID : 0x1C3034;
	byte EN_FMV_ID : 0x1C3042;
	short EN_abeY : 0x1C1230, 0x68, 0xBE; // 1E12
	int EN_gnFrame : 0x1C1B84; // Between Level and gnFrame = 14AC
	// byte IsPaused : 0x1C9300, 0x12C; // WILL HAVE PROBLEMS!
	byte EN_IsPaused : 0x1C9304; // 0 = Unpaused. 1 = Paused. 
	int EN_FMVframe : 0x7D2A40, 0x004, 0x15C;


	// SPANISH!!
	byte ES_LEVEL_ID : 0x1C33C0;
	byte ES_PATH_ID : 0x1C33C2;
	byte ES_CAM_ID : 0x1C33C4;
	byte ES_FMV_ID : 0x1C33D2;
	short ES_abeY : 0x1C1EF8, 0xBE; // FMV_ID + 14DA
	int ES_gnFrame : 0x1C1F14;
	byte ES_IsPaused : 0x1C9694; // 0 = Unpaused. 1 = Paused. 
	
	
	// FRENCH (Updated by Askew, 2 June 2020)
	byte FR_LEVEL_ID : 0x1C3908; // 1C3908
	byte FR_PATH_ID : 0x1C3914; // 1C390A
	byte FR_CAM_ID : 0x1C3916; // 1C390C
	byte FR_FMV_ID : 0x1C3910; // 1C3910
	short FR_abeY : 0x1C2440, 0xBE; // 1C4DEA 14DA
	int FR_gnFrame : 0x1C245C;
	byte FR_IsPaused : 0x1C9BDC; // NOT TESTED YET!! | 0 = Unpaused. 1 = Paused.


	// FRENCH STEAM!!	
	byte FRs_LEVEL_ID : 0x1C3908; // 1C3908
	byte FRs_PATH_ID : 0x1C390A; // 1C390A
	byte FRs_CAM_ID : 0x1C390C; // 1C390C
	byte FRs_FMV_ID : 0x1C391A; // 1C3910
	short FRs_abeY : 0x1C2440, 0xBE; // 1C4DEA 14DA
	int FRs_gnFrame : 0x1C245C;
	byte FRs_IsPaused : 0x1C9BDC; // 0 = Unpaused. 1 = Paused. 


	// GERMAN
	byte DE_LEVEL_ID : 0x1C3A08;
	byte DE_PATH_ID : 0x1C3A0A;
	byte DE_CAM_ID : 0x1C3A0C;
	byte DE_FMV_ID : 0x1C3A1A;
	short DE_abeY : 0x1C2540, 0xBE; // FMV_ID + 14DA
	int DE_gnFrame : 0x1C255C;
	byte DE_IsPaused : 0x1C9CDC; // 0 = Unpaused. 1 = Paused. 


	// ITALIAN
	byte IT_LEVEL_ID : 0x1C377A;
	byte IT_PATH_ID : 0x1C377C;
	byte IT_CAM_ID : 0x1C377E;
	byte IT_FMV_ID : 0x1C3782;
	short IT_abeY : 0x1C22A8, 0xBE; // FMV_ID + 14DA
	int IT_gnFrame : 0x1C22C4; // 0 = Unpaused. 1 = Paused. 
	byte IT_IsPaused : 0x1C9A44; // 0 = Unpaused. 1 = Paused. 
}

startup
{
	settings.Add("Version", true, "Official Version 1.7.1 (July 4nd 2020) - LegnaX#7777 - CHANGELOG");
	settings.SetToolTip("Version", "-- CHANGELOG --\n- Added Individual levels! They will probably be broken though... let's hope they aren't!\n- Fixed a glitch with the autosplitter remembering the Loadless time from previous attempts.\n- Removed a leftover debug thing on Tunnel 1 split that was locking the timer in place.");
	
	settings.Add("version2", true, "Use Game Time as timer (will be Loadless).");
	settings.Add("version3", true, "Add additional Real Time timer on layout.");
	
	settings.Add("nag", true, "REFRESH RATE OF THE AUTOSPLITTER");
	settings.SetToolTip("nag", "Sets the autosplitter to refresh 30 times per second. Leaving all options unckeched will set refresh rate to 30 by default anyway.");
	
	settings.Add("10Rate", false, "10 refreshes per second (potato mode ACTIVATED)", "nag");
	settings.SetToolTip("10Rate", "Sets the autosplitter to refresh 10 times per second. Perfect for potato computers. Inaccurate times may happen. Suggested by mouzedrift.");
	
	settings.Add("30Rate", true, "30 refreshes per second (DEFAULT)", "nag");
	settings.SetToolTip("30Rate", "Sets the autosplitter to refresh 30 times per second. Leaving all options unckeched will set refresh rate to 30 by default anyway.");
	
	settings.Add("40Rate", false, "40 refreshes per second", "nag");
	settings.SetToolTip("40Rate", "Sets the autosplitter to refresh 40 times per second. Should help getting a bit more accurate times.");
	
	settings.Add("50Rate", false, "50 refreshes per second", "nag");
	settings.SetToolTip("50Rate", "Sets the autosplitter to refresh 50 times per second. Should help getting very accurate times.");
	
	settings.Add("100Rate", false, "100 refreshes per second", "nag");
	settings.SetToolTip("100Rate", "Sets the autosplitter to refresh 100 times per second. R U crazy or wut m8?");	
	
	settings.Add("UsingIL", false, "INDIVIDUAL LEVELS - Check this to activate");
	settings.SetToolTip("UsingIL", "Leave this option unchecked to not use.\nAutosplit will priorize autosplit category over Individual Levels, so make sure you disable AUTOSPLIT GAME CATEGORY if you want to use ILs!\nYou need the splits file for the IL splits to work correctly. \nExcept for Mines, you need to use the prepared Save Files in order for the autosplit to start.\nDOWNLOAD THEM AT http://tiny.cc/Splits2 !\n-> INDIVIDUAL LEVEL LIST <-\n- Mines (start a new game)\n- Necrum (3 save files)\n- Mudomo\n- Mudanchee\n- FeeCo (3 save files)\n- Bonewerkz\n- Slig Barracks\n- Hub 1\n- Hub 2\n- Hub 3\n- Soulstorm Boiler");
	
	
	settings.Add("JustLines", true, "------------------------------------------------------");
	
	settings.Add("SPLITSinfo", true, "AUTOSPLITS. Uncheck this for just Loadess Feature.");		
	
	settings.Add("minesSplit", true, "Mines - Splits when Abe leaves Mines Boiler.");
	settings.Add("minesExtended", false, "One split each Tunnel (put mouse here for more info).", "minesSplit");
	settings.SetToolTip("minesExtended", "This will make the autosplit to split on the following points:\n- Tunnel 1.\n- Tunnel 2.\n- Slogs.\n- Tunnel 3.\n- Tunnel 4.\n- Tunnel 5.\n- Tunnel 6.\n- Tunnel 7.\n- Mines (original).\n\nIt doesn't matter the order or if you skip a Tunnel (for example on Any%).");
	
	settings.Add("necrumSplit", true, "Necrum - Ending Necrum by entering Mudomo | Mudanchee | FeeCo.");
	settings.Add("necrumExtended", false, "One split each part of Necrum (put mouse here for more info).", "necrumSplit");
	settings.SetToolTip("necrumExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Handstones.\n- Fleeches Entry.\n- Fleeches Trial 1.\n- Fleeches Trial 2.\n- Fleeches Trial 3.\n- Fleeches Trial 4.\n- Fleeches Trial 5.\n- Necrum (original).\n\nIt doesn't matter the order or if you skip half of it (for example on Any%).\nYou can also go to Mudomo or Mudanchee. Any order.");
	
	settings.Add("mudomoSplit", true, "Mudomo - Ending Mudomo by entering Mudanchee or FeeCo.");	
	settings.Add("mudomoExtended", false, "One split each part of Mudomo (put mouse here for more info).", "mudomoSplit");
	settings.SetToolTip("mudomoExtended", "This will make the autosplit to split on the following points:\n- Entry 1.\n- Entry 2.\n- Entry 3.\n- Trial 1.\n- Trial 2.\n- Trial 3.\n- Trial 4.\n- Trial 5.\n- Trial 6.\n- Vaults.\n- Mudomo (original).\n\nIt doesn't matter the trial order.\nYou can also go to Mudanchee or FeeCo after this. Any order.");
	
	settings.Add("mudancheeSplit", true, "Mudanchee - Ending Mudanchee by entering Mudomo or FeeCo.");
	settings.Add("mudancheeExtended", false, "One split each part of Mudanchee (put mouse here for more info).", "mudancheeSplit");
	settings.SetToolTip("mudancheeExtended", "This will make the autosplit to split on the following points:\n- Entry 1.\n- Entry 2.\n- Entry 3.\n- Trial 1.\n- Trial 2.\n- Trial 3.\n- Trial 4.\n- Trial 5.\n- Trial 6.\n- Vaults.\n- Mudanchee (original).\n\nIt doesn't matter the trial order.\nYou can also go to Mudomo or FeeCo after this. Any order.");
	
	settings.Add("feecoSplit", true, "FeeCo - Ending FeeCo by entering Barracks, Bonewerkz or Brewery.");	
	settings.Add("feecoExtended", false, "One split each part of FeeCo (put mouse here for more info).", "feecoSplit");
	settings.SetToolTip("feecoExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Terminal 1.\n- Terminal 2.\n- Main Terminal.\n- Terminal 3 (before Slig Barracks), Terminal 4 or Terminal 5.\n- FeeCo (original).\n\nIt doesn't matter the level order or where you go after the Main Terminal (Bonewerkz, Slig Barracks or Soulstorm Brewery).\n");
	
	settings.Add("barracksSplit", true, "Slig Barracks - Ending Slig Barracks by returning to FeeCo.");	
	settings.Add("barracksExtended", false, "One split each part of Barracks (put mouse here for more info).", "barracksSplit");
	settings.SetToolTip("barracksExtended", "This will make the autosplit to split on the following points:\n- Block 0.\n- Block 1.\n- Block 2.\n- Block 3.\n- Block 4.\n- Dripik.\n- Slig Barracks (original).\n\nIt doesn't matter the Block order.");
	
	settings.Add("bonewerkzSplit", true, "Bonewerkz - Ending Bonewerkz by returning to FeeCo.");	
	settings.Add("bonewerkzExtended", false, "One split each part of Bonewerkz (put mouse here for more info).", "bonewerkzSplit");
	settings.SetToolTip("bonewerkzExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Annex 1.\n- Annex 2.\n- Annex 3.\n- Annex 4.\n- Annex 5.\n- Annex 6.\n- Annex 7.\n- Annex 8.\n- Phleg.\n- Bonewerkz (original).");
	
	settings.Add("feeco2Split", true, "FeeCo2 - Put mouse here for details.");
	settings.SetToolTip("feeco2Split", "This basically makes the autosplit to split if the runner enters on Bonewerkz after completing Slig Barracks,\nor if the player goes to Slig Barracks after completing Bonewerkz.");
	
	settings.Add("officeSplit", true, "Executive Office - Ending Executive Office by returning to FeeCo.");
	settings.Add("officeExtended", false, "One split each part of the Office (put mouse here for more info).", "officeSplit");
	settings.SetToolTip("officeExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Aslik.\n- Executive Office (original).");
	
	settings.Add("feeco3Split", true, "FeeCo 3 - After doing Executive Office - Entering brewery.");	
	settings.SetToolTip("feeco3Split", "This basically makes the autosplit to split if the runner completes Terminal 5,\njust before entering on the train to Soulstorm Brewery.");
	
	settings.Add("hub1Split", true, "Soulstorm Brewery Hub 1 - Ending Hub 1 and entering Hub 2.");
	settings.Add("hub1Extended", false, "One split for each Zulag (put mouse here for more info).", "hub1Split");
	settings.SetToolTip("hub1Extended", "This will make the autosplit to split on the following points:\n- Entry.\n- Zulag 1.\n- Zulag 2.\n- Zulag 3.\n- Zulag 4.\n- Zulag 5.\n- Hub 1 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("hub2Split", true, "Soulstorm Brewery Hub 2 - Ending Hub 2 and entering Hub 3.");
	settings.Add("hub2Extended", false, "One split for each Zulag (put mouse here for more info).", "hub2Split");
	settings.SetToolTip("hub2Extended", "This will make the autosplit to split on the following points:\n- Zulag 6.\n- Zulag 7.\n- Zulag 8.\n- Zulag 9.\n- Zulag 10.\n- Hub 2 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("hub3Split", true, "Soulstorm Brewery Hub 3 - Ending Hub 3 and entering the Boiler.");
	settings.Add("hub3Extended", false, "One split for each Zulag (put mouse here for more info).", "hub3Split");
	settings.SetToolTip("hub3Extended", "This will make the autosplit to split on the following points:\n- Zulag 11.\n- Zulag 12.\n- Zulag 13.\n- Zulag 14.\n- Hub 3 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("boilerSplit", true, "Zulag 15 - Boiler (End game) - Splits when Abe enters on any portal.");
}

init
{	
	version = "1.7.1";
	
	vars.REAL_TIME_AND_LOADLESS_TIME = "(Use 2 rows) Both timers\nwill be displayed here";
	vars.REAL_TIME = "Real time will be displayed here";
	vars.LOADLESS_TIME = "Loadless time will be displayed here";
	vars.LOG_LastSplit = "No split yet. Game version: " + version;
	vars.LOG_LocationLastSplit = "The first split will save the values of the game.";
	vars.LOG_CurrentPositionAndTime = "Enter on the game first through the Start menu ;)";
	vars.LOG_CurrentTime = "[00:00:00.000]";
	vars.LOG_ModuleMemory = modules.First().ModuleMemorySize;
	
	vars.preSplitNecrum = false;
	vars.preSplitMudomo = false;
	vars.preSplitMudanchee = false;
	
	vars.ResetStatus = 0;
	vars.SplitFeeco2 = false;
	vars.ResetAllowed = true;
	vars.countToMud = 0; // We avoid doble split on Mudomo / Mudanchee splits.
	vars.FMVNecrum = 0;
	vars.PrePhlegSplit = false; // This variable checks if Phleg made it to the Glukkon intercom at least once. Prevents a wrong split if the player dies at Phleg on the last tier of Slogs.
	vars.ILWaitTimer = false; // True = the timer will not advance, not even on pause menu (obv).
	vars.ILWaitFrame = -1;
	vars.ILid = -1;
	vars.fps = 30.3; // FPS of the game.
	
	// 0 - 13 main splits. 14 - 21 Mines. 22 - 29 Necrum. 30 - 39 Mudomo. 40 - 50 Mudanchee. 51 - 55 FeeCo. 56 - 62 Barracks. 63 - 72 Bonewerkz.
	bool[] splitsTemp = new bool[95];
	vars.splits = splitsTemp;
	vars.splitsFeeCoAgain = vars.splits[4];
	vars.StartgnFrame = -1;	
	vars.Epoch = 0;
	vars.PauseStartTime = -1;	
	vars.MillisecondsPaused = 0;
	vars.AccumulatedPenaltyTime = 0;
	vars.LangDetected = "Nothing yet";
} 

start
{	
	bool areWeStartingOrNot = false;
	vars.ILid = -1; // Restarting IL id
	vars.ILWaitTimer = false;
	// Refresh rate
	if (settings["100Rate"]){
		refreshRate = 100;
	} else if (settings["50Rate"]){
		refreshRate = 50;
	} else if (settings["40Rate"]){
		refreshRate = 40;
	} else if (settings["10Rate"]){
		refreshRate = 10;
	} else {
		refreshRate = 30;	
	}
	
	
	// MINES (used for main splits OR ILs)
	int ol = 0;
	int	op = 0; // OLD PATH
	int oc = 13;
	int cl = 1;
	int	cp = 0; // CURRENT PATH
	int cc = 4;
	if (old.EN_LEVEL_ID == ol && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_CAM_ID == cc){
		vars.StartgnFrame = current.EN_gnFrame;
		vars.LangDetected = "English";
		areWeStartingOrNot = true;
	}
	
	if (old.ES_LEVEL_ID == ol && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_CAM_ID == cc){
		vars.StartgnFrame = current.ES_gnFrame;
		vars.LangDetected = "Spanish";
		areWeStartingOrNot = true;
	}
	
	if (old.FR_LEVEL_ID == ol && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_CAM_ID == cc){
		vars.StartgnFrame = current.FR_gnFrame;
		vars.LangDetected = "French";
		areWeStartingOrNot = true;
	}
	
	if (old.FRs_LEVEL_ID == ol && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_CAM_ID == cc){
		vars.StartgnFrame = current.FRs_gnFrame;
		vars.LangDetected = "French Steam";
		areWeStartingOrNot = true;
	}
	
	if (old.DE_LEVEL_ID == ol && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_CAM_ID == cc){
		vars.StartgnFrame = current.DE_gnFrame;
		vars.LangDetected = "German";
		areWeStartingOrNot = true;
	}
	
	if (old.IT_LEVEL_ID == ol && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_CAM_ID == cc){
		vars.StartgnFrame = current.IT_gnFrame;
		vars.LangDetected = "Italian";
		areWeStartingOrNot = true;
	}
	
	if (areWeStartingOrNot && settings["UsingIL"]){
		vars.ILid = 0; // Mines IL
	}

	// --------------------------------------------------------------------------------------------------------------------
	
	if (settings["UsingIL"]){
		
	// NECRUM (used for ILs)
		ol = 1; // OLD LEVEL
		op = 6; // OLD PATH
		oc = 7; // OLD CAMERA
		// cl = 2; // CURRENT LEVEL
		// cp = 2; // CURRENT PATH
		// cc = 1; // CURRENT CAMERA
		int of = 0;
		int cf = 232;
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && old.EN_FMV_ID == of && current.EN_FMV_ID == cf){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && old.ES_FMV_ID == of && current.ES_FMV_ID == cf){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && old.FR_FMV_ID == of && current.FR_FMV_ID == cf){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && old.FRs_FMV_ID == of && current.FRs_FMV_ID == cf){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && old.DE_FMV_ID == of && current.DE_FMV_ID == cf){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && old.IT_FMV_ID == of && current.IT_FMV_ID == cf){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 1; // Necrum IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// MUDOMO (used for ILs)
		ol = 2; // OLD LEVEL
		op = 5; // OLD PATH
		oc = 9; // OLD CAMERA
		cl = 3; // CURRENT LEVEL
		cp = 1; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 2; // Mudomo IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// MUDANCHEE (used for ILs)
		ol = 2; // OLD LEVEL
		op = 5; // OLD PATH
		oc = 1; // OLD CAMERA
		cl = 4; // CURRENT LEVEL
		cp = 6; // CURRENT PATH
		cc = 23; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 3; // Mudanchee IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// FEECO (used for ILs)
		ol = 2; // OLD LEVEL
		op = 3; // OLD PATH
		oc = 18; // OLD CAMERA
		cl = 5; // CURRENT LEVEL
		cp = 1; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 4; // FeeCo IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// BONEWERKZ (used for ILs)
		ol = 5; // OLD LEVEL
		op = 4; // OLD PATH
		oc = 14; // OLD CAMERA
		cl = 8; // CURRENT LEVEL
		cp = 1; // CURRENT PATH
		cc = 18; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 5; // Bonewerkz IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// SLIG BARRACKS (used for ILs)
		ol = 5; // OLD LEVEL
		op = 3; // OLD PATH
		oc = 14; // OLD CAMERA
		cl = 6; // CURRENT LEVEL
		cp = 1; // CURRENT PATH
		cc = 3; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 6; // Slig Barracks IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// HUB 1 (used for ILs)
		ol = 5; // OLD LEVEL
		op = 5; // OLD PATH
		oc = 14; // OLD CAMERA
		cl = 9; // CURRENT LEVEL
		cp = 16; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 7; // Hub 1 IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// HUB 2 (used for ILs)
		ol = 9; // OLD LEVEL
		op = 23; // OLD PATH
		oc = 1; // OLD CAMERA
		cl = 9; // CURRENT LEVEL
		cp = 24; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 8; // Hub 2 IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// HUB 3 (used for ILs)
		ol = 9; // OLD LEVEL
		op = 24; // OLD PATH
		oc = 1; // OLD CAMERA
		cl = 9; // CURRENT LEVEL
		cp = 25; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 9; // Hub 3 IL
		}

		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// SOULSTORM BOILER (used for ILs)
		ol = 9; // OLD LEVEL
		op = 25; // OLD PATH
		oc = 1; // OLD CAMERA
		cl = 10; // CURRENT LEVEL
		cp = 1; // CURRENT PATH
		cc = 1; // CURRENT CAMERA
		if (old.EN_LEVEL_ID == ol && old.EN_PATH_ID == op && old.EN_CAM_ID == oc && current.EN_LEVEL_ID == cl && current.EN_PATH_ID == cp && current.EN_CAM_ID == cc){
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}
		
		if (old.ES_LEVEL_ID == ol && old.ES_PATH_ID == op && old.ES_CAM_ID == oc && current.ES_LEVEL_ID == cl && current.ES_PATH_ID == cp && current.ES_CAM_ID == cc){
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}
		
		if (old.FR_LEVEL_ID == ol && old.FR_PATH_ID == op && old.FR_CAM_ID == oc && current.FR_LEVEL_ID == cl && current.FR_PATH_ID == cp && current.FR_CAM_ID == cc){
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}
		
		if (old.FRs_LEVEL_ID == ol && old.FRs_PATH_ID == op && old.FRs_CAM_ID == oc && current.FRs_LEVEL_ID == cl && current.FRs_PATH_ID == cp && current.FRs_CAM_ID == cc){
			vars.StartgnFrame = current.FRs_gnFrame;
			vars.LangDetected = "French Steam";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}
		
		if (old.DE_LEVEL_ID == ol && old.DE_PATH_ID == op && old.DE_CAM_ID == oc && current.DE_LEVEL_ID == cl && current.DE_PATH_ID == cp && current.DE_CAM_ID == cc){
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}
		
		if (old.IT_LEVEL_ID == ol && old.IT_PATH_ID == op && old.IT_CAM_ID == oc && current.IT_LEVEL_ID == cl && current.IT_PATH_ID == cp && current.IT_CAM_ID == cc){
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
			areWeStartingOrNot = true;
			vars.ILid = 10; // Soulstorm Boiler IL
		}

		// --------------------------------------------------------------------------------------------------------------------
	}
	
	
	if (areWeStartingOrNot){
		vars.ResetStatus = 0;		
		vars.Epoch = 0;
		vars.PauseStartTime = -1;	
		vars.MillisecondsPaused = 0;
		vars.AccumulatedPenaltyTime = 0;	
		areWeStartingOrNot = false;	
		return true;
	}
}

exit
{
}

reset
{
	if (vars.ResetStatus == 2){ // Start on main menu
		vars.ResetStatus = 0;		
		vars.StartgnFrame = -1;	
		vars.Epoch = 0;
		vars.PauseStartTime = -1;	
		vars.MillisecondsPaused = 0;
		vars.AccumulatedPenaltyTime = 0;
		vars.LOADLESS_TIME = "00:00.000";
		vars.REAL_TIME = "00:00.000";		
		vars.ILid = -1; // Restarting IL id
		vars.ILWaitTimer = false;
		return true;		
	} else {
		return false;
	}
}

isLoading
{	
	long c_gnFrame = -1;
	long o_gnFrame = -1;
	int IsPaused = -1;
	
	// Refresh rate
	if (settings["100Rate"]){
		refreshRate = 100;
	} else if (settings["50Rate"]){
		refreshRate = 50;
	} else if (settings["40Rate"]){
		refreshRate = 40;
	} else if (settings["10Rate"]){
		refreshRate = 10;
	} else {
		refreshRate = 30;	
	}
	
	if (vars.LangDetected == "Nothing yet"){
		return true;
	} else {
		if (vars.LangDetected == "English") {
			c_gnFrame = current.EN_gnFrame;
			o_gnFrame = old.EN_gnFrame;
			IsPaused = current.EN_IsPaused;			
		} else if (vars.LangDetected == "Spanish") {
			c_gnFrame = current.ES_gnFrame;
			o_gnFrame = old.ES_gnFrame;
			IsPaused = current.ES_IsPaused;			
		} else if (vars.LangDetected == "French") {
			c_gnFrame = current.FR_gnFrame;
			o_gnFrame = old.FR_gnFrame;
			IsPaused = current.FR_IsPaused;			
		} else if (vars.LangDetected == "French Steam") {
			c_gnFrame = current.FRs_gnFrame;
			o_gnFrame = old.FRs_gnFrame;
			IsPaused = current.FRs_IsPaused;			
		} else if (vars.LangDetected == "Italian") {
			c_gnFrame = current.IT_gnFrame;
			o_gnFrame = old.IT_gnFrame;
			IsPaused = current.IT_IsPaused;			
		} else if (vars.LangDetected == "German") {
			c_gnFrame = current.DE_gnFrame;
			o_gnFrame = old.DE_gnFrame;
			IsPaused = current.DE_IsPaused;			
		} else { // This should NEVER happen
			c_gnFrame = current.EN_gnFrame;
			o_gnFrame = old.EN_gnFrame;
			IsPaused = current.EN_IsPaused;
		}
		
		if (vars.ILWaitTimer){
			if (vars.ILWaitFrame == -1){
				vars.ILWaitFrame = c_gnFrame;
			}
			return true;
		} else {
			if (o_gnFrame > c_gnFrame){ // If we QuikLoaded, died or Restart Path...
				vars.AccumulatedPenaltyTime = vars.AccumulatedPenaltyTime + ((o_gnFrame - vars.StartgnFrame) * 1000 / vars.fps);
				vars.AccumulatedPenaltyTime = Convert.ToInt32(vars.AccumulatedPenaltyTime);
				vars.StartgnFrame = c_gnFrame - 1;
			}
			
			if (vars.ILWaitFrame > -1){
				vars.AccumulatedPenaltyTime = vars.AccumulatedPenaltyTime + ((vars.ILWaitFrame - vars.StartgnFrame) * 1000 / vars.fps);
				vars.AccumulatedPenaltyTime = Convert.ToInt32(vars.AccumulatedPenaltyTime);
				vars.StartgnFrame = c_gnFrame - 1;	
				vars.ILWaitFrame = -1;				
			}
			
			if (o_gnFrame + 60 < c_gnFrame) { // If we used the skip level code, we will fix the frames.
				vars.StartgnFrame = vars.StartgnFrame + (c_gnFrame - o_gnFrame);
			}
			
			if (IsPaused == 1 && vars.ILWaitTimer == false){ // if the game is paused...
				vars.Epoch = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
				if (vars.PauseStartTime == -1){ // Paused for the first time.
					vars.PauseStartTime = vars.Epoch;
				}		
				
			} else {				
				if (vars.PauseStartTime > 0){ // Unpaused for the first time.
					vars.MillisecondsPaused = vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime);
					vars.PauseStartTime = -1;
				}			
			}
			
			vars.CurrentFrames = c_gnFrame - vars.StartgnFrame;
			
			 if (c_gnFrame > 0) {
				if (IsPaused == 1){ // if the game is paused...
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((c_gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.AccumulatedPenaltyTime).ToString(@"mm\:ss\.fff");
					vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
					if ((TimeSpan.FromMilliseconds(((c_gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.AccumulatedPenaltyTime).TotalMilliseconds) < (timer.CurrentTime.GameTime.Value.TotalSeconds * 1000)){ // Is the ingame timer bigger than the gnFrame timer? We will pause it this frame.
						return true;
					} else {
						return false;
					}
				} else {
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((c_gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.AccumulatedPenaltyTime).ToString(@"mm\:ss\.fff");
					vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
					if ((TimeSpan.FromMilliseconds(((c_gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.AccumulatedPenaltyTime).TotalMilliseconds) < (timer.CurrentTime.GameTime.Value.TotalSeconds * 1000)){ // Is the ingame timer bigger than the gnFrame timer? We will pause it this frame.
						return true;
					} else {
						return false;
					}
				}
			} else {
				return true; // :shrug: 
			}
		}
	}
	
}


split
{		
	int o_LEVEL_ID = -1;
	int c_LEVEL_ID = -1;
	int o_PATH_ID = -1;
	int c_PATH_ID = -1;
	int o_CAM_ID = -1;
	int c_CAM_ID = -1;
	int o_FMV_ID = -1;
	int c_FMV_ID = -1;
	int abeY = -1;
	vars.LOG_CurrentTime = "[" + System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "") + "]";
	if (System.Convert.ToString(timer.CurrentTime.RealTime).Contains("00:00:00")) { // Used for resetting the main variables of the program if the timer resets. 		
		vars.SplitFeeco2 = false;
		vars.preSplitNecrum = false;
		vars.preSplitMudomo = false;
		vars.preSplitMudanchee = false;
		vars.splitsFeeCoAgain = false;		
		vars.PrePhlegSplit = false; // This variable checks if Phleg made it to the Glukkon intercom at least once. Prevents a wrong split if the player dies at Phleg on the last tier of Slogs.
	
		bool[] splitsTemp = new bool[95];	
		vars.splits = splitsTemp;	
		vars.countToMud = 0;
	} else { 
	
		if (vars.LangDetected == "Nothing yet"){
			
		} else if (settings["SPLITSinfo"] || vars.ILid >= 0){
			// We set the values to the detected language :)
			if (vars.LangDetected == "English"){
				o_LEVEL_ID = old.EN_LEVEL_ID;
				c_LEVEL_ID = current.EN_LEVEL_ID;
				o_PATH_ID = old.EN_PATH_ID;
				c_PATH_ID = current.EN_PATH_ID;
				o_CAM_ID = old.EN_CAM_ID;
				c_CAM_ID = current.EN_CAM_ID;
				o_FMV_ID = old.EN_FMV_ID;
				c_FMV_ID = current.EN_FMV_ID;
				abeY = current.EN_abeY;
			} else if (vars.LangDetected == "Spanish"){
				o_LEVEL_ID = old.ES_LEVEL_ID;
				c_LEVEL_ID = current.ES_LEVEL_ID;
				o_PATH_ID = old.ES_PATH_ID;
				c_PATH_ID = current.ES_PATH_ID;
				o_CAM_ID = old.ES_CAM_ID;
				c_CAM_ID = current.ES_CAM_ID;
				o_FMV_ID = old.ES_FMV_ID;
				c_FMV_ID = current.ES_FMV_ID;
				abeY = current.ES_abeY;
			} else if (vars.LangDetected == "French"){
				o_LEVEL_ID = old.FR_LEVEL_ID;
				c_LEVEL_ID = current.FR_LEVEL_ID;
				o_PATH_ID = old.FR_PATH_ID;
				c_PATH_ID = current.FR_PATH_ID;
				o_CAM_ID = old.FR_CAM_ID;
				c_CAM_ID = current.FR_CAM_ID;
				o_FMV_ID = old.FR_FMV_ID;
				c_FMV_ID = current.FR_FMV_ID;
				abeY = current.FR_abeY;
			} else if (vars.LangDetected == "French Steam"){
				o_LEVEL_ID = old.FRs_LEVEL_ID;
				c_LEVEL_ID = current.FRs_LEVEL_ID;
				o_PATH_ID = old.FRs_PATH_ID;
				c_PATH_ID = current.FRs_PATH_ID;
				o_CAM_ID = old.FRs_CAM_ID;
				c_CAM_ID = current.FRs_CAM_ID;
				o_FMV_ID = old.FRs_FMV_ID;
				c_FMV_ID = current.FRs_FMV_ID;
				abeY = current.FRs_abeY;
			} else if (vars.LangDetected == "German"){
				o_LEVEL_ID = old.DE_LEVEL_ID;
				c_LEVEL_ID = current.DE_LEVEL_ID;
				o_PATH_ID = old.DE_PATH_ID;
				c_PATH_ID = current.DE_PATH_ID;
				o_CAM_ID = old.DE_CAM_ID;
				c_CAM_ID = current.DE_CAM_ID;
				o_FMV_ID = old.DE_FMV_ID;
				c_FMV_ID = current.DE_FMV_ID;
				abeY = current.DE_abeY;
			} else if (vars.LangDetected == "Italian"){
				o_LEVEL_ID = old.IT_LEVEL_ID;
				c_LEVEL_ID = current.IT_LEVEL_ID;
				o_PATH_ID = old.IT_PATH_ID;
				c_PATH_ID = current.IT_PATH_ID;
				o_CAM_ID = old.IT_CAM_ID;
				c_CAM_ID = current.IT_CAM_ID;
				o_FMV_ID = old.IT_FMV_ID;
				c_FMV_ID = current.IT_FMV_ID;
				abeY = current.IT_abeY;
			}
			
							
			// Mines (LEVEL_ID 1)
				if (settings["minesSplit"] || vars.ILid == 0) {		
					if (c_LEVEL_ID == 1) { // If we are in Mines...		
						if (settings["minesExtended"] || vars.ILid == 0){ // 14 - 21
						// Tunnel 1 SPLIT
							if (c_FMV_ID == 71 && vars.splits[14] != true) {
								vars.splits[14] = true;
								vars.LOG_LastSplit = "Tunnel 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 2 SPLIT
							if (o_PATH_ID == 2 && c_PATH_ID == 3 && vars.splits[15] != true) {
								vars.splits[15] = true;
								vars.LOG_LastSplit = "Tunnel 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Slog SPLIT
							if (o_PATH_ID == 3 && c_PATH_ID == 4 && vars.splits[16] != true) {
								vars.splits[16] = true;
								vars.LOG_LastSplit = "Slogs. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 3 SPLIT
							if (c_FMV_ID == 32 && vars.splits[17] != true) {
								vars.splits[17] = true;
								vars.LOG_LastSplit = "Tunnel 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 4 SPLIT
							if (c_FMV_ID == 17 && vars.splits[18] != true) {
								vars.splits[18] = true;
								vars.LOG_LastSplit = "Tunnel 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 5 SPLIT
							if (c_FMV_ID == 5 && vars.splits[19] != true) {
								vars.splits[19] = true;
								vars.LOG_LastSplit = "Tunnel 5. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 6 SPLIT
							if (c_FMV_ID == 30 && vars.splits[20] != true) {
								vars.splits[20] = true;
								vars.LOG_LastSplit = "Tunnel 6. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 7 SPLIT
							if (c_FMV_ID == 28 && vars.splits[21] != true) {
								vars.splits[21] = true;
								vars.LOG_LastSplit = "Tunnel 7. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
					// MINES SPLIT
						if (c_FMV_ID == 232 && vars.splits[0] != true) {
							vars.splits[0] = true;
							vars.LOG_LastSplit = "Mines, last split. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
				}
			//////////////////////////////

			// Mudomo (LEVEL_ID 3, Vaults is LEVEL_ID 11)
				if (settings["mudomoSplit"] || vars.ILid == 2){
					if (c_LEVEL_ID == 3 && (settings["mudomoExtended"] || vars.ILid == 2)){ // 30 - 39
					
					// Mudomo Entry 1
						if (c_FMV_ID == 29 && vars.splits[30] != true) {
								vars.splits[30] = true;
								vars.LOG_LastSplit = "Mudomo Entry 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Entry 2
						if (c_FMV_ID == 33 && vars.splits[31] != true) {
								vars.splits[31] = true;
								vars.LOG_LastSplit = "Mudomo Entry 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Entry 3
						if (c_PATH_ID == 8 && vars.splits[32] != true) {
								vars.splits[32] = true;
								vars.LOG_LastSplit = "Mudomo Entry 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 1
						if (c_FMV_ID == 13 && vars.splits[33] != true) {
								vars.splits[33] = true;
								vars.LOG_LastSplit = "Mudomo Trial 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 2
						if (c_FMV_ID == 17 && vars.splits[34] != true) {
								vars.splits[34] = true;
								vars.LOG_LastSplit = "Mudomo Trial 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 3
						if (c_FMV_ID == 15 && vars.splits[35] != true) {
								vars.splits[35] = true;
								vars.LOG_LastSplit = "Mudomo Trial 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 4
						if (c_FMV_ID == 9 && vars.splits[36] != true) {
								vars.splits[36] = true;
								vars.LOG_LastSplit = "Mudomo Trial 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 5
						if (c_FMV_ID == 6 && vars.splits[37] != true) {
								vars.splits[37] = true;
								vars.LOG_LastSplit = "Mudomo Trial 5. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 6
						if (c_FMV_ID == 31 && vars.splits[38] != true) {
								vars.splits[38] = true;
								vars.LOG_LastSplit = "Mudomo Trial 6. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					}
					
				// Mudomo Vaults
					if (o_LEVEL_ID == 11 && c_LEVEL_ID == 2 && settings["mudomoExtended"] && vars.splits[39] != true) {
						vars.splits[39] = true;
						vars.LOG_LastSplit = "Mudomo Vaults. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
					
				// PRE-Mudomo split
					if (c_LEVEL_ID == 2 && c_PATH_ID == 5 && c_CAM_ID == 1 && c_FMV_ID != 8){ 
						vars.preSplitMudomo = true;
					}
				
				// Mudomo split
					if (vars.countToMud >= 1000 && ((c_LEVEL_ID == 4 && c_PATH_ID == 6 && c_CAM_ID == 23 && c_FMV_ID == 34 && vars.preSplitMudomo) || (o_PATH_ID == 3 && c_PATH_ID == 1 && c_LEVEL_ID == 5)) && vars.splits[2] != true) { 
						vars.splits[2] = true;
						vars.LOG_LastSplit = "Mudomo. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////

			// Mudanchee (LEVEL_ID 4)
				if (settings["mudancheeSplit"] || vars.ILid == 3){
					if (settings["mudancheeExtended"] || vars.ILid == 3){ // 40 - 50
						if (c_LEVEL_ID == 4){
						// Mudanchee Entry 1
							if (c_FMV_ID == 25 && vars.splits[40] != true) {
								vars.splits[40] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 2
							if (c_FMV_ID == 30 && vars.splits[41] != true) {
								vars.splits[41] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 3
							if (c_FMV_ID == 28 && vars.splits[42] != true) {
								vars.splits[42] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 4
							if (c_PATH_ID == 7 && o_CAM_ID == 2 && c_CAM_ID == 4 && vars.splits[43] != true) {
								vars.splits[43] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 1
							if (c_FMV_ID == 2 && vars.splits[44] != true) {
								vars.splits[44] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 2
							if (c_FMV_ID == 6 && vars.splits[45] != true) {
								vars.splits[45] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 3
							if (c_FMV_ID == 23 && vars.splits[46] != true) {
								vars.splits[46] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 4
							if (c_FMV_ID == 14 && vars.splits[47] != true) {
								vars.splits[47] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 5
							if (c_FMV_ID == 3 && vars.splits[48] != true) {
								vars.splits[48] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 5. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 6
							if (c_FMV_ID == 11 && vars.splits[49] != true) {
								vars.splits[49] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 6. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
					// Mudanchee Vaults
						if (o_LEVEL_ID == 7 && c_LEVEL_ID == 2 && vars.splits[50] != true) { 
							vars.splits[50] = true;
							vars.LOG_LastSplit = "Mudanchee Vaults. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}

					if (c_LEVEL_ID == 2 && c_PATH_ID == 5 && c_CAM_ID == 9 && c_FMV_ID != 8){ // Pre-Mudanchee split
						vars.preSplitMudanchee = true;
					}
					
					if (vars.countToMud >= 1000 && ((c_LEVEL_ID == 3 && c_PATH_ID == 1 && c_CAM_ID == 1 && c_FMV_ID == 25 && vars.preSplitMudanchee) || (o_PATH_ID == 3 && c_PATH_ID == 1 && c_LEVEL_ID == 5)) && vars.splits[3] != true) { // Mudanchee Split: we are in Mudomo or Wheel to FeeCo. 
						vars.splits[3] = true;
						vars.LOG_LastSplit = "Mudanchee. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////
				
			// Necrum (LEVEL_ID 2)
				if (settings["necrumSplit"] || vars.ILid == 1) {
					if (c_LEVEL_ID == 2){
						if (settings["necrumExtended"] || vars.ILid == 1) { // 22 - 29
						// Necrum Entry SPLIT
							if (c_FMV_ID == 10 && vars.splits[22] != true) {
								vars.splits[22] = true;
								vars.LOG_LastSplit = "Necrum Entry. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Hands SPLIT
							if (c_FMV_ID == 9 && vars.splits[23] != true) {
								vars.splits[23] = true;
								vars.LOG_LastSplit = "Handstones. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches Entry SPLIT
							if (c_FMV_ID == 6 && vars.splits[24] != true) {
								vars.splits[24] = true;
								vars.LOG_LastSplit = "Fleeches Entry. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 1 SPLIT
							if (c_FMV_ID == 18 && vars.splits[25] != true) {
								vars.splits[25] = true;
								vars.LOG_LastSplit = "Fleeches 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 2 SPLIT
							if (c_FMV_ID == 19 && vars.splits[26] != true) {
								vars.splits[26] = true;
								vars.LOG_LastSplit = "Fleeches 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 3 SPLIT
							if (c_FMV_ID == 20 && vars.splits[27] != true) {
								vars.splits[27] = true;
								vars.LOG_LastSplit = "Fleeches 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 4 SPLIT
							if (c_FMV_ID == 21 && vars.splits[28] != true) {
								vars.splits[28] = true;
								vars.LOG_LastSplit = "Fleeches 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 5 SPLIT
							if (c_FMV_ID == 15 && vars.splits[29] != true) {
								vars.splits[29] = true;
								vars.LOG_LastSplit = "Fleeches 5. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
					// Necrum pre-SPLIT
						if (c_PATH_ID == 5 && (c_CAM_ID == 9 || c_CAM_ID == 1) && vars.FMVNecrum == 8){ // Prepare for last split
							vars.preSplitNecrum = true;
							vars.FMVNecrum = 0;
						}			
					} 
					
					if (c_LEVEL_ID == 2 && c_FMV_ID == 8){
						vars.FMVNecrum = c_FMV_ID;
					}
					
					// Necrum SPLITS
					if (vars.ILid == -1 && vars.preSplitNecrum && (c_FMV_ID == 25 || c_FMV_ID == 34) && (c_LEVEL_ID >= 2 && c_LEVEL_ID <= 4) && vars.splits[1] != true) { // Cinematics: 25 is mudomo (24 end). 34 is Mudanchee (25 end). 4 is FeeCo.
						vars.splits[1] = true;
						vars.preSplitNecrum = false;
						vars.countToMud = 1;
						vars.LOG_LastSplit = "Necrum to Mudomo / Mudanchee. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
					
					if (vars.ILid == 1 && o_LEVEL_ID == 2 && c_LEVEL_ID == 3 && c_FMV_ID == 25){ // Necrum to Mudomo, we prepare to the next save file
						vars.ILWaitTimer = true;						
						vars.splits[55] = true; // Recycled for Necrum to Mudanchee split
						return true;
					}
					
					if (vars.ILid == 1 && o_CAM_ID == 5 && c_CAM_ID == 6 && vars.splits[55] == true){ // Save file 2.
						vars.ILWaitTimer = false;						
						vars.splits[55] = false;
						return true;
					}
					
					if (vars.ILid == 1 && o_LEVEL_ID == 2 && c_LEVEL_ID == 4 && c_FMV_ID == 34){ // Necrum to Mudanchee, we prepare to the next save file
						vars.ILWaitTimer = true;						
						vars.splits[56] = true; // Recycled for Necrum to FeeCo split
						return true;
					}					
					
					if (vars.ILid == 1 && o_LEVEL_ID == 7 && c_LEVEL_ID == 2 && vars.splits[56] == true){ // Save file 3.
						vars.ILWaitTimer = false;						
						vars.splits[56] = false; // Recycled for Necrum to Mudanchee split
						return true;
					}
					
					if (c_LEVEL_ID == 5 && o_LEVEL_ID == 2 && ((vars.splits[2] != true && vars.splits[3] != true) || (vars.ILid == 1))){ // From Necrum to FeeCo directly (Any%)
						vars.splits[1] = true;
						vars.splits[2] = true; // We will not use it anymore.
						vars.splits[3] = true; // We will not use it anymore.
						vars.preSplitNecrum = false;
						vars.LOG_LastSplit = "Necrum to FeeCo. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////

			// FeeCo & FeeCo 2 (LEVEL_ID 5)
				if (settings["feecoSplit"] || vars.ILid == 4) { 					
					if ((settings["feecoExtended"] || vars.ILid == 4) && c_LEVEL_ID == 2 && o_PATH_ID == 3 && o_CAM_ID == 2 && c_PATH_ID == 3 && c_CAM_ID == 9 && vars.splits[1] == true && vars.splits[2] == true && vars.splits[3] == true) { // SPECIAL: FeeCo entry through Necrum using Farewell FeeCo skip
						vars.splits[51] = true;
						vars.LOG_LastSplit = "Special split: Necrum to Terminal 1 (Any% | Farewell FeeCo skip). " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
					
					if ((settings["feecoExtended"] || vars.ILid == 4) && c_LEVEL_ID == 5) { // 51 - 55		
					// FeeCo Entry
						if (c_PATH_ID == 1 && c_CAM_ID == 3 && vars.splits[51] != true) {
							vars.splits[51] = true;
							vars.LOG_LastSplit = "FeeCo Entry. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal 1
						if (c_PATH_ID == 7 && c_CAM_ID == 1 && vars.splits[52] != true) {
							vars.splits[52] = true;
							vars.LOG_LastSplit = "Terminal 1. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal 2
						if (o_PATH_ID == 7 && c_PATH_ID == 2 && c_CAM_ID == 8 && (vars.splits[53] != true || vars.splits[0] == true || vars.splits[1] == true)) { // 0 is for 2nd save. 1 is for 3rd save file.
							vars.splits[53] = true;
							if (vars.splits[1] == true){ // Loading the second save file						
								vars.LOG_LastSplit = "Terminal 2 (go to Executive Office!) " + vars.LOG_CurrentTime;	
							} else if (vars.splits[0] == true){ // Loading the third save file					
								vars.LOG_LastSplit = "Terminal 2 (go to Bonewerkz!) " + vars.LOG_CurrentTime;			
							} else { // First time we come here
								vars.LOG_LastSplit = "Terminal 2 (go to Barracks!) " + vars.LOG_CurrentTime;								
							}
							if (vars.splits[1] == true){								
								vars.splits[0] = false;
								vars.splits[1] = false;
							}
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							vars.ILWaitTimer = false;
							return true;
						}
						
					// Terminal principal to Slig Barracks
					 // if (o_PATH_ID == 9 && c_PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 3
						if (o_PATH_ID == 9 && c_PATH_ID == 3 && vars.splits[54] != true) { // If I enter on Terminal 3
							vars.splits[54] = true;
							vars.LOG_LastSplit = "Main Terminal to Terminal 3. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal principal to Bonewerkz
						if (o_PATH_ID == 9 && c_PATH_ID == 4 && vars.splits[54] != true) { // If I enter on Terminal 4
							vars.splits[54] = true;
							vars.LOG_LastSplit = "Main Terminal to Terminal 4. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal principal to Soulstorm Brewery
						if (o_PATH_ID == 2 && c_PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 5
							vars.splits[54] = true;
							vars.LOG_LastSplit = "Main Terminal to Terminal 5. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 3
						if (c_PATH_ID == 5 && o_CAM_ID == 3 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.LOG_LastSplit = "Terminal 3. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 4
						if (vars.ILid == -1 && c_PATH_ID == 4 && o_CAM_ID == 13 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.LOG_LastSplit = "Terminal 4. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 5
						if (c_PATH_ID == 5 && o_CAM_ID == 7 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.LOG_LastSplit = "Terminal 5. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}		
				}
				
				if (vars.ILid == 4 && o_LEVEL_ID == 5 && (c_LEVEL_ID == 6 || c_LEVEL_ID == 8 || c_LEVEL_ID == 9) && (vars.splits[0] != true || vars.splits[1] != true)){				
					vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					vars.ILWaitTimer = true;					
					if (vars.splits[0] == false){								
						vars.splits[0] = true;						
						vars.LOG_LastSplit = "FeeCo 1. (LOAD SAVE FILE 2)" + vars.LOG_CurrentTime;
					} else {						
						vars.splits[1] = true;		
						vars.LOG_LastSplit = "FeeCo 2. (LOAD SAVE FILE 3)" + vars.LOG_CurrentTime;	
					}
					return true;
				}
					
				if (vars.ILid == -1 && (settings["feecoSplit"] || vars.SplitFeeco2 || vars.ILid == 4) && o_LEVEL_ID == 5 && (c_LEVEL_ID == 6 || c_LEVEL_ID == 8 || c_LEVEL_ID == 9) && vars.splits[4] != true) { // FeeCo Split. 6 is Bonewerkz.  5 is Barracks. 15 is Brewery
					vars.splits[4] = true;
					vars.splitsFeeCoAgain = vars.splits[4];
					vars.splits[8] = true; // We avoid double split if we go from FeeCo to Soulstorm directly.
					if (vars.splits[5]) { // Slig Barracks ya fue completado.
						vars.LOG_LastSplit = "FeeCo 2 to Bonewerkz. " + vars.LOG_CurrentTime;
					} else if (vars.splits[6]){ // Bonewerkz ya fue completado.
						vars.LOG_LastSplit = "FeeCo 2 to Slig Barracks. " + vars.LOG_CurrentTime;		
					} else { // Nada fue completado.
						vars.LOG_LastSplit = "FeeCo 1. " + vars.LOG_CurrentTime;
					}
					vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;
				}
			//////////////////////////////
					
			// Slig Barracks (LEVEL_ID 6)
				if (settings["barracksSplit"] || vars.ILid == 6) {
					if ((settings["barracksExtended"] || vars.ILid == 6) && c_LEVEL_ID == 6) { // 56 - 62			
					// Block 0
						if (o_PATH_ID == 13 && c_PATH_ID == 2 && vars.splits[56] != true) {
							vars.splits[56] = true;
							vars.LOG_LastSplit = "Block 0. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 1
						if (o_PATH_ID == 10 && c_PATH_ID == 2 && vars.splits[57] != true) {
							vars.splits[57] = true;
							vars.LOG_LastSplit = "Block 1. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 2
						if (o_PATH_ID == 5 && c_PATH_ID == 2 && vars.splits[58] != true) {
							vars.splits[58] = true;
							vars.LOG_LastSplit = "Block 2. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 3
						if (o_PATH_ID == 7 && c_PATH_ID == 2 && vars.splits[59] != true) {
							vars.splits[59] = true;
							vars.LOG_LastSplit = "Block 3. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 4
						if (o_PATH_ID == 14 && c_PATH_ID == 2 && vars.splits[60] != true) {
							vars.splits[60] = true;
							vars.LOG_LastSplit = "Block 4. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}	
					
					}
				// Dripik (fixed 08 June 2020)
					if ((settings["barracksExtended"] || vars.ILid == 6) && c_LEVEL_ID == 13 && o_PATH_ID == 11 && c_PATH_ID == 16 && vars.splits[61] != true) {
						vars.splits[61] = true;
						vars.LOG_LastSplit = "Dripik. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}	
					
					
					
				// Slig Barracks Split
					if (o_LEVEL_ID == 13 && c_LEVEL_ID == 5 && vars.splits[5] != true) { 
						vars.splits[5] = true;
						vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
						if (settings["feeco2Split"] && vars.SplitFeeco2 == false){
							vars.splits[4] = false; // So we split again when entering on Bonewerkz.
							vars.splitsFeeCoAgain = vars.splits[4];
							vars.SplitFeeco2 = true;
						}
						vars.LOG_LastSplit = "Slig Barracks. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////
					
			// Bonewerkz (LEVEL_ID 8 and 14)
				if (settings["bonewerkzSplit"] || vars.ILid == 5) {
					if (settings["bonewerkzExtended"] || vars.ILid == 5) { // 63 - 72
						if (c_LEVEL_ID == 8){			
						// Bonewerkz Entry
							if (o_PATH_ID == 1 && c_PATH_ID == 7 && vars.splits[63] != true) {
								vars.splits[63] = true;
								vars.LOG_LastSplit = "Bonewerkz Entry. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 1
							if (o_PATH_ID == 7 && c_PATH_ID == 1 && vars.splits[64] != true) {
								vars.splits[64] = true;
								vars.LOG_LastSplit = "Annex 1. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 2
							if (o_PATH_ID == 1 && c_PATH_ID == 2 && vars.splits[65] != true) {
								vars.splits[65] = true;
								vars.LOG_LastSplit = "Annex 2. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 3
							if (c_PATH_ID == 2 && c_CAM_ID == 4 && vars.splits[66] != true) {
								vars.splits[66] = true;
								vars.LOG_LastSplit = "Annex 3. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 4
							if (c_PATH_ID == 2 && c_CAM_ID == 7 && vars.splits[67] != true) {
								vars.splits[67] = true;
								vars.LOG_LastSplit = "Annex 4. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 5
							if (c_PATH_ID == 2 && c_CAM_ID == 9 && vars.splits[68] != true) {
								vars.splits[68] = true;
								vars.LOG_LastSplit = "Annex 5. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 6
							if (o_PATH_ID == 2 && c_PATH_ID == 3 && vars.splits[69] != true) {
								vars.splits[69] = true;
								vars.LOG_LastSplit = "Annex 6. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 7
							if (o_PATH_ID == 3 && c_PATH_ID == 4 && vars.splits[70] != true) {
								vars.splits[70] = true;
								vars.LOG_LastSplit = "Annex 7. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
						if (c_LEVEL_ID == 14){
						// Annex 8
							if (c_PATH_ID == 14 && vars.splits[71] != true) {
								vars.splits[71] = true;
								vars.LOG_LastSplit = "Annex 8. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
							if (c_LEVEL_ID == 14 && c_PATH_ID == 9 && c_CAM_ID == 15) { // Screen with the glukkon intercom phone
								vars.PrePhlegSplit = true;
							}
							
						// Phleg
							if (vars.PrePhlegSplit && c_PATH_ID == 9 && o_CAM_ID == 9 && c_CAM_ID == 8 && vars.splits[72] != true) {
								vars.splits[72] = true;
								vars.LOG_LastSplit = "Phleg. " + vars.LOG_CurrentTime;
								vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								vars.PrePhlegSplit = false;
								return true;
							}
						}
					}		
					
					if (o_LEVEL_ID == 14 && c_LEVEL_ID == 5 && vars.splits[6] != true) { // Bonewerkz Split
						vars.splits[6] = true;
						vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
						if (settings["feeco2Split"] && vars.SplitFeeco2 == false){ // We enabled FeeCo 2 (between Barracks - Bonewerkz and the next one).
							vars.splits[4] = false; // So we split again when entering on Barracks.
							vars.splitsFeeCoAgain = vars.splits[4];
							vars.SplitFeeco2 = true;
						}
						vars.LOG_LastSplit = "Bonewerkz. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ".";
						return true;
					}
				}
			//////////////////////////////

			// Executive Office (LEVEL_ID 12)
				if (settings["officeSplit"] || vars.ILid == 4) {
					if ((settings["officeExtended"] || vars.ILid == 4) && c_LEVEL_ID == 12){ // 73, 74
						
					// Entry Executive Office
						if (o_CAM_ID == 4 && c_CAM_ID == 5 && vars.splits[73] != true) {
							vars.splits[73] = true;
							vars.LOG_LastSplit = "Entry Executive Office. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Aslik
						if (o_CAM_ID == 8 && c_CAM_ID == 2 && vars.splits[74] != true) {
							vars.splits[74] = true;
							vars.LOG_LastSplit = "Aslik. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
					if (o_LEVEL_ID == 12 && c_LEVEL_ID == 5 && vars.splits[7] != true) {
						vars.splits[7] = true;
						vars.LOG_LastSplit = "Executive Office. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////	
					
			// FeeCo 3 (LEVEL_ID 5)
				if ((settings["feeco3Split"] || vars.ILid == 4) && o_LEVEL_ID == 5 && c_LEVEL_ID == 9 && vars.splits[8] != true) {	
					vars.splits[8] = true;
						vars.LOG_LastSplit = "FeeCo to Terminal 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;
				}
					
			// Hub I (LEVEL_ID 9)
				if ((settings["hub1Split"] || vars.ILid == 7) && c_LEVEL_ID == 9){
					if (settings["hub1Extended"] || vars.ILid == 7){ // 75 - 80
					// SoulStorm Brewery Entry
						if (o_PATH_ID == 16 && c_PATH_ID == 23 && vars.splits[75] != true) {
							vars.splits[75] = true;
							vars.LOG_LastSplit = "Zulag 0 (Soulstorm Brewery Entry). " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 1
						if (o_PATH_ID == 1 && c_PATH_ID == 23 && vars.splits[76] != true) {
							vars.splits[76] = true;
							vars.LOG_LastSplit = "Zulag 1. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 2
						if (o_PATH_ID == 2 && c_PATH_ID == 23 && vars.splits[77] != true) {
							vars.splits[77] = true;
							vars.LOG_LastSplit = "Zulag 2. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 3
						if (o_PATH_ID == 12 && c_PATH_ID == 23 && vars.splits[78] != true) {
							vars.splits[78] = true;
							vars.LOG_LastSplit = "Zulag 3. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 4
						if (o_PATH_ID == 19 && c_PATH_ID == 23 && vars.splits[79] != true) {
							vars.splits[79] = true;
							vars.LOG_LastSplit = "Zulag 4. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 5
						if (o_PATH_ID == 14 && c_PATH_ID == 23 && vars.splits[80] != true) {
							vars.splits[80] = true;
							vars.LOG_LastSplit = "Zulag 5. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}	
					
				// Hub 1
					if (o_PATH_ID == 23 && c_PATH_ID == 24 && vars.splits[9] != true) { 
						vars.splits[9] = true;
						vars.LOG_LastSplit = "Hub 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////	

			// Hub II
				if ((settings["hub2Split"] || vars.ILid == 8) && c_LEVEL_ID == 9){
					if (settings["hub2Extended"] || vars.ILid == 8){ // 81 - 85			
					// Zulag 6
						if (o_PATH_ID == 5 && o_CAM_ID == 4 && c_PATH_ID == 24 && vars.splits[81] != true) {
							vars.splits[81] = true;
							vars.LOG_LastSplit = "Zulag 6. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 7
						if (o_PATH_ID == 6 && o_CAM_ID == 10 && c_PATH_ID == 24 && vars.splits[82] != true) {
							vars.splits[82] = true;
							vars.LOG_LastSplit = "Zulag 7. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 8
						if (o_PATH_ID == 3 && c_PATH_ID == 24 && vars.splits[83] != true) {
							vars.splits[83] = true;
							vars.LOG_LastSplit = "Zulag 8. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 9
						if (o_PATH_ID == 17 && c_PATH_ID == 24 && vars.splits[84] != true) {
							vars.splits[84] = true;
							vars.LOG_LastSplit = "Zulag 9. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 10
						if (o_PATH_ID == 10 && c_PATH_ID == 24 && vars.splits[85] != true) {
							vars.splits[85] = true;
							vars.LOG_LastSplit = "Zulag 10. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
				// Hub 2
					if (o_PATH_ID == 24 && c_PATH_ID == 25 && vars.splits[10] != true) {
						vars.splits[10] = true;
						vars.LOG_LastSplit = "Hub 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////
				
			// Hub III	
				if (settings["hub3Split"] || vars.ILid == 9){
					if ((settings["hub3Extended"] || vars.ILid == 9) && c_LEVEL_ID == 9){ // 86 - 89
					// Zulag 11
						if (o_PATH_ID == 9 && c_PATH_ID == 25 && vars.splits[86] != true) {
							vars.splits[86] = true;
							vars.LOG_LastSplit = "Zulag 11. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					// Zulag 12
						if (o_PATH_ID == 11 && c_PATH_ID == 25 && vars.splits[87] != true) {
							vars.splits[87] = true;
							vars.LOG_LastSplit = "Zulag 12. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 13
						if ((o_PATH_ID == 20 || o_PATH_ID == 15) && c_PATH_ID == 25 && vars.splits[88] != true) {
							vars.splits[88] = true;
							vars.LOG_LastSplit = "Zulag 13. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
						
					// Zulag 14
						if (o_PATH_ID == 4 && o_CAM_ID == 13 && c_PATH_ID == 25 && vars.splits[89] != true) {
							vars.splits[89] = true;
							vars.LOG_LastSplit = "Zulag 14. " + vars.LOG_CurrentTime;
							vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
				// Hub 3
					if (c_LEVEL_ID == 10 && c_PATH_ID == 1 && vars.splits[11] != true) {
						vars.splits[11] = true;
						vars.LOG_LastSplit = "Hub 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
					
			//////////////////////////////

			// Soulstorm Brewery		
				if ((settings["boilerSplit"] || vars.ILid == 10) && c_LEVEL_ID == 10 && (c_FMV_ID == 17 || c_FMV_ID == 18 || c_CAM_ID == 15) && vars.splits[12] != true) {		
					vars.splits[12] = true;	
					vars.LOG_LastSplit = "Zulag 15. Game is over! FINAL TIME-> " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;	
				}
		
		}
	}
	
//##########################################################


// Other functions not related with splits whatsoever.

	if (c_LEVEL_ID > 0){
		vars.LOG_CurrentPositionAndTime = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ". Time: " + System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "");
	} else {		
		vars.LOG_CurrentPositionAndTime = "Enter on the game first through the Start menu ;)";
		vars.LOG_LocationLastSplit = "The first split will save the values of the game.";
	}

	if (!settings["GoG"] && version.Contains("EN")) { // We switch to spanish
			version = "ES";
	}	
		
	if (settings["GoG"] && version.Contains("ES")) { // We switch to english
		version = "EN";
	}

	if (c_LEVEL_ID == 1 && c_PATH_ID == 1){
		if (c_CAM_ID == 3){ // We disable the reset option.
			vars.ResetAllowed = false;
		} else if (c_CAM_ID != 4) {// If we are not on the dangerous reset point or in the first screen, we re-enable the reset ability
			vars.ResetAllowed = true;
		}
	}	
	
	// RESTART ZONE + LANG DETECTION (very cool)
	
	if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 1 && current.EN_LEVEL_ID == 0 && current.EN_PATH_ID == 1 && current.EN_CAM_ID == 12){ // ENGLISH
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "English";
	} else if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 1 && current.ES_LEVEL_ID == 0 && current.ES_PATH_ID == 1 && current.ES_CAM_ID == 12){ // SPANISH
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "Spanish";
	} else if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 1 && current.FR_LEVEL_ID == 0 && current.FR_PATH_ID == 1 && current.FR_CAM_ID == 12){ // FRENCH
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "French";
	} else if (old.FRs_LEVEL_ID == 0 && old.FRs_PATH_ID == 1 && old.FRs_CAM_ID == 1 && current.FRs_LEVEL_ID == 0 && current.FRs_PATH_ID == 1 && current.FRs_CAM_ID == 12){ // FRENCH STEAM
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "French Steam";
	} else if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 1 && current.IT_LEVEL_ID == 0 && current.IT_PATH_ID == 1 && current.IT_CAM_ID == 12){ // ITALIAN
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "Italian";
	} else if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 1 && current.DE_LEVEL_ID == 0 && current.DE_PATH_ID == 1 && current.DE_CAM_ID == 12){ // GERMAN
		vars.ResetStatus = 1;	
		vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
		vars.LangDetected = "German";
	}
	
	// --------------------------------------------
	
// LOG TOOL FOR DEBUG. 	
	if (vars.ResetStatus == 1) { // Needed at the end.
		vars.ResetStatus = 2;
	}
	
	if (vars.countToMud > 0 && vars.countToMud <= 999){
		vars.countToMud = vars.countToMud + 1;
	} 
}
