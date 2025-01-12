//  An autosplitter for Abe's Exoddus for PC: English / English GoG, Spanish, French / French Steam, German and Italian. 
//  Language should be detected automatically by looking for the localised "are you sure you want to quit" string (thanks to paulsapp). 
//  Created by LegnaX. 26 May 2022.

 // Added this so the ASL Var Viewer has at least one opcode loaded by default (even if it's unused). 
state("Exoddus", "default") {byte use_Variables_option_instead  : 0x1C3030;}
state("AliveExeAE", "default") {byte use_Variables_option_instead : 0x1C3030;}
state("AliveExe", "default") {byte use_Variables_option_instead : 0x1C3030;}
state("relive", "default") {byte use_Variables_option_instead : 0x1C3030;}

startup
{
	print("+startup");

	settings.Add("Version", true, "Official Version 2.1 (May 26th 2022) - LegnaX#7777 - CHANGELOG");
	settings.SetToolTip("Version", 
	@"########################################## CHANGELOG ########################################## 
-Added Individual level support!
-Fixed a glitch with the autosplitter remembering the Loadless time from previous attempts.
-Removed a leftover debug thing on Tunnel 1 split that was locking the timer in place.
-Added GNFrame as the current frames of the run (excluding pause times). Cleaned some of the code.
-Fixed an issue with splitting again after dying on FeeCo Save File 2.
-Fixed several faulty splits on Mudomo and Mudanchee (vaults).
-Renamed the categories: NLG is now NMG (No Major Glitches).
-Fixed a visual glitch with the IGT and added new condition to split on Executive Office - Entry and Executive Office - Aslik (for 100%, Max Cas and 50/50 categories).
-Completely revamped the init system (thanks to Paul) and added support to the Relive project (also made by Paul). paul#2754 - paulsapps.com
-Fixed a problem with the ASL Var Viewer. It should let you choose the variables correctly now (found by TopTheGamer and MarkTheW0lf).
-[May 26th 2022] Fixed compatibility with relive. It should work now (thanks to mouzedrift)."
);
	
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
	settings.Add("minesExtended", true, "One split each Tunnel (put mouse here for more info).", "minesSplit");
	settings.SetToolTip("minesExtended", "This will make the autosplit to split on the following points:\n- Tunnel 1.\n- Tunnel 2.\n- Slogs.\n- Tunnel 3.\n- Tunnel 4.\n- Tunnel 5.\n- Tunnel 6.\n- Tunnel 7.\n- Mines (original).\n\nIt doesn't matter the order or if you skip a Tunnel (for example on Any%).");
	
	settings.Add("necrumSplit", true, "Necrum - Ending Necrum by entering Mudomo | Mudanchee | FeeCo.");
	settings.Add("necrumExtended", true, "One split each part of Necrum (put mouse here for more info).", "necrumSplit");
	settings.SetToolTip("necrumExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Handstones.\n- Fleeches Entry.\n- Fleeches Trial 1.\n- Fleeches Trial 2.\n- Fleeches Trial 3.\n- Fleeches Trial 4.\n- Fleeches Trial 5.\n- Necrum (original).\n\nIt doesn't matter the order or if you skip half of it (for example on Any%).\nYou can also go to Mudomo or Mudanchee. Any order.");
	
	settings.Add("mudomoSplit", true, "Mudomo - Ending Mudomo by entering Mudanchee or FeeCo.");	
	settings.Add("mudomoExtended", true, "One split each part of Mudomo (put mouse here for more info).", "mudomoSplit");
	settings.SetToolTip("mudomoExtended", "This will make the autosplit to split on the following points:\n- Entry 1.\n- Entry 2.\n- Entry 3.\n- Trial 1.\n- Trial 2.\n- Trial 3.\n- Trial 4.\n- Trial 5.\n- Trial 6.\n- Vaults.\n- Mudomo (original).\n\nIt doesn't matter the trial order.\nYou can also go to Mudanchee or FeeCo after this. Any order.");
	
	settings.Add("mudancheeSplit", true, "Mudanchee - Ending Mudanchee by entering Mudomo or FeeCo.");
	settings.Add("mudancheeExtended", true, "One split each part of Mudanchee (put mouse here for more info).", "mudancheeSplit");
	settings.SetToolTip("mudancheeExtended", "This will make the autosplit to split on the following points:\n- Entry 1.\n- Entry 2.\n- Entry 3.\n- Trial 1.\n- Trial 2.\n- Trial 3.\n- Trial 4.\n- Trial 5.\n- Trial 6.\n- Vaults.\n- Mudanchee (original).\n\nIt doesn't matter the trial order.\nYou can also go to Mudomo or FeeCo after this. Any order.");
	
	settings.Add("feecoSplit", true, "FeeCo - Ending FeeCo by entering Barracks, Bonewerkz or Brewery.");	
	settings.Add("feecoExtended", true, "One split each part of FeeCo (put mouse here for more info).", "feecoSplit");
	settings.SetToolTip("feecoExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Terminal 1.\n- Terminal 2.\n- Main Terminal.\n- Terminal 3 (before Slig Barracks), Terminal 4 or Terminal 5.\n- FeeCo (original).\n\nIt doesn't matter the level order or where you go after the Main Terminal (Bonewerkz, Slig Barracks or Soulstorm Brewery).\n");
	
	settings.Add("barracksSplit", true, "Slig Barracks - Ending Slig Barracks by returning to FeeCo.");	
	settings.Add("barracksExtended", true, "One split each part of Barracks (put mouse here for more info).", "barracksSplit");
	settings.SetToolTip("barracksExtended", "This will make the autosplit to split on the following points:\n- Block 0.\n- Block 1.\n- Block 2.\n- Block 3.\n- Block 4.\n- Dripik.\n- Slig Barracks (original).\n\nIt doesn't matter the Block order.");
	
	settings.Add("bonewerkzSplit", true, "Bonewerkz - Ending Bonewerkz by returning to FeeCo.");	
	settings.Add("bonewerkzExtended", true, "One split each part of Bonewerkz (put mouse here for more info).", "bonewerkzSplit");
	settings.SetToolTip("bonewerkzExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Annex 1.\n- Annex 2.\n- Annex 3.\n- Annex 4.\n- Annex 5.\n- Annex 6.\n- Annex 7.\n- Annex 8.\n- Phleg.\n- Bonewerkz (original).");
	
	settings.Add("feeco2Split", true, "FeeCo2 - Put mouse here for details.");
	settings.SetToolTip("feeco2Split", "This basically makes the autosplit to split if the runner enters on Bonewerkz after completing Slig Barracks,\nor if the player goes to Slig Barracks after completing Bonewerkz.");
	
	settings.Add("officeSplit", true, "Executive Office - Ending Executive Office by returning to FeeCo.");
	settings.Add("officeExtended", true, "One split each part of the Office (put mouse here for more info).", "officeSplit");
	settings.SetToolTip("officeExtended", "This will make the autosplit to split on the following points:\n- Entry.\n- Aslik.\n- Executive Office (original).");
	
	settings.Add("feeco3Split", true, "FeeCo 3 - After doing Executive Office - Entering brewery.");	
	settings.SetToolTip("feeco3Split", "This basically makes the autosplit to split if the runner completes Terminal 5,\njust before entering on the train to Soulstorm Brewery.");
	
	settings.Add("hub1Split", true, "Soulstorm Brewery Hub 1 - Ending Hub 1 and entering Hub 2.");
	settings.Add("hub1Extended", true, "One split for each Zulag (put mouse here for more info).", "hub1Split");
	settings.SetToolTip("hub1Extended", "This will make the autosplit to split on the following points:\n- Entry.\n- Zulag 1.\n- Zulag 2.\n- Zulag 3.\n- Zulag 4.\n- Zulag 5.\n- Hub 1 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("hub2Split", true, "Soulstorm Brewery Hub 2 - Ending Hub 2 and entering Hub 3.");
	settings.Add("hub2Extended", true, "One split for each Zulag (put mouse here for more info).", "hub2Split");
	settings.SetToolTip("hub2Extended", "This will make the autosplit to split on the following points:\n- Zulag 6.\n- Zulag 7.\n- Zulag 8.\n- Zulag 9.\n- Zulag 10.\n- Hub 2 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("hub3Split", true, "Soulstorm Brewery Hub 3 - Ending Hub 3 and entering the Boiler.");
	settings.Add("hub3Extended", true, "One split for each Zulag (put mouse here for more info).", "hub3Split");
	settings.SetToolTip("hub3Extended", "This will make the autosplit to split on the following points:\n- Zulag 11.\n- Zulag 12.\n- Zulag 13.\n- Zulag 14.\n- Hub 3 (original).\n\nIt doesn't matter the Zulag order.");
	
	settings.Add("boilerSplit", true, "Zulag 15 - Boiler (End game) - Splits when Abe enters on any portal.");

	print("-startup");
}

init
{	
	
	vars.You_can_show_the_following_variables_on_runs = "Ahh, I see!";
	vars.version = "NOT DETECTED YET! Start a new game.";
	vars.REAL_TIME_AND_LOADLESS_TIME = "(Use 2 rows) Both timers\nwill be displayed here";
	vars.REAL_TIME = "Real time will be displayed here";
	vars.LOADLESS_TIME = "Loadless time will be displayed here";
	vars.LOG_LastSplit = "No split yet. Game version: " + vars.version;
	vars.LOG_CurrentRTA = "[00:00:00.000]";
	vars.____________________________________ = "Ignore this.";
	vars.You_can_NOT_show_the_following_variables_on_runs = "Only the 3 above ones can be used.";

// ###################################### FROM HERE TO LINE 290 IS PAUL'S BLACK MAGIC ###############################################
	print("+init");
	

	// Detect which version/language of the game we are running, load the entire code section to an array
	print("Reading " +  modules.First().ModuleMemorySize.ToString() + " bytes from the first module base address");
 	var moduleMemory = memory.ReadBytes(modules.First().BaseAddress, modules.First().ModuleMemorySize);
	string converted = Encoding.UTF8.GetString(moduleMemory, 0, moduleMemory.Length);
	print("Read code section as a string");

	version = "default";

	vars.SigScan = (Func<Process, int, string, IntPtr>)((proc, offset, signature) => {
        var target = new SigScanTarget(offset, signature);
        IntPtr result = IntPtr.Zero;
        foreach (var page in proc.MemoryPages(true)) {
            var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
            if ((result = scanner.Scan(target)) != IntPtr.Zero) {
                break;
            }
        }

        return result;
    });

	for (;;)
	{	
		// First check if this is relive
		int pos = converted.IndexOf("{DBC2AE1C-A5DE-465F-A89A-C385BE1DEFCC}");
		if (pos != -1)
		{
			print("Relive Buffer match: " + converted.Substring(pos, 50));

			// Find the guid again via signature scanning to get the RVA offset
			IntPtr scan = vars.SigScan(game, 0, "7B 44 42 43 32 41 45 31 43 2D 41 35 44 45 2D 34 36 35 46 2D 41 38 39 41 2D 43 33 38 35 42 45 31 44 45 46 43 43 7D 00");
			if (scan != IntPtr.Zero)
			{
				print("Scan = " + scan.ToString());

				// Point to data after the guid in the AEGameInfo structure
				scan += 40;

				vars.version = "Relive";
				
				// If this guid exists its a 64bit version of relive
				bool is64Bit = converted.IndexOf("{069DDB51-609D-49AB-B69D-5CC6D13E73EE}") != -1;
				int gamePointerSize = is64Bit ? 8 : 4;

				print("Pointer size = " + gamePointerSize.ToString());

				vars.watchers = new MemoryWatcherList
				{
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (1*gamePointerSize)))) { Name = "LEVEL_ID" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (2*gamePointerSize)))) { Name = "PATH_ID" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (3*gamePointerSize)))) { Name = "CAM_ID" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (4*gamePointerSize)))) { Name = "FMV_ID" },
					new MemoryWatcher<int>(new DeepPointer(memory.ReadPointer(scan + (5*gamePointerSize)))) { Name = "gnFrame" },
					new MemoryWatcher<short>(new DeepPointer(memory.ReadPointer(scan + (6*gamePointerSize)), new int[] {memory.ReadValue<int>(scan + (7*gamePointerSize))})) { Name = "abeY" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (8*gamePointerSize)))) { Name = "IsPaused" },
				};
			}
			break;
		}
		
		// Then look in the array for the quit strings which are localised to figure out which language this is (for the original game)
		pos = converted.IndexOf("Do you really want to quit?");
		if (pos != -1)
		{
			print("English Buffer match: " + converted.Substring(pos, 50));
			vars.version = "English";
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x1C3030)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3032)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3034)) { Name = "CAM_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3042)) { Name = "FMV_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1C1B84)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1C1230, new int[] {0xBE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C9304)) { Name = "IsPaused" },
			};
			break;
		}
		
		pos = converted.IndexOf("Salir, seguro?"); // Only check the ascii chars
		if (pos != -1) 
		{
			print("Buffer match: " + converted.Substring(pos, 50));
			vars.version = "Spanish";
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x1C33C0)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C33C2)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C33C4)) { Name = "CAM_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C33D2)) { Name = "FMV_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1C1F14)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1C1EF8, new int[] {0xBE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C9694)) { Name = "IsPaused" },
			};
			break;
		}
		
		pos = converted.IndexOf("Voulez-vous vraiment quitter?"); // Only check the ascii chars
		if (pos != -1) 
		{
			print("French Buffer match: " + converted.Substring(pos, 50));
			vars.version = "French";
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x1C3908)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C390A)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C390C)) { Name = "CAM_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C391A)) { Name = "FMV_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1C245C)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1C2440, new int[] {0xBE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C9BDC)) { Name = "IsPaused" },
			};
			break;
		}
		
		pos = converted.IndexOf("Wollen Sie wirklich "); // Only check the ascii chars
		if (pos != -1)
		{
			print("German Buffer match: " + converted.Substring(pos, 50));
			vars.version = "German";
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x1C3A08)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3A0A)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3A0C)) { Name = "CAM_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3A1A)) { Name = "FMV_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1C255C)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1C2540, new int[] {0xBE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C9CDC)) { Name = "IsPaused" },
			};
			break;
		}
		
		pos = converted.IndexOf("Vuoi davvero uscire?");
		if (pos != -1)
		{
			print("Italian Buffer match: " + converted.Substring(pos, 50));
			vars.version = "Italian";
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x1C377A)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C377C)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C377E)) { Name = "CAM_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C3782)) { Name = "FMV_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1C22C4)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1C22A8, new int[] {0xBE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1C9A44)) { Name = "IsPaused" },
			};
			break;
		}
		else
		{
			// Unknown
			print("Unknown game");
			break;
		}
	}
