//	An autosplitter for Abe's Exoddus for PC: Englisg, Spanish, French, German and English GoG. For GoG, check the checkbox in the instructions.
//	Created by LegnaX.

state("Exoddus", "EN")
{
	// ENGLISH, GERMAN and ENGLISH GoG OFFSETS
	byte LEVEL_ID : 0x1C3030;
	byte PATH_ID : 0x1C3032;
	byte CAM_ID : 0x1C3034;
	byte FMV_ID : 0x1C3042;
	short abeY : 0x1C1230, 0x68, 0xBE;
}

state("Exoddus", "ES")
{
	// SPANISH OFFSETS (390 values away) (Check the GoG checkbox if using GoG version)
	byte LEVEL_ID : 0x1C33C0;
	byte PATH_ID : 0x1C33C2;
	byte CAM_ID : 0x1C33C4;
	byte FMV_ID : 0x1C33D2;
	short abeY : 0x1C1EF8, 0xBE;
}

state("Exoddus", "FR")
{
	// FRENCH OFFSETS 
	byte LEVEL_ID : 0x1C3912;
	byte PATH_ID : 0x1C3914;
	byte CAM_ID : 0x1C3916;
	byte FMV_ID : 0x1C391A;
	short abeY : 0x1C2440, 0xBE;
}

startup
{
	settings.Add("GoG", true, "Uncheck ONLY if using Spanish game.");
	settings.Add("minesSplit", true, "Mines - Splits when Abe leaves Mines Boiler.");
	settings.Add("necrumSplit", true, "Necrum - Ending Necrum by entering Mudomo, Mudanchee of FeeCo.");
	settings.Add("mudomoSplit", true, "Mudomo - Ending Mudomo by entering Mudanchee or FeeCo.");
	settings.Add("mudancheeSplit", true, "Mudanchee - Ending Mudanchee by entering Mudomo or FeeCo.");
	settings.Add("feecoSplit", true, "FeeCo - Ending FeeCo by entering Barracks, Bonewerkz or Brewery.");
	settings.Add("barracksSplit", true, "Slig Barracks - Ending Slig Barracks by returning to FeeCo.");
	settings.Add("bonewerkzSplit", true, "Bonewerkz - Ending Bonewerkz by returning to FeeCo.");
	settings.Add("feeco2Split", true, "FeeCo2 - Ending Barracks or Bonewerkz and entering on the next part.");
	settings.Add("officeSplit", true, "Executive Office - Ending Executive Office by returning to FeeCo.");
	settings.Add("feeco3Split", true, "FeeCo 3 - After doing Executive Office - Entering brewery.");
	settings.Add("hub1Split", true, "Soulstorm Brewery Hub 1 - Ending Hub 1 and entering Hub 2.");
	settings.Add("hub2Split", true, "Soulstorm Brewery Hub 2 - Ending Hub 2 and entering Hub 3.");
	settings.Add("hub3Split", true, "Soulstorm Brewery Hub 3 - Ending Hub 3 and entering the Boiler.");
	settings.Add("boilerSplit", true, "Boiler (End game) - Splits when Abe enters on one of the 2 portals.");
}

init
{	
	if (modules.First().ModuleMemorySize == 8785920 && settings["GoG"] == false){ // That module is for spanish. Same module as German or EN GoG game.
		version = "ES" ;
	} else if (modules.First().ModuleMemorySize == 8790016){ // That module is for french game.
		version = "FR" ;
	} else { // Any differnet module (like GoG or unknown lang) will be loaded here. You need this for English or German.
		version = "EN" ;
	}	
	refreshRate = 15;	// Refresh rate of the script (per second).
	bool[] splitsTemp = new bool[13];
	vars.splits = splitsTemp;
	vars.preSplitNecrum = false;
	vars.preSplitMudomo = false;
	vars.preSplitMudanchee = false;
	vars.ResetStatus = 0;
	vars.SplitFeeco2 = false;
	vars.splitsFeeCoAgain = vars.splits[4];
	vars.ResetAllowed = true;
	vars.logLastSplit = "Nothing yet! Game detected: " + version;
	vars.countToMud = 0;
} 

