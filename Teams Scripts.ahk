StatusChange(keys) 				; The piece that actually does the window switching and change of status
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
	StatusChange("/available")
return

^F2::
	StatusChange("/dnd")
return

^F3::
	StatusChange("/busy")
return

^F4::
	StatusChange("/away")
return