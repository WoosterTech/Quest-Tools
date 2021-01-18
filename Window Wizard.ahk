#SingleInstance, force
Menu, Tray, Icon, images\WoosterGraphic.ico
Menu, Tray, Tip, WTS: Window Wizard

SetTitleMatchMode 2
DetectHiddenWindows, On

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = % A_AppData "\Wooster Technical Solutions\WoosterTech.ini"

; Section of INI file for 3CX
iniSection = WindowWizard

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["SlackHide"] := true
iniProps["OutlookHide"] := true
iniProps["TeamsHide"] := true
iniProps["3cxHide"] := false
iniProps["outlookKey"] := "F10"
iniProps["slackKey"] := "F8"
iniProps["teamsKey"] := "F9"
iniProps["teamsCommand"] := """""C:\Users\" A_UserName "\AppData\Local\Microsoft\Teams\Update.exe"" --processStart ""Teams.exe"""""

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

TeamsHide := iniProps["TeamsHide"]
SlackHide := iniProps["SlackHide"]
OutlookHide := iniProps["TeamsHide"]
3cxHide := iniProps["3cxHide"]
outlookKey := iniProps["outlookKey"]
slackKey := iniProps["slackKey"]
teamsKey := iniProps["teamsKey"]
teamsCommand := iniProps["teamsCommand"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Hotkey, %outlookKey%, outlook
Hotkey, %teamsKey%, teams
Hotkey, %slackKey%, slack
return

outlook:
if WinExist("- Outlook")
{
	WTSFunctions_winShow(OutlookHide)
} else {
	try run Outlook.exe
	catch e
		MsgBox, 16, Outlook Error, Didn't find Outlook Window`nUnable to run Outlook`n%e%
}
return

teams:
if WinExist("| Microsoft Teams") or WinExist("ahk_exe Teams.exe")
{
	WTSFunctions_winShow(TeamsHide)
} else {
	try run %teamsCommand%
	catch e
		MsgBox, 16, Teams Error, Didn't find Teams window`nUnable to run Teams`n%e%
}
return

slack:
if WinExist("Slack |")
{
	WTSFunctions_winShow(SlackHide)
} else {
	try run Slack.exe
	catch e
		MsgBox, 16, Slack Error, Didn't find Slack window`nUnable to run Slack`n%e%
}
return

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