#SingleInstance, force

^!=:: 											; ctrl+alt+= clears search in GM	
; winid := WinExist()
if WinExist("ahk_exe gmw.exe")
{
	winid := WinExist("ahk_exe gmw.exe")
}
if WinExist("ahk_exe mstsc.exe")
{
	winid := WinExist("ahk_exe mstsc.exe")
}
; MsgBox %winid%								; debugging only
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
	MsgBox, 8208, Not Running, GoldMine is not running, cancelling
	return
}
Click, 200, 90									; clicks in search field of GM
SendInput, ^a%var%{Enter}						; selects all and clears text
return