// ###################################### FROM LINE 113 TO THIS LINE IS PAUL'S BLACK MAGIC ###############################################

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

	vars.DEBUG_CurrentPositionAndTime = "Enter on the game first through the Start menu ;)";
	vars.DEBUG_LocationLastSplit = "The first split will save the values of the game.";
	vars.GNFrame = 0;
	// vars.LOG_ModuleMemory = modules.First().ModuleMemorySize;	
	
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
	vars.GNFrameWithoutAddedFrames = 0;
	vars.Terminal2Split = false; // Used to avoid extra splits on Terminal 2 after the second and third save file.

	vars.isBeginStart = false;

	print("-init");
} 

// MORE OF PAUL MAGIC, IT SEEMS!
update
{
    vars.watchers.UpdateAll(game);
/* 
	print("GnFrame = " + vars.watchers["gnFrame"].Current.ToString());
	print("LEVEL_ID = " + vars.watchers["LEVEL_ID"].Current.ToString());
	print("PATH_ID = " + vars.watchers["PATH_ID"].Current.ToString());
	print("CAM_ID = " + vars.watchers["CAM_ID"].Current.ToString());
	print("FMV_ID = " + vars.watchers["FMV_ID"].Current.ToString());
	print("abeY = " + vars.watchers["abeY"].Current.ToString());
	print("IsPaused = " + vars.watchers["IsPaused"].Current.ToString()); */
}
// BETTER THAN RON'S MAGIC AT LEAST-> https://youtu.be/avOsvIWJlQk?t=72

