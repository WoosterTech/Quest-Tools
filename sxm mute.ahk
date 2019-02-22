#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
; SetTitleMatchMode, 2
Menu, Tray, Icon, images\siriusxm.png		; Icon for this script
Menu, Tray, Tip, sxm mute 					; Change tooltip on icon in tray
CoordMode, Mouse, Client

debugOn := 1
mainMute := ["sxm main mute1", "sxm main mute2", "sxm main mute3", "sxm main mute4", "sxm main mute5", "sxm main mute6"]
flyoutMute := ["sxm mute1", "sxm unmute1"]

buttonLoc(fileBase, startX, startY, endX, endY)
{
	butX := 0
	butY := 0
	; MsgBox, % fileBase[1]
	Loop, % fileBase.MaxIndex()
	{
		
		ImageSearch, butX, butY, startX, startY, endX, endY, % A_WorkingDir "\images\" fileBase[A_Index] ".png"
		
		; if debugOn
		; 	MsgBox, 8208, Loop Error %A_Index%, % A_WorkingDir "\images\" fileBase[A_Index] ".png`n`nErrorLevel: " ErrorLevel

		if (ErrorLevel == 2) {
			MsgBox, 8208, ImageSearch General Failure, %ErrorLevel%, 5
			return
		}

		If !ErrorLevel
			Break
	}

	; If ErrorLevel
	; {
	; 	MsgBox, 8208, ImageSearch Error, % "Error: " ErrorLevel, 5
	; 	Return 
	; }

	return [butX, butY, ErrorLevel]

}

timeElapse(start, current)										; Shows a message box of elapsed time since start value was last set and resets it
{
	difference := current - start
	MsgBox, , Elapsed Time, % "It's been " difference " ms since last MsgBox."
	return A_TickCount
}


^Esc::
start := A_TickCount 					; Capture start time of hotkey; for debugging
winid := WinExist("A")					; Store ID of current active window
MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position

IfWinActive, SiriusXM
{
	Goto, wholeScript
} else {
	WinActivate, SiriusXM
	sleep, 250
	WinActivate, SiriusXM
	WinWaitActive, SiriusXM, , 1
	If ErrorLevel
	{
		MsgBox, 8192, SiriusXM, SiriusXM not able to be activated, please activate and re-run
		Return
	}
	; Sleep, 500
	Goto, wholeScript
}

wholeScript:
WinGetPos, , , WinWidth, WinHeight

sleep, 250

butLoc := buttonLoc(flyoutMute, .5*WinWidth, 0, WinWidth, .25*WinHeight)		; Returns location of flyout mute button (if already visible)

if (!butLoc[3]) {																; If no ErrorLevel, click button and end
	Click, % butLoc[1] "," butLoc[2]
	goto, ayw
}

butLoc := buttonLoc(mainMute, .875*WinWidth, 0, WinWidth, .125*WinHeight)		; Returns location of main mute button

if (!butLoc[3]) {																; If no ErrorLevel, click button, else error message
	; start := timeElapse(start, A_TickCount)
	Click, % butLoc[1] "," butLoc[2]
} else if (butLoc[3] == 1) {
	MsgBox, 8208, Error, "Main Mute Button Not Found", 5
	goto, ayw
}

sleep, 300																		; Takes roughly this long for menu to appear

butLoc := buttonLoc(flyoutMute, .5*WinWidth, 0, WinWidth, .25*WinHeight)		; Returns location of flyout menu button

if (!butLoc[3]) {																; If no ErrorLevel, click button, else error message
	; start := timeElapse(start, A_TickCount)
	Click, % butLoc[1] "," butLoc[2]
} else if (butLoc[3] == 1) {
	MsgBox, 8208, Error, "Flyout Mute Button Not Found", 5
	goto, ayw
}

ayw:	;;;; As you were! ;;;;
WinActivate, ahk_id %winid%					; Switch back to original active window
Sleep, 100
WinActivate, ahk_id %winid%
MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position

return 