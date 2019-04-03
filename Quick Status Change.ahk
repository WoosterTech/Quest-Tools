#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, red_q_on_blue_bkgd.ico	; Icon for this script
Menu, Tray, Tip, QI Tools: Quick Status Change 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Read INI file (all times in ms); last values on each line are defaults
IniRead, teamsSleep, %pathINI%, QuickStatusChange, teamsSleep , 250			; Time between actions in Teams
IniRead, onCallPos, %pathINI%, QuickStatusChange, onCallPos, 80,500			; Location of "End Call" button
IniRead, onCallColors, %pathINI%, QuickStatusChange, onCallColors, 0x0000FF,0x575757,0xC1C1C1,0xFF0000 ; Comma delimited list of colors when on a call
IniRead, codeAvail, %pathINI%, QuickStatusChange, codeAvail, *30			; dial code for available
IniRead, codeAway, %pathINI%, QuickStatusChange, codeAway, *31				; dial code for away
IniRead, codeDND, %pathINI%, QuickStatusChange, codeDND, *32				; dial code for do not disturb
IniRead, codeLunch, %pathINI%, QuickStatusChange, codeLunch, *33			; dial code for lunch
IniRead, codeSB, %pathINI%, QuickStatusChange, codeSB, *34					; dial code for study block

onCallPosXY := StrSplit(onCallPos, ",")										; Separate X and Y components of read value
onCallColorList := StrSplit(onCallColors, ",")								; Separate colors into array of n-size

StatusChange(keysTeams, pos3CX)		; The function that actually does the window switching and change of status
{
	winid := WinExist("A")					; Store ID of current active window
	MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

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
		global onCallPosXY
		global onCallColorList

		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, 3CX Timed Out, cancelling
			return
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

	WinActivate, ahk_id %winid%					; Switch back to original active window
	MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position
}

^F1::StatusChange("/available", codeAvail)

^F2::StatusChange("/dnd", codeDND)

^F3::StatusChange("/brb", codeAway)

^F4::StatusChange("/busy", codeDND)

^F5::StatusChange("/brb", codeLunch)

^F6::StatusChange("/dnd", codeSB)