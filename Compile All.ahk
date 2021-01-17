#SingleInstance, force 												; Forces only one instance, allows to re-run script without reloading

listAHK := ["Window Wizard", "Master", "3DConnexion Reset", "Basic Shortcuts", "Quick Status Change", "SOLIDWORKS Reset"]
destFolder := "QI Tools"   ; This is where the WiX solution will look for the EXEs

For index, AHK in listAHK
{
	ahkEXE := % AHK ".exe"

	; MsgBox, %ahkEXE%

	Process, Exist, % ahkEXE
	; MsgBox, % ErrorLevel
	While ErrorLevel
	{
		ToolTip, % "Closing " AHK
		Process, Close, % ahkEXE
		if not ErrorLevel
		{
			MsgBox, 16, Error, % "Unable to close " ahkEXE "!`n`nPlease close all scripts manually`nand run ""Run All"" from the`nStart Menu"
			ExitApp
		}
		Process, Exist, % ahkEXE
	}
	Process, WaitClose, % ahkEXE, 5
	if ErrorLevel
		MsgBox, "What the hell?"

	try
	{
		ToolTip, % "Compiling " AHK
		; RunWait, % "Ahk2Exe.exe /in """ AHK ".ahk"" /icon images/red_q_on_blue_bkgd.ico"					; Run compiler for AHK files
		RunWait, % "Ahk2Exe.exe /in """ AHK ".ahk"" /out """ destFolder "\" AHK ".exe"" /icon images/WoosterGraphic.ico"					; Run compiler for AHK files
	} catch e {
		MsgBox, % "Unable to compile """ AHK """, exiting"
		ExitApp
	}
}

ToolTip