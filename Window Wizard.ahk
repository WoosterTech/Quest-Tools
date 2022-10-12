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
iniProps["windowList"] := "slack,teams,outlook,8by8,yourphone"
iniProps["SlackHide"] := true
iniProps["OutlookHide"] := true
iniProps["TeamsHide"] := true
iniProps["8by8Hide"] := true
iniProps["YourPhoneHide"] := true
iniProps["outlookKey"] := "F10"
iniProps["slackKey"] := "F8"
iniProps["teamsKey"] := "F9"
iniProps["8by8Key"] := "F11"
iniProps["YourPhoneKey"] := "F7"
iniProps["teamsCommand"] := """""C:\Users\" A_UserName "\AppData\Local\Microsoft\Teams\Update.exe"" --processStart ""Teams.exe"""""
iniProps["slackCommand"] := "Slack.exe"
iniProps["slackWinTitle"] := "Slack |"
iniProps["8by8WinTitle"] := "8x8 Work"
iniProps["8by8Command"] := """""C:\Users\" A_UserName "\AppData\Local\8x8-Work\8x8 Work.exe"""
iniProps["YourPhoneWinTitle"] := "Your Phone"
iniProps["YourPhoneCommand"] := "MicrosoftYourPhone_8wekyb3d8bbwe!App"

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

; windowList := StrSplit(iniProps["windowList"], ",")
windowList := iniProps["windowList"]
TeamsHide := iniProps["TeamsHide"]
SlackHide := iniProps["SlackHide"]
OutlookHide := iniProps["TeamsHide"]
8by8Hide := iniProps["8by8Hide"]
YourPhoneHide := iniProps["YourPhoneHide"]
outlookKey := iniProps["outlookKey"]
slackKey := iniProps["slackKey"]
teamsKey := iniProps["teamsKey"]
8by8Key := iniProps ["8by8Key"]
YourPhoneKey := iniProps["YourPhoneKey"]
teamsCommand := iniProps["teamsCommand"]
slackCommand := iniProps["slackCommand"]
slackWinTitle := iniProps["slackWinTitle"]
8by8WinTitle := iniProps["8by8WinTitle"]
8by8Command := iniProps["8by8Command"]
YourPhoneWinTitle := iniProps["YourPhoneWinTitle"]
YourPhoneCommand := iniProps["YourPhoneCommand"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
outlookVar = outlook
teamsVar = teams
slackVar = slack
8by8Var = 8by8
yourphoneVar = yourphone

If outlookVar in %windowList%
{
	Hotkey, %outlookKey%, outlook
}
If teamsVar in %windowList%
{
	Hotkey, %teamsKey%, teams
}
If slackVar in %windowList%
{
	Hotkey, %slackKey%, slack
}
If 8by8Var in %windowList%
{
	Hotkey, %8by8Key%, 8by8
}
If yourphoneVar in %windowList%
{
	Hotkey, %YourPhoneKey%, yourPhone
}
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
if WinExist(slackWinTitle)
{
	WTSFunctions_winShow(SlackHide)
} else {
	try run %slackCommand%
	catch e
		MsgBox, 16, Slack Error, Didn't find Slack window`nUnable to run Slack`n%e%
}
return

8by8:
if WinExist(8by8WinTitle)
{
	WTSFunctions_winShow(8by8Hide)
} else {
	try run %8by8Command%
	catch e
		MsgBox, 16, 8x8 Work Error, Didn't find 8x8 Work window`nUnable to run 8x8 Work`n%e%
}
return

yourPhone:
if WinExist(YourPhoneWinTitle)
{
	WTSFunctions_winShow(YourPhoneHide)
} else {
	try run %YourPhoneCommand%
	catch e
		MsgBox, 16, Your Phone Error, Didn't find Your Phone window`nUnable to run Your Phone`n%e%
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