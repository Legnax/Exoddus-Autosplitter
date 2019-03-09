//  An autosplitter for Abe's Exoddus for PC: English, Spanish, French, German and English GoG. 
//  Make sure you check either Spanish or Germa incase you are using this 2 languages: otherwise, leave everything unchecked.
//  Created by LegnaX. Special thanks to MirkyPoo for fixing some stuff.

state("Exoddus", "EN") // ENGLISH, GERMAN and ENGLISH GoG OFFSETS
{	
	byte LEVEL_ID : 0x1C3030;
	byte PATH_ID : 0x1C3032;
	byte CAM_ID : 0x1C3034;
	byte FMV_ID : 0x1C3042;
	short abeY : 0x1C1230, 0x68, 0xBE; // 1E12
}

state("Exoddus", "ES") // SPANISH OFFSETS (390 values away) (Uncheck the GoG checkbox if using spanish version; leave it checked otherwise)
{	
	byte LEVEL_ID : 0x1C33C0;
	byte PATH_ID : 0x1C33C2;
	byte CAM_ID : 0x1C33C4;
	byte FMV_ID : 0x1C33D2;
	short abeY : 0x1C1EF8, 0xBE; // FMV_ID + 14DA
}

state("Exoddus", "FR")// FRENCH OFFSETS 
{	
	byte LEVEL_ID : 0x1C3912; // 1C3908
	byte PATH_ID : 0x1C3914; // 1C390A
	byte CAM_ID : 0x1C3916; // 1C390C
	byte FMV_ID : 0x1C391A; // 1C3910
	short abeY : 0x1C2440, 0xBE; // 1C4DEA 14DA
}


state("Exoddus", "FRs")// FRENCH Steam OFFSETS 
{	
	byte LEVEL_ID : 0x1C3908; // 1C3908
	byte PATH_ID : 0x1C390A; // 1C390A
	byte CAM_ID : 0x1C390C; // 1C390C
	byte FMV_ID : 0x1C391A; // 1C3910
	short abeY : 0x1C2440, 0xBE; // 1C4DEA 14DA
}

state("Exoddus", "DE")// DEUTSCH OFFSETS 
{	
	byte LEVEL_ID : 0x1C3A08;
	byte PATH_ID : 0x1C3A0A;
	byte CAM_ID : 0x1C3A0C;
	byte FMV_ID : 0x1C3A1A;
	short abeY : 0x1C2540, 0xBE; // FMV_ID + 14DA
}

startup
{
	settings.Add("version", true, "Version 1.3. By LegnaX. https://github.com/Legnax/Exoddus-Autosplitter");
	
	settings.Add("Spanish", false, "Check ONLY if you are using Spanish game.");
	settings.SetToolTip("Spanish", "For some odd reason, the ModuleMemorySize of the English version and the Spanish version is the same, while it's offsets are different, making the autosplit have a bad time for identifying the version of the game on this case.");
	
	settings.Add("French", false, "Check ONLY if you are using French game.");
	settings.SetToolTip("French", "For some odd reason, the ModuleMemorySize of the French version and the German version is the same, while it's offsets are different, making the autosplit have a bad time for identifying the version of the game on this case.");
	
	settings.Add("FrenchSteam", false, "Check ONLY if you are using French STEAM game.");
	settings.SetToolTip("FrenchSteam", "For some odd reason, the ModuleMemorySize of the French steam version and the German steam version is the same, while it's offsets are different, making the autosplit have a bad time for identifying the version of the game on this case.");
	
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
	if (modules.First().ModuleMemorySize == 8785920){ // That module is for spanish GoG. Same module as German or EN GoG game.
		if (settings["Spanish"]){
			version = "ES" ;
		} else {
			version = "EN" ;			
		}
	} else if (modules.First().ModuleMemorySize == 8790016){ // That module is for german or french game.
		if (settings["French"]){
			version = "FR" ;
		} else {
			version = "DE" ;			
		}
	} else if (modules.First().ModuleMemorySize == 9142272){  // That module is for STEAM German or French game.
		if (settings["FrenchSteam"]){
			version = "FRs";			
		} else {
			version = "DE" ;			
		}
	} else if (modules.First().ModuleMemorySize == 9138176){ // That module is for spanish. 
		version = "ES" ;
	} else { // Any different module (like GoG or unknown lang) will be loaded here. You need this for English or German.
		version = "EN" ;
	}	
	refreshRate = 15;	// Refresh rate of the script (per second).
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
	
	// 0 - 13 main splits. 14 - 21 Mines. 22 - 29 Necrum. 30 - 39 Mudomo. 40 - 50 Mudanchee. 51 - 55 FeeCo. 56 - 62 Barracks. 63 - 72 Bonewerkz.
	bool[] splitsTemp = new bool[95];
	vars.splits = splitsTemp;
	vars.splitsFeeCoAgain = vars.splits[4];
} 

