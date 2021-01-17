#SingleInstance, force
Menu, Tray, Icon,  images\WoosterGraphic.ico
Menu, Tray, Tip, WTS: Window Wizard

SetTitleMatchMode 2
DetectHiddenWindows, On
; SetKeyDelay, 500

; F3::						; Switch to Outlook inbox
; IfWinExist, - Outlook
; {
; 	WTSFunctions_winTogg()
; 	SendInput ^1
; } else {
; 	run Outlook.exe /select outlook:inbox
; }
; return

; F4::						; Switch to Outlook calendar
; IfWinExist, - Outlook
; {
; 	WTSFunctions_winTogg()
; 	SendInput ^2
; } else {
; 	run Outlook.exe /select outlook:calendar
; }
; return

; ^Numpad1::
; IfWinExist, ahk_exe Google Play Music Desktop Player.exe
; {
; 	WinGet, Style, Style
; 	MsgBox, % Style
; 	WTSFunctions_winTogg()
; } else {
; 	MsgBox, GMDPR not found!
; }
; return

F6::
IfWinExist, - Outlook
{
	WTSFunctions_winTogg()
} else {
	run Outlook.exe
}
Sleep 500
Tooltip
return

F9::
IfWinExist, | Microsoft Teams
{
	WTSFunctions_winTogg()
} else {
	; run "C:\Users\karl\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Microsoft Teams.lnk"
	run "C:\Users\karl\AppData\Local\Microsoft\Teams\Update.exe" --processStart "Teams.exe"
}
return

; F7::
; IfWinExist, 3CX -
; {
; 	WTSFunctions_winTogg()
; } else {
; 	run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\3CXPhone for Windows\3CXPhone for Windows.lnk"
; }
; return

F8::
IfWinExist, Slack
{
	WinGet, Name, ControlList
	Tooltip, % Name "Window Found"
	WTSFunctions_winTogg()
} else {
	Tooltip "Window NOT Found"
	run Slack.exe
}
Sleep 500
Tooltip
return

; F9::
; ; IfWinExist, ahk_exe "Google Play Music Desktop Player.exe"
; IfWinExist, ahk_exe teams.exe
; {
; 	IfWinNotActive
; 	{
; 		WinShow
; 		WinActivate
; 	} else {
; 		WinMinimize
; 		WinHide
; 	}
; } else {
; 	MsgBox, Did not find Google Play Music!
; 	; run "Google Play Music Desktop Player.exe"
; }
; return

; ^!p::gotoChannel("DE{space}-{space}TS")					; Direct access to DE - TS "general" channel

; ^!l::gotoChannel("Lunch")								; Direct access to DE - TS "lunch" channel

^!1::													; Opens "Activities"
error := activateTeams()
if !error
{
	SendInput, ^1
} else {
	errorHandler("teams", error)
}
return

^!2::													; Opens "Chat"
error := activateTeams()
if !error
{
	SendInput, ^2
} else {
	errorHandler("teams", error)
}
return

^!3::													; Opens "Teams"
error := activateTeams()
if !error
{
	SendInput, ^3
} else {
	errorHandler("teams", error)
}
return

gotoChannel(channel)
{
	error := activateTeams()
	if !error
	{
		Send, ^e
		Sleep, 50
		Send, /
		Sleep, 100
		Send, goto
		Sleep, 100
		Send, {space}
		Sleep, 400
		Send, %channel%
		Sleep, 200
		Send, {tab}{enter}
	} else {
		errorHandler("teams", error)
	}
}

activateTeams()
{
	if WinExist("| Microsoft Teams")		; Check to make sure Teams is running
	{
		WinGet, Style, Style
		If !(Style & 0x10000000)
			WinRestore
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			return 1
		}	
		return 0
		
	} else {
		return 2
	}
}

errorHandler(errorSource, errorNo)
{
	if errorSource = teams
	{
		if errorNo = 1
			MsgBox, 8208, Error, "Teams timed out, try again."
		else if (errorNo = 2)
			MsgBox, 8208, Error, "Didn't find Teams, try again."
		else
			MsgBox, 8208, Error, "Unspecified error."
	}
}