start
{	
	bool startingWithMines = false;
	vars.ILid = -1; // Restarting IL id
	vars.ILWaitTimer = false;

	// Checking for the Backstory screen, and resetting the value once back in the Main screen
	// Might need to be moved to 'update' if the ASL struggles to start full runs. TBD
	if (vars.watchers["LEVEL_ID"].Current == 0) {
		if (vars.watchers["CAM_ID"].Current == 12) {
			vars.isBeginStart = true;
		} else if (vars.watchers["CAM_ID"].Current == 1) {
			vars.isBeginStart = false;
		}
	}

	// Mines (for both IL and full runs)
	if (vars.watchers["LEVEL_ID"].Old == 0 && vars.watchers["LEVEL_ID"].Current == 1 && vars.isBeginStart) {
		startingWithMines = true;
		if (settings["UsingIL"]) {
			vars.ILid = 0;
		}
	}

	if (settings["UsingIL"]) {
		// Necrum
		if (vars.watchers["LEVEL_ID"].Old == 1 && vars.watchers["FMV_ID"].Old == 0 && vars.watchers["FMV_ID"].Current == 232) {
			vars.ILid = 1;
		}

		// Mudomo
		if (vars.watchers["LEVEL_ID"].Old == 2 && vars.watchers["PATH_ID"].Old == 5 && vars.watchers["CAM_ID"].Old == 9
		&& vars.watchers["LEVEL_ID"].Current == 3 && vars.watchers["PATH_ID"].Current == 1 && vars.watchers["CAM_ID"].Current == 1) {
			vars.ILid = 2;
		}

		// Mudanchee
		if (vars.watchers["LEVEL_ID"].Old == 2 && vars.watchers["PATH_ID"].Old == 5 && vars.watchers["CAM_ID"].Old == 1
		&& vars.watchers["LEVEL_ID"].Current == 4 && vars.watchers["PATH_ID"].Current == 6 && vars.watchers["CAM_ID"].Current == 23) {
			vars.ILid = 3;
		}

		// FeeCo
		if (vars.watchers["LEVEL_ID"].Old == 2 && vars.watchers["PATH_ID"].Old == 3 && vars.watchers["CAM_ID"].Old == 18
		&& vars.watchers["LEVEL_ID"].Current == 5 && vars.watchers["PATH_ID"].Current == 1 && vars.watchers["CAM_ID"].Current == 1) {
			vars.ILid = 4;
		}

		// Bonewerkz
		if (vars.watchers["LEVEL_ID"].Old == 5 && vars.watchers["PATH_ID"].Old == 4 && vars.watchers["CAM_ID"].Old == 14
		&& vars.watchers["LEVEL_ID"].Current == 8 && vars.watchers["PATH_ID"].Current == 1 && vars.watchers["CAM_ID"].Current == 18) {
			vars.ILid = 5;
		}

		// Slig Barracks
		if (vars.watchers["LEVEL_ID"].Old == 5 && vars.watchers["PATH_ID"].Old == 3 && vars.watchers["CAM_ID"].Old == 14
		&& vars.watchers["LEVEL_ID"].Current == 6 && vars.watchers["PATH_ID"].Current == 1 && vars.watchers["CAM_ID"].Current == 3) {
			vars.ILid = 6;
		}

		// Hub 1
		if (vars.watchers["LEVEL_ID"].Old == 5 && vars.watchers["PATH_ID"].Old == 5 && vars.watchers["CAM_ID"].Old == 14
		&& vars.watchers["LEVEL_ID"].Current == 9 && vars.watchers["PATH_ID"].Current == 16 && vars.watchers["CAM_ID"].Current == 1) {
			vars.ILid = 7;
		}

		// Hub 2
		if (vars.watchers["LEVEL_ID"].Old == 9 && vars.watchers["PATH_ID"].Old == 23
		&& vars.watchers["LEVEL_ID"].Current == 9 && vars.watchers["PATH_ID"].Current == 24) {
			vars.ILid = 8;
		}

		// Hub 3
		if (vars.watchers["LEVEL_ID"].Old == 9 && vars.watchers["PATH_ID"].Old == 24
		&& vars.watchers["LEVEL_ID"].Current == 9 && vars.watchers["PATH_ID"].Current == 25) {
			vars.ILid = 9;
		}

		// Soulstorm Boiler
		if (vars.watchers["LEVEL_ID"].Old == 9 && vars.watchers["PATH_ID"].Old == 25
		&& vars.watchers["LEVEL_ID"].Current == 10 && vars.watchers["CAM_ID"].Current == 1) {
			vars.ILid = 10;
		}
	}
	
	if (startingWithMines || vars.ILid >= 0) {
		vars.StartgnFrame = vars.watchers["gnFrame"].Current;		
		vars.Epoch = 0;
		vars.PauseStartTime = -1;	
		vars.MillisecondsPaused = 0;
		vars.AccumulatedPenaltyTime = 0;	
		startingWithMines = false;	
		vars.Terminal2Split = false;
		return true;
	}
}

