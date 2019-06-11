#SingleInstance, force 												; Forces only one instance, allows to re-run script without reloading

listAHK := ["3CX", "3DConnexion Reset", "Basic Shortcuts", "Quick Status Change", "Run All", "SOLIDWORKS Reset", "Window Switching"]
pathNSIS := % A_ProgramFiles "\NSIS\makensis.exe"
optionsNSIS := "/OC:\Users\karl\Documents\GitHub\AutoHotKey\compile_log.log"
pathIN := % A_WorkingDir "\QI Tools.nsi"

For index, AHK in listAHK
{
	RunWait, % "Ahk2Exe.exe /in """ AHK ".ahk"""					; Run compiler for AHK files
}

RunWait, % """" pathNSIS """ """ optionsNSIS """ """ pathIN """"	; Compile NSIS file, writing log to file

ToolTip