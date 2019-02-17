#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
; SetTitleMatchMode, 2
Menu, Tray, Icon, images\siriusxm.png		; Icon for this script
Menu, Tray, Tip, sxm mute 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

^Esc::
winid := WinExist("A")					; Store ID of current active window
MouseGetPos, ogMousePosX, ogMousePosY	; Store current mouse position
; MsgBox, 8195, SiriusXM, SiriusXM, is it active?
IfWinActive, SiriusXM
{
	Goto, wholeScript
} else {
	WinActivate, SiriusXM
	WinActivate, SiriusXM
	WinWaitActive, SiriusXM, , 1
	If ErrorLevel
	{
		MsgBox, 8192, SiriusXM, SiriusXM not able to be activated, please activate and re-run
		Return
	}
	Sleep, 500
	Goto, wholeScript
}

wholeScript:
WinGetPos, , , WinWidth, WinHeight
ImageSearch, muteIconX, muteIconY, .875*WinWidth, .875*WinHeight, WinWidth, WinHeight, % A_WorkingDir "\images\sxm mute.png"
If (ErrorLevel)
{
	MsgBox, 8208, Error, % "Error: " ErrorLevel, 5
	Return
}
Click, %muteIconX%, %muteIconY%
sleep, 25
; MsgBox, % "Width: " WinWidth "`nHeight: " WinHeight
Loop, 2
{
	ImageSearch, muteButX, muteButY, .75*WinWidth, .75*WinHeight, WinWidth, WinHeight, % A_WorkingDir "\images\sxm mute" A_Index ".png"
	If !ErrorLevel 
	{
		Goto, muteBut
	}
}

If (ErrorLevel)
{
	MsgBox, 8208, Error, % "Error: " ErrorLevel, 5
	Return
}

muteBut:
Click, %muteButX%, %muteButY%

WinActivate, ahk_id %winid%					; Switch back to original active window
Sleep, 500
WinActivate, ahk_id %winid%
MouseMove, ogMousePosX, ogMousePosY, 0		; Restore original mouse position

return 