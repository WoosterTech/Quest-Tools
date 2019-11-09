#SingleInstance, force
; Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QuestStart

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = QuestStart

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["runBSC"] := 1
iniProps["runQSC"] := 1
iniProps["run3CX"] := 1
iniProps["delay"] := 100

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

runBSC := iniProps["runBSC"]
runQSC := iniProps["runQSC"]
run3CX := iniProps["run3CX"]
delay := iniProps["delay"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SplashImage, images/qonlybig-edited.png, b CWFF0000
WinSet, TransColor, FF0000, Splash
Sleep, 500

If FileExist("Basic Shortcuts.exe") and runBSC
	Run, "Basic Shortcuts.exe"

Sleep, %delay%

If FileExist("Quick Status Change.exe") and runQSC
	Run, "Quick Status Change.exe"

Sleep, %delay%

If FileExist("3CX.exe") and run3CX
	Run, "3CX.exe"

Sleep, 500
SplashImage, Off