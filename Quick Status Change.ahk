StatusChange(keysHC, keysTeams, pos3CX)		; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

	if WinExist("HipChat")					; Check to make sure HipChat is running
	{
		global hcSleep
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, HipChat Timed Out, cancelling
			return
		}
		; SendInput, ^{Tab}					; Switch room to clear selection
		; SendInput, ^+{Tab}					; Switch back to original room
		; Sleep, 250
		SendInput, ^a%keysHC%{Enter}		; Select all existing text and send command
		Sleep, %hcSleep%					; Seems to be more reliable, especially when a lot of text is entered
	}

	if WinExist("ahk_exe teams.exe")		; Check to make sure Teams is running
	{
		global teamsSleep					; Allows variable to be pulled in from outside of function
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, Teams Timed Out, cancelling
			return
		}	
		SendInput, ^e
		SendInput, %keysTeams%
		Sleep, %teamsSleep%					; Seems to need a delay before sending enter
		SendInput, {Enter}
		Sleep, %teamsSleep%					; Seems to be more reliable with a delay before switching apps
	}

	if WinExist("ahk_exe 3CXWin8Phone.exe")		; Check to make sure 3CX is running
	{
		global 3cxSleep
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, 3CX Timed Out, cancelling
			return
		}

		; Check if on a call, don't change status
		PixelGetColor, onCall, 80, 500			; Check color of window in "End Call" button area
		if (onCall != 0x0000FF and onCall != 0x575757)	; if red (0x0000FF) or "gray" (0x575757), skip changing status
		{
			Loop, 4								; Escape needs to be pressed multiple times if multiple levels deep
			{
				SendInput, {Esc}				; Works to escape any menus to get to "main" window
				Sleep, 25						; Needs a quick moment between escape presses
			}
			Click, 30,45						; Click on availability button
			Sleep, 3cxSleep						; Seems to need to wait for the menu to be built, improves reliability
			Click, %pos3CX%						; Click on appropriate menu item based on coordinates below
		}
	}

	WinActivate, ahk_id %winid%				; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0	; Restore original mouse position
}

; 3cxMessage(message)
; {

; }

#SingleInstance, force 						; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images/quick_change.ico
CoordMode, Mouse, Client

; Read INI file
IniRead, hcSleep, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, hcSleep , 50
IniRead, teamsSleep, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, teamsSleep , 250
IniRead, 3cxSleep, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, 3cxSleep , 100
IniRead, posAvail, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, posAvail				; Default is 30,80
IniRead, posAway, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, posAway				; Default is 30,120
IniRead, posDND, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, posDND					; Default is 30,155
IniRead, awayInterval, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, awayInterval, 15
IniRead, roundInterval, %A_ScriptDir%\QI Tools.ini, QuickStatusChange, roundInterval, 5

^F1::
	StatusChange("/back", "/available", posAvail)
return

^F2::
	StatusChange("/dnd On Phone", "/dnd", posDND)
return

^F3::
	; Determine time %increment% minutes from now
	increment := %awayInterval%				; time to add to current time
	rounder := %roundInterval%				; what level to round UP to nearest
	var := ;								; initialize %var% as current time
	EnvAdd, var, %increment%, Minutes 		; current time plus increment
	; MsgBox %var%
	FormatTime, min, %var%, mm 				; grab minute part of time for rounding
	mod := Mod(min, rounder)				; grab remainder after dividing current mins by rounder
	; MsgBox %var% %mod%
	if mod
	{
		EnvSub, rounder, %mod%
		EnvAdd, var, %rounder%, Minutes
		; MsgBox %var%
	}
	FormatTime, var, %var%, h:mm 			; format for easy human digestion

	StatusChange("/away Back ~" var, "/brb", posAway)
return

^F4::
	StatusChange("/away PM Me", "/brb", posAway)
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed 
	{
		return
	}

	StatusChange("/away " var, "/away", posAway)
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed
	{
		return
	}
	
	StatusChange("/dnd " var, "/dnd", posDND)
return