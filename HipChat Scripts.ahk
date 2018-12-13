StatusChangeHC(keys) 			; The function that actually does the window switching and change of status
{
	winid := WinExist("A")		; Store ID of current active window

	if WinExist("HipChat")		; Check to make sure HipChat is running
	{
		WinActivate
		WinActivate 			; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1	; Make sure window got activated within 1 second
		If ErrorLevel 			; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
			return
		}
	} else {
		MsgBox, 8208, Not Running, HipChat is not running, cancelling
		return
	}
	SendInput, ^a%keys%{Enter}
	WinActivate, ahk_id %winid%		; Switch back to original active window
}

StatusChangeTeams(keys) 		; The piece that actually does the window switching and change of status
{
	winid := WinExist("A")		; Store ID of current active window

	if WinExist("ahk_exe teams.exe")		; Check to make sure HipChat is running
	{
		WinActivate
		WinActivate 			; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1	; Make sure window got activated within 1 second
		If ErrorLevel 			; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
			return
		}
	} else {
		MsgBox, 8208, Not Running, Teams is not running, cancelling
		return
	}

	SendInput, ^e
	SendInput, %keys%
	Sleep, 250
	SendInput, {Enter}
	Sleep, 250
	WinActivate, ahk_id %winid%		; Switch back to original active window
}

^F1::
	StatusChangeHC("/back")
	StatusChangeTeams("/available")
return

^F2::
	StatusChangeHC("/dnd On Phone")
	StatusChangeTeams("/dnd")
return

^F3::
	; Determine time %increment% minutes from now
	increment := 15 						; time to add to current time
	rounder := 5 							; what level to round UP to nearest
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

	StatusChangeHC("/away Back ~" var)
	StatusChangeTeams("/away")
return

^F4::
	StatusChangeHC("/away PM Me")
	StatusChangeTeams("/away")
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed 
	{
		return
	}

	StatusChangeHC("/away " var)
	StatusChangeTeams("/away")
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed
	{
		return
	}
	
	StatusChangeHC("/dnd " var)
	StatusChangeTeams("/dnd")
return