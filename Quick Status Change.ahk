#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\WoosterGraphic.ico		; Icon for this script
Menu, Tray, Tip, WTS: Quick Status Change 		; Change tooltip on icon in tray
CoordMode, Mouse, Client

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DetectHiddenWindows, On
SetTitleMatchMode, 2

; Define INI file location
pathINI = % A_AppData "\Wooster Technical Solutions\WoosterTech.ini"

; Section of INI file for QSC
iniSection = QuickStatusChange

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["teamsSleep"] := 250
iniProps["onCallPos"] := "80,500"
iniProps["onCallColors"] := "0x0000FF,0x575757,0xC1C1C1,0xFF0000"
iniProps["codeIndex"] := 3
iniProps["changeTeams"] := 1
; iniProps["change3CX"] := 0
iniProps["availKey"] := "^F1"
iniProps["awayKey"] := "^F2"
iniProps["dndKey"] := "^F3"
iniProps["busyKey"] := "^F4"
iniProps["lunchKey"] := "^F6"
; iniProps["qLoginKey"] := "^F7"
; iniProps["qLogoutKey"] := "^F8"

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

onCallPosXY := StrSplit(iniProps["onCallPos"], ",")							; Separate X and Y components of read value
onCallColorList := StrSplit(iniProps["onCallColors"], ",")					; Separate colors into array of n-size

codeF1 = % "*" iniProps["codeIndex"] "0"									; Available
codeF2 = % "*" iniProps["codeIndex"] "1"									; Away
codeF3 = % "*" iniProps["codeIndex"] "2"									; DND
codeF5 = % "*" iniProps["codeIndex"] "3"									; n/a
codeF6 = % "*" iniProps["codeIndex"] "4"									; Lunch
; codeF7 = % "*62"															; Queue log in
; codeF8 = % "*63"															; Queue log out

teamsSleep := iniProps["teamsSleep"]
changeTeams := iniProps["changeTeams"]
; change3CX := iniProps["change3CX"]
availKey := iniProps["availKey"]
awayKey := iniProps["awayKey"]
dndKey := iniProps["dndKey"]
busyKey := iniProps["busyKey"]
lunchKey := iniProps["lunchKey"]
; qLoginKey := iniProps["qLoginKey"]
; qLogoutKey := iniProps["qLogoutKey"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Hotkey, %availKey%, availLabel
Hotkey, %awayKey%, awayLabel
Hotkey, %dndKey%, dndLabel
Hotkey, %busyKey%, busyLabel
Hotkey, %lunchKey%, lunchLabel
; Hotkey, %qLoginKey%, qLogin
; Hotkey, %qLogoutKey%, qLogout
return

availLabel:
StatusChange("available", codeF1, "green", changeTeams)
return

awayLabel:
StatusChange("brb", codeF2, "yellow", changeTeams, 1)
return

dndLabel:
StatusChange("dnd", codeF3, "red", changeTeams)
return

busyLabel:
StatusChange("busy", codeF3, "red", changeTeams)
return

lunchLabel:
StatusChange("brb", codeF6, "red", changeTeams)
return

; ^F5::StatusChange("available", codeF5, "yellow", changeTeams)

qLogin:
StatusChange("", codeF7, , 0)
return

qLogout:
StatusChange("", codeF8, , 0)
return

;############### Actual work being done ###################
StatusChange(keysTeams, pos3CX, icoColor := "default", teams := 1, winLock := 0)	; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

	; if WinExist("3CX -") and 3CX		; Check to make sure 3CX is running
	; {
	; 	global onCallPosXY
	; 	global onCallColorList

	; 	WinGet, Style, Style

	; 	WinShow
	; 	WinActivate
	; 	WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
	; 	WinWaitActive, , , 1				; Make sure window got activated within 1 second
	; 	If ErrorLevel 						; Run if window did not activate within timeout value
	; 	{
	; 		MsgBox, 8208, Error, "3CX Timed Out, moving on...", 2
	; 		Goto, 3cxSkip
	; 	}

	; 	; MsgBox, 4132, Question, Is 3CX visible?
	; 	; IfMsgBox, No
	; 	; 	Return

	; 	MouseMove, onCallPosXY[1], onCallPosXY[2], 0

	; 	; Check if on a call, don't change status
	; 	PixelGetColor, onCall, onCallPosXY[1], onCallPosXY[2]			; Check color of window in "End Call" button area

	; 	Loop % onCallColorList.MaxIndex()
	; 	{
	; 		if (onCall = onCallColorList[A_Index])
	; 		Goto, 3cxSkip
	; 	}

	; 	If !(Style & 0x10000000)  ; 0x10000000 is WS_VISIBLE
	; 	{
	; 		WinMinimize
	; 		WinHide
	; 	}

	; 	Run, "C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXClickToCall.exe" "%pos3CX%"

	; 	3cxSkip:
	; }

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