StatusChange(keysHC, keysTeams, imageSearchFiles)		; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

	if WinExist("Microsoft Teams")			; Check to make sure Teams is running
	{
		global teamsSleep					; Allows variable to be pulled in from outside of function
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, "Teams Timed Out, moving on...", 2
			Goto, teamsSkip
		}	
		SendInput, ^e
		SendInput, %keysTeams%
		Sleep, %teamsSleep%					; Seems to need a delay before sending enter
		SendInput, {Enter}
		Sleep, %teamsSleep%					; Seems to be more reliable with a delay before switching apps
		teamsSkip:
	}

	if WinExist("ahk_exe 3CXWin8Phone.exe")		; Check to make sure 3CX is running
	{
		global 3cxSleep
		global buttonAvail
		global onCallPosXY
		global onCallColorList
		global 3cxWinWidth
		global 3cxWinHeight
		global imageLocation
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, "3CX Timed Out, moving on...", 5
			Goto, 3cxSkip
		}

		; Check if on a call, don't change status
		PixelGetColor, onCall, onCallPosXY[1], onCallPosXY[2]			; Check color of window in "End Call" button area													; Initialize condition

		Loop % onCallColorList.MaxIndex()								; Loop over all colors from INI file
		{
			if (onCall = onCallColorList[A_Index])						; Check to see if loop color matches button color
			Goto, 3cxSkip
		}

		Loop, 4														; Escape needs to be pressed multiple times if multiple levels deep
		{
			SendInput, {Esc}										; Works to escape any menus to get to "main" window
			Sleep, 25												; Needs a quick moment between escape presses
		}

		Click, %buttonAvail%									; Click on availability button
		Sleep, %3cxSleep%										; Seems to need to wait for the menu to be built, improves reliability
		
		Loop, % imageSearchFiles.MaxIndex()
		{
			ImageSearch, statusX, statusY, 0, 0, 3cxWinWidth/2, 3cxWinHeight/2, % imageLocation "\" imageSearchFiles[A_Index]		; Search for arrow in left half, top quarter of window
			if !ErrorLevel
			{
				Goto, 3cxChange
			} else if (ErrorLevel == 1) {
				err := 1
			} else if (ErrorLevel == 2) and (err != 1) {
				err := 2
			}
		}

		if (err == 1)
		{
			MsgBox, 8192, Not Found, % "Image not found.`n`nErrorLevel: " err
			Goto, 3cxSkip
		} else if (err == 2) {
			MsgBox, 8192, Error, % "Unable to run search.`n`nErrorLevel: " err
			Goto, 3cxSkip
		} else {
			MsgBox, 8192, Unknown Error, % "Who knows!`n`nErrorLevel: " err
			Goto, 3cxSkip
		}

		3cxChange:
			Click, 30, %statusY%									; Click on availability button

		3cxSkip:
	}
	
	asUWere:
	WinActivate, ahk_id %winid%					; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position
}

#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
SetTitleMatchMode, 2
Menu, Tray, Icon, red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Quick Status Change 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

; PixelGetColor, 3cxTheme, 130, 70
; MsgBox, % "Color is " 3cxTheme
; Return
; black 0x242424
; white 0xFFFFFF
; gray 0x333333
; default 0x404040

WinGetPos, , , 3cxWinWidth, 3cxWinHeight, ahk_exe 3CXWin8Phone.exe			; Capture window size of 3CX in case of different scaling

; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Read INI file (all times in ms); last values on each line are defaults
IniRead, teamsSleep, %pathINI%, QuickStatusChange, teamsSleep , 250			; Time between actions in Teams
IniRead, 3cxSleep, %pathINI%, QuickStatusChange, 3cxSleep , 150				; Time to wait for availability list to populate
IniRead, buttonAvail, %pathINI%, QuickStatusChange, buttonAvail, 30,45		; Location of "Availability" button
IniRead, 3cxTheme, %pathINI%, QuickStatusChange, 3cxTheme, default	 		; Theme of 3CX
IniRead, screenSize, %pathINI%, QuickStatusChange, screenSize, 1k			; Screensize in k's... 1080p is 1k, etc.
; IniRead, posAvail, %pathINI%, QuickStatusChange, posAvail, 30,80			; Location of "Available" setting
; IniRead, posAway, %pathINI%, QuickStatusChange, posAway, 30,120				; Location of "Away" setting
; IniRead, posDND, %pathINI%, QuickStatusChange, posDND, 30,155				; Location of "Do not disturb" setting
IniRead, awayInterval, %pathINI%, QuickStatusChange, awayInterval, 15		; Minutes to add to current time
IniRead, roundInterval, %pathINI%, QuickStatusChange, roundInterval, 5		; Minutes to round time to
IniRead, onCallPos, %pathINI%, QuickStatusChange, onCallPos, 80,500			; Location of "End Call" button
IniRead, onCallColors, %pathINI%, QuickStatusChange, onCallColors, 0x0000FF,0x575757,0xC1C1C1,0xFF0000 ; Comma delimited list of colors when on a call
IniWrite, %3cxWinWidth%, %pathINI%, QuickStatusChange, 3cxWinWidth			; Store 3CX window width
IniWrite, %3cxWinHeight%, %pathINI%, QuickStatusChange, 3cxWinHeight		; Store 3CX window height

onCallPosXY := StrSplit(onCallPos, ",")										; Separate X and Y components of read value
onCallColorList := StrSplit(onCallColors, ",")								; Separate colors into array of n-size

imageSearchFilesAvail := ["available_.png","available_hover.png"]
imageSearchFilesAway := ["away_.png","away_hover.png"]
imageSearchFilesDND := ["dnd_.png","dnd_hover.png"]

imageLocation := % A_WorkingDir "\images\search"

^F1::
	StatusChange("/back", "/available", imageSearchFilesAvail)
	; imageSearchFiles := ["available_.png","available_hover.png"]
	Menu, Tray, Icon, q_on_green_bkgd.ico
return

^F2::
	StatusChange("/dnd On Phone", "/dnd", imageSearchFilesDND)
	Menu, Tray, Icon, q_on_red_bkgd.ico
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

	StatusChange("/away Back ~" var, "/brb", imageSearchFilesAway)
	Menu, Tray, Icon, q_on_yellow_bkgd.ico
return

^F4::
	StatusChange("/away PM Me", "/brb", imageSearchFilesAway)
	Menu, Tray, Icon, q_on_yellow_bkgd.ico
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed 
	{
		return
	}

	StatusChange("/away " var, "/away", imageSearchFilesAway)
	Menu, Tray, Icon, q_on_yellow_bkgd.ico
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed
	{
		return
	}
	
	StatusChange("/dnd " var, "/dnd", imageSearchFilesDND)
	Menu, Tray, Icon, q_on_red_bkgd.ico
return