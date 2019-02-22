#SingleInstance, force
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: GoldMine Search
; SetTitleMatchMode, 2

^!=:: 													; ctrl+alt+= clears search in GM	
; winid := WinExist()
if WinExist("ahk_exe gmw.exe") {						; check if GoldMine is running
	winid := WinExist("ahk_exe gmw.exe")
} else if WinExist("gm rdp ahk_exe mstsc.exe") {		; check if RDP is running (assumed GM is what is being run in RDP)
	winid := WinExist("gm rdp ahk_exe mstsc.exe")
} else {
	MsgBox, 8256, Not Running, GoldMine is not running; cancelling, 5		; task modal (8192), icon asterisk/exclamation (64), times out after 5 seconds
	return
}
; MsgBox %winid%										; debugging only
if winid
{
	InputBox, var, Name, Name to Search For
	WinActivate
	WinActivate
	WinWaitActive, , , 1
	If ErrorLevel
	{
		MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
		return
	}
} else {
	MsgBox, 8256, Not Running, GoldMine is not running; cancelling, 5		; task modal (8192), icon asterisk/exclamation (64), times out after 5 seconds	
	return
}

Click, 200, 90											; clicks in search field of GM
SendInput, ^a%var%{Enter}								; selects all and clears text
return