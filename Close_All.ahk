; #SingleInstance, force 												; Forces only one instance, allows to re-run script without reloading

listAHK := ["3CX", "3DConnexion Reset", "Basic Shortcuts", "Quick Status Change", "Run All", "SOLIDWORKS Reset", "Window Switching"]
counter := 0

For index, AHK in listAHK
{
	ahkEXE := % AHK ".exe"

	Process, Exist, % ahkEXE
	While ErrorLevel
	{
		; MsgBox, % ErrorLevel
		ToolTip, % "Closing " AHK
		Process, Close, % ErrorLevel
		MsgBox, % ErrorLevel
		Process, Exist, % ahkEXE
		counter += 1
	}
	Process, WaitClose, % ahkEXE
	If ErrorLevel
		MsgBox, % ErrorLevel
}

ToolTip, % counter " scripts closed"
Sleep, 2000