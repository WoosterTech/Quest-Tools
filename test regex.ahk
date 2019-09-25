#SingleInstance, force

#Include 3CX_Properties.ahk

Hotkey, %numEnter%, copyNumber
return

copyNumber:

	SendInput, ^c

	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 8208, Error, Selection does not contain text, 2
		return
	}

	pnMatch := RegExMatch(Clipboard, pnregex, 1)
	if !pnMatch
	{
		MsgBox, % "Not able to format as phone number`n`nSelection: " clipboard
		return
	}

	pNumber := RegExReplace(Clipboard, pnRegEx, RegExOut, 1)

	MsgBox, % "Clipboard: " clipboard "`nRegExMatch: " pnMatch "`nRegExReplace: " pNumber

return