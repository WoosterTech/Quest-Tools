StatusChange(keys) ; The piece that actually does the window switching and change of status
{
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
	SendInput, %keys%{Enter}
	Sleep, 100
	WinActivate, ahk_id %winid%
}

^F1::
	StatusChange("/back")
return

^F2::
	StatusChange("/dnd On Phone")
return

^F3::
	; Determine time %increment% minutes from now
	increment := 15 ; time to add to current time
	rounder := 5 ; what level to round UP to nearest
	EnvAdd, var, %increment%, Minutes
	FormatTime, time, %var%, h:mm
	FormatTime, min, %var%, mm
	mod := Mod(min, rounder)
	if mod
	{
		EnvSub, rounder, %mod%
		EnvAdd, var, %rounder%, Minutes
	}
	FormatTime, var, %var%, h:mm
	StatusChange("/away Back ~" var)
return

^F4::
	StatusChange("/away PM Me")
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?
	if ErrorLevel 
	{
		return
	}
	StatusChange("/away " var)
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?
	if ErrorLevel
	{
		return
	}
	StatusChange("/dnd " var)
return