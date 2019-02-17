#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
SetTitleMatchMode, 2
Menu, Tray, Icon, red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Quick Status Change 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

`::
if WinExist("ahk_exe 3CXWin8Phone.exe")		; Check to make sure 3CX is running
	{
		; global 3cxSleep
		; global buttonAvail
		; global onCallPosXY
		; global onCallColorList
		WinActivate
		WinActivate 						; Not sure why this has to be sent twice, seems to be related to virtual desktops
		WinWaitActive, , , 1				; Make sure window got activated within 1 second
		If ErrorLevel 						; Run if window did not activate within timeout value
		{
			MsgBox, 8208, Error, 3CX Timed Out, cancelling
			return
		}

		WinGetPos, , , ,scaleDPI			; Measure height of 3CX window (not sizeable)
		scaleDPI /= 570						; 100% scaling on 1080p monitor height is 570 pixels

		MsgBox, %scaleDPI%

		; Check if on a call, don't change status
		PixelGetColor, onCall, %scaleDPI% * 80, 500			; Check color of window in "End Call" button area

		b_onCall := 0													; Initialize condition

		onCallColorList := 0x0000FF,0x575757,0xC1C1C1,0xFF0000

		Loop % onCallColorList.MaxIndex()								; Loop over all colors from INI file
		{
			if (onCall = onCallColorList[A_Index])						; Check to see if loop color matches button color
			{
				b_onCall := 1											; Set condition to "true" if colors match
				break 													; Break loop if a color matches
			}
		}

		if (b_onCall != 1)						; If a match was made above, don't run code below
		{
			Loop, 4								; Escape needs to be pressed multiple times if multiple levels deep
			{
				SendInput, {Esc}				; Works to escape any menus to get to "main" window
				Sleep, 25						; Needs a quick moment between escape presses
			}
			
			ImageSearch, availX, availY, 0, 0, 260, 100, %A_WorkingDir%\availability_default_at_rest.png
			if (ErrorLevel == 1)
			{
				ImageSearch, availX, availY, 0, 0, 260, 100, %A_WorkingDir%\available_default_hover.png
			}
			If (ErrorLevel)
			{
				MsgBox, % "ErrorLevel: " ErrorLevel
				Return
			}
			Click, 30, 45				; Click on availability button
			Sleep, 100					; Seems to need to wait for the menu to be built, improves reliability
			Click, 30,80					; Click on appropriate menu item based on coordinates below
		}
	}
return