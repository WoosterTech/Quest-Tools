StatusChange(keysTeams)		; The function that actually does the window switching and change of status
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

	asUWere:
	WinActivate, ahk_id %winid%					; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position
}

#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
SetTitleMatchMode, 2
Menu, Tray, Icon, red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Teams Status 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Read INI file (all times in ms); last values on each line are defaults
IniRead, teamsSleep, %pathINI%, TeamsStatus, teamsSleep , 250			; Time between actions in Teams
IniRead, screenSize, %pathINI%, TeamsStatus, screenSize, 1k			; Screensize in k's... 1080p is 1k, etc.
IniRead, awayInterval, %pathINI%, TeamsStatus, awayInterval, 15		; Minutes to add to current time
IniRead, roundInterval, %pathINI%, TeamsStatus, roundInterval, 5		; Minutes to round time to

^F1::		; Available
	StatusChange("/available")
	Menu, Tray, Icon, q_on_green_bkgd.ico
return

^F2::		; Do not disturb
	StatusChange("/dnd")
	Menu, Tray, Icon, q_on_red_bkgd.ico
return

^F3::		; Away

	;**** Leaving this here for future development to set a Custom Status
	; ; Determine time %increment% minutes from now
	; increment := %awayInterval%				; time to add to current time
	; rounder := %roundInterval%				; what level to round UP to nearest
	; var := ;								; initialize %var% as current time
	; EnvAdd, var, %increment%, Minutes 		; current time plus increment
	; ; MsgBox %var%
	; FormatTime, min, %var%, mm 				; grab minute part of time for rounding
	; mod := Mod(min, rounder)				; grab remainder after dividing current mins by rounder
	; ; MsgBox %var% %mod%
	; if mod
	; {
	; 	EnvSub, rounder, %mod%
	; 	EnvAdd, var, %rounder%, Minutes
	; 	; MsgBox %var%
	; }
	; FormatTime, var, %var%, h:mm 			; format for easy human digestion

	StatusChange("/brb")
	Menu, Tray, Icon, q_on_yellow_bkgd.ico
return

^F4::		; Busy
	StatusChange("/busy")
	Menu, Tray, Icon, q_on_red_bkgd.ico
return

; ^F5::
; 	; Ask user for away input
; 	InputBox, var, Away Message, Message for Away Status?
; 	if ErrorLevel 		; Cancel script if "Cancel" is pressed 
; 	{
; 		return
; 	}

; 	StatusChange("/away " var, "/away", imageSearchFilesAway)
; 	Menu, Tray, Icon, q_on_yellow_bkgd.ico
; return

; ^F6::
; 	; Ask user for dnd input
; 	InputBox, var, Do Not Disturb Message, Message for DND Status?
; 	if ErrorLevel 		; Cancel script if "Cancel" is pressed
; 	{
; 		return
; 	}
	
; 	StatusChange("/dnd " var, "/dnd", imageSearchFilesDND)
; 	Menu, Tray, Icon, q_on_red_bkgd.ico
; return