start
{
	refreshRate = 15;	
	if (current.LEVEL_ID == 01 && current.PATH_ID == 1 && current.CAM_ID == 4 && current.abeY == 1500 && old.abeY < 1500) {
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
	if (System.Convert.ToString(timer.CurrentTime.RealTime).Contains("00:00:00")) { // Used for resetting the main variables of the program if the timer resets. 		
		vars.SplitFeeco2 = false;
		vars.preSplitNecrum = false;
		vars.preSplitMudomo = false;
		vars.preSplitMudanchee = false;
		vars.splitsFeeCoAgain = false;
		bool[] splitsTemp = new bool[13];		
		vars.countToMud = 0;
		vars.splits = splitsTemp;
	}
	
// Mines SPLIT
	if (settings["minesSplit"] && vars.splits[0] != true && current.FMV_ID == 232) {
		vars.splits[0] = true;
		return true;
	}
//////////////////////////////

// Mudomo 
	if (current.LEVEL_ID == 2 && current.PATH_ID == 5 && current.CAM_ID == 1 && current.FMV_ID != 8){
		vars.preSplitMudomo = true;
	}
	if (vars.countToMud >= 90 && settings["mudomoSplit"] && vars.splits[2] != true && ((current.LEVEL_ID == 4 && current.PATH_ID == 6 && current.CAM_ID == 23 && current.FMV_ID == 34 && vars.preSplitMudomo) || (old.PATH_ID == 3 && current.PATH_ID == 1  && current.LEVEL_ID == 5))) {
		vars.splits[2] = true;
		vars.logLastSplit = "Mudomo. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////

// Mudanchee
	if (current.LEVEL_ID == 2 && current.PATH_ID == 5 && current.CAM_ID == 9 && current.FMV_ID != 8){
		vars.preSplitMudanchee = true;
	}
	if (vars.countToMud >= 90 && settings["mudancheeSplit"] && vars.splits[3] != true && ((current.LEVEL_ID == 3 && current.PATH_ID == 1 && current.CAM_ID == 1 && current.FMV_ID == 25 && vars.preSplitMudanchee) || (old.PATH_ID == 3 && current.PATH_ID == 1 && current.LEVEL_ID == 5))) { // We are in mudomo or Wheel to feeCo. 
		vars.splits[3] = true;
		vars.logLastSplit = "Mudanchee. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////
	
// Necrum SPLIT

	if (current.LEVEL_ID == 2 && current.PATH_ID == 5 && (current.CAM_ID == 9 || current.CAM_ID == 1) && current.FMV_ID == 8){
		vars.preSplitNecrum = true;
	}
	if (settings["necrumSplit"] && vars.splits[1] != true && vars.preSplitNecrum && (current.FMV_ID == 25 || current.FMV_ID == 34)) { // Cinematics: 25 is mudomo (24 end). 34 is Mudanchee (25 end). 4 is FeeCo.
		vars.splits[1] = true;
		vars.preSplitNecrum = false;
		vars.logLastSplit = "Necrum to Mud-. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		vars.countToMud = 1;
		return true;
	}
	if (settings["necrumSplit"] && vars.splits[2] != true && vars.splits[3] != true && current.LEVEL_ID == 5 && old.LEVEL_ID == 2){ // From Necrum to feeCo directly
		vars.splits[1] = true;
		vars.preSplitNecrum = false;
		vars.logLastSplit = "necrum to FeeCo. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////

// FEECO	
	if ((settings["feecoSplit"] || vars.SplitFeeco2) && vars.splits[4] != true && old.LEVEL_ID == 5 && (current.LEVEL_ID == 6 || current.LEVEL_ID == 8 || current.LEVEL_ID == 9)) { // 6 is Bonewerkz.  5 is Barracks. 15 is Brewery
		vars.splits[4] = true;
		vars.splitsFeeCoAgain = vars.splits[4];
		vars.splits[8] = true; // We avoid double split if we go from feeCo to Soulstorm directly.
		vars.logLastSplit = "FeeCo 1 or 3. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////
		
// Slig Barracks
	if (settings["barracksSplit"] && vars.splits[5] != true && old.LEVEL_ID == 13 && current.LEVEL_ID == 5) {
		vars.splits[5] = true;
		vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
		if (settings["feeco2Split"] && vars.SplitFeeco2 == false){
			vars.splits[4] = false; // So we split again when entering on Bonewerkz.
			vars.splitsFeeCoAgain = vars.splits[4];
			vars.SplitFeeco2 = true;
		}
		vars.logLastSplit = "Slig Barracks. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////
		
// Bonewerkz
	if (settings["bonewerkzSplit"] && vars.splits[6] != true && old.LEVEL_ID == 14 && current.LEVEL_ID == 5) {
		vars.splits[6] = true;
		vars.splits[8] = false; // If we are not going directly from FeeCo to Soulstorm, we can split on FeeCo 2.
		if (settings["feeco2Split"] && vars.SplitFeeco2 == false){ // We enabled FeeCo 2 (between Barracks - Bonewerkz and the next one).
			vars.splits[4] = false; // So we split again when entering on Barracks.
			vars.splitsFeeCoAgain = vars.splits[4];
			vars.SplitFeeco2 = true;
		}
		vars.logLastSplit = "Bonewerkz. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////

// Executive Office
	if (settings["officeSplit"] && vars.splits[7] != true && old.LEVEL_ID == 12 && current.LEVEL_ID == 5) {
		vars.splits[7] = true;
		vars.logLastSplit = "Executive Office. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////	
		
// FeeCo 3
	if (settings["feeco3Split"] && vars.splits[8] != true && old.LEVEL_ID == 5 && current.LEVEL_ID == 9) {	
		vars.splits[8] = true;
		vars.logLastSplit = "FeeCo 2. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
		
// Hub I
	if (settings["hub1Split"] && vars.splits[9] != true && current.LEVEL_ID == 9 && current.PATH_ID == 24) {
		vars.splits[9] = true;
		vars.logLastSplit = "Hub 1. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////	

// Hub II
	if (settings["hub2Split"] && vars.splits[10] != true && current.LEVEL_ID == 9 && current.PATH_ID == 25) {
		vars.splits[10] = true;
		vars.logLastSplit = "Hub 2. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////
	
// Hub III
	if (settings["hub3Split"] && vars.splits[11] != true && current.LEVEL_ID == 10 && current.FMV_ID == 6) {
		vars.splits[11] = true;
		vars.logLastSplit = "Hub 3. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;
	}
//////////////////////////////

// Soulstorm Brewery		
	if (settings["boilerSplit"] && vars.splits[12] != true && current.LEVEL_ID == 10 && (current.FMV_ID == 17 || current.FMV_ID == 18 || current.CAM_ID == 15)) {		
		vars.splits[12] = true;	
		vars.logLastSplit = "Game ending. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
		return true;	
	}
	
//##########################################################


// Other functions not related with splits whatsoever.

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
			vars.logLastSplit = "Reset main menu. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";		
		}
	}
	
	if (current.LEVEL_ID == 1 && current.CAM_ID == 4 && current.PATH_ID == 1){ // Reset? 
		if (current.abeY < 1400 && current.abeY > 1 && vars.ResetAllowed){ // Reset (Tunnel 1 restart path)
			vars.ResetStatus = 1;
			vars.logLastSplit = "Reset Tunnel 1. Level = " + current.LEVEL_ID + ". Path = " + current.PATH_ID + ". Cam = " + current.CAM_ID + ".";
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
