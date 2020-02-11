#SingleInstance, force
Menu, Tray, Tip, QuestStart

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file
iniSection = QuestStart

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["fullList"] := "Basic Shortcuts,Quick Status Change,3CX,Window Wizard,AppKill"
iniProps["startList"] := "Basic Shortcuts,Quick Status Change,3CX,Window Wizard,AppKill"
iniProps["delay"] := 100

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

startList := StrSplit(iniProps["startList"], ",")
delay := iniProps["delay"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SplashImage, images/qonlybig-edited.png, b CWC40233, %A_Space%
Sleep, 500

For index, program in startList
{
	Start(program, , %delay%)
}

SplashImage, Off

Start(file, type := "exe", fDelay := 100)
{
	fFile := % file "." type
	If FileExist(fFile)
	{
		SplashImage, , , % "Starting: " file
		Run, %fFile%
		Sleep, %fDelay%
	}
	Sleep, 500
}