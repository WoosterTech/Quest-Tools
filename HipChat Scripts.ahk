StatusChange(keys) 				; The function that actually does the window switching and change of status
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
	SendInput, %keys%{Enter}
	WinActivate, ahk_id %winid%		; Switch back to original active window
}

^F1::
	StatusChange("/back")
return

^F2::
	StatusChange("/dnd On Phone")
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

	StatusChange("/away Back ~" var)
return

^F4::
	StatusChange("/away PM Me")
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed 
	{
		return
	}

	StatusChange("/away " var)
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?
	if ErrorLevel 		; Cancel script if "Cancel" is pressed
	{
		return
	}
	
	StatusChange("/dnd " var)
return