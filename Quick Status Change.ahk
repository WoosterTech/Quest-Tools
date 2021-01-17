#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\WoosterGraphic.ico	; Icon for this script
Menu, Tray, Tip, WTS: Quick Status Change 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DetectHiddenWindows, On
SetTitleMatchMode, 2

; Define INI file location
pathINI = %A_AppData%\WoosterTech\WoosterTech.ini

; Section of INI file for QSC
iniSection = QuickStatusChange

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["teamsSleep"] := 250
iniProps["changeTeams"] := 1

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)																; Queue log out

teamsSleep := iniProps["teamsSleep"]
changeTeams := iniProps["changeTeams"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^F1::StatusChange("available", "green", changeTeams)

^F2::StatusChange("brb", "yellow", changeTeams, 1)

^F3::StatusChange("dnd", "red", changeTeams)

^F4::StatusChange("busy", "red", changeTeams)

^F5::StatusChange("available", "yellow", changeTeams)

^F6::StatusChange("brb", "red", changeTeams)

^F7::StatusChange("", , 0)

^F8::StatusChange("", , 0)

;############### Actual work being done ###################
StatusChange(keysTeams, icoColor := "default", teams := 1, winLock := 0)	; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

	if WinExist("| Microsoft Teams") and teams		; Check to make sure Teams is running
	{
		global teamsSleep					; Allows variable to be pulled in from outside of function
		
		WinGet, Style, Style 
		; If (Style & 0x10000000)  ; 0x10000000 is WS_VISIBLE
  ;     		MsgBox, My Window is Visible
		; Else  MsgBox, My Window is Hidden
		If !(Style & 0x10000000)
			WinRestore
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, "Teams Timed Out, moving on...", 2
			Goto, teamsSkip
		}	
		SendInput, ^e
		Sleep, 50
		SendInput, /
		Sleep, 100
		Send, %keysTeams%
		Sleep, %teamsSleep%					; Seems to need a delay before sending enter
		SendInput, {Enter}
		Sleep, %teamsSleep%					; Seems to be more reliable with a delay before switching apps

		If !(Style & 0x10000000)  ; 0x10000000 is WS_VISIBLE
		{
			WinMinimize
			WinHide
		}

		teamsSkip:
	}

	WinActivate, ahk_id %winid%					; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position

	; if (icoColor = "green")									; Changes icon color based on call
	; {
	; 	Menu, Tray, Icon, images\q_on_green_bkgd.ico
	; } else if (icoColor = "yellow") {
	; 	Menu, Tray, Icon, images\q_on_yellow_bkgd.ico
	; } else if (icoColor = "red") {
	; 	Menu, Tray, Icon, images\q_on_red_bkgd.ico
	; } else if (icoColor = "default") {
	; 	Sleep, 1
	; }

	if winLock												; Locks computer
	{
		MsgBox, 4132, Timer, 5 Seconds until lock., 5
		IfMsgBox, No
			Sleep, 1
		else
			DllCall("LockWorkStation")
	}
}