exit
{
}

reset
{
	// Upon reaching the Backstory screen
	if (vars.watchers["LEVEL_ID"].Current == 0 && vars.watchers["CAM_ID"].Old == 1 && vars.watchers["CAM_ID"].Current == 12) {
		print("Do restart");	
		vars.StartgnFrame = -1;	
		vars.Epoch = 0;
		vars.PauseStartTime = -1;	
		vars.MillisecondsPaused = 0;
		vars.AccumulatedPenaltyTime = 0;
		vars.LOADLESS_TIME = "00:00:00.000";
		vars.REAL_TIME = "00:00:00.000";		
		vars.ILid = -1; // Restarting IL id
		vars.ILWaitTimer = false;
		return true;	
	}
}

gameTime
{
	TimeSpan gameTimeTimeSpan;

	// Store the current gnFrame upon entering idle state (loading a save during ILs)
	if (vars.ILWaitTimer && vars.ILWaitFrame == -1) {
		vars.ILWaitFrame = vars.watchers["gnFrame"].Current;
	}

	// The ASL must not be in a idle state
	if (!vars.ILWaitTimer) {
		// The statements' order matter as there are behavior priorities to be taken in consideration
		// We first update the startGNFrame and the penality time

		// When QuikLoading or Restarting Path
		if (vars.watchers["gnFrame"].Old > vars.watchers["gnFrame"].Current) {
			vars.AccumulatedPenaltyTime = vars.AccumulatedPenaltyTime + ((vars.watchers["gnFrame"].Old - vars.StartgnFrame) * 1000 / vars.fps);
			vars.AccumulatedPenaltyTime = Convert.ToInt32(vars.AccumulatedPenaltyTime);
			vars.StartgnFrame = vars.watchers["gnFrame"].Current - 1;
		}

		// When leaving idle state 
		if (vars.ILWaitFrame > -1) {
			vars.AccumulatedPenaltyTime = vars.AccumulatedPenaltyTime + ((vars.ILWaitFrame - vars.StartgnFrame) * 1000 / vars.fps);
			vars.AccumulatedPenaltyTime = Convert.ToInt32(vars.AccumulatedPenaltyTime);
			vars.StartgnFrame = vars.watchers["gnFrame"].Current - 1;	
			vars.ILWaitFrame = -1;				
		}

		// When using level skip code(?) (fixing gnFrame)
		// This doesn't work in the case the save loaded upon level skip has a smaller gnFrame than the current one
		// Leaving it as it is just in case
		if (vars.watchers["gnFrame"].Old + 60 < vars.watchers["gnFrame"].Current) {
			vars.StartgnFrame = vars.StartgnFrame + (vars.watchers["gnFrame"].Current - vars.watchers["gnFrame"].Old);
		}

		if (vars.watchers["IsPaused"].Current == 1) { // if the game is paused...
			vars.Epoch = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			if (vars.PauseStartTime == -1) { // Paused for the first time.
				vars.PauseStartTime = vars.Epoch;
			}		
		} else {				
			if (vars.PauseStartTime > 0) { // Unpaused for the first time.
				vars.MillisecondsPaused = vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime);
				vars.PauseStartTime = -1;
			}			
		}

		vars.GNFrameWithoutAddedFrames = vars.watchers["gnFrame"].Current - vars.StartgnFrame;
		vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
		if (vars.watchers["IsPaused"].Current == 1) { // if the game is paused...
			gameTimeTimeSpan = TimeSpan.FromMilliseconds((vars.GNFrameWithoutAddedFrames * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.AccumulatedPenaltyTime);
		} else {
			gameTimeTimeSpan = TimeSpan.FromMilliseconds((vars.GNFrameWithoutAddedFrames * 1000 / vars.fps) + vars.MillisecondsPaused + vars.AccumulatedPenaltyTime);
		}

		vars.LOADLESS_TIME = gameTimeTimeSpan.ToString(@"h\:mm\:ss\.fff");
		vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
		return gameTimeTimeSpan;
	}
}

