#SingleInstance, force
Menu, Tray, Icon, images/q_on_red_bkgd.ico

^!F1::
winid := WinExist("A")

IfWinExist, HipChat
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, HipChat is not running, cancelling
	return
}

Sleep, 500

WinActivate, ahk_id %winid%
return

^+F1::
IfWinExist, HipChat
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, HipChat is not running, cancelling
	return
}
return

^+F2::
IfWinExist, ahk_exe mstsc.exe, gm rdp
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, RDP is not running, cancelling
	return
}
return

^+F3::
IfWinExist, ahk_exe OUTLOOK.EXE
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, Outlook is not running, cancelling
	return
}
return

^+F4::
IfWinExist, ahk_exe slack.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, slack is not running, cancelling
	return
}
return

^+F5::
IfWinExist, ahk_exe firefox.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, Firefox is not running, cancelling
	return
}
return

^+F6::
IfWinExist, ahk_exe g2mui.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, GoToMeeting is not running, cancelling
	return
}
return

^+F7::
IfWinExist, ahk_exe chrome.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1 
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, Chrome is not running, cancelling
	return
}
return

^+F8::											; ctrl+F8 switch to SW if open
IfWinExist, ahk_exe sldworks.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1 
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, SOLIDWORKS is not running, cancelling
	return
}
return

; ^!=::											; ctrl+alt+= clears search in GM
; if WinExist("ahk_exe mstsc.exe", "gm rdp")
; {
; 	InputBox, var, Name, Name to Search For
; 	WinActivate
; 	WinActivate
; 	WinWaitActive, , , 1
; 	If ErrorLevel
; 	{
; 		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
; 		return
; 	}
; } else {
; 	MsgBox, 8208, Not Running, GoldMine RDP is not running, cancelling
; 	return
; }
; Click, 200, 90									; clicks in search field of GM
; SendInput, ^a%var%{Enter}						; selects all and clears text
; return

^+F9::											; ctrl+F9 switch to 3cx if open
IfWinExist, ahk_exe 3CXWin8Phone.exe
{
	WinActivate
	WinActivate
	WinWaitActive, , , 1 
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8208, Not Running, 3CX is not running, cancelling
	return
}
return