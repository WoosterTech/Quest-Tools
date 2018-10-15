#WinActivateForce

StatusChange(keys) ; The piece that actually does the window switching and change of status
{
	winid := WinExist("A")
	WinActivate, HipChat
	WinActivate, HipChat
	SendInput, %keys%
	SendInput, {Enter}
	WinActivate, ahk_id %winid%
}

^F1::
	StatusChange("/back")
return

^F2::
	StatusChange("/dnd on phone")
return

^F3::
	; Determine time 15 minutes from now
	EnvAdd, var, 15, Minutes
	FormatTime, var, %var%, h:mm

	StatusChange("/away back ~" var)
return

^F4::
	StatusChange("/away PM me")
return

^F5::
	; Ask user for away input
	InputBox, var, Away Message, Message for Away Status?

	StatusChange("/away " var)
return

^F6::
	; Ask user for dnd input
	InputBox, var, Do Not Disturb Message, Message for DND Status?

	StatusChange("/dnd " var)
return