; #SingleInstance, force 												; Forces only one instance, allows to re-run script without reloading

listAHK := ["3CX", "3DConnexion Reset", "Basic Shortcuts", "Quick Status Change", "Run All", "SOLIDWORKS Reset", "Window Wizard", "AppKill"]
counter := 0

For index, AHK in listAHK
{
	ahkEXE := % AHK ".exe"

	Process, Exist, % ahkEXE
	While ErrorLevel
	{
		ToolTip, % "Closing " AHK
		Process, Close, % ahkEXE
		if not ErrorLevel
		{
			MsgBox, 16, Error, % "Unable to close " ahkEXE "!`n`nPlease close all scripts manually"
			ExitApp
		}
		Process, Exist, % ahkEXE
		counter += 1
	}
	Process, WaitClose, % ahkEXE, 5
	if ErrorLevel
		MsgBox, "What the hell?"
}

ToolTip, % counter " scripts closed"
Sleep, 2000