start
{
	refreshRate = 15;	
	// if (!settings["GoG"] && version.Contains("EN")) { // We switch to spanish
		// version = "ES";
	// }	
	// if (settings["GoG"] && version.Contains("ES")) { // We switch to english
		// version = "EN";
	// }
	
	if (current.PATH_ID == 0) { // Wrong values, we switch ModuleMemory.
		if (modules.First().ModuleMemorySize == 8785920){ 
			version = "ES" ;
			vars.LOG_LastSplit = "No split yet. Game version: " + version;
		} else if (modules.First().ModuleMemorySize == 8790016){
			version = "DE" ;
			vars.LOG_LastSplit = "No split yet. Game version: " + version;
		}
	}
	
	if (current.LEVEL_ID == 01 && current.PATH_ID == 1 && current.CAM_ID == 4 && current.abeY == 1500 && old.abeY < 1500 && old.abeY > 100) {
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
		return true;		
	} else {
		return false;
	}
}

split
{		
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
	
	// Mines (LEVEL_ID 1)
		if (settings["minesSplit"]) {		
			if (current.LEVEL_ID == 1) { // If we are in Mines...		
				if (settings["minesExtended"]){ // 14 - 21
				// Tunnel 1 SPLIT
					if (current.FMV_ID == 71 && vars.splits[14] != true) {
						vars.splits[14] = true;
						vars.LOG_LastSplit = "Tunnel 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 2 SPLIT
					if (old.PATH_ID == 2 && current.PATH_ID == 3 && vars.splits[15] != true) {
						vars.splits[15] = true;
						vars.LOG_LastSplit = "Tunnel 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Slog SPLIT
					if (old.PATH_ID == 3 && current.PATH_ID == 4 && vars.splits[16] != true) {
						vars.splits[16] = true;
						vars.LOG_LastSplit = "Slogs. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 3 SPLIT
					if (current.FMV_ID == 32 && vars.splits[17] != true) {
						vars.splits[17] = true;
						vars.LOG_LastSplit = "Tunnel 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 4 SPLIT
					if (current.FMV_ID == 17 && vars.splits[18] != true) {
						vars.splits[18] = true;
						vars.LOG_LastSplit = "Tunnel 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 5 SPLIT
					if (current.FMV_ID == 5 && vars.splits[19] != true) {
						vars.splits[19] = true;
						vars.LOG_LastSplit = "Tunnel 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 6 SPLIT
					if (current.FMV_ID == 30 && vars.splits[20] != true) {
						vars.splits[20] = true;
						vars.LOG_LastSplit = "Tunnel 6. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Tunnel 7 SPLIT
					if (current.FMV_ID == 28 && vars.splits[21] != true) {
						vars.splits[21] = true;
						vars.LOG_LastSplit = "Tunnel 7. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
				}
				
			// MINES SPLIT
				if (current.FMV_ID == 232 && vars.splits[0] != true) {
					vars.splits[0] = true;
						vars.LOG_LastSplit = "Mines, last split. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}
		}
	//////////////////////////////

	// Mudomo (LEVEL_ID 3, Vaults is LEVEL_ID 11)
		if (settings["mudomoSplit"]){
			if (current.LEVEL_ID == 3 && settings["mudomoExtended"]){ // 30 - 39
			
			// Mudomo Entry 1
				if (current.FMV_ID == 29 && vars.splits[30] != true) {
						vars.splits[30] = true;
						vars.LOG_LastSplit = "Mudomo Entry 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Entry 2
				if (current.FMV_ID == 33 && vars.splits[31] != true) {
						vars.splits[31] = true;
						vars.LOG_LastSplit = "Mudomo Entry 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Entry 3
				if (current.PATH_ID == 8 && vars.splits[32] != true) {
						vars.splits[32] = true;
						vars.LOG_LastSplit = "Mudomo Entry 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 1
				if (current.FMV_ID == 13 && vars.splits[33] != true) {
						vars.splits[33] = true;
						vars.LOG_LastSplit = "Mudomo Trial 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 2
				if (current.FMV_ID == 17 && vars.splits[34] != true) {
						vars.splits[34] = true;
						vars.LOG_LastSplit = "Mudomo Trial 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 3
				if (current.FMV_ID == 15 && vars.splits[35] != true) {
						vars.splits[35] = true;
						vars.LOG_LastSplit = "Mudomo Trial 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 4
				if (current.FMV_ID == 9 && vars.splits[36] != true) {
						vars.splits[36] = true;
						vars.LOG_LastSplit = "Mudomo Trial 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 5
				if (current.FMV_ID == 6 && vars.splits[37] != true) {
						vars.splits[37] = true;
						vars.LOG_LastSplit = "Mudomo Trial 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Mudomo Trial 6
				if (current.FMV_ID == 31 && vars.splits[38] != true) {
						vars.splits[38] = true;
						vars.LOG_LastSplit = "Mudomo Trial 6. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			}
			
		// Mudomo Vaults
			if (old.LEVEL_ID == 11 && current.LEVEL_ID == 2 && settings["mudomoExtended"] && vars.splits[39] != true) {
				vars.splits[39] = true;
				vars.LOG_LastSplit = "Mudomo Vaults. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
			
		// PRE-Mudomo split
			if (current.LEVEL_ID == 2 && current.PATH_ID == 5 && current.CAM_ID == 1 && current.FMV_ID != 8){ 
				vars.preSplitMudomo = true;
			}
		
		// Mudomo split
			if (vars.countToMud >= 90 && ((current.LEVEL_ID == 4 && current.PATH_ID == 6 && current.CAM_ID == 23 && current.FMV_ID == 34 && vars.preSplitMudomo) || (old.PATH_ID == 3 && current.PATH_ID == 1 && current.LEVEL_ID == 5)) && vars.splits[2] != true) { 
				vars.splits[2] = true;
				vars.LOG_LastSplit = "Mudomo. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////

	// Mudanchee (LEVEL_ID 4)
		if (settings["mudancheeSplit"]){
			if (settings["mudancheeExtended"]){ // 40 - 50
				if (current.LEVEL_ID == 4){
				// Mudanchee Entry 1
					if (current.FMV_ID == 25 && vars.splits[40] != true) {
						vars.splits[40] = true;
						vars.LOG_LastSplit = "Mudanchee Entry 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Entry 2
					if (current.FMV_ID == 30 && vars.splits[41] != true) {
						vars.splits[41] = true;
						vars.LOG_LastSplit = "Mudanchee Entry 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Entry 3
					if (current.FMV_ID == 28 && vars.splits[42] != true) {
						vars.splits[42] = true;
						vars.LOG_LastSplit = "Mudanchee Entry 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Entry 4
					if (current.PATH_ID == 7 && old.CAM_ID == 2 && current.CAM_ID == 4 && vars.splits[43] != true) {
						vars.splits[43] = true;
						vars.LOG_LastSplit = "Mudanchee Entry 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 1
					if (current.FMV_ID == 2 && vars.splits[44] != true) {
						vars.splits[44] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 2
					if (current.FMV_ID == 6 && vars.splits[45] != true) {
						vars.splits[45] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 3
					if (current.FMV_ID == 23 && vars.splits[46] != true) {
						vars.splits[46] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 4
					if (current.FMV_ID == 14 && vars.splits[47] != true) {
						vars.splits[47] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 5
					if (current.FMV_ID == 3 && vars.splits[48] != true) {
						vars.splits[48] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Mudanchee Trial 6
					if (current.FMV_ID == 11 && vars.splits[49] != true) {
						vars.splits[49] = true;
						vars.LOG_LastSplit = "Mudanchee Trial 6. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
				}
				
			// Mudanchee Vaults
				if (old.LEVEL_ID == 7 && current.LEVEL_ID == 2 && vars.splits[50] != true) { 
					vars.splits[50] = true;
					vars.LOG_LastSplit = "Mudanchee Vaults. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}

			if (current.LEVEL_ID == 2 && current.PATH_ID == 5 && current.CAM_ID == 9 && current.FMV_ID != 8){ // Pre-Mudanchee split
				vars.preSplitMudanchee = true;
			}
			
			if (vars.countToMud >= 90 && ((current.LEVEL_ID == 3 && current.PATH_ID == 1 && current.CAM_ID == 1 && current.FMV_ID == 25 && vars.preSplitMudanchee) || (old.PATH_ID == 3 && current.PATH_ID == 1 && current.LEVEL_ID == 5)) && vars.splits[3] != true) { // Mudanchee Split: we are in Mudomo or Wheel to FeeCo. 
				vars.splits[3] = true;
				vars.LOG_LastSplit = "Mudanchee. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////
		
	// Necrum (LEVEL_ID 2)
		if (settings["necrumSplit"]) {
			if (current.LEVEL_ID == 2){
				if (settings["necrumExtended"]) { // 22 - 29
				// Necrum Entry SPLIT
					if (current.FMV_ID == 10 && vars.splits[22] != true) {
						vars.splits[22] = true;
						vars.LOG_LastSplit = "Necrum Entry. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Hands SPLIT
					if (current.FMV_ID == 9 && vars.splits[23] != true) {
						vars.splits[23] = true;
						vars.LOG_LastSplit = "Handstones. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches Entry SPLIT
					if (current.FMV_ID == 6 && vars.splits[24] != true) {
						vars.splits[24] = true;
						vars.LOG_LastSplit = "Fleeches Entry. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches 1 SPLIT
					if (current.FMV_ID == 18 && vars.splits[25] != true) {
						vars.splits[25] = true;
						vars.LOG_LastSplit = "Fleeches 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches 2 SPLIT
					if (current.FMV_ID == 19 && vars.splits[26] != true) {
						vars.splits[26] = true;
						vars.LOG_LastSplit = "Fleeches 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches 3 SPLIT
					if (current.FMV_ID == 20 && vars.splits[27] != true) {
						vars.splits[27] = true;
						vars.LOG_LastSplit = "Fleeches 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches 4 SPLIT
					if (current.FMV_ID == 21 && vars.splits[28] != true) {
						vars.splits[28] = true;
						vars.LOG_LastSplit = "Fleeches 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Fleeches 5 SPLIT
					if (current.FMV_ID == 15 && vars.splits[29] != true) {
						vars.splits[29] = true;
						vars.LOG_LastSplit = "Fleeches 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
				}
				
			// Necrum pre-SPLIT
				if (current.PATH_ID == 5 && (current.CAM_ID == 9 || current.CAM_ID == 1) && vars.FMVNecrum == 8){ // Prepare for last split
					vars.preSplitNecrum = true;
					vars.FMVNecrum = 0;
				}			
			} 
			
			if (current.LEVEL_ID == 2 && current.FMV_ID == 8){
				vars.FMVNecrum = current.FMV_ID;
			}
			
			// Necrum SPLITS
			if (vars.preSplitNecrum && (current.FMV_ID == 25 || current.FMV_ID == 34) && (current.LEVEL_ID >= 2 && current.LEVEL_ID <= 4) && vars.splits[1] != true) { // Cinematics: 25 is mudomo (24 end). 34 is Mudanchee (25 end). 4 is FeeCo.
				vars.splits[1] = true;
				vars.preSplitNecrum = false;
				vars.countToMud = 1;
				vars.LOG_LastSplit = "Necrum to Mudomo / Mudanchee. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
			
			if (current.LEVEL_ID == 5 && old.LEVEL_ID == 2 && vars.splits[2] != true && vars.splits[3] != true){ // From Necrum to FeeCo directly (Any%)
				vars.splits[1] = true;
				vars.splits[2] = true; // We will not use it anymore.
				vars.splits[3] = true; // We will not use it anymore.
				vars.preSplitNecrum = false;
				vars.LOG_LastSplit = "Necrum to FeeCo. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////

	// FeeCo & FeeCo 2 (LEVEL_ID 5)
		if (settings["feecoSplit"]) { 					
			if (settings["feecoExtended"] && current.LEVEL_ID == 2 && old.PATH_ID == 3 && old.CAM_ID == 2 && current.PATH_ID == 3 && current.CAM_ID == 9 && vars.splits[1] == true && vars.splits[2] == true && vars.splits[3] == true) { // SPECIAL: FeeCo entry through Necrum using Farewell FeeCo skip
				vars.splits[51] = true;
				vars.LOG_LastSplit = "Special split: Necrum to Terminal 1 (Any% | Farewell FeeCo skip). " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
			
			if (settings["feecoExtended"] && current.LEVEL_ID == 5) { // 51 - 55		
			// FeeCo Entry
				if (current.PATH_ID == 1 && current.CAM_ID == 3 && vars.splits[51] != true) {
					vars.splits[51] = true;
					vars.LOG_LastSplit = "FeeCo Entry. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Terminal 1
				if (current.PATH_ID == 7 && current.CAM_ID == 1 && vars.splits[52] != true) {
					vars.splits[52] = true;
					vars.LOG_LastSplit = "Terminal 1. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Terminal 2
				if (current.PATH_ID == 2 && current.CAM_ID == 8 && vars.splits[53] != true) {
					vars.splits[53] = true;
					vars.LOG_LastSplit = "Terminal 2. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Terminal principal to Slig Barracks
				if (old.PATH_ID == 9 && current.PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 3
					vars.splits[54] = true;
					vars.LOG_LastSplit = "Main Terminal to Terminal 3. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Terminal principal to Bonewerkz
				if (old.PATH_ID == 9 && current.PATH_ID == 4 && vars.splits[54] != true) { // If I enter on Terminal 4
					vars.splits[54] = true;
					vars.LOG_LastSplit = "Main Terminal to Terminal 4. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Terminal principal to Soulstorm Brewery
				if (old.PATH_ID == 2 && current.PATH_ID == 5 && vars.splits[54] != true) { // If I enter on Terminal 5
					vars.splits[54] = true;
					vars.LOG_LastSplit = "Main Terminal to Terminal 5. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
					
			// Terminal 3
				if (current.PATH_ID == 5 && old.CAM_ID == 3 && current.CAM_ID == 14 && vars.splits[55] != true) {
					vars.splits[55] = true;
					vars.LOG_LastSplit = "Terminal 3. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
					
			// Terminal 4
				if (current.PATH_ID == 4 && old.CAM_ID == 13 && current.CAM_ID == 14 && vars.splits[55] != true) {
					vars.splits[55] = true;
					vars.LOG_LastSplit = "Terminal 4. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
					
			// Terminal 5
				if (current.PATH_ID == 5 && old.CAM_ID == 7 && current.CAM_ID == 14 && vars.splits[55] != true) {
					vars.splits[55] = true;
					vars.LOG_LastSplit = "Terminal 5. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}		
		}
			
		if ((settings["feecoSplit"] || vars.SplitFeeco2) && old.LEVEL_ID == 5 && (current.LEVEL_ID == 6 || current.LEVEL_ID == 8 || current.LEVEL_ID == 9) && vars.splits[4] != true) { // FeeCo Split. 6 is Bonewerkz.  5 is Barracks. 15 is Brewery
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
			vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
			return true;
		}
	//////////////////////////////
			
	// Slig Barracks (LEVEL_ID 6)
		if (settings["barracksSplit"]) {
			if (settings["barracksExtended"] && current.LEVEL_ID == 6) { // 56 - 62			
			// Block 0
				if (old.PATH_ID == 13 && current.PATH_ID == 2 && vars.splits[56] != true) {
					vars.splits[56] = true;
					vars.LOG_LastSplit = "Block 0. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Block 1
				if (old.PATH_ID == 10 && current.PATH_ID == 2 && vars.splits[57] != true) {
					vars.splits[57] = true;
					vars.LOG_LastSplit = "Block 1. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Block 2
				if (old.PATH_ID == 5 && current.PATH_ID == 2 && vars.splits[58] != true) {
					vars.splits[58] = true;
					vars.LOG_LastSplit = "Block 2. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Block 3
				if (old.PATH_ID == 7 && current.PATH_ID == 2 && vars.splits[59] != true) {
					vars.splits[59] = true;
					vars.LOG_LastSplit = "Block 3. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Block 4
				if (old.PATH_ID == 14 && current.PATH_ID == 2 && vars.splits[60] != true) {
					vars.splits[60] = true;
					vars.LOG_LastSplit = "Block 4. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}			
			}
			
			
		// Dripik
			if (current.LEVEL_ID == 13 && old.PATH_ID == 11 && current.PATH_ID == 16 && vars.splits[61] != true) {
				vars.splits[61] = true;
				vars.LOG_LastSplit = "Dripik. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
			
		// Slig Barracks Split
			if (old.LEVEL_ID == 13 && current.LEVEL_ID == 5 && vars.splits[5] != true) { 
				vars.splits[5] = true;
				vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
				if (settings["feeco2Split"] && vars.SplitFeeco2 == false){
					vars.splits[4] = false; // So we split again when entering on Bonewerkz.
					vars.splitsFeeCoAgain = vars.splits[4];
					vars.SplitFeeco2 = true;
				}
				vars.LOG_LastSplit = "Slig Barracks. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////
			
	// Bonewerkz (LEVEL_ID 8 and 14)
		if (settings["bonewerkzSplit"]) {
			if (settings["bonewerkzExtended"]) { // 63 - 72
				if (current.LEVEL_ID == 8){			
				// Bonewerkz Entry
					if (old.PATH_ID == 1 && current.PATH_ID == 7 && vars.splits[63] != true) {
						vars.splits[63] = true;
						vars.LOG_LastSplit = "Bonewerkz Entry. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 1
					if (old.PATH_ID == 7 && current.PATH_ID == 1 && vars.splits[64] != true) {
						vars.splits[64] = true;
						vars.LOG_LastSplit = "Annex 1. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 2
					if (old.PATH_ID == 1 && current.PATH_ID == 2 && vars.splits[65] != true) {
						vars.splits[65] = true;
						vars.LOG_LastSplit = "Annex 2. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 3
					if (current.PATH_ID == 2 && current.CAM_ID == 4 && vars.splits[66] != true) {
						vars.splits[66] = true;
						vars.LOG_LastSplit = "Annex 3. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 4
					if (current.PATH_ID == 2 && current.CAM_ID == 7 && vars.splits[67] != true) {
						vars.splits[67] = true;
						vars.LOG_LastSplit = "Annex 4. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 5
					if (current.PATH_ID == 2 && current.CAM_ID == 9 && vars.splits[68] != true) {
						vars.splits[68] = true;
						vars.LOG_LastSplit = "Annex 5. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 6
					if (old.PATH_ID == 2 && current.PATH_ID == 3 && vars.splits[69] != true) {
						vars.splits[69] = true;
						vars.LOG_LastSplit = "Annex 6. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
				// Annex 7
					if (old.PATH_ID == 3 && current.PATH_ID == 4 && vars.splits[70] != true) {
						vars.splits[70] = true;
						vars.LOG_LastSplit = "Annex 7. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
				}
				
				if (current.LEVEL_ID == 14){
				// Annex 8
					if (current.PATH_ID == 14 && vars.splits[71] != true) {
						vars.splits[71] = true;
						vars.LOG_LastSplit = "Annex 8. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						return true;
					}
					
					if (current.LEVEL_ID == 14 && current.PATH_ID == 9 && current.CAM_ID == 15) { // Screen with the glukkon intercom phone
						vars.PrePhlegSplit = true;
					}
					
				// Phleg
					if (vars.PrePhlegSplit && current.PATH_ID == 9 && old.CAM_ID == 9 && current.CAM_ID == 8 && vars.splits[72] != true) {
						vars.splits[72] = true;
						vars.LOG_LastSplit = "Phleg. " + vars.LOG_CurrentTime;
						vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
						vars.PrePhlegSplit = false;
						return true;
					}
				}
			}		
			
			if (old.LEVEL_ID == 14 && current.LEVEL_ID == 5 && vars.splits[6] != true) { // Bonewerkz Split
				vars.splits[6] = true;
				vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
				if (settings["feeco2Split"] && vars.SplitFeeco2 == false){ // We enabled FeeCo 2 (between Barracks - Bonewerkz and the next one).
					vars.splits[4] = false; // So we split again when entering on Barracks.
					vars.splitsFeeCoAgain = vars.splits[4];
					vars.SplitFeeco2 = true;
				}
				vars.LOG_LastSplit = "Bonewerkz. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
				return true;
			}
		}
	//////////////////////////////

	// Executive Office (LEVEL_ID 12)
		if (settings["officeSplit"]) {
			if (settings["officeExtended"] && current.LEVEL_ID == 12){ // 73, 74
				
			// Entry Executive Office
				if (old.CAM_ID == 4 && current.CAM_ID == 5 && vars.splits[73] != true) {
					vars.splits[73] = true;
					vars.LOG_LastSplit = "Entry Executive Office. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Aslik
				if (old.CAM_ID == 8 && current.CAM_ID == 2 && vars.splits[74] != true) {
					vars.splits[74] = true;
					vars.LOG_LastSplit = "Aslik. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}
			
			if (old.LEVEL_ID == 12 && current.LEVEL_ID == 5 && vars.splits[7] != true) {
				vars.splits[7] = true;
				vars.LOG_LastSplit = "Executive Office. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////	
			
	// FeeCo 3 (LEVEL_ID 5)
		if (settings["feeco3Split"] && old.LEVEL_ID == 5 && current.LEVEL_ID == 9 && vars.splits[8] != true) {	
			vars.splits[8] = true;
				vars.LOG_LastSplit = "FeeCo to Terminal 5. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
			return true;
		}
			
	// Hub I (LEVEL_ID 9)
		if (settings["hub1Split"] && current.LEVEL_ID == 9){
			if (settings["hub1Extended"]){ // 75 - 80
			// SoulStorm Brewery Entry
				if (old.PATH_ID == 16 && current.PATH_ID == 23 && vars.splits[75] != true) {
					vars.splits[75] = true;
					vars.LOG_LastSplit = "Zulag 0 (Soulstorm Brewery Entry). " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 1
				if (old.PATH_ID == 1 && current.PATH_ID == 23 && vars.splits[76] != true) {
					vars.splits[76] = true;
					vars.LOG_LastSplit = "Zulag 1. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 2
				if (old.PATH_ID == 2 && current.PATH_ID == 23 && vars.splits[77] != true) {
					vars.splits[77] = true;
					vars.LOG_LastSplit = "Zulag 2. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 3
				if (old.PATH_ID == 12 && current.PATH_ID == 23 && vars.splits[78] != true) {
					vars.splits[78] = true;
					vars.LOG_LastSplit = "Zulag 3. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 4
				if (old.PATH_ID == 19 && current.PATH_ID == 23 && vars.splits[79] != true) {
					vars.splits[79] = true;
					vars.LOG_LastSplit = "Zulag 4. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 5
				if (old.PATH_ID == 14 && current.PATH_ID == 23 && vars.splits[80] != true) {
					vars.splits[80] = true;
					vars.LOG_LastSplit = "Zulag 5. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}	
			
		// Hub 1
			if (old.PATH_ID == 23 && current.PATH_ID == 24 && vars.splits[9] != true) { 
				vars.splits[9] = true;
				vars.LOG_LastSplit = "Hub 1. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////	

	// Hub II
		if (settings["hub2Split"] && current.LEVEL_ID == 9){
			if (settings["hub2Extended"]){ // 81 - 85			
			// Zulag 6
				if (old.PATH_ID == 5 && old.CAM_ID == 4 && current.PATH_ID == 24 && vars.splits[81] != true) {
					vars.splits[81] = true;
					vars.LOG_LastSplit = "Zulag 6. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 7
				if (old.PATH_ID == 6 && old.CAM_ID == 10 && current.PATH_ID == 24 && vars.splits[82] != true) {
					vars.splits[82] = true;
					vars.LOG_LastSplit = "Zulag 7. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 8
				if (old.PATH_ID == 3 && current.PATH_ID == 24 && vars.splits[83] != true) {
					vars.splits[83] = true;
					vars.LOG_LastSplit = "Zulag 8. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 9
				if (old.PATH_ID == 17 && current.PATH_ID == 24 && vars.splits[84] != true) {
					vars.splits[84] = true;
					vars.LOG_LastSplit = "Zulag 9. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 10
				if (old.PATH_ID == 10 && current.PATH_ID == 24 && vars.splits[85] != true) {
					vars.splits[85] = true;
					vars.LOG_LastSplit = "Zulag 10. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}
			
		// Hub 2
			if (old.PATH_ID == 24 && current.PATH_ID == 25 && vars.splits[10] != true) {
				vars.splits[10] = true;
				vars.LOG_LastSplit = "Hub 2. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
	//////////////////////////////
		
	// Hub III	
		if (settings["hub3Split"]){
			if (settings["hub3Extended"] && current.LEVEL_ID == 9){ // 86 - 89
			// Zulag 11
				if (old.PATH_ID == 9 && current.PATH_ID == 25 && vars.splits[86] != true) {
					vars.splits[86] = true;
					vars.LOG_LastSplit = "Zulag 11. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			// Zulag 12
				if (old.PATH_ID == 11 && current.PATH_ID == 25 && vars.splits[87] != true) {
					vars.splits[87] = true;
					vars.LOG_LastSplit = "Zulag 12. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
			// Zulag 13
				if ((old.PATH_ID == 20 || old.PATH_ID == 15) && current.PATH_ID == 25 && vars.splits[88] != true) {
					vars.splits[88] = true;
					vars.LOG_LastSplit = "Zulag 13. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
				
				
			// Zulag 14
				if (old.PATH_ID == 4 && old.CAM_ID == 13 && current.PATH_ID == 25 && vars.splits[89] != true) {
					vars.splits[89] = true;
					vars.LOG_LastSplit = "Zulag 14. " + vars.LOG_CurrentTime;
					vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
					return true;
				}
			}
			
		// Hub 3
			if (current.LEVEL_ID == 10 && current.PATH_ID == 1 && vars.splits[11] != true) {
				vars.splits[11] = true;
				vars.LOG_LastSplit = "Hub 3. " + vars.LOG_CurrentTime;
				vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
				return true;
			}
		}
			
	//////////////////////////////

	// Soulstorm Brewery		
		if (settings["boilerSplit"] && current.LEVEL_ID == 10 && (current.FMV_ID == 17 || current.FMV_ID == 18 || current.CAM_ID == 15) && vars.splits[12] != true) {		
			vars.splits[12] = true;	
			vars.LOG_LastSplit = "Zulag 15. Game is over! FINAL TIME-> " + vars.LOG_CurrentTime;
			vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";
			return true;	
		}
	}
	
//##########################################################


// Other functions not related with splits whatsoever.

	if (current.LEVEL_ID > 0){
		vars.LOG_CurrentPositionAndTime = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ". Time: " + System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "");
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

	if (current.LEVEL_ID == 1 && current.PATH_ID == 1){
		if (current.CAM_ID == 3){ // We disable the reset option.
			vars.ResetAllowed = false;
		} else if (current.CAM_ID != 4) {// If we are not on the dangerous reset point or in the first screen, we re-enable the reset ability
			vars.ResetAllowed = true;
		}
	}
	
	if (current.LEVEL_ID == 0){ // Reset?
		if (old.LEVEL_ID == 0 && old.PATH_ID == 1 && current.PATH_ID == 1 && old.CAM_ID == 1 && current.CAM_ID == 12){ // Reset (main menu)
			vars.ResetStatus = 1;	
			vars.LOG_LastSplit = "Reset (Main Menu) " + vars.LOG_CurrentTime;
			vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";	
		}
	}
	
	if (current.LEVEL_ID == 1 && current.CAM_ID == 4 && current.PATH_ID == 1){ // Reset? 
		if (current.abeY < 1400 && current.abeY > 760 && vars.ResetAllowed){ // Reset (Tunnel 1 restart path)
			vars.ResetStatus = 1;
			vars.LOG_LastSplit = "Reset (Tunnel 1) " + vars.LOG_CurrentTime;
			vars.LOG_LocationLastSplit = "Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ". FMV = " + current.FMV_ID + ". abeY = " + current.abeY + ".";	
		}
	}
	
// LOG TOOL FOR DEBUG. 	
	if (vars.ResetStatus == 1) { // Needed at the end.
		vars.ResetStatus = 2;
	}
	
	if (vars.countToMud > 0 && vars.countToMud <= 99){
		vars.countToMud = vars.countToMud + 1;
	} 
}