isLoading
{	
	return true;	
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
	vars.LOG_CurrentRTA = "[" + System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "") + "]";
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
	
		if (vars.version == ""){
			// Game version not yet detected
		} else if (settings["SPLITSinfo"] || vars.ILid >= 0){
			o_LEVEL_ID = vars.watchers["LEVEL_ID"].Old;
			c_LEVEL_ID = vars.watchers["LEVEL_ID"].Current;
			o_PATH_ID = vars.watchers["PATH_ID"].Old;
			c_PATH_ID = vars.watchers["PATH_ID"].Current;
			o_CAM_ID = vars.watchers["CAM_ID"].Old;
			c_CAM_ID = vars.watchers["CAM_ID"].Current;
			o_FMV_ID = vars.watchers["FMV_ID"].Old;
			c_FMV_ID = vars.watchers["FMV_ID"].Current;
			abeY = vars.watchers["abeY"].Current;
		
							
			// Mines (LEVEL_ID 1)
				if (settings["minesSplit"] || vars.ILid == 0) {		
					if (c_LEVEL_ID == 1) { // If we are in Mines...		
						if (settings["minesExtended"] || vars.ILid == 0){ // 14 - 21
						// Tunnel 1 SPLIT
							if (c_FMV_ID == 71 && vars.splits[14] != true) {
								vars.splits[14] = true;
								vars.LOG_LastSplit = "Tunnel 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 2 SPLIT
							if (o_PATH_ID == 2 && c_PATH_ID == 3 && vars.splits[15] != true) {
								vars.splits[15] = true;
								vars.LOG_LastSplit = "Tunnel 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Slog SPLIT
							if (o_PATH_ID == 3 && c_PATH_ID == 4 && vars.splits[16] != true) {
								vars.splits[16] = true;
								vars.LOG_LastSplit = "Slogs. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 3 SPLIT
							if (c_FMV_ID == 32 && vars.splits[17] != true) {
								vars.splits[17] = true;
								vars.LOG_LastSplit = "Tunnel 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 4 SPLIT
							if (c_FMV_ID == 17 && vars.splits[18] != true) {
								vars.splits[18] = true;
								vars.LOG_LastSplit = "Tunnel 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 5 SPLIT
							if (c_FMV_ID == 5 && vars.splits[19] != true) {
								vars.splits[19] = true;
								vars.LOG_LastSplit = "Tunnel 5. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 6 SPLIT
							if (c_FMV_ID == 30 && vars.splits[20] != true) {
								vars.splits[20] = true;
								vars.LOG_LastSplit = "Tunnel 6. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Tunnel 7 SPLIT
							if (c_FMV_ID == 28 && vars.splits[21] != true) {
								vars.splits[21] = true;
								vars.LOG_LastSplit = "Tunnel 7. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
					// MINES SPLIT
						if (c_FMV_ID == 232 && vars.splits[0] != true) {
							vars.splits[0] = true;
							vars.LOG_LastSplit = "Mines, last split. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
								vars.LOG_LastSplit = "Mudomo Entry 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Entry 2
						if (c_FMV_ID == 33 && vars.splits[31] != true) {
								vars.splits[31] = true;
								vars.LOG_LastSplit = "Mudomo Entry 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Entry 3
						if (c_PATH_ID == 8 && vars.splits[32] != true) {
								vars.splits[32] = true;
								vars.LOG_LastSplit = "Mudomo Entry 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 1
						if (c_FMV_ID == 13 && vars.splits[33] != true) {
								vars.splits[33] = true;
								vars.LOG_LastSplit = "Mudomo Trial 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 2
						if (c_FMV_ID == 17 && vars.splits[34] != true) {
								vars.splits[34] = true;
								vars.LOG_LastSplit = "Mudomo Trial 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 3
						if (c_FMV_ID == 15 && vars.splits[35] != true) {
								vars.splits[35] = true;
								vars.LOG_LastSplit = "Mudomo Trial 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 4
						if (c_FMV_ID == 9 && vars.splits[36] != true) {
								vars.splits[36] = true;
								vars.LOG_LastSplit = "Mudomo Trial 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 5
						if (c_FMV_ID == 6 && vars.splits[37] != true) {
								vars.splits[37] = true;
								vars.LOG_LastSplit = "Mudomo Trial 5. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Mudomo Trial 6
						if (c_FMV_ID == 31 && vars.splits[38] != true) {
								vars.splits[38] = true;
								vars.LOG_LastSplit = "Mudomo Trial 6. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					}
					
				// Mudomo Vaults
					if ((settings["mudomoExtended"] || vars.ILid == 2) && o_LEVEL_ID == 11 && c_LEVEL_ID == 2 && vars.splits[39] != true) {
						vars.splits[39] = true;
						vars.LOG_LastSplit = "Mudomo Vaults. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
					
				// PRE-Mudomo split
					if (c_LEVEL_ID == 2 && c_PATH_ID == 5 && c_CAM_ID == 1 && c_FMV_ID != 8){ 
						vars.preSplitMudomo = true;
					}
				
				// Mudomo split
					if ((vars.countToMud >= 1000 || vars.ILid == 2) && ((c_LEVEL_ID == 4 && c_PATH_ID == 6 && c_CAM_ID == 23 && c_FMV_ID == 34 && vars.preSplitMudomo) || (o_PATH_ID == 3 && c_PATH_ID == 1 && c_LEVEL_ID == 5)) && vars.splits[2] != true) { 
						vars.splits[2] = true;
						vars.LOG_LastSplit = "Mudomo. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
								vars.LOG_LastSplit = "Mudanchee Entry 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 2
							if (c_FMV_ID == 30 && vars.splits[41] != true) {
								vars.splits[41] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 3
							if (c_FMV_ID == 28 && vars.splits[42] != true) {
								vars.splits[42] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Entry 4
							if (c_PATH_ID == 7 && o_CAM_ID == 2 && c_CAM_ID == 4 && vars.splits[43] != true) {
								vars.splits[43] = true;
								vars.LOG_LastSplit = "Mudanchee Entry 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 1
							if (c_FMV_ID == 2 && vars.splits[44] != true) {
								vars.splits[44] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 2
							if (c_FMV_ID == 6 && vars.splits[45] != true) {
								vars.splits[45] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 3
							if (c_FMV_ID == 23 && vars.splits[46] != true) {
								vars.splits[46] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 4
							if (c_FMV_ID == 14 && vars.splits[47] != true) {
								vars.splits[47] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 5
							if (c_FMV_ID == 3 && vars.splits[48] != true) {
								vars.splits[48] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 5. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Mudanchee Trial 6
							if (c_FMV_ID == 11 && vars.splits[49] != true) {
								vars.splits[49] = true;
								vars.LOG_LastSplit = "Mudanchee Trial 6. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
					// Mudanchee Vaults
						if (o_LEVEL_ID == 7 && c_LEVEL_ID == 2 && vars.splits[50] != true) { 
							vars.splits[50] = true;
							vars.LOG_LastSplit = "Mudanchee Vaults. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}

					if (c_LEVEL_ID == 2 && c_PATH_ID == 5 && c_CAM_ID == 9 && c_FMV_ID != 8){ // Pre-Mudanchee split
						vars.preSplitMudanchee = true;
					}
					
					if ((vars.countToMud >= 1000 || vars.ILid == 3) && ((c_LEVEL_ID == 3 && c_PATH_ID == 1 && c_CAM_ID == 1 && c_FMV_ID == 25 && vars.preSplitMudanchee) || (o_PATH_ID == 3 && c_PATH_ID == 1 && c_LEVEL_ID == 5)) && vars.splits[3] != true) { // Mudanchee Split: we are in Mudomo or Wheel to FeeCo. 
						vars.splits[3] = true;
						vars.LOG_LastSplit = "Mudanchee. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
								vars.LOG_LastSplit = "Necrum Entry. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Hands SPLIT
							if (c_FMV_ID == 9 && vars.splits[23] != true) {
								vars.splits[23] = true;
								vars.LOG_LastSplit = "Handstones. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches Entry SPLIT
							if (c_FMV_ID == 6 && vars.splits[24] != true) {
								vars.splits[24] = true;
								vars.LOG_LastSplit = "Fleeches Entry. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 1 SPLIT
							if (c_FMV_ID == 18 && vars.splits[25] != true) {
								vars.splits[25] = true;
								vars.LOG_LastSplit = "Fleeches 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 2 SPLIT
							if (c_FMV_ID == 19 && vars.splits[26] != true) {
								vars.splits[26] = true;
								vars.LOG_LastSplit = "Fleeches 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 3 SPLIT
							if (c_FMV_ID == 20 && vars.splits[27] != true) {
								vars.splits[27] = true;
								vars.LOG_LastSplit = "Fleeches 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 4 SPLIT
							if (c_FMV_ID == 21 && vars.splits[28] != true) {
								vars.splits[28] = true;
								vars.LOG_LastSplit = "Fleeches 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Fleeches 5 SPLIT
							if (c_FMV_ID == 15 && vars.splits[29] != true) {
								vars.splits[29] = true;
								vars.LOG_LastSplit = "Fleeches 5. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
						vars.LOG_LastSplit = "Necrum to Mudomo / Mudanchee. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
						vars.LOG_LastSplit = "Necrum to FeeCo. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////

			// FeeCo & FeeCo 2 (LEVEL_ID 5)
				if (settings["feecoSplit"] || vars.ILid == 4) { 					
					if ((settings["feecoExtended"] || vars.ILid == 4) && c_LEVEL_ID == 2 && o_PATH_ID == 3 && o_CAM_ID == 2 && c_PATH_ID == 3 && c_CAM_ID == 9 && vars.splits[1] == true && vars.splits[2] == true && vars.splits[3] == true) { // SPECIAL: FeeCo entry through Necrum using Farewell FeeCo skip
						vars.splits[51] = true;
						vars.LOG_LastSplit = "Special split: Necrum to Terminal 1 (Any% | Farewell FeeCo skip). " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
					
					if ((settings["feecoExtended"] || vars.ILid == 4) && c_LEVEL_ID == 5) { // 51 - 55		
					// FeeCo Entry
						if (c_PATH_ID == 1 && c_CAM_ID == 3 && vars.splits[51] != true) {
							vars.splits[51] = true;
							vars.LOG_LastSplit = "FeeCo Entry. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal 1
						if (c_PATH_ID == 7 && c_CAM_ID == 1 && vars.splits[52] != true) {
							vars.splits[52] = true;
							vars.LOG_LastSplit = "Terminal 1. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal 2
						if (o_PATH_ID == 7 && c_PATH_ID == 2 && c_CAM_ID == 8 && (vars.splits[53] != true || vars.splits[0] == true || vars.splits[1] == true) && vars.Terminal2Split == false) { // 0 is for 2nd save. 1 is for 3rd save file.
							vars.Terminal2Split = true;
							vars.splits[53] = true;
							if (vars.splits[1] == true){ // Loading the second save file						
								vars.LOG_LastSplit = "Terminal 2 (go to Executive Office!) " + vars.LOG_CurrentRTA;	
							} else if (vars.splits[0] == true){ // Loading the third save file					
								vars.LOG_LastSplit = "Terminal 2 (go to Bonewerkz!) " + vars.LOG_CurrentRTA;			
							} else { // First time we come here
								vars.LOG_LastSplit = "Terminal 2 (go to Barracks!) " + vars.LOG_CurrentRTA;								
							}
							if (vars.splits[1] == true){								
								vars.splits[0] = false;
								vars.splits[1] = false;
							}
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							vars.ILWaitTimer = false;
							return true;
						}
						
					// Terminal principal to Slig Barracks
					 // if (o_PATH_ID == 9 && c_PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 3
						if (o_PATH_ID == 9 && c_PATH_ID == 3 && vars.splits[54] != true) { // If I enter on Terminal 3
							vars.splits[54] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Main Terminal to Terminal 3. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal principal to Bonewerkz
						if (o_PATH_ID == 9 && c_PATH_ID == 4 && vars.splits[54] != true) { // If I enter on Terminal 4
							vars.splits[54] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Main Terminal to Terminal 4. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Terminal principal to Soulstorm Brewery
						if (o_PATH_ID == 2 && c_PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 5
							vars.splits[54] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Main Terminal to Terminal 5. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 3
						if (c_PATH_ID == 5 && o_CAM_ID == 3 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Terminal 3. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 4
						if (vars.ILid == -1 && c_PATH_ID == 4 && o_CAM_ID == 13 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Terminal 4. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
							
					// Terminal 5
						if (c_PATH_ID == 5 && o_CAM_ID == 7 && c_CAM_ID == 14 && vars.splits[55] != true) {
							vars.splits[55] = true;
							vars.Terminal2Split = false;
							vars.LOG_LastSplit = "Terminal 5. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}		
				}
				// Enter on any of the train doors
				if (vars.ILid == 4 && o_LEVEL_ID == 5 && (c_LEVEL_ID == 6 || c_LEVEL_ID == 8 || c_LEVEL_ID == 9) && (vars.splits[0] != true || vars.splits[1] != true)){ 				
					vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					vars.ILWaitTimer = true;	
					vars.Terminal2Split = false;					
					if (vars.splits[0] == false){								
						vars.splits[0] = true;						
						vars.LOG_LastSplit = "FeeCo 1. (LOAD SAVE FILE 2)" + vars.LOG_CurrentRTA;
					} else {						
						vars.splits[1] = true;		
						vars.LOG_LastSplit = "FeeCo 2. (LOAD SAVE FILE 3)" + vars.LOG_CurrentRTA;	
					}
					return true;
				}
					
				if (vars.ILid == -1 && (settings["feecoSplit"] || vars.SplitFeeco2 || vars.ILid == 4) && o_LEVEL_ID == 5 && (c_LEVEL_ID == 6 || c_LEVEL_ID == 8 || c_LEVEL_ID == 9) && vars.splits[4] != true) { // FeeCo Split. 6 is Bonewerkz.  5 is Barracks. 15 is Brewery
					vars.splits[4] = true;
					vars.splitsFeeCoAgain = vars.splits[4];
					vars.splits[8] = true; // We avoid double split if we go from FeeCo to Soulstorm directly.
					if (vars.splits[5]) { // Slig Barracks ya fue completado.
						vars.LOG_LastSplit = "FeeCo 2 to Bonewerkz. " + vars.LOG_CurrentRTA;
					} else if (vars.splits[6]){ // Bonewerkz ya fue completado.
						vars.LOG_LastSplit = "FeeCo 2 to Slig Barracks. " + vars.LOG_CurrentRTA;		
					} else { // Nada fue completado.
						vars.LOG_LastSplit = "FeeCo 1. " + vars.LOG_CurrentRTA;
					}
					vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;
				}
			//////////////////////////////
					
			// Slig Barracks (LEVEL_ID 6)
				if (settings["barracksSplit"] || vars.ILid == 6) {
					if ((settings["barracksExtended"] || vars.ILid == 6) && c_LEVEL_ID == 6) { // 56 - 62			
					// Block 0
						if (o_PATH_ID == 13 && c_PATH_ID == 2 && vars.splits[56] != true) {
							vars.splits[56] = true;
							vars.LOG_LastSplit = "Block 0. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 1
						if (o_PATH_ID == 10 && c_PATH_ID == 2 && vars.splits[57] != true) {
							vars.splits[57] = true;
							vars.LOG_LastSplit = "Block 1. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 2
						if (o_PATH_ID == 5 && c_PATH_ID == 2 && vars.splits[58] != true) {
							vars.splits[58] = true;
							vars.LOG_LastSplit = "Block 2. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 3
						if (o_PATH_ID == 7 && c_PATH_ID == 2 && vars.splits[59] != true) {
							vars.splits[59] = true;
							vars.LOG_LastSplit = "Block 3. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Block 4
						if (o_PATH_ID == 14 && c_PATH_ID == 2 && vars.splits[60] != true) {
							vars.splits[60] = true;
							vars.LOG_LastSplit = "Block 4. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}	
					
					}
				// Dripik (fixed 08 June 2020)
					if ((settings["barracksExtended"] || vars.ILid == 6) && c_LEVEL_ID == 13 && o_PATH_ID == 11 && c_PATH_ID == 16 && vars.splits[61] != true) {
						vars.splits[61] = true;
						vars.LOG_LastSplit = "Dripik. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
						vars.LOG_LastSplit = "Slig Barracks. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
								vars.LOG_LastSplit = "Bonewerkz Entry. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 1
							if (o_PATH_ID == 7 && c_PATH_ID == 1 && vars.splits[64] != true) {
								vars.splits[64] = true;
								vars.LOG_LastSplit = "Annex 1. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 2
							if (o_PATH_ID == 1 && c_PATH_ID == 2 && vars.splits[65] != true) {
								vars.splits[65] = true;
								vars.LOG_LastSplit = "Annex 2. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 3
							if (c_PATH_ID == 2 && c_CAM_ID == 4 && vars.splits[66] != true) {
								vars.splits[66] = true;
								vars.LOG_LastSplit = "Annex 3. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 4
							if (c_PATH_ID == 2 && c_CAM_ID == 7 && vars.splits[67] != true) {
								vars.splits[67] = true;
								vars.LOG_LastSplit = "Annex 4. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 5
							if (c_PATH_ID == 2 && c_CAM_ID == 9 && vars.splits[68] != true) {
								vars.splits[68] = true;
								vars.LOG_LastSplit = "Annex 5. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 6
							if (o_PATH_ID == 2 && c_PATH_ID == 3 && vars.splits[69] != true) {
								vars.splits[69] = true;
								vars.LOG_LastSplit = "Annex 6. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
						// Annex 7
							if (o_PATH_ID == 3 && c_PATH_ID == 4 && vars.splits[70] != true) {
								vars.splits[70] = true;
								vars.LOG_LastSplit = "Annex 7. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
						}
						
						if (c_LEVEL_ID == 14){
						// Annex 8
							if (c_PATH_ID == 14 && vars.splits[71] != true) {
								vars.splits[71] = true;
								vars.LOG_LastSplit = "Annex 8. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
								return true;
							}
							
							if (c_LEVEL_ID == 14 && c_PATH_ID == 9 && c_CAM_ID == 15) { // Screen with the glukkon intercom phone
								vars.PrePhlegSplit = true;
							}
							
						// Phleg
							if (vars.PrePhlegSplit && c_PATH_ID == 9 && o_CAM_ID == 9 && c_CAM_ID == 8 && vars.splits[72] != true) {
								vars.splits[72] = true;
								vars.LOG_LastSplit = "Phleg. " + vars.LOG_CurrentRTA;
								vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
						vars.LOG_LastSplit = "Bonewerkz. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ".";
						return true;
					}
				}
			//////////////////////////////

			// Executive Office (LEVEL_ID 12)
				if (settings["officeSplit"] || vars.ILid == 4) {
					if ((settings["officeExtended"] || vars.ILid == 4) && c_LEVEL_ID == 12){ // 73, 74
						
					// Entry Executive Office
						if ((o_CAM_ID == 4 && c_CAM_ID == 5) || (o_CAM_ID == 1 && c_CAM_ID == 2 && c_PATH_ID == 14) && vars.splits[73] != true) {
							vars.splits[73] = true;
							vars.LOG_LastSplit = "Entry Executive Office. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Aslik
						if (c_CAM_ID == 2 && c_PATH_ID == 14 && vars.splits[74] != true) {
							vars.splits[74] = true;
							vars.LOG_LastSplit = "Aslik. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
					if (o_LEVEL_ID == 12 && c_LEVEL_ID == 5 && vars.splits[7] != true) {
						vars.splits[7] = true;
						vars.LOG_LastSplit = "Executive Office. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
			//////////////////////////////	
					
			// FeeCo 3 (LEVEL_ID 5)
				if ((settings["feeco3Split"] || vars.ILid == 4) && o_LEVEL_ID == 5 && c_LEVEL_ID == 9 && vars.splits[8] != true) {	
					vars.splits[8] = true;
						vars.LOG_LastSplit = "FeeCo to Terminal 5. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;
				}
					
			// Hub I (LEVEL_ID 9)
				if ((settings["hub1Split"] || vars.ILid == 7) && c_LEVEL_ID == 9){
					if (settings["hub1Extended"] || vars.ILid == 7){ // 75 - 80
					// SoulStorm Brewery Entry
						if (o_PATH_ID == 16 && c_PATH_ID == 23 && vars.splits[75] != true) {
							vars.splits[75] = true;
							vars.LOG_LastSplit = "Zulag 0 (Soulstorm Brewery Entry). " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 1
						if (o_PATH_ID == 1 && c_PATH_ID == 23 && vars.splits[76] != true) {
							vars.splits[76] = true;
							vars.LOG_LastSplit = "Zulag 1. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 2
						if (o_PATH_ID == 2 && c_PATH_ID == 23 && vars.splits[77] != true) {
							vars.splits[77] = true;
							vars.LOG_LastSplit = "Zulag 2. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 3
						if (o_PATH_ID == 12 && c_PATH_ID == 23 && vars.splits[78] != true) {
							vars.splits[78] = true;
							vars.LOG_LastSplit = "Zulag 3. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 4
						if (o_PATH_ID == 19 && c_PATH_ID == 23 && vars.splits[79] != true) {
							vars.splits[79] = true;
							vars.LOG_LastSplit = "Zulag 4. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 5
						if (o_PATH_ID == 14 && c_PATH_ID == 23 && vars.splits[80] != true) {
							vars.splits[80] = true;
							vars.LOG_LastSplit = "Zulag 5. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}	
					
				// Hub 1
					if (o_PATH_ID == 23 && c_PATH_ID == 24 && vars.splits[9] != true) { 
						vars.splits[9] = true;
						vars.LOG_LastSplit = "Hub 1. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
							vars.LOG_LastSplit = "Zulag 6. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 7
						if (o_PATH_ID == 6 && o_CAM_ID == 10 && c_PATH_ID == 24 && vars.splits[82] != true) {
							vars.splits[82] = true;
							vars.LOG_LastSplit = "Zulag 7. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 8
						if (o_PATH_ID == 3 && c_PATH_ID == 24 && vars.splits[83] != true) {
							vars.splits[83] = true;
							vars.LOG_LastSplit = "Zulag 8. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 9
						if (o_PATH_ID == 17 && c_PATH_ID == 24 && vars.splits[84] != true) {
							vars.splits[84] = true;
							vars.LOG_LastSplit = "Zulag 9. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 10
						if (o_PATH_ID == 10 && c_PATH_ID == 24 && vars.splits[85] != true) {
							vars.splits[85] = true;
							vars.LOG_LastSplit = "Zulag 10. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
				// Hub 2
					if (o_PATH_ID == 24 && c_PATH_ID == 25 && vars.splits[10] != true) {
						vars.splits[10] = true;
						vars.LOG_LastSplit = "Hub 2. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
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
							vars.LOG_LastSplit = "Zulag 11. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					// Zulag 12
						if (o_PATH_ID == 11 && c_PATH_ID == 25 && vars.splits[87] != true) {
							vars.splits[87] = true;
							vars.LOG_LastSplit = "Zulag 12. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
					// Zulag 13
						if ((o_PATH_ID == 20 || o_PATH_ID == 15) && c_PATH_ID == 25 && vars.splits[88] != true) {
							vars.splits[88] = true;
							vars.LOG_LastSplit = "Zulag 13. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
						
						
					// Zulag 14
						if (o_PATH_ID == 4 && o_CAM_ID == 13 && c_PATH_ID == 25 && vars.splits[89] != true) {
							vars.splits[89] = true;
							vars.LOG_LastSplit = "Zulag 14. " + vars.LOG_CurrentRTA;
							vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
							return true;
						}
					}
					
				// Hub 3
					if (c_LEVEL_ID == 10 && c_PATH_ID == 1 && vars.splits[11] != true) {
						vars.splits[11] = true;
						vars.LOG_LastSplit = "Hub 3. " + vars.LOG_CurrentRTA;
						vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
						return true;
					}
				}
					
			//////////////////////////////

			// Soulstorm Brewery		
				if ((settings["boilerSplit"] || vars.ILid == 10) && c_LEVEL_ID == 10 && (c_FMV_ID == 17 || c_FMV_ID == 18 || c_CAM_ID == 15) && vars.splits[12] != true) {		
					vars.splits[12] = true;	
					vars.LOG_LastSplit = "Zulag 15. Game is over! FINAL TIME-> " + vars.LOG_CurrentRTA;
					vars.DEBUG_LocationLastSplit = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ".";
					return true;	
				}
		
		}
	}
	
//##########################################################


// Other functions not related with splits whatsoever.

	if (c_LEVEL_ID > 0){
		vars.DEBUG_CurrentPositionAndTime = "Level = " + c_LEVEL_ID + ". Path = " + c_PATH_ID + ". Cam = " + c_CAM_ID + ". FMV = " + c_FMV_ID + ". abeY = " + abeY + ". Time: " + System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "");
	} else {		
		vars.DEBUG_CurrentPositionAndTime = "Enter on the game first through the Start menu ;)";
		vars.DEBUG_LocationLastSplit = "The first split will save the values of the game.";
	}

	if (c_LEVEL_ID == 1 && c_PATH_ID == 1){
		if (c_CAM_ID == 3){ // We disable the reset option.
			vars.ResetAllowed = false;
		} else if (c_CAM_ID != 4) {// If we are not on the dangerous reset point or in the first screen, we re-enable the reset ability
			vars.ResetAllowed = true;
		}
	}	
	
	// --------------------------------------------
	
// LOG TOOL FOR DEBUG. 		
	if (vars.countToMud > 0 && vars.countToMud <= 999){
		vars.countToMud = vars.countToMud + 1;
	} 
}
