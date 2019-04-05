QIFunctions_readINI(iniPath, iniKeys, ini_section)					; Reads keys from defined INI file based on 'iniKeys'
{
	For key, value in iniKeys
	{
		IniRead, value, %iniPath%, %ini_section%, %key%, %value%
		iniKeys[(key)] := value
	}

	return iniKeys
}

QIFunctions_StatusChange(keysTeams, pos3CX, teams := 1, 3CX := 1)	; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

	if WinExist("ahk_exe 3CXWin8Phone.exe") and 3CX		; Check to make sure 3CX is running
	{
		global onCallPosXY
		global onCallColorList

		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, "3CX Timed Out, moving on...", 2
			Goto, 3cxSkip
		}

		; Check if on a call, don't change status
		PixelGetColor, onCall, onCallPosXY[1], onCallPosXY[2]			; Check color of window in "End Call" button area

		Loop % onCallColorList.MaxIndex()
		{
			if (onCall = onCallColorList[A_Index])
			Goto, 3cxSkip
		}

		Run, "C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXClickToCall.exe" "%pos3CX%"

		3cxSkip:
	}

	if WinExist("ahk_exe teams.exe") and teams		; Check to make sure Teams is running
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
		Send, %keysTeams%
		Sleep, %teamsSleep%					; Seems to need a delay before sending enter
		SendInput, {Enter}
		Sleep, %teamsSleep%					; Seems to be more reliable with a delay before switching apps
		teamsSkip:
	}

	WinActivate, ahk_id %winid%					; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position
}